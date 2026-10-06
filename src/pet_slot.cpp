#include "pet_slot.h"

#include <algorithm>
#include <map>
#include <optional>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "creature.h"
#include "debug.h"
#include "flexbuffer_json.h"
#include "generic_factory.h"
#include "item.h"
#include "itype.h"
#include "json.h"
#include "monster.h"
#include "mtype.h"

namespace
{

generic_factory<pet_slot> pet_slot_factory( "pet slot" );
std::map<pet_slot_id, pet_slot_id> pet_slot_parents;

std::optional<creature_size> creature_size_from_string( const std::string &value )
{
    if( value == "tiny" ) {
        return creature_size::tiny;
    }
    if( value == "small" ) {
        return creature_size::small;
    }
    if( value == "medium" ) {
        return creature_size::medium;
    }
    if( value == "large" ) {
        return creature_size::large;
    }
    if( value == "huge" ) {
        return creature_size::huge;
    }
    return std::nullopt;
}

void check_nesting_cycles( const pet_slot_id &slot, std::set<pet_slot_id> &visiting,
                           std::set<pet_slot_id> &checked, std::vector<pet_slot_id> &path )
{
    if( checked.count( slot ) > 0 ) {
        return;
    }
    if( visiting.count( slot ) > 0 ) {
        std::string cycle;
        const auto cycle_start = std::find( path.begin(), path.end(), slot );
        for( auto iter = cycle_start; iter != path.end(); ++iter ) {
            cycle += iter->str();
            cycle += " -> ";
        }
        cycle += slot.str();
        debugmsg( "pet slot nesting cycle detected: %s", cycle );
        return;
    }

    visiting.insert( slot );
    path.push_back( slot );
    for( const pet_slot_id &sub : slot.obj().sub_slots ) {
        if( sub.is_valid() ) {
            check_nesting_cycles( sub, visiting, checked, path );
        }
    }
    path.pop_back();
    visiting.erase( slot );
    checked.insert( slot );
}

} // namespace

template<>
const pet_slot &string_id<pet_slot>::obj() const
{
    return pet_slot_factory.obj( *this );
}

template<>
bool string_id<pet_slot>::is_valid() const
{
    return pet_slot_factory.is_valid( *this );
}

void load_pet_slots( const JsonObject &jo, const std::string &src )
{
    pet_slot_factory.load( jo, src );
}

void reset_pet_slots()
{
    pet_slot_parents.clear();
    pet_slot_factory.reset();
}

const std::vector<pet_slot> &get_all_pet_slots()
{
    return pet_slot_factory.get_all();
}

std::optional<pet_slot_id> get_pet_slot_parent( const pet_slot_id &slot )
{
    const auto iter = pet_slot_parents.find( slot );
    if( iter == pet_slot_parents.end() ) {
        return std::nullopt;
    }
    return iter->second;
}

void pet_slot::load( const JsonObject &jo, std::string_view )
{
    mandatory( jo, was_loaded, "name", name );
    mandatory( jo, was_loaded, "description", description );

    optional( jo, was_loaded, "required_flags", required_flags );
    optional( jo, was_loaded, "forbidden_flags", forbidden_flags );
    optional( jo, was_loaded, "min_creature_volume", min_creature_volume, volume_reader{}, 0_ml );
    optional( jo, was_loaded, "max_creature_volume", max_creature_volume, volume_reader{},
              units::volume::max() );
    optional( jo, was_loaded, "bodytypes", bodytypes );
    optional( jo, was_loaded, "min_storage", min_storage, volume_reader{}, 0_ml );
    optional( jo, was_loaded, "pet_armor", pet_armor, false );
    optional( jo, was_loaded, "mount_only", mount_only, false );
    optional( jo, was_loaded, "passive_effects", passive_effects );
    optional( jo, was_loaded, "mount_threshold_delta", mount_threshold_delta, 0 );
    optional( jo, was_loaded, "melee_hit_multiplier", melee_hit_multiplier, 1.0 );
    optional( jo, was_loaded, "melee_damage_multiplier", melee_damage_multiplier, 1.0 );
    optional( jo, was_loaded, "fear_multiplier", fear_multiplier, 1.0 );
    optional( jo, was_loaded, "sub_slots", sub_slots );

    if( jo.has_member( "creature_size_range" ) ) {
        JsonArray range = jo.get_array( "creature_size_range" );
        if( range.size() != 2 ) {
            jo.throw_error_at( "creature_size_range", "expected two creature-size names" );
        }
        const std::optional<creature_size> low = creature_size_from_string( range.get_string( 0 ) );
        const std::optional<creature_size> high = creature_size_from_string( range.get_string( 1 ) );
        if( !low || !high || *low > *high ) {
            jo.throw_error_at( "creature_size_range",
                               "expected an ordered pair using tiny, small, medium, large, or huge" );
        }
        creature_size_range = std::make_pair( *low, *high );
    }
}

