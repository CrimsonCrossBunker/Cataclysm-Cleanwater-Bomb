#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include "avatar.h"
#include "creature_tracker.h"
#include "game.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_items.h"
#include "lua_platform_overmap.h"
#include "lua_platform_world_services.h"
#include "map_helpers.h"
#include "monster_uid.h"
#include "npc.h"
#include "overmapbuffer.h"
#include "player_activity.h"
#include "vehicle.h"
#include "vpart_position.h"
#include <functional>
#include "player_helpers.h"

#include "lua_platform_test_map_support.h"

static const mtype_id mon_zombie( "mon_zombie" );
static const npc_template_id npc_template_test_talker( "test_talker" );
static const ter_str_id ter_t_floor( "t_floor" );

namespace cata::lua_platform::test
{

platform_overmap_travel_fixture::platform_overmap_travel_fixture(
    const std::size_t runtime_number, const std::size_t world_number ) :
    owner( cata::lua_platform::make_game_handle_runtime_owner() ),
    runtime( owner, runtime_number ),
    world( world_number )
{
    clear_avatar();
    clear_map_without_vision();
    cata::lua_platform::reset_overmap_tile_tokens();

    avatar &player = get_avatar();
    source_omt = project_to<coords::omt>( player.pos_abs() );
    const point_abs_om om_pos = project_to<coords::om>( source_omt.xy() );
    const point_om_omt local_xy =
        project_remain<coords::om>( source_omt.xy() ).remainder;
    source_overmap = overmap_buffer.get_existing( om_pos );
    if( source_overmap != nullptr ) {
        source_local = tripoint_om_omt( local_xy, source_omt.z() );
        preimage.terrain = source_overmap->ter( source_local );
        preimage.seen = source_overmap->seen( source_local );
        preimage.explored = source_overmap->is_explored( source_local );
        preimage.has_note = source_overmap->has_note( source_local );
        preimage.note = source_overmap->note( source_local );
        preimage.danger_radius =
            source_overmap->note_danger_radius( source_local );
        preimage.dangerous = preimage.danger_radius >= 0;
        edit_ready = true;
    }
    target_omt = source_omt + tripoint::east;

    services = lua.create_table();
    const auto current_runtime = [this]() {
        return runtime;
    };
    const auto current_world = [this]() {
        return world;
    };
    cata::lua_platform::install_value_type_api(
    lua, services, []() {} );
    cata::lua_platform::install_mapgen_service_api(
    services, current_runtime, current_world, []() {},
    [this]() {
        write_called = true;
    } );
    cata::lua_platform::install_overmap_api(
    services, current_runtime, current_world, []() {},
    [this]() {
        write_called = true;
    },
    []( const std::size_t ) {
        return std::size_t{ 0 };
    } );
    cata::lua_platform::install_game_handle_api(
    lua, services, current_runtime, current_world, []() {} );
    cata::lua_platform::install_world_api(
    services, current_runtime, current_world, []() {},
    [this]() {
        write_called = true;
    } );
    cata::lua_platform::install_game_world_service_api(
    services, current_runtime, current_world, []() {},
    [this]() {
        write_called = true;
    },
    []() {}, []() {
        return true;
    } );

    const tripoint_abs_ms position = player.pos_abs();
    avatar_handle = cata::lua_platform::game_handle::from_creature(
    player, {
        "avatar", player.getID().get_value(),
        position.x(), position.y(), position.z(), {}
    },
    runtime, world );
}

platform_overmap_travel_fixture::~platform_overmap_travel_fixture()
{
    if( get_avatar().pos_abs_omt() != source_omt ) {
        g->place_player_overmap( source_omt );
    }
    if( edit_ready ) {
        if( source_overmap->ter( source_local ) != preimage.terrain ) {
            source_overmap->ter_set( source_local, preimage.terrain );
        }
        if( source_overmap->seen( source_local ) != preimage.seen ) {
            source_overmap->set_seen( source_local, preimage.seen, true );
        }
        if( source_overmap->is_explored( source_local ) != preimage.explored ) {
            source_overmap->explored( source_local ) = preimage.explored;
        }
        if( preimage.has_note ) {
            if( !source_overmap->has_note( source_local ) ||
                source_overmap->note( source_local ) != preimage.note ) {
                if( source_overmap->has_note( source_local ) ) {
                    source_overmap->delete_note( source_local );
                }
                source_overmap->add_note( source_local, preimage.note );
            }
        } else if( source_overmap->has_note( source_local ) ) {
            source_overmap->delete_note( source_local );
        }
        if( preimage.has_note && source_overmap->has_note( source_local ) ) {
            source_overmap->mark_note_dangerous(
                source_local,
                preimage.dangerous ? preimage.danger_radius : 0,
                preimage.dangerous );
        }
    }
    cata::lua_platform::reset_overmap_tile_tokens();
    clear_avatar();
}

platform_map_api_test_fixture::platform_map_api_test_fixture( const std::size_t runtime_number,
        const std::size_t world_number ) :
    runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
    runtime( runtime_owner, runtime_number ),
    active_runtime( runtime ),
    active_world_generation( world_number )
{
    clear_map_without_vision();
    cata::lua_platform::reset_map_tile_tokens();
    services = lua.create_table();
    cata::lua_platform::install_value_type_api(
    lua, services, []() {} );
    cata::lua_platform::install_map_api(
        services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {},
    [this]() {
        write_called = true;
    } );
    cata::lua_platform::install_game_handle_api(
        lua, services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {} );
    cata::lua_platform::install_item_api(
        services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {},
    [this]() {
        write_called = true;
    } );
    local = tripoint_bub_ms::zero;
    absolute = get_map().get_abs( local );
}

platform_map_api_test_fixture::~platform_map_api_test_fixture()
{
    cata::lua_platform::reset_map_tile_tokens();
}

platform_monster_relocation_fixture::platform_monster_relocation_fixture(
    const std::size_t runtime_number, const std::size_t world_number ) :
    runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
    runtime( runtime_owner, runtime_number ),
    active_runtime( runtime ),
    active_world_generation( world_number )
{
    clear_avatar();
    clear_map_without_vision();
    get_creature_tracker().clear();
    cata::lua_platform::reset_map_tile_tokens();
    local = tripoint_bub_ms::zero;
    target_local = local + tripoint::east;
    source_abs = get_map().get_abs( local );
    target_abs = get_map().get_abs( target_local );

    if( ter_t_floor.is_valid() ) {
        get_map().ter_set( local, ter_t_floor.id() );
        get_map().ter_set( target_local, ter_t_floor.id() );
    }

    test_monster = make_shared_fast<monster>(
                       mon_zombie, local );
    if( test_monster ) {
        test_monster->set_hp( 1 );
        if( !get_creature_tracker().add( test_monster ) ) {
            test_monster.reset();
        }
    }

    services = lua.create_table();
    cata::lua_platform::install_value_type_api(
    lua, services, []() {} );
    cata::lua_platform::install_map_api(
        services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {},
    [this]() {
        write_called = true;
    } );
    cata::lua_platform::install_game_handle_api(
        lua, services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {} );
    cata::lua_platform::install_game_world_service_api(
        services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {},
    [this]() {
        write_called = true;
    },
    []() {},
    []() {
        return true;
    } );

    if( test_monster ) {
        monster_handle = cata::lua_platform::game_handle::from_creature(
        *test_monster, {
            "monster", test_monster->uid().get_value(),
            source_abs.x(), source_abs.y(), source_abs.z(), {}
        },
        runtime, active_world_generation );
    }
}

platform_monster_relocation_fixture::~platform_monster_relocation_fixture()
{
    for( const shared_ptr_fast<monster> &entry : extra_monsters ) {
        if( entry && get_creature_tracker().temporary_id( *entry ) >= 0 ) {
            get_creature_tracker().remove( *entry );
        }
    }
    if( test_monster &&
        get_creature_tracker().temporary_id( *test_monster ) >= 0 ) {
        get_creature_tracker().remove( *test_monster );
    }
    cata::lua_platform::reset_map_tile_tokens();
}

shared_ptr_fast<monster> platform_monster_relocation_fixture::add_monster(
    const tripoint_bub_ms &value )
{
    shared_ptr_fast<monster> result = make_shared_fast<monster>(
                                          mon_zombie, value );
    result->set_hp( 1 );
    if( !get_creature_tracker().add( result ) ) {
        return {};
    }
    extra_monsters.push_back( result );
    return result;
}

platform_avatar_relocation_fixture::platform_avatar_relocation_fixture(
    const std::size_t runtime_number, const std::size_t world_number ) :
    runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
    runtime( runtime_owner, runtime_number ),
    active_runtime( runtime ),
    active_world_generation( world_number )
{
    clear_avatar();
    clear_map_without_vision();
    cata::lua_platform::reset_map_tile_tokens();
    get_creature_tracker().clear();
    local = tripoint_bub_ms::zero;
    target_local = local + tripoint::east;
    source_abs = get_map().get_abs( local );
    target_abs = get_map().get_abs( target_local );

    if( ter_t_floor.is_valid() ) {
        get_map().ter_set( local, ter_t_floor.id() );
        get_map().ter_set( target_local, ter_t_floor.id() );
    }

    avatar &player = get_avatar();
    player.setpos( get_map(), local );
    player.in_vehicle = false;
    player.grab_point = tripoint_rel_ms::zero;
    player.hauling = false;
    player.activity = player_activity();
    player.clear_destination();

    services = lua.create_table();
    cata::lua_platform::install_value_type_api(
    lua, services, []() {} );
    cata::lua_platform::install_map_api(
        services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {},
    [this]() {
        write_called = true;
    } );
    cata::lua_platform::install_game_handle_api(
        lua, services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {} );
    cata::lua_platform::install_game_world_service_api(
        services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {},
    [this]() {
        write_called = true;
    },
    []() {},
    []() {
        return true;
    } );

    avatar_handle = cata::lua_platform::game_handle::from_creature(
    player, {
        "avatar", player.getID().get_value(),
        source_abs.x(), source_abs.y(), source_abs.z(), {}
    },
    runtime, active_world_generation );
}

platform_avatar_relocation_fixture::~platform_avatar_relocation_fixture()
{
    for( const shared_ptr_fast<monster> &entry : extra_monsters ) {
        if( entry && get_creature_tracker().temporary_id( *entry ) >= 0 ) {
            get_creature_tracker().remove( *entry );
        }
    }
    clear_avatar();
    cata::lua_platform::reset_map_tile_tokens();
}

shared_ptr_fast<monster> platform_avatar_relocation_fixture::add_monster(
    const tripoint_bub_ms &value )
{
    shared_ptr_fast<monster> result = make_shared_fast<monster>(
                                          mon_zombie, value );
    result->set_hp( 1 );
    if( !get_creature_tracker().add( result ) ) {
        return {};
    }
    extra_monsters.push_back( result );
    return result;
}

platform_npc_relocation_fixture::platform_npc_relocation_fixture(
    const std::size_t runtime_number, const std::size_t world_number ) :
    runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
    runtime( runtime_owner, runtime_number ),
    active_runtime( runtime ),
    active_world_generation( world_number )
{
    clear_npcs();
    clear_avatar();
    clear_map_without_vision();
    cata::lua_platform::reset_map_tile_tokens();
    get_avatar().setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
    local = tripoint_bub_ms( 58, 60, 0 );
    target_local = local + tripoint::east;
    source_abs = get_map().get_abs( local );
    target_abs = get_map().get_abs( target_local );

    if( ter_t_floor.is_valid() ) {
        get_map().ter_set( local, ter_t_floor.id() );
        get_map().ter_set( target_local, ter_t_floor.id() );
    }

    npc_id = get_map().place_npc( local.xy(), npc_template_test_talker );
    g->load_npcs();
    test_npc = g->find_npc( npc_id );
    if( test_npc != nullptr ) {
        test_npc->in_vehicle = false;
        test_npc->grab_point = tripoint_rel_ms::zero;
        test_npc->hauling = false;
        test_npc->activity = player_activity();
        test_npc->clear_destination();
    }

    services = lua.create_table();
    cata::lua_platform::install_value_type_api(
    lua, services, []() {} );
    cata::lua_platform::install_map_api(
        services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {},
    [this]() {
        write_called = true;
    } );
    cata::lua_platform::install_game_handle_api(
        lua, services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {} );
    cata::lua_platform::install_game_world_service_api(
        services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {},
    [this]() {
        write_called = true;
    },
    []() {},
    []() {
        return true;
    } );

    if( test_npc != nullptr ) {
        npc_handle = cata::lua_platform::game_handle::from_creature(
        *test_npc, {
            "npc", test_npc->getID().get_value(),
            source_abs.x(), source_abs.y(), source_abs.z(), {}
        },
        runtime, active_world_generation );
    }
}

platform_npc_relocation_fixture::~platform_npc_relocation_fixture()
{
    if( test_npc != nullptr ) {
        test_npc->in_vehicle = false;
    }
    clear_npcs();
    cata::lua_platform::reset_map_tile_tokens();
}

platform_vehicle_relocation_fixture::platform_vehicle_relocation_fixture(
    const std::size_t runtime_number, const std::size_t world_number ) :
    runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
    runtime( runtime_owner, runtime_number ),
    active_runtime( runtime ),
    active_world_generation( world_number )
{
    clear_avatar();
    get_avatar().in_vehicle = false;
    clear_vehicles();
    get_creature_tracker().clear();
    clear_map_without_vision();
    cata::lua_platform::reset_map_tile_tokens();
    source_local = tripoint_bub_ms( 8, 8, 0 );
    target_local = source_local + tripoint_rel_ms( 6, 0, 0 );
    source_abs = get_map().get_abs( source_local );
    target_abs = get_map().get_abs( target_local );

    if( ter_t_floor.is_valid() ) {
        for( int dx = -2; dx <= 8; ++dx ) {
            for( int dy = -2; dy <= 2; ++dy ) {
                const tripoint_rel_ms offset( dx, dy, 0 );
                get_map().ter_set( source_local + offset, ter_t_floor.id() );
            }
        }
    }

    epoch_before = cata::lua_platform::map_mutation_epoch();
    test_vehicle = get_map().add_vehicle(
                       vehicle_prototype_test_shopping_cart,
                       source_local, 0_degrees, 0,
                       veh_spawn_status::UNDAMAGED );
    epoch_after = cata::lua_platform::map_mutation_epoch();

    services = lua.create_table();
    cata::lua_platform::install_value_type_api(
    lua, services, []() {} );
    cata::lua_platform::install_map_api(
        services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {},
    [this]() {
        write_called = true;
    } );
    cata::lua_platform::install_game_handle_api(
        lua, services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {} );
    cata::lua_platform::install_game_world_service_api(
        services,
    [this]() {
        return active_runtime;
    },
    [this]() {
        return active_world_generation;
    },
    []() {},
    [this]() {
        write_called = true;
    },
    []() {},
    []() {
        return true;
    } );

    if( test_vehicle != nullptr ) {
        vehicle_handle = cata::lua_platform::game_handle::from_vehicle(
        *test_vehicle, {
            "map_vehicle", 0, source_abs.x(),
            source_abs.y(), source_abs.z(), {}
        },
        runtime, active_world_generation );
        vehicle_identity_generation = vehicle_handle.identity_generation();

        for( int part_index = 0;
             part_index < test_vehicle->part_count(); ++part_index ) {
            vehicle_part &candidate = test_vehicle->part( part_index );
            if( candidate.removed ) {
                continue;
            }
            const cata::lua_platform::game_handle candidate_handle =
                cata::lua_platform::game_handle::from_vehicle_part(
            candidate, *test_vehicle, {
                "vehicle_part", 0, source_abs.x(), source_abs.y(),
                source_abs.z(), {}
            },
            runtime, active_world_generation );
            if( candidate_handle.kind() ==
                cata::lua_platform::game_handle_kind::vehicle_part ) {
                live_part = &candidate;
                vehicle_part_handle = candidate_handle;
                part_identity_generation =
                    vehicle_part_handle.identity_generation();
            }
            break;
        }
    }
}

platform_vehicle_relocation_fixture::~platform_vehicle_relocation_fixture()
{
    g->setremoteveh( nullptr );
    avatar &player = get_avatar();
    player.grab( object_type::NONE );
    bool unboarded = false;
    if( player.in_vehicle && test_vehicle != nullptr ) {
        for( const int part_index : test_vehicle->boarded_parts() ) {
            if( test_vehicle->get_passenger( part_index ) == &player ) {
                get_map().unboard_vehicle(
                    vpart_reference( *test_vehicle, part_index ), &player );
                unboarded = true;
                break;
            }
        }
    }
    if( !unboarded ) {
        player.in_vehicle = false;
    }
    clear_avatar();
    clear_vehicles();
    for( const shared_ptr_fast<monster> &entry : extra_monsters ) {
        if( entry && get_creature_tracker().temporary_id( *entry ) >= 0 ) {
            get_creature_tracker().remove( *entry );
        }
    }
    cata::lua_platform::reset_map_tile_tokens();
}

shared_ptr_fast<monster> platform_vehicle_relocation_fixture::add_monster(
    const tripoint_bub_ms &value )
{
    shared_ptr_fast<monster> result = make_shared_fast<monster>(
                                          mon_zombie, value );
    if( !result ) {
        return {};
    }
    result->set_hp( 1 );
    if( !get_creature_tracker().add( result ) ) {
        return {};
    }
    extra_monsters.push_back( result );
    return result;
}

platform_mapgen_callback_transaction_test_fixture::platform_mapgen_callback_transaction_test_fixture()
    :
    local_map( ter_t_floor.id() ),
    data( *local_map.cast_to_map(), mapgendata::dummy_settings ),
    context( data, true, UINT64_C( 0x6a09e667f3bcc909 ) )
{
    native_map().ter_set( position(), ter_t_floor.id() );
    data.set_dir( 0, direction_before );
}

} // namespace cata::lua_platform::test

#endif
