#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"

TEST_CASE( "lua_platform_zones_read_surface_uses_read_gate",
           "[lua][platform][zones]" )
{
    platform_zones_read_fixture fixture;
    const sol::table zones = fixture.services["zones"];
    REQUIRE( zones.valid() );
    CHECK( zones["types"].valid() );
    CHECK( zones["type"].valid() );
    CHECK( zones["list"].valid() );
    CHECK( zones["at"].valid() );
    CHECK( zones["get"].valid() );
    CHECK( zones["contains"].valid() );

    const sol::protected_function_result types_result = zones["types"]();
    REQUIRE( types_result.valid() );
    const sol::table types_page = types_result.get<sol::table>();
    REQUIRE( types_page.valid() );
    const sol::table type_items = types_page["items"].get<sol::table>();
    REQUIRE( type_items.valid() );
    REQUIRE( types_page["returned"].valid() );

    const sol::protected_function_result list_result = zones["list"]();
    REQUIRE( list_result.valid() );
    const sol::table list_envelope = list_result.get<sol::table>();
    REQUIRE( list_envelope.valid() );
    REQUIRE( list_envelope["ok"].get<bool>() );
    const sol::table list_value = list_envelope["value"].get<sol::table>();
    REQUIRE( list_value.valid() );
    const sol::table list_items = list_value["items"].get<sol::table>();
    REQUIRE( list_items.valid() );

    CHECK( fixture.read_gate_calls > 0 );
    CHECK( fixture.write_gate_calls == 0 );
}

TEST_CASE( "lua_platform_zones_mutation_and_token_surface",
           "[lua][platform][zones][contract]" )
{
    platform_zones_read_fixture fixture;
    const sol::table zones = fixture.services["zones"];
    REQUIRE( zones.valid() );

    CHECK( zones["create"].valid() );
    CHECK( zones["rename"].valid() );
    CHECK( zones["set_enabled"].valid() );
    CHECK( zones["set_temporary_disabled"].valid() );
    CHECK( zones["set_position"].valid() );
    CHECK( zones["remove"].valid() );

    const sol::object zone_token_type = fixture.lua["ZoneToken"];
    REQUIRE( zone_token_type.valid() );
    CHECK( zone_token_type.get_type() == sol::type::table );

    const sol::table list_options = fixture.lua.create_table_with(
                                        "kind", "global" );
    const sol::protected_function_result list_result = zones["list"](
                list_options );
    REQUIRE( list_result.valid() );
    const sol::table list_envelope = list_result.get<sol::table>();
    REQUIRE( list_envelope["ok"].get<bool>() );
    const sol::table list_value = list_envelope["value"].get<sol::table>();
    REQUIRE( list_value.valid() );
    const sol::table list_items = list_value["items"].get<sol::table>();
    REQUIRE( list_items.valid() );
    const std::size_t returned = list_value["returned"].get<std::size_t>();
    for( std::size_t index = 1; index <= returned; ++index ) {
        const sol::object item_object = list_items[index];
        REQUIRE( item_object.is<sol::table>() );
        const sol::table item = item_object.as<sol::table>();
        CHECK( item["kind"].get<std::string>() == "global" );
    }
}

TEST_CASE( "lua_platform_zones_rejects_wrong_game_id_kinds",
           "[lua][platform][zones][contract]" )
{
    platform_zones_read_fixture fixture;
    const sol::table zones = fixture.services["zones"];
    REQUIRE( zones.valid() );

    const auto &zone_types = zone_manager::get_manager().get_types();
    const auto valid_type = std::find_if(
                                zone_types.begin(), zone_types.end(),
    []( const auto &entry ) {
        return entry.first.is_valid();
    } );
    REQUIRE( valid_type != zone_types.end() );

    const sol::protected_function type = zones["type"];
    const sol::protected_function_result wrong_type_result = type(
                cata::lua_platform::script_game_id(
                    "terrain", "t_floor" ) );
    CHECK_FALSE( wrong_type_result.valid() );

    const sol::table wrong_faction_options = fixture.lua.create_table_with(
                                                 "faction",
                                                 cata::lua_platform::script_game_id(
                                                     "zone", valid_type->first.str() ) );
    const sol::protected_function list = zones["list"];
    const sol::protected_function_result wrong_faction_result = list(
                wrong_faction_options );
    CHECK_FALSE( wrong_faction_result.valid() );

    const faction_id faction( "your_followers" );
    std::ostringstream zone_name_stream;
    zone_name_stream << "lua_platform_wrong_kind_"
                     << static_cast<const void *>( &fixture );
    const std::string zone_name = zone_name_stream.str();
    const cata::lua_platform::script_tripoint_coord position =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square,
            tripoint_abs_ms::zero.raw() );
    const sol::table wrong_create_options = fixture.lua.create_table_with(
                                                "name", zone_name,
                                                "type",
                                                cata::lua_platform::script_game_id(
                                                    "faction", faction.str() ),
                                                "faction",
                                                cata::lua_platform::script_game_id(
                                                    "faction", faction.str() ),
                                                "start", position,
                                                "end", position,
                                                "kind", "global" );
    const sol::protected_function create = zones["create"];
    const sol::protected_function_result wrong_create_result = create(
                wrong_create_options );
    CHECK_FALSE( wrong_create_result.valid() );

    bool matching_zone_found = false;
    for( zone_manager::ref_zone_data candidate :
         zone_manager::get_manager().get_zones( faction ) ) {
        if( candidate.get().get_name() == zone_name ) {
            matching_zone_found = true;
            break;
        }
    }
    CHECK_FALSE( matching_zone_found );
}

