#include "mongroup.h"

#include "avatar.h"
#include "character_id.h"
#include "mission.h"

#include <enums.h>
#include <mapgen_primitives.h>
#include <monster.h>
#include <type_id.h>
#include <algorithm>
#include <cstdint>
#include <limits>
#include <stdexcept>
#include <string>
#include <utility>

#include "calendar.h"
#include "cata_assert.h"
#include "cata_utility.h"
#include "debug.h"
#include "enum_conversions.h"
#include "flexbuffer_json.h"
#include "generic_factory.h"
#include "init.h"
#include "lua_platform_content.h"
#include "mtype.h"
#include "options.h"
#include "rng.h"
#include "units.h"

//  Frequency: If you don't use the whole 1000 points of frequency for each of
//     the monsters, the remaining points will go to the defaultMonster.
//     I.e. a group with 1 monster at frequency 500 will have 50% chance to spawn
//     the default monster.
//     In the same spirit, if you have a total point count of over 1000, the
//     default monster will never get picked, and nor will the others past the
//     monster that makes the point count go over 1000

std::map<mongroup_id, MonsterGroup> MonsterGroupManager::monsterGroupMap;
MonsterGroupManager::t_string_set MonsterGroupManager::monster_blacklist;
MonsterGroupManager::t_string_set MonsterGroupManager::monster_whitelist;
MonsterGroupManager::t_string_set MonsterGroupManager::monster_categories_blacklist;
MonsterGroupManager::t_string_set MonsterGroupManager::monster_categories_whitelist;
MonsterGroupManager::t_string_set MonsterGroupManager::monster_species_blacklist;
MonsterGroupManager::t_string_set MonsterGroupManager::monster_species_whitelist;

static const mtype_id mon_null( "mon_null" );

static bool monster_whitelist_is_exclusive = false;

/** @relates string_id */
template<>
bool string_id<MonsterGroup>::is_valid() const
{
    return MonsterGroupManager::isValidMonsterGroup( *this );
}

/** @relates string_id */
template<>
const MonsterGroup &string_id<MonsterGroup>::obj() const
{
    return MonsterGroupManager::GetMonsterGroup( *this );
}

namespace io
{

template<>
std::string enum_to_string<mongroup::horde_behaviour>( mongroup::horde_behaviour data )
{
    switch( data ) {
        // *INDENT-OFF*
        case mongroup::horde_behaviour::none: return "none";
        case mongroup::horde_behaviour::city: return "city";
        case mongroup::horde_behaviour::roam: return "roam";
        case mongroup::horde_behaviour::nemesis: return "nemesis";
        // *INDENT-ON*
        case mongroup::horde_behaviour::last:
            break;
    }
    cata_fatal( "Invalid mongroup::horde_behaviour" );
}

} // namespace io

bool mongroup::is_safe() const
{
    return type.obj().is_safe;
}

bool mongroup::empty() const
{
    return population <= 0 && monsters.empty();
}

void mongroup::clear()
{
    population = 0;
    monsters.clear();
}

/**
 * The average speed of the monsters in the group.
 * If monsters vector is empty, the average speed of the group is calculated.
 */
float mongroup::avg_speed() const
{
    float avg_speed = 0.0f;
    if( monsters.empty() ) {
        const MonsterGroup &g = type.obj();
        int remaining_frequency = g.freq_total;
        for( const MonsterGroupEntry &elem : g.monsters ) {
            if( elem.is_group() ) {
                // TODO: recursively derive average speed from subgroups
                avg_speed += elem.frequency * 100;
            } else {
                avg_speed += elem.frequency * elem.mtype->speed;
            }
            remaining_frequency -= elem.frequency;
        }
        if( remaining_frequency > 0 ) {
            avg_speed += g.defaultMonster.obj().speed * remaining_frequency;
        }
        avg_speed /= g.freq_total;
    } else {
        for( const monster &it : monsters ) {
            avg_speed += it.type->speed;
        }
        avg_speed /= monsters.size();
    }
    return avg_speed;
}

