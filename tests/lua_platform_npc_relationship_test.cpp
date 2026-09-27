#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <cstddef>
#include <cstdint>
#include <functional>
#include <initializer_list>
#include <list>
#include <optional>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "condition.h"
#include "coordinates.h"
#include "dialogue.h"
#include "faction.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_location.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_factions.h"
#include "lua_platform_handle.h"
#include "lua_platform_items.h"
#include "lua_platform_npcs.h"
#include "lua_platform_sol.h"
#include "map.h"
#include "map_helpers.h"
#include "npc.h"
#include "npctalk.h"
#include "point.h"
#include "pocket_type.h"
#include "player_helpers.h"
#include "type_id.h"

static const itype_id itype_apple( "apple" );
static const itype_id itype_backpack( "backpack" );
static const itype_id itype_bandages( "bandages" );
static const itype_id itype_rock( "rock" );

TEST_CASE( "lua_platform_npc_follow_preserves_native_state_transitions",
           "[lua][platform][npc][semantic]" )
{
    clear_avatar();
    clear_npcs();
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
        clear_avatar();
    } );
    avatar &player = get_avatar();
    npc &legacy = spawn_npc( player.pos_bub().xy() + point::south, "thug" );
    npc &migrated = spawn_npc( player.pos_bub().xy() + point::north, "thug" );
    for( npc *subject : {
             &legacy, &migrated
         } ) {
        subject->set_attitude( NPCATT_FOLLOW );
        subject->set_mission( NPC_MISSION_GUARD );
        subject->goal = tripoint_abs_omt( 12, 13, 0 );
        subject->guard_pos = tripoint_abs_ms( 24, 25, 0 );
        subject->set_ai_guard_pos( tripoint_abs_ms( 26, 27, 0 ) );
        subject->set_committed_goal( "patrol" );
        subject->cash = 47;
        subject->custom_profession = "test profession";
    }
    const bool temporary = GENERATE( false, true );
    player.cash = 100;
    if( temporary ) {
        talk_function::follow_only( legacy );
    } else {
        talk_function::follow( legacy );
    }
    const int expected_player_cash = player.cash;
    player.cash = 100;

    namespace platform = cata::lua_platform;
    sol::state lua;
    sol::table services = lua.create_table();
    const platform::game_handle_runtime_owner_ptr owner = platform::make_game_handle_runtime_owner();
    const platform::game_handle_runtime runtime{ owner, 1 };
    platform::install_value_type_api( lua, services, []() {} );
    platform::install_game_handle_api( lua, services, [&]() {
        return runtime;
    },
    []() {
        return 1;
    }, []() {} );
    platform::install_npc_api( services, [&]() {
        return runtime;
    },
    []() {
        return 1;
    }, []() {}, []() {}, []() {} );
    platform::register_npc_handle_identity( migrated );
    const platform::game_handle npc_handle = platform::game_handle::from_creature(
                migrated, { "npc", migrated.getID().get_value(), 0, 0, 0, {} }, runtime, 1 );
    const platform::game_handle avatar_handle = platform::game_handle::from_creature(
                player, { "avatar", player.getID().get_value(), 0, 0, 0, {} }, runtime, 1 );
    sol::protected_function function = services["npcs"][temporary ? "follow_temporarily" :
                                       "join_player"];
    sol::protected_function_result call = temporary ? function( npc_handle ) :
                                          function( npc_handle, avatar_handle );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    if( temporary ) {
        CHECK( result["value"]["changed"].get<bool>() );
    }
    CHECK( migrated.get_attitude() == legacy.get_attitude() );
    CHECK( migrated.mission == legacy.mission );
    CHECK( migrated.mission == NPC_MISSION_NULL );
    CHECK( migrated.goal == npc::no_goal_point );
    CHECK_FALSE( migrated.guard_pos );
    CHECK_FALSE( migrated.get_ai_guard_pos() );
    CHECK( migrated.get_committed_goal().empty() );
    CHECK( migrated.cash == legacy.cash );
    CHECK( player.cash == expected_player_cash );
    CHECK( migrated.custom_profession == legacy.custom_profession );
    if( !temporary ) {
        CHECK( migrated.get_faction()->id == legacy.get_faction()->id );
        CHECK( player.follower_ids.count( migrated.getID() ) == 1 );
    }
}