TEST_CASE( "lua_platform_zones_vehicle_create_fails_closed",
           "[lua][platform][zones][contract]" )
{
    platform_zones_read_fixture fixture;
    const sol::table zones = fixture.services["zones"];
    REQUIRE( zones.valid() );

    std::ostringstream zone_name_stream;
    zone_name_stream << "lua_platform_vehicle_rejected_"
                     << static_cast<const void *>( &fixture );
    const std::string zone_name = zone_name_stream.str();

    const auto &zone_types = zone_manager::get_manager().get_types();
    const auto valid_type = std::find_if(
                                zone_types.begin(), zone_types.end(),
    []( const auto &entry ) {
        return entry.first.is_valid();
    } );
    REQUIRE( valid_type != zone_types.end() );

    const cata::lua_platform::script_tripoint_coord position =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square,
            tripoint_abs_ms::zero.raw() );
    const sol::table create_options = fixture.lua.create_table_with(
                                          "name", zone_name,
                                          "type",
                                          cata::lua_platform::script_game_id(
                                              "zone", valid_type->first.str() ),
                                          "start", position,
                                          "end", position,
                                          "kind", "vehicle" );
    const sol::protected_function create = zones["create"];
    const sol::protected_function_result create_result = create(
                create_options );
    REQUIRE( create_result.valid() );
    const sol::table create_envelope = create_result.get<sol::table>();
    REQUIRE_FALSE( create_envelope["ok"].get<bool>() );
    const sol::table error = create_envelope["error"].get<sol::table>();
    REQUIRE( error.valid() );
    CHECK( error["code"].get<std::string>() ==
           "unsupported_vehicle_mutation" );
    CHECK( fixture.write_gate_calls > 0 );

    bool matching_zone_found = false;
    for( zone_manager::ref_zone_data candidate :
         zone_manager::get_manager().get_zones(
             faction_id( "your_followers" ) ) ) {
        if( candidate.get().get_name() == zone_name ) {
            matching_zone_found = true;
            break;
        }
    }
    CHECK_FALSE( matching_zone_found );
}