static bool is_spawn_valid(
    const MonsterGroupEntry &entry, const time_point &sunset, const time_point &sunrise,
    const season_type season, const bool can_spawn_events )
{
    // If an event was specified for this entry, check if it matches the current holiday
    if( entry.event != holiday::none && ( !can_spawn_events ||
                                          entry.event != get_holiday_from_time() ) ) {
        return false;
    }

    //Insure that the time is not before the spawn first appears or after it stops appearing
    if( calendar::turn < calendar::start_of_cataclysm + entry.starts ) {
        return false;
    }
    if( !entry.lasts_forever() && calendar::turn >= calendar::start_of_cataclysm + entry.ends ) {
        return false;
    }

    std::vector<std::pair<time_point, time_point> > valid_times_of_day;
    bool season_limited = false;
    bool season_matched = false;
    //Collect the various spawn conditions, and then insure they are met appropriately
    for( const std::string &elem : entry.conditions ) {
        //Collect valid time of day ranges
        if( elem == "DAY" || elem == "NIGHT" || elem == "DUSK" || elem == "DAWN" ) {
            if( elem == "DAY" ) {
                valid_times_of_day.emplace_back( sunrise, sunset );
            } else if( elem == "NIGHT" ) {
                valid_times_of_day.emplace_back( sunset, sunrise );
            } else if( elem == "DUSK" ) {
                valid_times_of_day.emplace_back( sunset - 1_hours, sunset + 1_hours );
            } else if( elem == "DAWN" ) {
                valid_times_of_day.emplace_back( sunrise - 1_hours, sunrise + 1_hours );
            }
        }

        //If we have any seasons listed, we know to limit by season, and if any season matches this season, we are good to spawn
        if( elem == "SUMMER" || elem == "WINTER" || elem == "SPRING" || elem == "AUTUMN" ) {
            season_limited = true;
            if( ( season == SUMMER && elem == "SUMMER" ) ||
                ( season == WINTER && elem == "WINTER" ) ||
                ( season == SPRING && elem == "SPRING" ) ||
                ( season == AUTUMN && elem == "AUTUMN" ) ) {
                season_matched = true;
            }
        }
    }

    //Make sure the current time of day is within one of the valid time ranges for this spawn
    bool is_valid_time_of_day = false;
    if( valid_times_of_day.empty() ) {
        //Then it can spawn whenever, since no times were defined
        is_valid_time_of_day = true;
    } else {
        //Otherwise, it's valid if it matches any of the times of day
        for( auto &elem : valid_times_of_day ) {
            if( calendar::turn > elem.first && calendar::turn < elem.second ) {
                is_valid_time_of_day = true;
            }
        }
    }
    if( !is_valid_time_of_day ) {
        return false;
    }

    //If we are limited by season, make sure we matched a season
    if( season_limited && !season_matched ) {
        return false;
    }

    return true;
}

