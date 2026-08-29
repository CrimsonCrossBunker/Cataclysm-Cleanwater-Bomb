#include "item_category.h"

#include <algorithm>
#include <utility>
#include <vector>

#include "lua_platform_content.h"
#include "generic_factory.h"
#include "item.h"

namespace
{
generic_factory<item_category> item_category_factory( "item_category" );
} // namespace

generic_factory<item_category> &cata::lua_platform::detail::item_category_registry()
{
    return item_category_factory;
}

std::vector<cata::lua_platform::detail::item_category_snapshot_entry>
cata::lua_platform::detail::item_category_snapshot()
{
    std::vector<item_category_snapshot_entry> result;
    for( const item_category &value : item_category_factory.get_all() ) {
        item_category_snapshot_entry entry;
        entry.id = value.id.str();
        entry.header = value.name_header();
        entry.noun = value.name_noun( 1 );
        entry.sort_rank = value.sort_rank();
        entry.zone = value.zone_.has_value() ? value.zone_.value().str() : std::string();
        for( const zone_priority_data &rule : value.zone_priority_ ) {
            item_category_snapshot_entry::priority_rule converted;
            converted.zone = rule.id.str();
            converted.filthy = rule.filthy;
            for( const flag_id &flag : rule.flags ) {
                converted.flags.emplace_back( flag.str() );
            }
            entry.priority_zones.emplace_back( std::move( converted ) );
        }
        entry.spawn_rate = value.get_spawn_rate();
        result.emplace_back( std::move( entry ) );
    }
    std::sort( result.begin(), result.end(),
    []( const item_category_snapshot_entry &left,
        const item_category_snapshot_entry &right ) {
        return left.id < right.id;
    } );
    return result;
}

template<>
const item_category &string_id<item_category>::obj() const
{
    return item_category_factory.obj( *this );
}

template<>
bool string_id<item_category>::is_valid() const
{
    return item_category_factory.is_valid( *this );
}

void zone_priority_data::deserialize( const JsonObject &jo )
{
    load( jo );
}

void zone_priority_data::load( const JsonObject &jo )
{
    mandatory( jo, was_loaded, "id", id );
    optional( jo, was_loaded, "flags", flags );
    optional( jo, was_loaded, "filthy", filthy, false );
}

const std::vector<item_category> &item_category::get_all()
{
    return item_category_factory.get_all();
}

void item_category::finalize_all()
{
    item_category_factory.finalize();
}

void item_category::load_item_cat( const JsonObject &jo, const std::string &src )
{
    item_category_factory.load( jo, src );
}

void item_category::reset()
{
    item_category_factory.reset();
}

void item_category::load( const JsonObject &jo, std::string_view )
{
    mandatory( jo, was_loaded, "id", id );
    mandatory( jo, was_loaded, "name_header", name_header_ );
    name_noun_.make_plural();
    mandatory( jo, was_loaded, "name_noun", name_noun_ );
    mandatory( jo, was_loaded, "sort_rank", sort_rank_ );
    optional( jo, was_loaded, "priority_zones", zone_priority_ );
    optional( jo, was_loaded, "zone", zone_, std::nullopt );
    float spawn_rate = 1.0f;
    optional( jo, was_loaded, "spawn_rate", spawn_rate, 1.0f );
    set_spawn_rate( spawn_rate );
}

bool item_category::operator<( const item_category &rhs ) const
{
    if( sort_rank_ != rhs.sort_rank_ ) {
        return sort_rank_ < rhs.sort_rank_;
    }
    if( name_header_.translated_ne( rhs.name_header_ ) ) {
        return name_header_.translated_lt( rhs.name_header_ );
    }
    return id < rhs.id;
}

bool item_category::operator==( const item_category &rhs ) const
{
    return sort_rank_ == rhs.sort_rank_ && name_header_.translated_eq( rhs.name_header_ ) &&
           id == rhs.id;
}

bool item_category::operator!=( const item_category &rhs ) const
{
    return !operator==( rhs );
}

std::string item_category::name_header() const
{
    return name_header_.translated();
}

std::string item_category::name_noun( const int count ) const
{
    return name_noun_.translated( count );
}

item_category_id item_category::get_id() const
{
    return id;
}

std::optional<zone_type_id> item_category::zone() const
{
    return zone_;
}

std::optional<zone_type_id> item_category::priority_zone( const item &it ) const
{
    for( const zone_priority_data &zone_dat : zone_priority_ ) {
        if( zone_dat.filthy ) {
            if( it.is_filthy() ) {
                return zone_dat.id;

            } else {
                continue;
            }
        }
        if( it.has_any_flag( zone_dat.flags ) ) {
            return zone_dat.id;
        }
    }
    return std::nullopt;
}

int item_category::sort_rank() const
{
    return sort_rank_;
}

void item_category::set_spawn_rate( const float &rate ) const
{
    item_category_spawn_rates::get_item_category_spawn_rates().set_spawn_rate( id, rate );
}

float item_category::get_spawn_rate() const
{
    return item_category_spawn_rates::get_item_category_spawn_rates().get_spawn_rate( id );
}

void item_category_spawn_rates::set_spawn_rate( const item_category_id &id, const float &rate )
{
    auto it = spawn_rates.find( id );
    if( it != spawn_rates.end() ) {
        it->second = rate;
    } else {
        spawn_rates.insert( std::make_pair( id, rate ) );
    }
}

void item_category_spawn_rates::set_spawn_rates(
    const std::vector<std::pair<item_category_id, float>> &updates )
{
    std::map<item_category_id, std::optional<float>> snapshot;
    for( const auto &update : updates ) {
        const auto it = spawn_rates.find( update.first );
        const std::optional<float> previous =
            it == spawn_rates.end() ? std::nullopt :
            std::optional<float>( it->second );
        snapshot.emplace( update.first, previous );
    }

    try {
        for( const auto &update : updates ) {
            auto it = spawn_rates.find( update.first );
            if( it != spawn_rates.end() ) {
                it->second = update.second;
            } else {
                spawn_rates.emplace( update.first, update.second );
            }
        }
    } catch( ... ) {
        // find/assignment/erase do not allocate here: every entry that was
        // present in the snapshot remains present during the commit, and an
        // entry absent from it can only be a newly committed map node.
        for( const auto &entry : snapshot ) {
            if( entry.second ) {
                auto it = spawn_rates.find( entry.first );
                if( it != spawn_rates.end() ) {
                    it->second = *entry.second;
                }
            } else {
                spawn_rates.erase( entry.first );
            }
        }
        throw;
    }
}

float item_category_spawn_rates::get_spawn_rate( const item_category_id &id )
{
    auto it = spawn_rates.find( id );
    if( it != spawn_rates.end() ) {
        return it->second;
    }
    return 1.0f;
}