TEST_CASE( "lua_platform_zones_create_and_remove_global_zone",
           "[lua][platform][zones]" )
{
    platform_zones_read_fixture fixture;
    const sol::table zones = fixture.services["zones"];
    REQUIRE( zones.valid() );

    const faction_id faction( "your_followers" );
    std::ostringstream zone_name_stream;
    zone_name_stream << "lua_platform_global_"
                     << static_cast<const void *>( &fixture );
    const std::string zone_name = zone_name_stream.str();
    on_out_of_scope cleanup( [&zone_name, faction]() {
        zone_manager &manager = zone_manager::get_manager();
        bool removed_any = false;
        while( true ) {
            zone_data *residual = nullptr;
            for( zone_manager::ref_zone_data candidate :
                 manager.get_zones( faction ) ) {
                if( candidate.get().get_name() == zone_name ) {
                    residual = &candidate.get();
                    break;
                }
            }
            if( residual == nullptr || !manager.remove( *residual ) ) {
                break;
            }
            removed_any = true;
        }
        if( removed_any ) {
            manager.cache_data();
        }
    } );

    const auto &zone_types = zone_manager::get_manager().get_types();
    const auto valid_type = std::find_if(
                                zone_types.begin(), zone_types.end(),
    []( const auto &entry ) {
        return entry.first.is_valid();
    } );
    REQUIRE( valid_type != zone_types.end() );

    REQUIRE( g != nullptr );
    map &here = get_map();
    const tripoint_bub_ms avatar_position = get_avatar().pos_bub();
    std::optional<tripoint_bub_ms> global_position;
    for( const tripoint_bub_ms &candidate :
         here.points_in_radius( avatar_position, 3 ) ) {
        if( !here.veh_at( candidate ) ) {
            global_position = candidate;
            break;
        }
    }
    REQUIRE( global_position.has_value() );
    const tripoint_abs_ms global_abs_position =
        here.get_abs( *global_position );
    const cata::lua_platform::script_tripoint_coord position =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::abs, coords::scale::map_square,
            global_abs_position.raw() );

    const sol::table create_options = fixture.lua.create_table_with(
                                          "name", zone_name,
                                          "type",
                                          cata::lua_platform::script_game_id(
                                              "zone", valid_type->first.str() ),
                                          "faction",
                                          cata::lua_platform::script_game_id(
                                              "faction", faction.str() ),
                                          "start", position,
                                          "end", position,
                                          "kind", "global" );
    const sol::protected_function create = zones["create"];
    const int write_gates_before_create = fixture.write_gate_calls;
    const sol::protected_function_result create_result = create(
                create_options );
    REQUIRE( create_result.valid() );
    CHECK( fixture.write_gate_calls == write_gates_before_create + 1 );
    const sol::table create_envelope = create_result.get<sol::table>();
    REQUIRE( create_envelope["ok"].get<bool>() );
    const sol::table snapshot = create_envelope["value"].get<sol::table>();
    REQUIRE( snapshot.valid() );
    CHECK( snapshot["kind"].get<std::string>() == "global" );
    CHECK_FALSE( snapshot["personal"].get<bool>() );
    CHECK_FALSE( snapshot["vehicle"].get<bool>() );

    const sol::object token_object = snapshot["token"];
    REQUIRE( token_object.is<sol::userdata>() );
    const sol::userdata token = token_object;
    REQUIRE( token.valid() );
    const sol::protected_function token_is_valid = token["is_valid"];
    const sol::protected_function token_status = token["status"];

    const int read_gates_before_token = fixture.read_gate_calls;
    const sol::protected_function_result valid_result = token_is_valid( token );
    REQUIRE( valid_result.valid() );
    CHECK( valid_result.get<bool>() );
    const sol::protected_function_result status_result = token_status( token );
    REQUIRE( status_result.valid() );
    const sol::table status_envelope = status_result.get<sol::table>();
    REQUIRE( status_envelope["ok"].get<bool>() );
    CHECK( fixture.read_gate_calls >= read_gates_before_token + 2 );

    const sol::protected_function remove = zones["remove"];
    const int write_gates_before_remove = fixture.write_gate_calls;
    const sol::protected_function_result remove_result = remove( token );
    REQUIRE( remove_result.valid() );
    CHECK( fixture.write_gate_calls == write_gates_before_remove + 1 );
    const sol::table remove_envelope = remove_result.get<sol::table>();
    REQUIRE( remove_envelope["ok"].get<bool>() );
    CHECK( remove_envelope["value"].get<sol::table>()
           ["removed"].get<bool>() );

    const sol::protected_function_result invalid_result = token_is_valid( token );
    REQUIRE( invalid_result.valid() );
    CHECK_FALSE( invalid_result.get<bool>() );

    const sol::protected_function_result status_after_remove = token_status(
                token );
    REQUIRE( status_after_remove.valid() );
    const sol::table status_after_remove_envelope =
        status_after_remove.get<sol::table>();
    REQUIRE_FALSE( status_after_remove_envelope["ok"].get<bool>() );
    const sol::table status_after_remove_error =
        status_after_remove_envelope["error"].get<sol::table>();
    REQUIRE( status_after_remove_error.valid() );
    CHECK( status_after_remove_error["code"].get<std::string>() ==
           "not_found" );
}