bool pet_slot::accepts( const item &candidate, const monster &pet,
                        std::string *failure_reason ) const
{
    const auto reject = [failure_reason]( const std::string & reason ) {
        if( failure_reason != nullptr ) {
            *failure_reason = reason;
        }
        return false;
    };

    if( mount_only && !pet.has_flag( mon_flag_PET_MOUNTABLE ) ) {
        return reject( "slot is restricted to mountable creatures" );
    }
    if( candidate.type->pet_equipment ) {
        const std::vector<std::string> &item_slots = candidate.type->pet_equipment->slots;
        if( std::find( item_slots.begin(), item_slots.end(), id.str() ) == item_slots.end() ) {
            return reject( "item does not declare compatibility with this equipment slot" );
        }
    } else if( !required_flags.empty() && std::none_of( required_flags.begin(), required_flags.end(),
    [&candidate]( const flag_id & flag ) {
    return candidate.has_flag( flag );
    } ) ) {
        return reject( "item lacks a required equipment flag" );
    }
    if( std::any_of( forbidden_flags.begin(), forbidden_flags.end(),
    [&candidate]( const flag_id & flag ) {
    return candidate.has_flag( flag );
    } ) ) {
        return reject( "item has a forbidden equipment flag" );
    }
    if( pet.get_volume() < min_creature_volume || pet.get_volume() > max_creature_volume ) {
        return reject( "creature volume is outside the slot's supported range" );
    }
    if( creature_size_range && ( pet.get_size() < creature_size_range->first ||
                                 pet.get_size() > creature_size_range->second ) ) {
        return reject( "creature size is outside the slot's supported range" );
    }
    if( !bodytypes.empty() && bodytypes.count( pet.type->bodytype ) == 0 ) {
        return reject( "item slot does not support this creature body type" );
    }
    if( pet_armor && ( candidate.get_pet_armor_bodytype() != pet.type->bodytype ||
                       pet.get_volume() < candidate.get_pet_armor_min_vol() ||
                       pet.get_volume() > candidate.get_pet_armor_max_vol() ) ) {
        return reject( "armor does not fit this creature's body type or volume" );
    }
    if( min_storage > 0_ml && candidate.get_volume_capacity() < min_storage ) {
        return reject( "container capacity is below the slot minimum" );
    }
    return true;
}

void pet_slot::check_consistency()
{
    for( const pet_slot &slot : pet_slot_factory.get_all() ) {
        if( slot.min_creature_volume > slot.max_creature_volume ) {
            debugmsg( "pet slot %s has an inverted creature-volume range", slot.id.c_str() );
        }
        if( slot.melee_hit_multiplier < 0.0 || slot.melee_damage_multiplier < 0.0 ||
            slot.fear_multiplier < 0.0 ) {
            debugmsg( "pet slot %s has a negative riding multiplier", slot.id.c_str() );
        }
        for( const pet_slot_id &sub : slot.sub_slots ) {
            if( sub == slot.id ) {
                debugmsg( "pet slot %s lists itself as a sub-slot", slot.id.c_str() );
            } else if( !sub.is_valid() ) {
                debugmsg( "pet slot %s references unknown sub-slot %s", slot.id.c_str(), sub.c_str() );
            }
        }
    }

    std::set<pet_slot_id> checked;
    for( const pet_slot &slot : pet_slot_factory.get_all() ) {
        std::set<pet_slot_id> visiting;
        std::vector<pet_slot_id> path;
        check_nesting_cycles( slot.id, visiting, checked, path );
    }
}

void pet_slot::finalize_all()
{
    pet_slot_factory.finalize();
    pet_slot_parents.clear();
    for( const pet_slot &slot : pet_slot_factory.get_all() ) {
        for( const pet_slot_id &sub : slot.sub_slots ) {
            const auto inserted = pet_slot_parents.emplace( sub, slot.id );
            if( !inserted.second && inserted.first->second != slot.id ) {
                debugmsg( "pet slot %s has more than one parent", sub.c_str() );
            }
        }
    }
}