// Quantity is adjusted directly as a side effect of this function
// is_recursive is only true when called recursively from this function
std::vector<MonsterGroupResult> MonsterGroupManager::GetResultFromGroup(
    const mongroup_id &group_name, int *quantity, bool *mon_found, bool is_recursive,
    bool *returned_default, bool use_pack_size )
{
    const MonsterGroup &group = GetMonsterGroup( group_name );
    int spawn_chance = rng( 1, group.event_adjusted_freq_total() );
    //Our spawn details specify, by default, a single instance of the default monster
    std::vector<MonsterGroupResult> spawn_details;

    bool monster_found = false;
    // Loop invariant values
    const time_point sunset = ::sunset( calendar::turn );
    const time_point sunrise = ::sunrise( calendar::turn );
    const season_type season = season_of_year( calendar::turn );
    std::string opt = get_option<std::string>( "EVENT_SPAWNS" );
    const bool can_spawn_events = opt == "monsters" || opt == "both";

    // Step through spawn definitions from the monster group until one is found or
    for( const MonsterGroupEntry &entry : group.monsters ) {
        if( !is_spawn_valid( entry, sunset, sunrise, season, can_spawn_events ) ) {
            continue;
        }

        // Only keep if the monsters frequency is at least the spawn_chance
        if( entry.frequency < spawn_chance ) {
            spawn_chance -= entry.frequency;
            continue;
        }

        const int pack_size =
            entry.pack_maximum > 1 ? rng( entry.pack_minimum, entry.pack_maximum ) : 1;

        if( entry.is_group() ) {
            // Check for monsters within subgroup
            for( int i = 0; i < pack_size; i++ ) {
                std::vector<MonsterGroupResult> tmp_grp =
                    GetResultFromGroup( entry.group, quantity, &monster_found, true );
                spawn_details.insert( spawn_details.end(), tmp_grp.begin(), tmp_grp.end() );
            }
        } else {
            if( use_pack_size ) {
                for( int i = 0; i < pack_size; i++ ) {
                    spawn_details.emplace_back( entry.mtype, pack_size, entry.data );
                    // And if a quantity pointer with remaining value was passed, will modify the external
                    // value as a side effect.  We will reduce it by the spawn rule's cost multiplier.
                    if( quantity ) {
                        *quantity -= std::max( 1, entry.cost_multiplier * pack_size );
                    }
                }
            } else {
                spawn_details.emplace_back( entry.mtype, pack_size, entry.data );
                // And if a quantity pointer with remaining value was passed, will modify the external
                // value as a side effect.  We will reduce it by the spawn rule's cost multiplier.
                if( quantity ) {
                    *quantity -= std::max( 1, entry.cost_multiplier * pack_size );
                }
            }
            monster_found = true;
        }
        break;
    }

    if( mon_found ) {
        ( *mon_found ) = monster_found;
    }

    if( !is_recursive && !monster_found ) {
        spawn_details.emplace_back( group.defaultMonster, 1, spawn_data() );
        if( returned_default ) {
            ( *returned_default ) = true;
        }
        // Force quantity to decrement regardless of whether we found a monster.
        if( quantity ) {
            ( *quantity )--;
        }
    }

    return spawn_details;
}

bool MonsterGroup::IsMonsterInGroup( const mtype_id &mtypeid ) const
{
    for( const MonsterGroupEntry &m : monsters ) {
        if( m.mtype == mtypeid ) {
            return true;
        }
    }
    return false;
}

int MonsterGroup::event_adjusted_freq_total( holiday event ) const
{
    std::string opt = get_option<std::string>( "EVENT_SPAWNS" );
    if( opt != "monsters" && opt != "both" ) {
        return freq_total;
    } else if( event == holiday::num_holiday ) {
        event = get_holiday_from_time();
    }

    if( event == holiday::none ) {
        return freq_total;
    }

    auto iter = event_freq.find( event );
    return freq_total + ( iter == event_freq.end() ? 0 : iter->second );
}

bool MonsterGroupManager::IsMonsterInGroup( const mongroup_id &group, const mtype_id &monster )
{
    return group.obj().IsMonsterInGroup( monster );
}

const mongroup_id &MonsterGroupManager::Monster2Group( const mtype_id &monster )
{
    for( auto &g : monsterGroupMap ) {
        if( g.second.IsMonsterInGroup( monster ) ) {
            return g.second.id;
        }
    }
    return mongroup_id::NULL_ID();
}

std::vector<mtype_id> MonsterGroupManager::GetMonstersFromGroup( const mongroup_id &group,
        bool from_subgroups )
{
    const MonsterGroup &g = group.obj();
    std::vector<mtype_id> monsters;
    std::string opt = get_option<std::string>( "EVENT_SPAWNS" );
    const bool can_spawn_events = opt == "monsters" || opt == "both";

    for( const MonsterGroupEntry &elem : g.monsters ) {
        if( elem.event != holiday::none && ( !can_spawn_events ||
                                             elem.event != get_holiday_from_time() ) ) {
            continue;
        }
        if( elem.is_group() ) {
            if( from_subgroups ) {
                std::vector<mtype_id> submons = GetMonstersFromGroup( elem.group, from_subgroups );
                monsters.reserve( monsters.size() + submons.size() );
                monsters.insert( monsters.end(), submons.begin(), submons.end() );
            }
        } else {
            monsters.push_back( elem.mtype );
        }
    }
    return monsters;
}

