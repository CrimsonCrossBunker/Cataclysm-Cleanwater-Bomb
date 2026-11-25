#include <algorithm>
#include <cstddef>
#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_assert.h"
#include "character.h"
#include "character_action_guard.h"
#include "city.h"
#include "coordinates.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "enum_conversions.h"
#include "enums.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "generic_factory.h"
#include "line.h"
#include "map_iterator.h"
#include "map_scale_constants.h"
#include "mapgen_functions.h"
#include "math_parser_diag_value.h"
#include "messages.h"
#include "mission.h"
#include "npc.h"
#include "omdata.h"
#include "overmap.h"
#include "overmapbuffer.h"
#include "point.h"
#include "rng.h"
#include "talker.h"
#include "translations.h"
#include "type_id.h"

static constexpr int local_mission_range = 20000 / ( 2 * SEEX );

static tripoint_abs_omt reveal_destination( const std::string &type, const Character &who )
{
    const tripoint_abs_omt your_pos = who.pos_abs_omt();
    const tripoint_abs_omt center_pos =
        overmap_buffer.find_random( your_pos, type, rng( 40, 80 ), false );

    if( !center_pos.is_invalid() ) {
        overmap_buffer.reveal( center_pos, 2 );
        return center_pos;
    }

    return tripoint_abs_omt::invalid;
}

static void reveal_route( mission *miss, const tripoint_abs_omt &destination, const Character &who )
{
    const npc *p = g->find_npc( miss->get_npc_id() );
    if( p == nullptr ) {
        debugmsg( "couldn't find an NPC!" );
        return;
    }

    const tripoint_abs_omt source = who.pos_abs_omt();

    const tripoint_abs_omt source_road = overmap_buffer.find_closest( source, "road", 3, false );
    const tripoint_abs_omt dest_road = overmap_buffer.find_closest( destination, "road", 3, false );

    if( overmap_buffer.reveal_route( source_road, dest_road ) ) {
        who.add_msg_if_player( _( "%s also marks the road that leads to it…" ), p->get_name() );
    }
}

static void reveal_target( mission *miss, const std::string &omter_id, const Character &who )
{
    const npc *p = g->find_npc( miss->get_npc_id() );
    if( p == nullptr ) {
        debugmsg( "couldn't find an NPC!" );
        return;
    }

    const tripoint_abs_omt destination = reveal_destination( omter_id, who );
    if( !destination.is_invalid() ) {
        const oter_id oter = overmap_buffer.ter( destination );
        who.add_msg_if_player( _( "%s has marked the only %s known to them on your map." ), p->get_name(),
                               oter->get_name( om_vision_level::full ) );
        miss->set_target( destination );
        if( one_in( 3 ) ) {
            reveal_route( miss, destination, who );
        }
    }
}

static void reveal_any_target( mission *miss, const std::vector<std::string> &omter_ids,
                               const Character &who )
{
    reveal_target( miss, random_entry( omter_ids ), who );
}

bool mission_util::reveal_road( const tripoint_abs_omt &source, const tripoint_abs_omt &dest,
                                overmapbuffer &omb )
{
    const tripoint_abs_omt source_road = overmap_buffer.find_closest( source, "road", 3, false );
    const tripoint_abs_omt dest_road = overmap_buffer.find_closest( dest, "road", 3, false );
    return omb.reveal_route( source_road, dest_road );
}

/**
 * Reveal the cloest overmap terrain of a type and return the its location
 */
tripoint_abs_omt mission_util::reveal_om_ter( tripoint_abs_omt origin, const std::string &omter,
        int reveal_rad,
        bool must_see, int target_z )
{
    // Missions are normally on z-level 0, but allow an optional argument.
    origin.z() = target_z;
    const tripoint_abs_omt place = overmap_buffer.find_closest( origin, omter,
                                   local_mission_range, must_see );
    if( !place.is_invalid() && rl_dist( origin, place ) > local_mission_range ) {
        return tripoint_abs_omt::invalid;
    }
    if( !place.is_invalid() && reveal_rad >= 0 ) {
        overmap_buffer.reveal( place, reveal_rad );
    }
    return place;
}

/**
 * Given a (valid!) city reference, select a random house within the city borders.
 * @return global overmap terrain coordinates of the house.
 */