TEST_CASE( "lua_platform_zones_create_move_and_remove_personal_zone",
           "[lua][platform][zones]" )
{
    platform_zones_read_fixture fixture;
    const sol::table zones = fixture.services["zones"];
    REQUIRE( zones.valid() );

    const faction_id faction( "your_followers" );
    std::ostringstream zone_name_stream;
    zone_name_stream << "lua_platform_personal_"
                     << static_cast<const void *>( &fixture );
    const std::string zone_name = zone_name_stream.str();
    on_out_of_scope cleanup( [&zone_name, faction]() {
        zone_manager &manager = zone_manager::get_manager();
        bool removed_any = false;
        while( true ) {
            zone_data *residual = nullptr;
            for( zone_manager::ref_zone_data candidate :
                 manager.get_zones( faction ) ) {
                if( candidate.get().get_name() == zone_name ) {
                    residual = &candidate.get();
                    break;
                }
            }
            if( residual == nullptr || !manager.remove( *residual ) ) {
                break;
            }
            removed_any = true;
        }
        if( removed_any ) {
            manager.cache_data();
        }
    } );

    const sol::protected_function_result types_result = zones["types"]();
    REQUIRE( types_result.valid() );
    const sol::table types_page = types_result.get<sol::table>();
    const sol::table type_items = types_page["items"].get<sol::table>();
    REQUIRE( type_items.valid() );

    std::optional<cata::lua_platform::script_game_id> personal_type;
    for( const auto &entry : type_items ) {
        if( !entry.second.is<sol::table>() ) {
            continue;
        }
        const sol::table type_snapshot = entry.second.as<sol::table>();
        if( !type_snapshot["can_be_personal"].get<bool>() ) {
            continue;
        }
        const sol::object type_id = type_snapshot["id"];
        REQUIRE( type_id.is<cata::lua_platform::script_game_id>() );
        personal_type = type_id.as<cata::lua_platform::script_game_id>();
        break;
    }
    REQUIRE( personal_type.has_value() );

    const cata::lua_platform::script_tripoint_coord initial_start =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::relative, coords::scale::map_square,
            tripoint_rel_ms( -4, -3, 0 ).raw() );
    const cata::lua_platform::script_tripoint_coord initial_end =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::relative, coords::scale::map_square,
            tripoint_rel_ms( 2, 1, 0 ).raw() );
    const sol::table create_options = fixture.lua.create_table_with(
                                          "name", zone_name,
                                          "type", personal_type.value(),
                                          "faction",
                                          cata::lua_platform::script_game_id(
                                              "faction", faction.str() ),
                                          "start", initial_start,
                                          "end", initial_end,
                                          "kind", "personal" );
    const sol::protected_function create = zones["create"];
    const sol::protected_function_result create_result = create(
                create_options );
    REQUIRE( create_result.valid() );
    const sol::table create_envelope = create_result.get<sol::table>();
    REQUIRE( create_envelope["ok"].get<bool>() );
    const sol::table snapshot = create_envelope["value"].get<sol::table>();
    REQUIRE( snapshot.valid() );
    CHECK( snapshot["kind"].get<std::string>() == "personal" );
    CHECK( snapshot["personal"].get<bool>() );
    CHECK_FALSE( snapshot["vehicle"].get<bool>() );

    const sol::object relative_start_object = snapshot["relative_start"];
    const sol::object relative_end_object = snapshot["relative_end"];
    REQUIRE( relative_start_object.is<
              cata::lua_platform::script_tripoint_coord>() );
    REQUIRE( relative_end_object.is<
              cata::lua_platform::script_tripoint_coord>() );
    const cata::lua_platform::script_tripoint_coord created_start =
        relative_start_object.as<cata::lua_platform::script_tripoint_coord>();
    const cata::lua_platform::script_tripoint_coord created_end =
        relative_end_object.as<cata::lua_platform::script_tripoint_coord>();
    CHECK( created_start.native_origin() == coords::origin::relative );
    CHECK( created_start.native_scale() == coords::scale::map_square );
    CHECK( created_end.native_origin() == coords::origin::relative );
    CHECK( created_end.native_scale() == coords::scale::map_square );
    CHECK( created_start == initial_start );
    CHECK( created_end == initial_end );

    const sol::object token_object = snapshot["token"];
    REQUIRE( token_object.is<sol::userdata>() );
    const sol::userdata token = token_object;
    REQUIRE( token.valid() );
    const sol::protected_function token_is_valid = token["is_valid"];

    const cata::lua_platform::script_tripoint_coord moved_start =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::relative, coords::scale::map_square,
            tripoint_rel_ms( -1, -2, 0 ).raw() );
    const cata::lua_platform::script_tripoint_coord moved_end =
        cata::lua_platform::script_tripoint_coord::from_native(
            coords::origin::relative, coords::scale::map_square,
            tripoint_rel_ms( 3, 2, 0 ).raw() );
    const sol::protected_function set_position = zones["set_position"];
    const sol::protected_function_result set_position_result = set_position(
                token, moved_start, moved_end );
    REQUIRE( set_position_result.valid() );
    const sol::table set_position_envelope =
        set_position_result.get<sol::table>();
    REQUIRE( set_position_envelope["ok"].get<bool>() );
    const sol::table set_position_value =
        set_position_envelope["value"].get<sol::table>();
    REQUIRE( set_position_value.valid() );
    CHECK( set_position_value["changed"].get<bool>() );

    const sol::object after_start_object = set_position_value["after_start"];
    const sol::object after_end_object = set_position_value["after_end"];
    REQUIRE( after_start_object.is<
              cata::lua_platform::script_tripoint_coord>() );
    REQUIRE( after_end_object.is<
              cata::lua_platform::script_tripoint_coord>() );
    CHECK( after_start_object.as<cata::lua_platform::script_tripoint_coord>() ==
           moved_start );
    CHECK( after_end_object.as<cata::lua_platform::script_tripoint_coord>() ==
           moved_end );

    const sol::table moved_snapshot =
        set_position_value["zone"].get<sol::table>();
    REQUIRE( moved_snapshot.valid() );
    const sol::object moved_relative_start_object =
        moved_snapshot["relative_start"];
    const sol::object moved_relative_end_object =
        moved_snapshot["relative_end"];
    REQUIRE( moved_relative_start_object.is<
              cata::lua_platform::script_tripoint_coord>() );
    REQUIRE( moved_relative_end_object.is<
              cata::lua_platform::script_tripoint_coord>() );
    CHECK( moved_relative_start_object.as<
           cata::lua_platform::script_tripoint_coord>() == moved_start );
    CHECK( moved_relative_end_object.as<
           cata::lua_platform::script_tripoint_coord>() == moved_end );

    const sol::protected_function_result stale_after_move = token_is_valid(
                token );
    REQUIRE( stale_after_move.valid() );
    CHECK_FALSE( stale_after_move.get<bool>() );

    const sol::object moved_token_object = moved_snapshot["token"];
    REQUIRE( moved_token_object.is<sol::userdata>() );
    const sol::userdata moved_token = moved_token_object;
    REQUIRE( moved_token.valid() );
    const sol::protected_function moved_token_is_valid =
        moved_token["is_valid"];
    const sol::protected_function_result moved_token_valid =
        moved_token_is_valid( moved_token );
    REQUIRE( moved_token_valid.valid() );
    CHECK( moved_token_valid.get<bool>() );

    const sol::protected_function remove = zones["remove"];
    const sol::protected_function_result remove_result = remove( moved_token );
    REQUIRE( remove_result.valid() );
    const sol::table remove_envelope = remove_result.get<sol::table>();
    REQUIRE( remove_envelope["ok"].get<bool>() );
    CHECK( remove_envelope["value"].get<sol::table>()
           ["removed"].get<bool>() );

    const sol::protected_function_result stale_after_remove =
        moved_token_is_valid( moved_token );
    REQUIRE( stale_after_remove.valid() );
    CHECK_FALSE( stale_after_remove.get<bool>() );
}