bool MonsterGroupManager::isValidMonsterGroup( const mongroup_id &group )
{
    return monsterGroupMap.count( group ) > 0;
}

const MonsterGroup &MonsterGroupManager::GetMonsterGroup( const mongroup_id &group )
{
    const auto it = monsterGroupMap.find( group );
    if( it == monsterGroupMap.end() ) {
        debugmsg( "Unable to get the group '%s'", group.c_str() );
        // Initialize the group with a null-monster, it's ignored while spawning,
        // but it prevents further messages about invalid monster type id
        auto &g = monsterGroupMap[group];
        g.id = group;
        g.defaultMonster = mtype_id::NULL_ID();
        return g;
    } else {
        return it->second;
    }
}

void MonsterGroupManager::LoadMonsterBlacklist( const JsonObject &jo )
{
    add_array_to_set( monster_blacklist, jo, "monsters" );
    add_array_to_set( monster_categories_blacklist, jo, "categories" );
    add_array_to_set( monster_species_blacklist, jo, "species" );
}

void MonsterGroupManager::LoadMonsterWhitelist( const JsonObject &jo )
{
    if( jo.has_string( "mode" ) && jo.get_string( "mode" ) == "EXCLUSIVE" ) {
        monster_whitelist_is_exclusive = true;
    }
    add_array_to_set( monster_whitelist, jo, "monsters" );
    add_array_to_set( monster_categories_whitelist, jo, "categories" );
    add_array_to_set( monster_species_whitelist, jo, "species" );

}

void cata::lua_platform::detail::insert_platform_monster_blacklist(
    const platform_blacklist_data &value )
{
    auto &monsters = value.whitelist ? MonsterGroupManager::monster_whitelist :
                     MonsterGroupManager::monster_blacklist;
    auto &categories = value.whitelist ? MonsterGroupManager::monster_categories_whitelist :
                       MonsterGroupManager::monster_categories_blacklist;
    auto &species = value.whitelist ? MonsterGroupManager::monster_species_whitelist :
                    MonsterGroupManager::monster_species_blacklist;
    monsters.insert( value.entries.begin(), value.entries.end() );
    categories.insert( value.categories.begin(), value.categories.end() );
    species.insert( value.species.begin(), value.species.end() );
    monster_whitelist_is_exclusive = monster_whitelist_is_exclusive || value.exclusive;
}

cata::lua_platform::detail::monster_filter_state
cata::lua_platform::detail::capture_platform_monster_filter()
{
    return {
        MonsterGroupManager::monster_blacklist,
        MonsterGroupManager::monster_whitelist,
        MonsterGroupManager::monster_categories_blacklist,
        MonsterGroupManager::monster_categories_whitelist,
        MonsterGroupManager::monster_species_blacklist,
        MonsterGroupManager::monster_species_whitelist,
        monster_whitelist_is_exclusive
    };
}

void cata::lua_platform::detail::restore_platform_monster_filter( monster_filter_state &&state )
{
    MonsterGroupManager::monster_blacklist = std::move( state.blocked_monsters );
    MonsterGroupManager::monster_whitelist = std::move( state.allowed_monsters );
    MonsterGroupManager::monster_categories_blacklist = std::move( state.blocked_categories );
    MonsterGroupManager::monster_categories_whitelist = std::move( state.allowed_categories );
    MonsterGroupManager::monster_species_blacklist = std::move( state.blocked_species );
    MonsterGroupManager::monster_species_whitelist = std::move( state.allowed_species );
    monster_whitelist_is_exclusive = state.exclusive;
}

std::vector<std::string> cata::lua_platform::detail::monster_blacklist_snapshot()
{
    return std::vector<std::string>(
               MonsterGroupManager::monster_blacklist.begin(),
               MonsterGroupManager::monster_blacklist.end() );
}