static tripoint_abs_omt random_house_in_city( const city_reference &cref )
{
    const tripoint_abs_omt city_center_omt =
        project_to<coords::omt>( cref.abs_sm_pos );
    std::vector<tripoint_abs_omt> valid;
    for( const tripoint_abs_omt &p : points_in_radius( city_center_omt, cref.city->size ) ) {
        if( overmap_buffer.check_ot( "house", ot_match_type::prefix, p ) ) {
            valid.push_back( p );
        }
    }
    return random_entry( valid, city_center_omt ); // center of the city is a good fallback
}

tripoint_abs_omt mission_util::random_house_in_closest_city()
{
    return random_house_in_closest_city( get_player_character() );
}

tripoint_abs_omt mission_util::random_house_in_closest_city( const Character &player_character )
{
    const tripoint_abs_sm center = player_character.pos_abs_sm();
    const city_reference cref = overmap_buffer.closest_city( center );
    if( !cref || rl_dist( player_character.pos_abs_omt(),
                         project_to<coords::omt>( cref.abs_sm_pos ) ) > local_mission_range ) {
        debugmsg( "could not find closest city" );
        return player_character.pos_abs_omt();
    }
    const tripoint_abs_omt house = random_house_in_city( cref );
    return rl_dist( player_character.pos_abs_omt(), house ) <= local_mission_range ?
           house : project_to<coords::omt>( cref.abs_sm_pos );
}

static std::optional<tripoint_abs_omt> find_or_create_om_terrain(
    const tripoint_abs_omt &origin_pos, const mission_target_params &params, dialogue &d )
{
    tripoint_abs_omt target_pos = tripoint_abs_omt::invalid;

    if( params.target_var.has_value() ) {
        return project_to<coords::omt>( read_var_value( *params.target_var, d ).tripoint() );
    }

    omt_find_params find_params;
    std::vector<std::pair<std::string, ot_match_type>> temp_types;
    std::pair<std::string, ot_match_type> temp_pair;
    temp_pair.first = params.overmap_terrain.evaluate( d );
    temp_pair.second = params.overmap_terrain_match_type;
    temp_types.push_back( temp_pair );
    find_params.types = temp_types;
    find_params.search_range = params.search_range.evaluate( d );
    find_params.min_distance = params.min_distance.evaluate( d );
    find_params.must_see = params.must_see;
    find_params.cant_see = params.cant_see;
    find_params.existing_only = true;

    if( params.z ) {
        find_params.min_z = find_params.max_z = origin_pos.z();
    }

    if( params.overmap_special.has_value() ) {
        const overmap_special_id special_id = static_cast<overmap_special_id>(
                ( *params.overmap_special ).evaluate( d ) );
        find_params.om_special = special_id;

        if( overmap_buffer.contains_unique_special( special_id ) ) {
            target_pos = overmap_buffer.find_existing_globally_unique( origin_pos, find_params );
            if( target_pos.is_invalid() ) {
                debugmsg( "Couldn't find placed overmap special %s???", special_id.str() );
                return std::nullopt;
            }
            return target_pos;
        }
    } else {
        find_params.search_range = find_params.search_range > 0 ?
                                   std::min( find_params.search_range, local_mission_range ) :
                                   local_mission_range;
    }
    const auto find_target = [&]() {
        return params.random ? overmap_buffer.find_random( origin_pos, find_params ) :
               overmap_buffer.find_closest( origin_pos, find_params );
    };
    const bool can_create = params.create_if_necessary && !params.must_see;
    target_pos = find_target();
    if( target_pos.is_invalid() && find_params.om_special && can_create ) {
        if( overmap_buffer.place_special( *find_params.om_special, origin_pos,
                                          find_params.search_range ) ) {
            target_pos = overmap_buffer.contains_unique_special( *find_params.om_special ) ?
                         overmap_buffer.find_existing_globally_unique( origin_pos, find_params ) :
                         find_target();
        }
    }
    if( target_pos.is_invalid() && find_params.om_special && !params.must_see ) {
        const point_abs_om origin_om = project_to<coords::om>( origin_pos.xy() );
        const int range = find_params.search_range > 0 ? find_params.search_range : OMAPX;
        const point_abs_om low = project_to<coords::om>( origin_pos.xy() - point( range, range ) );
        const point_abs_om high = project_to<coords::om>( origin_pos.xy() + point( range, range ) );
        for( const point_abs_om &p : closest_points_first( origin_om, 0, 1 ) ) {
            if( p.x() < low.x() || p.x() > high.x() || p.y() < low.y() || p.y() > high.y() ||
                overmap_buffer.has( p ) ) {
                continue;
            }
            overmap_buffer.get( p );
            target_pos = find_target();
            if( !target_pos.is_invalid() ) {
                break;
            }
        }
        if( target_pos.is_invalid() && can_create &&
            overmap_buffer.place_special( *find_params.om_special, origin_pos, range ) ) {
            target_pos = find_target();
        }
    } else if( target_pos.is_invalid() && !params.must_see ) {
        find_params.existing_only = false;
        target_pos = find_target();
    }
    if( target_pos.is_invalid() && !find_params.om_special && can_create &&
        params.replaceable_overmap_terrain ) {
        find_params.types.front().first = params.replaceable_overmap_terrain->evaluate( d );
        target_pos = overmap_buffer.find_random( origin_pos, find_params );
        if( !target_pos.is_invalid() ) {
            overmap_buffer.ter_set( target_pos, oter_id( params.overmap_terrain.evaluate( d ) ) );
        }
    }

    // If we got here and this is still invalid, it means that we couldn't find it nor create it
    // on any overmap (new or existing) within the allowed search range.
    if( target_pos.is_invalid() ) {
        debugmsg( "Unable to find and assign mission target %s within %d tiles.",
                  params.overmap_terrain.evaluate( d ), find_params.search_range );
        return std::nullopt;
    }
    return target_pos;
}

