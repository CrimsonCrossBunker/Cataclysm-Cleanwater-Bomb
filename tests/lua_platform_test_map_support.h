#pragma once

#include "lua_platform_test_support.h"

namespace cata::lua_platform::test
{
struct platform_overmap_travel_fixture {
    explicit platform_overmap_travel_fixture(
        const std::size_t runtime_number, const std::size_t world_number );

    ~platform_overmap_travel_fixture();

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
                                            const std::size_t world_number );

    ~platform_map_api_test_fixture();

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
        const std::size_t runtime_number, const std::size_t world_number );

    ~platform_monster_relocation_fixture();

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

    shared_ptr_fast<monster> add_monster( const tripoint_bub_ms &value );

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
        const std::size_t runtime_number, const std::size_t world_number );

    ~platform_avatar_relocation_fixture();

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

    shared_ptr_fast<monster> add_monster( const tripoint_bub_ms &value );

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
        const std::size_t runtime_number, const std::size_t world_number );

    ~platform_npc_relocation_fixture();

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
        const std::size_t runtime_number, const std::size_t world_number );

    ~platform_vehicle_relocation_fixture();

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

    shared_ptr_fast<monster> add_monster( const tripoint_bub_ms &value );

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
    platform_mapgen_callback_transaction_test_fixture();

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

} // namespace cata::lua_platform::test