std::vector<std::string> cata::lua_platform::detail::monster_whitelist_snapshot()
{
    return std::vector<std::string>(
               MonsterGroupManager::monster_whitelist.begin(),
               MonsterGroupManager::monster_whitelist.end() );
}

bool MonsterGroupManager::monster_is_blacklisted( const mtype_id &m )
{
    if( monster_whitelist.count( m.str() ) > 0 ) {
        return false;
    }
    const mtype &mt = m.obj();
    for( const auto &elem : monster_categories_whitelist ) {
        if( mt.categories.count( elem ) > 0 ) {
            return false;
        }
    }
    for( const auto &elem : monster_species_whitelist ) {
        if( mt.in_species( species_id( elem ) ) ) {
            return false;
        }
    }
    for( const auto &elem : monster_categories_blacklist ) {
        if( mt.categories.count( elem ) > 0 ) {
            return true;
        }
    }
    for( const auto &elem : monster_species_blacklist ) {
        if( mt.in_species( species_id( elem ) ) ) {
            return true;
        }
    }
    if( monster_blacklist.count( m.str() ) > 0 ) {
        return true;
    }
    // Return true if the whitelist mode is exclusive and any whitelist is populated.
    return monster_whitelist_is_exclusive &&
           ( !monster_whitelist.empty() || !monster_categories_whitelist.empty() ||
             !monster_species_whitelist.empty() );
}

void MonsterGroupManager::FinalizeMonsterGroups()
{
    for( const std::string &mtid : monster_whitelist ) {
        if( !mtype_id( mtid ).is_valid() ) {
            debugmsg( "monster on whitelist %s does not exist", mtid.c_str() );
        }
    }
    for( const std::string &mtid : monster_blacklist ) {
        if( !mtype_id( mtid ).is_valid() ) {
            debugmsg( "monster on blacklist %s does not exist", mtid.c_str() );
        }
    }
    // Further, remove all blacklisted monsters
    for( auto &elem : monsterGroupMap ) {
        MonsterGroup &mg = elem.second;
        for( FreqDef::iterator c = mg.monsters.begin(); c != mg.monsters.end(); ) {
            if( !c->is_group() && MonsterGroupManager::monster_is_blacklisted( c->mtype ) ) {
                c = mg.monsters.erase( c );
            } else {
                ++c;
            }
        }
        if( MonsterGroupManager::monster_is_blacklisted( mg.defaultMonster ) ) {
            mg.defaultMonster = mtype_id::NULL_ID();
        }
    }
}

std::map<mongroup_id, MonsterGroup> &MonsterGroupManager::Get_all_Groups()
{
    return MonsterGroupManager::monsterGroupMap;
}