static tripoint_abs_omt get_mission_om_origin( const mission_target_params &params, dialogue &d )
{
    // use the player or NPC's current position, adjust for the z value if any
    tripoint_abs_omt origin_pos = d.has_actor( false ) ? d.const_actor( false )->pos_abs_omt() :
                                  tripoint_abs_omt::invalid;
    if( !params.origin_u ) {
        npc *guy = nullptr;

        if( params.guy ) {
            guy = params.guy;
        } else if( params.mission_pointer ) {
            guy = g->find_npc( params.mission_pointer->get_npc_id() );
        }
        if( guy ) {
            origin_pos = guy->pos_abs_omt();
        }
    }
    if( params.z ) {
        origin_pos.z() = ( *params.z ).evaluate( d );
    }
    return origin_pos;
}

std::optional<tripoint_abs_omt> mission_util::assign_mission_target(
    const mission_target_params &params, dialogue &d )
{
    // use the player or NPC's current position, adjust for the z value if any
    tripoint_abs_omt origin_pos = get_mission_om_origin( params, d );
    if( origin_pos.is_invalid() && !params.target_var ) {
        return std::nullopt;
    }

    std::optional<tripoint_abs_omt> target_pos = find_or_create_om_terrain( origin_pos, params, d );
    if( target_pos ) {
        if( params.offset ) {
            *target_pos += *params.offset;
        }
        if( !params.overmap_special && !params.target_var &&
            rl_dist( origin_pos, *target_pos ) > local_mission_range ) {
            return std::nullopt;
        }

        // If we specified a reveal radius, then go ahead and reveal around our found position.
        if( params.reveal_radius ) {
            overmap_buffer.reveal( *target_pos, ( *params.reveal_radius ).evaluate( d ) );
        }

        // Set the mission target to our found position.
        params.mission_pointer->set_target( *target_pos );
    }

    return target_pos;
}

tripoint_abs_omt mission_util::get_om_terrain_pos( const mission_target_params &params,
        dialogue &d )
{
    // use the player or NPC's current position, adjust for the z value if any
    tripoint_abs_omt origin_pos = get_mission_om_origin( params, d );
    if( origin_pos.is_invalid() && !params.target_var ) {
        return origin_pos;
    }
    tripoint_abs_omt target_pos = origin_pos;
    if( !params.overmap_terrain.evaluate( d ).empty() ) {
        std::optional<tripoint_abs_omt> temp_pos = find_or_create_om_terrain( origin_pos, params, d );
        if( temp_pos ) {
            target_pos = *temp_pos;
        }
    }

    if( params.offset ) {
        target_pos += *params.offset;
    }

    // If we specified a reveal radius, then go ahead and reveal around our found position.
    if( params.reveal_radius ) {
        overmap_buffer.reveal( target_pos, ( *params.reveal_radius ).evaluate( d ) );
    }

    return target_pos;
}

/**
 * Set target of mission to closest overmap terrain of that type,
 * reveal the area around it (uses reveal with reveal_rad),
 * and returns the mission target.
*/
tripoint_abs_omt mission_util::target_om_ter(
    tripoint_abs_omt origin, const std::string &omter, int reveal_rad, mission *miss, bool must_see,
    int target_z )
{
    const tripoint_abs_omt place = reveal_om_ter( origin, omter, reveal_rad, must_see, target_z );
    miss->set_target( place );
    return place;
}

