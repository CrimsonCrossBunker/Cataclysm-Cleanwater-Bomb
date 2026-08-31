#pragma once

#include "lua_platform_test_support.h"

namespace
{
struct platform_overmap_travel_fixture {
    explicit platform_overmap_travel_fixture(
        const std::size_t runtime_number, const std::size_t world_number ) :
        owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( owner, runtime_number ),
        world( world_number ) {
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
                             player,
                             { "avatar", player.getID().get_value(),
                               position.x(), position.y(), position.z(), {} },
                             runtime, world );
    }

    ~platform_overmap_travel_fixture() {
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

    sol::table overmap_api() const {
        return services["overmap"];
    }

    sol::table relocation_api() const {
        return services["relocation"];
    }

    cata::lua_platform::script_tripoint_coord abs_omt_position(
        const tripoint_abs_omt &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::overmap_terrain,
                   value.raw() );
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> owner;
    cata::lua_platform::game_handle_runtime runtime;
    std::size_t world;
    sol::state lua;
    sol::table services;
    cata::lua_platform::game_handle avatar_handle;
    tripoint_abs_omt source_omt = tripoint_abs_omt::invalid;
    overmap *source_overmap = nullptr;
    tripoint_om_omt source_local = tripoint_om_omt::invalid;
    struct platform_overmap_tile_preimage {
        oter_id terrain;
        om_vision_level seen = om_vision_level::unseen;
        bool explored = false;
        bool has_note = false;
        std::string note;
        int danger_radius = -1;
        bool dangerous = false;
    } preimage;
    bool edit_ready = false;
    tripoint_abs_omt target_omt = tripoint_abs_omt::invalid;
    bool write_called = false;
};

struct platform_map_api_test_fixture {
    explicit platform_map_api_test_fixture( const std::size_t runtime_number,
            const std::size_t world_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
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

    ~platform_map_api_test_fixture() {
        cata::lua_platform::reset_map_tile_tokens();
    }

    sol::table map_api() const {
        return services["map"];
    }

    sol::table item_api() const {
        return services["items"];
    }

    map &get_map() const {
        return ::get_map();
    }

    cata::lua_platform::script_tripoint_coord position() const {
        return position( local );
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_bub_ms &value ) const {
        const tripoint_abs_ms absolute_position = get_map().get_abs( value );
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   absolute_position.raw() );
    }

    sol::table map_holder(
        const cata::lua_platform::map_tile_token &token ) {
        sol::table holder = lua.create_table();
        holder["kind"] = "map_tile";
        holder["tile"] = token;
        return holder;
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    sol::state lua;
    sol::table services;
    tripoint_bub_ms local = tripoint_bub_ms::zero;
    tripoint_abs_ms absolute = tripoint_abs_ms::invalid;
    bool write_called = false;
};

struct platform_monster_relocation_fixture {
    explicit platform_monster_relocation_fixture(
        const std::size_t runtime_number, const std::size_t world_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
        clear_avatar();
        clear_map_without_vision();
        get_creature_tracker().clear();
        cata::lua_platform::reset_map_tile_tokens();
        local = tripoint_bub_ms::zero;
        target_local = local + tripoint::east;
        source_abs = get_map().get_abs( local );
        target_abs = get_map().get_abs( target_local );

        const ter_str_id floor_id( "t_floor" );
        if( floor_id.is_valid() ) {
            get_map().ter_set( local, floor_id.id() );
            get_map().ter_set( target_local, floor_id.id() );
        }

        test_monster = make_shared_fast<monster>(
                            mtype_id( "mon_zombie" ), local );
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
                                 *test_monster,
                                 { "monster", test_monster->uid().get_value(),
                                   source_abs.x(), source_abs.y(), source_abs.z(), {} },
                                 runtime, active_world_generation );
        }
    }

    ~platform_monster_relocation_fixture() {
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

    map &get_map() const {
        return ::get_map();
    }

    sol::table map_api() const {
        return services["map"];
    }

    sol::table relocation_api() const {
        return services["relocation"];
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_bub_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   get_map().get_abs( value ).raw() );
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_abs_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   value.raw() );
    }

    shared_ptr_fast<monster> add_monster( const tripoint_bub_ms &value ) {
        shared_ptr_fast<monster> result = make_shared_fast<monster>(
                mtype_id( "mon_zombie" ), value );
        result->set_hp( 1 );
        if( !get_creature_tracker().add( result ) ) {
            return {};
        }
        extra_monsters.push_back( result );
        return result;
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    sol::state lua;
    sol::table services;
    tripoint_bub_ms local = tripoint_bub_ms::zero;
    tripoint_bub_ms target_local = tripoint_bub_ms::zero;
    tripoint_abs_ms source_abs = tripoint_abs_ms::invalid;
    tripoint_abs_ms target_abs = tripoint_abs_ms::invalid;
    shared_ptr_fast<monster> test_monster;
    std::vector<shared_ptr_fast<monster>> extra_monsters;
    cata::lua_platform::game_handle monster_handle;
    bool write_called = false;
};