namespace
{

struct monster_group_layer {
    MonsterGroup values;
    std::string source;
    bool replace = false;
    std::optional<mtype_id> default_monster;
    mtype_id fallback_monster = mon_null;
    std::optional<time_duration> replacement_time;
    std::optional<int> frequency_total;
    bool auto_total = false;
};

std::map<mongroup_id, std::vector<monster_group_layer>> monster_group_layers;
std::map<std::string, int> monster_group_evolution_multipliers;

int monster_group_evolution_multiplier()
{
    const float factor = get_option<float>( "EVOLUTION_INVERSE_MULTIPLIER" );
    return factor > 0 ? static_cast<int>( factor ) : 1;
}

int checked_group_frequency( const mongroup_id &id, const std::int64_t frequency )
{
    if( frequency < std::numeric_limits<int>::min() ||
        frequency > std::numeric_limits<int>::max() ) {
        throw std::runtime_error( "monster group '" + id.str() + "' exceeds the native weight range" );
    }
    return static_cast<int>( frequency );
}

void apply_monster_group_layer( MonsterGroup &group, bool extending,
                                const monster_group_layer &layer )
{
    const MonsterGroup &values = layer.values;
    if( !extending || layer.replace ) {
        group = MonsterGroup{};
        group.id = values.id;
        group.defaultMonster = layer.fallback_monster;
    }
    if( layer.default_monster ) {
        group.defaultMonster = *layer.default_monster;
    }
    std::int64_t frequency = group.freq_total;
    for( const MonsterGroupEntry &entry : values.monsters ) {
        if( entry.event == holiday::none ) {
            frequency += entry.frequency;
        }
        int &event_frequency = group.event_freq[entry.event];
        event_frequency = checked_group_frequency( group.id,
                          static_cast<std::int64_t>( event_frequency ) + entry.frequency );
        group.monsters.push_back( entry );
    }
    group.is_animal = values.is_animal;
    group.replace_monster_group = values.replace_monster_group;
    group.new_monster_group = values.new_monster_group;
    group.is_safe = values.is_safe;
    if( layer.replacement_time ) {
        group.monster_group_time = *layer.replacement_time;
    }
    if( layer.auto_total ) {
        frequency = 0;
        for( const MonsterGroupEntry &entry : group.monsters ) {
            frequency += entry.frequency;
        }
    } else if( layer.frequency_total ) {
        frequency = *layer.frequency_total;
    }
    group.freq_total = checked_group_frequency( group.id, frequency );
}

void register_monster_group_layer( std::map<mongroup_id, MonsterGroup> &registry,
                                   monster_group_layer layer )
{
    const mongroup_id id = layer.values.id;
    auto &layers = monster_group_layers[id];
    const auto &loader = DynamicDataLoader::get_instance();
    const auto position = loader.source_load_order( layer.source );
    MonsterGroup resolved;
    const bool arrives_last = std::none_of( layers.begin(), layers.end(),
    [&loader, &position]( const monster_group_layer & authored ) {
        return loader.source_load_order( authored.source ) > position;
    } );
    if( arrives_last ) {
        const auto previous = registry.find( id );
        const bool extending = previous != registry.end() && !layer.replace;
        if( extending ) {
            resolved = previous->second;
        }
        apply_monster_group_layer( resolved, extending, layer );
    } else {
        // Lua can contribute at an earlier Mod's position after later JSON was read.
        std::vector<const monster_group_layer *> ordered;
        ordered.reserve( layers.size() + 1 );
        for( const monster_group_layer &authored : layers ) {
            ordered.push_back( &authored );
        }
        ordered.push_back( &layer );
        std::stable_sort( ordered.begin(), ordered.end(), [&loader]( const auto *lhs, const auto *rhs ) {
            return loader.source_load_order( lhs->source ) < loader.source_load_order( rhs->source );
        } );
        bool extending = false;
        for( const monster_group_layer *authored : ordered ) {
            apply_monster_group_layer( resolved, extending, *authored );
            extending = true;
        }
    }
    layers.push_back( std::move( layer ) );
    registry[id] = std::move( resolved );
}

} // namespace