tripoint_abs_omt mission_util::target_om_ter_random( const std::string &omter, int reveal_rad,
        mission *miss, bool must_see, int range, tripoint_abs_omt loc )
{
    Character &player_character = get_player_character();
    if( loc.is_invalid() ) {
        loc = player_character.pos_abs_omt();
    }

    auto places = overmap_buffer.find_all( loc, omter, range, must_see );
    if( places.empty() ) {
        return player_character.pos_abs_omt();
    }
    const overmap *loc_om = overmap_buffer.get_existing_om_global( loc ).om;
    cata_assert( loc_om );

    std::vector<tripoint_abs_omt> places_om;
    for( auto &i : places ) {
        if( loc_om == overmap_buffer.get_existing_om_global( i ).om ) {
            places_om.push_back( i );
        }
    }

    const tripoint_abs_omt place = random_entry( places_om );
    if( reveal_rad >= 0 ) {
        overmap_buffer.reveal( place, reveal_rad );
    }
    miss->set_target( place );
    return place;
}

mission_target_params mission_util::parse_mission_om_target( const JsonObject &jo )
{
    mission_target_params p;
    optional( jo, false, "om_terrain", p.overmap_terrain );
    if( jo.has_member( "om_terrain_match_type" ) ) {
        p.overmap_terrain_match_type = jo.get_enum_value<ot_match_type>( "om_terrain_match_type" );
    }
    if( jo.get_bool( "origin_npc", false ) ) {
        p.origin_u = false;
    }
    optional( jo, false, "om_terrain_replace", p.replaceable_overmap_terrain );
    optional( jo, false, "om_special", p.overmap_special );
    optional( jo, false, "reveal_radius", p.reveal_radius );
    if( jo.has_member( "must_see" ) ) {
        p.must_see = jo.get_bool( "must_see" );
    }
    if( jo.has_member( "cant_see" ) ) {
        p.cant_see = jo.get_bool( "cant_see" );
    }
    if( jo.has_member( "exclude_seen" ) ) {
        p.random = jo.get_bool( "exclude" );
    }
    if( jo.has_member( "random" ) ) {
        p.random = jo.get_bool( "random" );
    }
    if( !p.random && jo.has_member( "search_range" ) ) {
        jo.throw_error_at( "search_range",
                           "There's no reason to change max search range if your search isn't random." );
    }
    optional( jo, false, "search_range", p.search_range, OMAPX * 3 );
    optional( jo, false, "min_distance", p.min_distance );

    if( jo.has_member( "offset_x" ) || jo.has_member( "offset_y" ) || jo.has_member( "offset_z" ) ) {
        tripoint_rel_omt offset;
        if( jo.has_member( "offset_x" ) ) {
            offset.x() = jo.get_int( "offset_x" );
        }
        if( jo.has_member( "offset_y" ) ) {
            offset.y() = jo.get_int( "offset_y" );
        }
        if( jo.has_member( "offset_z" ) ) {
            offset.z() = jo.get_int( "offset_z" );
        }
        p.offset = offset;
    }
    optional( jo, false, "z", p.z );
    optional( jo, false, "var", p.target_var );
    return p;
}

void mission_util::set_reveal( const std::string &terrain,
                               std::vector<std::function<void( mission *, Character & )>> &funcs )
{
    auto mission_func = [ terrain ]( mission * miss, Character & who ) {
        reveal_target( miss, terrain, who );
    };
    funcs.emplace_back( std::move( mission_func ) );
}

void mission_util::set_reveal_any( const JsonArray &ja,
                                   std::vector<std::function<void( mission *, Character & )>> &funcs )
{
    std::vector<std::string> terrains;
    for( const std::string terrain : ja ) {
        terrains.push_back( terrain );
    }
    auto mission_func = [ terrains = std::move( terrains ) ]( mission * miss, Character & who ) {
        reveal_any_target( miss, terrains, who );
    };
    funcs.emplace_back( std::move( mission_func ) );
}

void mission_util::set_assign_om_target( const JsonObject &jo,
        std::vector<std::function<void( mission *, Character & )>> &funcs )
{
    mission_target_params p = parse_mission_om_target( jo );
    auto mission_func = [p = std::move( p )]( mission * miss, Character & who ) mutable {
        p.mission_pointer = miss;
        dialogue d( get_talker_for( who ), nullptr );
        assign_mission_target( p, d );
    };
    funcs.emplace_back( std::move( mission_func ) );
}