TEST_CASE( "lua_platform_drop_stolen_items_matches_native_item_return",
           "[lua][platform][npc][items][semantic]" )
{
    clear_avatar();
    clear_npcs();
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
        clear_avatar();
        clear_map_without_vision();
    } );

    g->faction_manager_ptr->create_if_needed();
    avatar &setup_player = get_avatar();
    npc &subject = spawn_npc( setup_player.pos_bub().xy() + point::east, "thug" );
    subject.set_fac( faction_id( "your_followers" ) );
    REQUIRE( subject.get_faction() != nullptr );
    const faction_id owner = subject.get_faction()->id;

    struct stolen_inventory {
        item *flat = nullptr;
        item *container = nullptr;
        item *nested = nullptr;
        item *retained = nullptr;
    };
    const auto add_inventory = [&]( avatar &holder ) {
        stolen_inventory added;
        item flat( itype_rock, calendar::turn_zero );
        if( !holder.wield( flat, std::nullopt, false ) ) {
            return added;
        }
        item_location flat_location = holder.get_wielded_item();
        if( !flat_location ) {
            return added;
        }
        flat_location->set_old_owner( owner );
        added.flat = flat_location.get_item();

        item container( itype_backpack, calendar::turn_zero );
        item nested( itype_bandages, calendar::turn_zero );
        nested.set_old_owner( owner );
        if( !container.put_in( nested, pocket_type::CONTAINER ).success() ) {
            return stolen_inventory{};
        }
        item retained( itype_apple, calendar::turn_zero );
        if( !container.put_in( retained, pocket_type::CONTAINER ).success() ) {
            return stolen_inventory{};
        }
        const std::optional<std::list<item>::iterator> worn = holder.wear_item( container, false );
        if( !worn ) {
            return stolen_inventory{};
        }
        added.container = &**worn;
        for( item *const contained : added.container->all_items_top() ) {
            if( contained->typeId() == itype_bandages ) {
                added.nested = contained;
            } else if( contained->typeId() == itype_apple ) {
                added.retained = contained;
            }
        }
        return added;
    };
    const auto ground_signature = []( const tripoint_bub_ms &position ) {
        std::vector<std::pair<std::string, std::string>> result;
        const map_stack ground = get_map().i_at( position );
        for( const item &entry : ground ) {
            result.emplace_back( entry.typeId().str(), entry.get_owner().str() );
        }
        return result;
    };
    const auto contains_type = []( const Character &holder, const itype_id &type ) {
        return holder.has_item_with( [&type]( const item &entry ) {
            return entry.typeId() == type;
        } );
    };
    const auto contains_item = []( const Character &holder, const item *candidate ) {
        return holder.has_item_with( [candidate]( const item &entry ) {
            return &entry == candidate;
        } );
    };
    const auto is_in_native_inventory_dump = []( const avatar &holder, const item *candidate ) {
        for( const item *entry : holder.inv_dump() ) {
            if( entry == candidate ) {
                return true;
            }
        }
        return false;
    };

    avatar &native_player = get_avatar();
    const stolen_inventory native_items = add_inventory( native_player );
    REQUIRE( native_items.flat != nullptr );
    REQUIRE( native_items.container != nullptr );
    REQUIRE( native_items.nested != nullptr );
    REQUIRE( native_items.retained != nullptr );
    REQUIRE( is_in_native_inventory_dump( native_player, native_items.flat ) );
    REQUIRE( is_in_native_inventory_dump( native_player, native_items.container ) );
    REQUIRE( contains_item( native_player, native_items.nested ) );
    REQUIRE( contains_item( native_player, native_items.retained ) );
    subject.known_stolen_item = native_items.flat;
    subject.set_attitude( NPCATT_MUG );
    native_player.start_hauling( {} );
    REQUIRE( native_player.is_hauling() );
    const tripoint_bub_ms native_position = native_player.pos_bub();

    // The native dialogue effect's static WRAP calls this exact NPC overload;
    // compare its recursive item selection and state changes with the service.
    talk_function::drop_stolen_item( subject );
    const auto native_ground = ground_signature( native_position );
    REQUIRE( native_ground.size() == 2 );
    CHECK_FALSE( contains_type( native_player, itype_rock ) );
    CHECK_FALSE( contains_type( native_player, itype_bandages ) );
    CHECK( contains_type( native_player, itype_apple ) );
    CHECK_FALSE( native_player.is_hauling() );
    CHECK( subject.known_stolen_item == nullptr );
    CHECK( subject.get_attitude() == NPCATT_NULL );
    CHECK( native_ground[0].second == owner.str() );
    CHECK( native_ground[1].second == owner.str() );

    clear_avatar();
    get_map().i_clear( native_position );
    avatar &platform_player = get_avatar();
    const stolen_inventory platform_items = add_inventory( platform_player );
    REQUIRE( platform_items.flat != nullptr );
    REQUIRE( platform_items.container != nullptr );
    REQUIRE( platform_items.nested != nullptr );
    REQUIRE( platform_items.retained != nullptr );
    REQUIRE( is_in_native_inventory_dump( platform_player, platform_items.flat ) );
    REQUIRE( is_in_native_inventory_dump( platform_player, platform_items.container ) );
    REQUIRE( contains_item( platform_player, platform_items.nested ) );
    REQUIRE( contains_item( platform_player, platform_items.retained ) );
    subject.known_stolen_item = platform_items.flat;
    subject.set_attitude( NPCATT_MUG );
    platform_player.start_hauling( {} );
    REQUIRE( platform_player.is_hauling() );
    const tripoint_bub_ms platform_position = platform_player.pos_bub();

    namespace platform = cata::lua_platform;
    sol::state lua;
    sol::table services = lua.create_table();
    const platform::game_handle_runtime_owner_ptr runtime_owner =
        platform::make_game_handle_runtime_owner();
    const platform::game_handle_runtime runtime{ runtime_owner, 247 };
    platform::install_value_type_api( lua, services, []() {} );
    platform::install_game_handle_api( lua, services, [&]() {
        return runtime;
    }, []() {
        return std::size_t( 1 );
    }, []() {} );
    platform::install_npc_api( services, [&]() {
        return runtime;
    }, []() {
        return std::size_t( 1 );
    }, []() {}, []() {}, []() {} );
    platform::register_npc_handle_identity( subject );
    const platform::game_handle npc_handle = platform::game_handle::from_creature(
                subject, { "npc", subject.getID().get_value(), 0, 0, 0, {} }, runtime, 1 );
    const auto make_item_handle = [&]( item &entry ) {
        return platform::game_handle::from_item(
                   entry, { "character_inventory", entry.uid().get_value(), 0, 0, 0, {} },
                   runtime, 1 );
    };
    const platform::game_handle flat_handle = make_item_handle( *platform_items.flat );
    const platform::game_handle nested_handle = make_item_handle( *platform_items.nested );
    const platform::game_handle container_handle = make_item_handle( *platform_items.container );
    const platform::game_handle retained_handle = make_item_handle( *platform_items.retained );
    const std::uint64_t generation_before = platform::item_holder_mutation_generation();

    const sol::protected_function drop_stolen_items =
        services["npcs"]["drop_stolen_items"];
    const sol::protected_function_result call = drop_stolen_items( npc_handle );
    REQUIRE( call.valid() );
    const sol::table envelope = call;
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"];
    CHECK( value["dropped"].get<bool>() );
    CHECK( value["claim_cleared"].get<bool>() );

    const auto platform_ground = ground_signature( platform_position );
    CHECK( platform_ground == native_ground );
    CHECK_FALSE( contains_type( platform_player, itype_rock ) );
    CHECK_FALSE( contains_type( platform_player, itype_bandages ) );
    CHECK( contains_type( platform_player, itype_apple ) );
    CHECK_FALSE( platform_player.is_hauling() );
    CHECK( subject.known_stolen_item == nullptr );
    CHECK( subject.get_attitude() == NPCATT_NULL );
    CHECK( platform::item_holder_mutation_generation() == generation_before + 1 );
    CHECK( flat_handle.validation_error( runtime, 1 ) );
    CHECK( nested_handle.validation_error( runtime, 1 ) );
    CHECK_FALSE( container_handle.validation_error( runtime, 1 ) );
    CHECK_FALSE( retained_handle.validation_error( runtime, 1 ) );
    const std::list<item *> remaining_container_contents =
        platform_items.container->all_items_top();
    REQUIRE( remaining_container_contents.size() == 1 );
    CHECK( remaining_container_contents.front() == platform_items.retained );
    platform::retire_npc_handle_identity( subject );
}