void MonsterGroupManager::LoadMonsterGroup( const JsonObject &jo, const std::string &source )
{
    const int upgrade_mult = monster_group_evolution_multiplier();
    monster_group_layer layer;
    layer.source = source;
    layer.replace = jo.get_bool( "override", false );
    MonsterGroup &g = layer.values;

    //TODO: Remove after 0.I
    if( !jo.has_string( "id" ) && jo.has_string( "name" ) ) {
        g.id = mongroup_id( jo.get_string( "name" ) );
        debugmsg( R"((safely ignorable) monstergroup %s's "name" member should be renamed "id" before 0.I stable, you can use /tools/json-tools/monstergroup_name_to_id.py to automate this change)",
                  g.id.c_str() );
    } else {
        g.id = mongroup_id( jo.get_string( "id" ) );
    }

    if( jo.has_string( "default" ) ) {
        layer.default_monster.emplace( jo.get_string( "default" ) );
    }
    g.is_animal = jo.get_bool( "is_animal", false );
    if( jo.has_array( "monsters" ) ) {
        int highest_frequency = 0;
        for( JsonObject mon : jo.get_array( "monsters" ) ) {
            bool isgroup = false;
            std::string id_name;
            if( mon.has_string( "group" ) ) {
                isgroup = true;
                id_name = mon.get_string( "group" );
            } else {
                id_name = mon.get_string( "monster" );
            }

            holiday event = mon.get_enum_value<holiday>( "event", holiday::none );

            int freq = mon.get_int( "weight", 1 );
            if( mon.has_int( "freq" ) ) {
                freq = mon.get_int( "freq" );
            }
            if( !isgroup && event == holiday::none && freq > highest_frequency ) {
                layer.fallback_monster = mtype_id( id_name );
                highest_frequency = freq;
            }
            int cost = mon.get_int( "cost_multiplier", 1 );
            int pack_min = 1;
            int pack_max = 1;
            if( mon.has_member( "pack_size" ) ) {
                JsonArray packarr = mon.get_array( "pack_size" );
                pack_min = packarr.next_int();
                pack_max = packarr.next_int();
            }
            const time_duration starts = mon.has_member( "starts" )
                                         ? read_from_json_string<time_duration>( mon.get_member( "starts" ),
                                                 time_duration::units ) * upgrade_mult
                                         : 0_turns;
            const time_duration ends = mon.has_member( "ends" )
                                       ? read_from_json_string<time_duration> ( mon.get_member( "ends" ),
                                               time_duration::units ) * upgrade_mult
                                       : 0_turns;
            spawn_data data;
            if( mon.has_object( "spawn_data" ) ) {
                const JsonObject &sd = mon.get_object( "spawn_data" );
                if( sd.has_array( "ammo" ) ) {
                    const JsonArray &ammos = sd.get_array( "ammo" );
                    for( const JsonObject adata : ammos ) {
                        data.ammo.emplace( itype_id( adata.get_string( "ammo_id" ) ), jmapgen_int( adata, "qty" ) );
                    }
                }
            }
            MonsterGroupEntry new_mon_group = isgroup ?
                                              MonsterGroupEntry( mongroup_id( id_name ), freq, cost,
                                                      pack_min, pack_max, data, starts, ends, event ) :
                                              MonsterGroupEntry( mtype_id( id_name ), freq, cost, pack_min,
                                                      pack_max, data, starts, ends, event );
            if( mon.has_member( "conditions" ) ) {
                for( const std::string line : mon.get_array( "conditions" ) ) {
                    new_mon_group.conditions.push_back( line );
                }
            }

            g.monsters.push_back( std::move( new_mon_group ) );
        }
    }
    g.replace_monster_group = jo.get_bool( "replace_monster_group", false );
    g.new_monster_group = mongroup_id( jo.get_string( "new_monster_group_id",
                                       mongroup_id::NULL_ID().str() ) );
    if( jo.has_member( "replacement_time" ) ) {
        time_duration value = 0_turns;
        mandatory( jo, false, "replacement_time", value, time_bound_reader{ 1_days } );
        layer.replacement_time = value;
    }
    g.is_safe = jo.get_bool( "is_safe", false );
    if( jo.has_member( "freq_total" ) ) {
        layer.frequency_total = jo.get_int( "freq_total" );
    }
    layer.auto_total = jo.get_bool( "auto_total", false );
    register_monster_group_layer( monsterGroupMap, std::move( layer ) );
}

void MonsterGroupManager::RecordPlatformMonsterGroupSource( const std::string &source )
{
    // Lua layers are applied after JSON loading. Keep the value that was active at this source.
    monster_group_evolution_multipliers.try_emplace( source, monster_group_evolution_multiplier() );
}