bool mission_util::set_update_mapgen( const JsonObject &jo,
                                      std::vector<std::function<void( mission *, Character & )>> &funcs )
{
    bool defer = false;
    mapgen_update_func update_map = add_mapgen_update_func( jo, defer );
    if( defer ) {
        jo.allow_omitted_members();
        return false;
    }

    if( jo.has_member( "om_terrain" ) ) {
        const std::string om_terrain = jo.get_string( "om_terrain" );
        auto mission_func = [update_map = std::move( update_map ), om_terrain]( mission * miss,
        Character & who ) {
            tripoint_abs_omt update_pos3 = mission_util::reveal_om_ter( miss->has_target() ? miss->get_target()
                                           : who.pos_abs_omt(), om_terrain, 1, false );
            if( !update_pos3.is_invalid() ) {
                update_map( update_pos3, miss );
            }
        };
        funcs.emplace_back( std::move( mission_func ) );
    } else {
        auto mission_func = [update_map = std::move( update_map )]( mission * miss, Character & ) {
            if( miss->has_target() ) {
                update_map( miss->get_target(), miss );
            }
        };
        funcs.emplace_back( std::move( mission_func ) );
    }
    return true;
}

bool mission_util::load_funcs( const JsonObject &jo,
                               std::vector<std::function<void( mission *, Character & )>> &funcs )
{
    if( jo.has_string( "reveal_om_ter" ) ) {
        const std::string target_terrain = jo.get_string( "reveal_om_ter" );
        set_reveal( target_terrain, funcs );
    } else if( jo.has_member( "reveal_om_ter" ) ) {
        set_reveal_any( jo.get_array( "reveal_om_ter" ), funcs );
    } else if( jo.has_member( "assign_mission_target" ) ) {
        JsonObject mission_target = jo.get_object( "assign_mission_target" );
        set_assign_om_target( mission_target, funcs );
    }

    if( jo.has_object( "update_mapgen" ) ) {
        JsonObject update_mapgen = jo.get_object( "update_mapgen" );
        if( !set_update_mapgen( update_mapgen, funcs ) ) {
            return false;
        }
    } else {
        for( JsonObject update_mapgen : jo.get_array( "update_mapgen" ) ) {
            if( !set_update_mapgen( update_mapgen, funcs ) ) {
                return false;
            }
        }
    }

    return true;
}

bool mission_type::parse_funcs( const JsonObject &jo, std::string_view src,
                                std::function<void( mission *, Character & )> &phase_func )
{
    std::vector<std::function<void( mission *, Character & )>> funcs;
    if( !mission_util::load_funcs( jo, funcs ) ) {
        return false;
    }

    /* this is a kind of gross hijack of the dialogue responses effect system, but I don't want to
     * write that code in two places so here it goes.
     */
    talk_effect_t talk_effects;
    talk_effects.load_effect( jo, "effect", src );
    phase_func = [ funcs, talk_effects ]( mission * miss, Character & who ) {
        const int mission_id = miss->get_id();
        const std::size_t generation = miss->identity_generation();
        const character_action_guard owner( who );
        npc *beta_npc = g->find_npc( miss->get_npc_id() );
        std::optional<character_action_guard> giver;
        if( beta_npc ) {
            // A giver's death is itself a native mission-failure trigger.
            // Retain that dead instance for the phase's beta dialogue without
            // suppressing the surviving owner's failure effects.
            giver.emplace( *beta_npc, beta_npc->is_dead() );
        }
        const auto live = [&]() {
            return owner && ( !giver || *giver ) && mission::find( mission_id, true ) == miss &&
                   miss->identity_generation() == generation;
        };
        ::dialogue d( get_talker_for( who ),
                      beta_npc == nullptr ? nullptr : get_talker_for( beta_npc ) );
        for( const talk_effect_fun_t &effect : talk_effects.effects ) {
            if( !live() ) {
                return;
            }
            effect( d );
        }
        for( const auto &mission_function : funcs ) {
            if( !live() ) {
                return;
            }
            mission_function( miss, who );
        }
    };

    for( talk_effect_fun_t &effect : talk_effects.effects ) {
        talk_effect_fun_t::likely_rewards_t rewards = effect.get_likely_rewards();
        if( !rewards.empty() ) {
            likely_rewards.insert( likely_rewards.end(), rewards.begin(), rewards.end() );
        }
    }

    return true;
}