struct platform_avatar_relocation_fixture {
    explicit platform_avatar_relocation_fixture(
        const std::size_t runtime_number, const std::size_t world_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
        clear_avatar();
        clear_map_without_vision();
        cata::lua_platform::reset_map_tile_tokens();
        get_creature_tracker().clear();
        local = tripoint_bub_ms::zero;
        target_local = local + tripoint::east;
        source_abs = get_map().get_abs( local );
        target_abs = get_map().get_abs( target_local );

        const ter_str_id floor_id( "t_floor" );
        if( floor_id.is_valid() ) {
            get_map().ter_set( local, floor_id.id() );
            get_map().ter_set( target_local, floor_id.id() );
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
                             player,
                             { "avatar", player.getID().get_value(),
                               source_abs.x(), source_abs.y(), source_abs.z(), {} },
                             runtime, active_world_generation );
    }

    ~platform_avatar_relocation_fixture() {
        for( const shared_ptr_fast<monster> &entry : extra_monsters ) {
            if( entry && get_creature_tracker().temporary_id( *entry ) >= 0 ) {
                get_creature_tracker().remove( *entry );
            }
        }
        clear_avatar();
        cata::lua_platform::reset_map_tile_tokens();
    }

    map &get_map() const {
        return ::get_map();
    }

    sol::table map_api() const {
        return services["map"];
    }

    sol::table relocation_api() const {
        return services["relocation"];
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_bub_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   get_map().get_abs( value ).raw() );
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_abs_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   value.raw() );
    }

    shared_ptr_fast<monster> add_monster( const tripoint_bub_ms &value ) {
        shared_ptr_fast<monster> result = make_shared_fast<monster>(
                mtype_id( "mon_zombie" ), value );
        result->set_hp( 1 );
        if( !get_creature_tracker().add( result ) ) {
            return {};
        }
        extra_monsters.push_back( result );
        return result;
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    sol::state lua;
    sol::table services;
    tripoint_bub_ms local = tripoint_bub_ms::zero;
    tripoint_bub_ms target_local = tripoint_bub_ms::zero;
    tripoint_abs_ms source_abs = tripoint_abs_ms::invalid;
    tripoint_abs_ms target_abs = tripoint_abs_ms::invalid;
    std::vector<shared_ptr_fast<monster>> extra_monsters;
    cata::lua_platform::game_handle avatar_handle;
    bool write_called = false;
};

struct platform_npc_relocation_fixture {
    explicit platform_npc_relocation_fixture(
        const std::size_t runtime_number, const std::size_t world_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
        clear_npcs();
        clear_avatar();
        clear_map_without_vision();
        cata::lua_platform::reset_map_tile_tokens();
        get_avatar().setpos( get_map(), tripoint_bub_ms( 60, 60, 0 ) );
        local = tripoint_bub_ms( 58, 60, 0 );
        target_local = local + tripoint::east;
        source_abs = get_map().get_abs( local );
        target_abs = get_map().get_abs( target_local );

        const ter_str_id floor_id( "t_floor" );
        if( floor_id.is_valid() ) {
            get_map().ter_set( local, floor_id.id() );
            get_map().ter_set( target_local, floor_id.id() );
        }

        npc_id = get_map().place_npc( local.xy(), npc_template_id( "test_talker" ) );
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
                             *test_npc,
                             { "npc", test_npc->getID().get_value(),
                               source_abs.x(), source_abs.y(), source_abs.z(), {} },
                             runtime, active_world_generation );
        }
    }

    ~platform_npc_relocation_fixture() {
        if( test_npc != nullptr ) {
            test_npc->in_vehicle = false;
        }
        clear_npcs();
        cata::lua_platform::reset_map_tile_tokens();
    }

    map &get_map() const {
        return ::get_map();
    }

    sol::table map_api() const {
        return services["map"];
    }

    sol::table relocation_api() const {
        return services["relocation"];
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_bub_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   get_map().get_abs( value ).raw() );
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_abs_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   value.raw() );
    }

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    sol::state lua;
    sol::table services;
    tripoint_bub_ms local = tripoint_bub_ms::zero;
    tripoint_bub_ms target_local = tripoint_bub_ms::zero;
    tripoint_abs_ms source_abs = tripoint_abs_ms::invalid;
    tripoint_abs_ms target_abs = tripoint_abs_ms::invalid;
    npc *test_npc = nullptr;
    character_id npc_id;
    cata::lua_platform::game_handle npc_handle;
    bool write_called = false;
};