void MonsterGroupManager::AddPlatformMonsterGroup( MonsterGroup group, const std::string &source,
        bool extend, std::optional<mtype_id> default_monster )
{
    monster_group_layer layer;
    layer.values = std::move( group );
    layer.source = source;
    layer.replace = !extend;
    layer.default_monster = std::move( default_monster );
    layer.values.new_monster_group = mongroup_id::NULL_ID();
    const auto recorded = monster_group_evolution_multipliers.find( source );
    const int upgrade_mult = recorded == monster_group_evolution_multipliers.end() ?
                             monster_group_evolution_multiplier() : recorded->second;
    int highest_frequency = 0;
    for( MonsterGroupEntry &entry : layer.values.monsters ) {
        entry.starts *= upgrade_mult;
        entry.ends *= upgrade_mult;
        if( !entry.is_group() && entry.event == holiday::none && entry.frequency > highest_frequency ) {
            highest_frequency = entry.frequency;
            layer.fallback_monster = entry.mtype;
        }
    }
    register_monster_group_layer( monsterGroupMap, std::move( layer ) );
}

void MonsterGroupManager::RemovePlatformMonsterGroupLayer( const mongroup_id &id )
{
    const auto found = monster_group_layers.find( id );
    cata_assert( found != monster_group_layers.end() && !found->second.empty() );
    found->second.pop_back();
    if( found->second.empty() ) {
        monster_group_layers.erase( found );
    }
}

bool MonsterGroupManager::is_animal( const mongroup_id &group_name )
{
    const MonsterGroup *groupptr = &group_name.obj();
    return groupptr->is_animal;
}

void MonsterGroupManager::ClearMonsterGroups()
{
    monsterGroupMap.clear();
    monster_group_layers.clear();
    monster_group_evolution_multipliers.clear();
    monster_blacklist.clear();
    monster_whitelist.clear();
    monster_whitelist_is_exclusive = false;
    monster_categories_blacklist.clear();
    monster_categories_whitelist.clear();
    monster_species_blacklist.clear();
    monster_species_whitelist.clear();
}

static void check_group_def( const mongroup_id &g )
{
    for( const MonsterGroupEntry &m : g.obj().monsters ) {
        if( m.is_group() ) {
            if( !m.group.is_valid() ) {
                debugmsg( "monster group %s contains unknown subgroup %s", g.c_str(), m.group.c_str() );
            } else {
                check_group_def( m.group );
            }
        } else if( !m.mtype.is_valid() ) {
            debugmsg( "monster group %s contains unknown monster %s", g.c_str(), m.mtype.c_str() );
        }
    }
}

void MonsterGroupManager::check_group_definitions()
{
    for( const auto &e : monsterGroupMap ) {
        check_group_def( e.first );
    }
}

const mtype_id &MonsterGroupManager::GetRandomMonsterFromGroup( const mongroup_id &group )
{
    int spawn_chance = rng( 1, group->event_adjusted_freq_total() );
    std::string opt = get_option<std::string>( "EVENT_SPAWNS" );
    const bool can_spawn_events = opt == "monsters" || opt == "both";
    for( const MonsterGroupEntry &monster_type : group->monsters ) {
        if( monster_type.event != holiday::none && ( !can_spawn_events ||
                monster_type.event != get_holiday_from_time() ) ) {
            continue;
        }
        if( monster_type.frequency >= spawn_chance ) {
            if( monster_type.is_group() ) {
                return GetRandomMonsterFromGroup( monster_type.group );
            }
            return monster_type.mtype;
        } else {
            spawn_chance -= monster_type.frequency;
        }
    }

    return group->defaultMonster;
}

bool mongroup::nemesis_targets( const character_id who ) const
{
    if( !who.is_valid() || behaviour != horde_behaviour::nemesis ) {
        return false;
    }
    if( nemesis_mission_id < 0 ) {
        return who == get_avatar().getID();
    }
    const mission *task = mission::find( nemesis_mission_id, true );
    return task && task->get_type().goal == MGOAL_KILL_NEMESIS &&
           task->get_assigned_player_id() == who;
}

bool mongroup::nemesis_orphaned() const
{
    if( behaviour != horde_behaviour::nemesis || nemesis_mission_id < 0 ) {
        return false;
    }
    const mission *task = mission::find( nemesis_mission_id, true );
    return !task || task->get_type().goal != MGOAL_KILL_NEMESIS || !task->is_assigned();
}