TEST_CASE( "lua_platform_weather_read_contract_uses_weather_service",
           "[lua][platform][weather]" )
{
    platform_weather_read_fixture fixture;
    const sol::table weather = fixture.services["weather"];
    REQUIRE( weather.valid() );
    CHECK( weather["types"].valid() );
    CHECK( weather["type"].valid() );
    CHECK( weather["current"].valid() );
    CHECK( weather["generator"].valid() );
    CHECK( weather["forecast"].valid() );
    CHECK( weather["limits"].valid() );
    CHECK_FALSE( fixture.services["world"].valid() );
    CHECK_FALSE( fixture.services["game"].valid() );

    const sol::protected_function types = weather["types"];
    const sol::protected_function_result types_result = types();
    REQUIRE( types_result.valid() );

    const sol::protected_function type = weather["type"];
    const cata::lua_platform::script_game_id valid_id(
        "weather_type", "clear" );
    const sol::protected_function_result valid_type = type( valid_id );
    REQUIRE( valid_type.valid() );
    REQUIRE( valid_type.get<sol::table>().valid() );

    const cata::lua_platform::script_game_id invalid_id(
        "weather_type", "missing_weather_type" );
    const sol::protected_function_result invalid_type = type( invalid_id );
    CHECK_FALSE( invalid_type.valid() );

    REQUIRE( g != nullptr );
    const sol::protected_function_result current_result =
        weather["current"]();
    REQUIRE( current_result.valid() );
    CHECK( current_result.get<sol::table>().valid() );

    const sol::protected_function_result generator_result =
        weather["generator"]();
    REQUIRE( generator_result.valid() );
    const sol::protected_function_result forecast_result =
        weather["forecast"]();
    REQUIRE( forecast_result.valid() );
    const sol::protected_function_result limits_result =
        weather["limits"]();
    REQUIRE( limits_result.valid() );

    CHECK( fixture.read_gate_calls > 0 );
    CHECK( fixture.write_gate_calls == 0 );
}

#endif // CATA_ENABLE_LUA_PLATFORM