struct platform_vehicle_relocation_fixture {
    explicit platform_vehicle_relocation_fixture(
        const std::size_t runtime_number, const std::size_t world_number ) :
        runtime_owner( cata::lua_platform::make_game_handle_runtime_owner() ),
        runtime( runtime_owner, runtime_number ),
        active_runtime( runtime ),
        active_world_generation( world_number ) {
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

        const ter_str_id floor_id( "t_floor" );
        if( floor_id.is_valid() ) {
            for( int dx = -2; dx <= 8; ++dx ) {
                for( int dy = -2; dy <= 2; ++dy ) {
                    const tripoint_rel_ms offset( dx, dy, 0 );
                    get_map().ter_set( source_local + offset, floor_id.id() );
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
                                 *test_vehicle,
                                 { "map_vehicle", 0, source_abs.x(),
                                   source_abs.y(), source_abs.z(), {} },
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
                        candidate, *test_vehicle,
                        { "vehicle_part", 0, source_abs.x(), source_abs.y(),
                          source_abs.z(), {} },
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

    ~platform_vehicle_relocation_fixture() {
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

    map &get_map() const {
        return ::get_map();
    }

    sol::table map_api() const {
        return services["map"];
    }

    sol::table relocation_api() const {
        return services["relocation"];
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_bub_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   get_map().get_abs( value ).raw() );
    }

    cata::lua_platform::script_tripoint_coord position(
        const tripoint_abs_ms &value ) const {
        return cata::lua_platform::script_tripoint_coord::from_native(
                   coords::origin::abs,
                   coords::scale::map_square,
                   value.raw() );
    }

    vehicle *add_target_blocker_vehicle() {
        vehicle *result = get_map().add_vehicle(
                              vehicle_prototype_test_shopping_cart,
                              target_local, 0_degrees, 0,
                              veh_spawn_status::UNDAMAGED );
        if( result != nullptr ) {
            target_blocker_vehicle = result;
        }
        return result;
    }

    shared_ptr_fast<monster> add_monster( const tripoint_bub_ms &value ) {
        shared_ptr_fast<monster> result = make_shared_fast<monster>(
                mtype_id( "mon_zombie" ), value );
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

    std::shared_ptr<const cata::lua_platform::game_handle_runtime_owner> runtime_owner;
    cata::lua_platform::game_handle_runtime runtime;
    cata::lua_platform::game_handle_runtime active_runtime;
    std::size_t active_world_generation;
    sol::state lua;
    sol::table services;
    tripoint_bub_ms source_local = tripoint_bub_ms::zero;
    tripoint_bub_ms target_local = tripoint_bub_ms::zero;
    tripoint_abs_ms source_abs = tripoint_abs_ms::invalid;
    tripoint_abs_ms target_abs = tripoint_abs_ms::invalid;
    vehicle *test_vehicle = nullptr;
    vehicle *target_blocker_vehicle = nullptr;
    vehicle_part *live_part = nullptr;
    std::vector<shared_ptr_fast<monster>> extra_monsters;
    cata::lua_platform::game_handle vehicle_handle;
    cata::lua_platform::game_handle vehicle_part_handle;
    std::size_t vehicle_identity_generation = 0;
    std::size_t part_identity_generation = 0;
    std::uint64_t epoch_before = 0;
    std::uint64_t epoch_after = 0;
    bool write_called = false;
};

struct platform_mapgen_callback_transaction_test_fixture {
    platform_mapgen_callback_transaction_test_fixture() :
        local_map( ter_str_id( "t_floor" ).id() ),
        data( *local_map.cast_to_map(), mapgendata::dummy_settings ),
        context( data, true, UINT64_C( 0x6a09e667f3bcc909 ) ) {
        native_map().ter_set( position(), ter_str_id( "t_floor" ).id() );
        data.set_dir( 0, direction_before );
    }

    map &native_map() {
        return *local_map.cast_to_map();
    }

    static tripoint_bub_ms position() {
        return tripoint_bub_ms( 1, 1, 0 );
    }

    small_fake_map local_map;
    mapgendata data;
    cata::lua_platform::script_mapgen_context context;
    sol::state lua;
    const int direction_before = 37;
};

} // namespace