TEST_CASE( "lua_migrated_social_conditions_match_native_talker_slots",
           "[lua][platform][npc][conditions][semantic]" )
{
    clear_avatar();
    clear_npcs();
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
        clear_avatar();
    } );
    avatar &player = get_avatar();
    npc &alpha = spawn_npc( player.pos_bub().xy() + point::south, "thug" );
    npc &beta = spawn_npc( player.pos_bub().xy() + point::north, "thug" );
    alpha.set_fac( faction_id( "your_followers" ) );
    beta.set_fac( faction_id( "hells_raiders" ) );
    alpha.set_attitude( NPCATT_FOLLOW );
    beta.set_attitude( NPCATT_KILL );
    alpha.op_of_u.owed = 3;
    beta.op_of_u.owed = 8;
    faction *alpha_faction = alpha.get_faction();
    faction *beta_faction = beta.get_faction();
    REQUIRE( alpha_faction != nullptr );
    REQUIRE( beta_faction != nullptr );
    REQUIRE( alpha_faction != beta_faction );
    const int previous_alpha_trust = alpha_faction->trusts_u;
    const int previous_beta_trust = beta_faction->trusts_u;
    const on_out_of_scope restore_trust( [alpha_faction, beta_faction,
    previous_alpha_trust, previous_beta_trust]() {
        alpha_faction->trusts_u = previous_alpha_trust;
        beta_faction->trusts_u = previous_beta_trust;
    } );
    alpha_faction->trusts_u = 1;
    beta_faction->trusts_u = 8;

    dialogue context( get_talker_for( alpha ), get_talker_for( beta ) );
    const conditional_t owed_condition( json_loader::from_string(
            R"({"u_are_owed":8})" ).get_object() );
    const conditional_t trust_condition( json_loader::from_string(
            R"({"u_has_faction_trust":8})" ).get_object() );
    const conditional_t friend_condition( "u_friend" );

    namespace platform = cata::lua_platform;
    sol::state lua;
    sol::table services = lua.create_table();
    const platform::game_handle_runtime_owner_ptr owner =
        platform::make_game_handle_runtime_owner();
    const platform::game_handle_runtime runtime{ owner, 1 };
    const auto current_world = []() {
        return std::size_t( 1 );
    };
    platform::install_value_type_api( lua, services, []() {} );
    platform::install_game_handle_api( lua, services, [runtime]() {
        return runtime;
    }, current_world, []() {} );
    platform::install_npc_api( services, [runtime]() {
        return runtime;
    }, current_world, []() {}, []() {}, []() {} );
    platform::install_faction_api( services, [runtime]() {
        return runtime;
    }, current_world, []() {}, []() {} );
    platform::register_npc_handle_identity( alpha );
    platform::register_npc_handle_identity( beta );
    const platform::game_handle alpha_handle = platform::game_handle::from_creature(
            alpha, { "npc", alpha.getID().get_value(), 0, 0, 0, {} }, runtime, 1 );
    const platform::game_handle beta_handle = platform::game_handle::from_creature(
            beta, { "npc", beta.getID().get_value(), 0, 0, 0, {} }, runtime, 1 );

    const sol::protected_function get_npc = services["npcs"]["get"];
    sol::protected_function_result alpha_call = get_npc( alpha_handle );
    REQUIRE( alpha_call.valid() );
    const sol::table alpha_result = alpha_call;
    REQUIRE( alpha_result["ok"].get<bool>() );
    const sol::table alpha_snapshot = alpha_result["value"];
    sol::protected_function_result beta_call = get_npc( beta_handle );
    REQUIRE( beta_call.valid() );
    const sol::table beta_result = beta_call;
    REQUIRE( beta_result["ok"].get<bool>() );
    const sol::table beta_snapshot = beta_result["value"];
    const sol::protected_function for_character =
        services["factions"]["for_character"];
    sol::protected_function_result alpha_faction_call = for_character( alpha_handle );
    REQUIRE( alpha_faction_call.valid() );
    const sol::table alpha_faction_result = alpha_faction_call;
    REQUIRE( alpha_faction_result["ok"].get<bool>() );
    const sol::table alpha_faction_snapshot = alpha_faction_result["value"];
    sol::protected_function_result faction_call = for_character( beta_handle );
    REQUIRE( faction_call.valid() );
    const sol::table faction_result = faction_call;
    REQUIRE( faction_result["ok"].get<bool>() );
    const sol::table faction_snapshot = faction_result["value"];

    const bool owed_from_platform =
        beta_snapshot["opinion"]["owed"].get<int>() >= 8;
    const bool trust_from_platform =
        faction_snapshot["reputation"]["trusts"].get<int>() >= 8;
    const bool friend_from_platform =
        alpha_snapshot["friendly"].get<bool>();
    CHECK( beta_snapshot["opinion"]["owed"].get<int>() == 8 );
    CHECK( alpha_faction_snapshot["reputation"]["trusts"].get<int>() == 1 );
    CHECK( faction_snapshot["reputation"]["trusts"].get<int>() == 8 );
    CHECK( owed_condition( context ) == owed_from_platform );
    CHECK( owed_from_platform );
    CHECK( trust_condition( context ) == trust_from_platform );
    CHECK( trust_from_platform );
    CHECK( friend_condition( context ) == friend_from_platform );
    CHECK( friend_from_platform );
    CHECK_FALSE( beta_snapshot["friendly"].get<bool>() );
}
#endif
