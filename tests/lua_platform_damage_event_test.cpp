#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <string>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "coordinates.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "lua_platform_loader.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "lua_platform_test_support.h"
#include "map_helpers.h"
#include "npc.h"
#include "player_helpers.h"
#include "type_id.h"

TEST_CASE( "lua_damage_event_keeps_data_without_rebinding_an_invalidated_target",
           "[lua][platform][event]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    clear_avatar();
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
        clear_npcs();
        clear_avatar();
    } );
    npc &target = spawn_npc( point_bub_ms( 65, 65 ), "test_talker" );

    class retire_target : public event_subscriber
    {
        public:
            explicit retire_target( npc &target ) : target( target ) {}
            using event_subscriber::notify;
            void notify( const cata::event &event ) override {
                if( enabled && event.type() == event_type::character_takes_damage &&
                    event.get<character_id>( "character" ) == target.getID() ) {
                    target.on_unload();
                }
            }
            bool enabled = false;
        private:
            npc &target;
    } retire_before_lua( target );
    get_event_bus().subscribe( &retire_before_lua );

    const platform_lua_test_directory directory;
    directory.write( "main.lua", R"lua(
local ccb = require("ccb")
retire_in_lua = false
killed = false
observed = 0
has_target = false
state_writable = false
outer_restored = false

ccb.runtime.handler("first", function(event)
    if retire_in_lua and event.data.character == victim_id then
        local result = ccb.services.characters.die(event.actors.character,
            { remove_corpse = true, suppress_message = true })
        killed = result.ok and result.value.dead
    end
end)
ccb.runtime.handler("observe", function(event)
    if event.data.character ~= victim_id then return end
    observed = observed + 1
    amount = event.data.damage
    pain = event.data.pain
    bodypart = event.data.bodypart
    damage_type = event.data_types.damage
    has_target = event.actors.character ~= nil or event.actors.speaker ~= nil
    state_writable = pcall(ccb.state.character.set, "damage_scope", "wrong")
end)
ccb.runtime.handler("outer", function()
    ccb.state.character.set("damage_scope", "outer")
    hit_victim()
    outer_restored = ccb.state.character.get("damage_scope") == "outer"
end)
ccb.runtime.on("game:character_takes_damage", "first")
ccb.runtime.on("game:character_takes_damage", "observe")
ccb.runtime.on("game:character_heals_damage", "outer")
)lua" );

    const std::string mod = "damage_event_lifetime";
    std::string error;
    REQUIRE( platform::prepare_mods( { { mod, directory.root, directory.root / "main.lua" } },
                                     error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    platform::runtime_world_ready( true );
    const auto owner = platform::detail::find_active_runtime( mod );
    REQUIRE( owner );
    sol::state &lua = *owner->lua;
    lua["victim_id"] = target.getID().get_value();
    const auto hit_victim = [&target]() {
        target.apply_damage( nullptr, body_part_torso, 1, true );
    };
    lua.set_function( "hit_victim", hit_victim );

    bool expect_target = false;
    SECTION( "a hit with a live target binds its character state" ) {
        expect_target = true;
        hit_victim();
    }

    SECTION( "a native subscriber invalidates the target before Lua runs" ) {
        retire_before_lua.enabled = true;
        hit_victim();
    }
    SECTION( "the invalidated event cannot inherit an enclosing character" ) {
        retire_before_lua.enabled = true;
        npc &enclosing = spawn_npc( point_bub_ms( 66, 65 ), "test_talker" );
        enclosing.mod_part_hp_cur( body_part_torso, -1 );
        enclosing.heal( body_part_torso, 1 );
        CHECK( lua["outer_restored"].get<bool>() );
    }
    SECTION( "the first Lua handler kills the target before the second one runs" ) {
        lua["retire_in_lua"] = true;
        hit_victim();
        CHECK( lua["killed"].get<bool>() );
    }

    CHECK( lua["observed"].get<int>() == 1 );
    CHECK( lua["amount"].get<int>() == 1 );
    CHECK( lua["pain"].get<int>() == 0 );
    CHECK( lua["bodypart"].get<std::string>() == "torso" );
    CHECK( lua["damage_type"].get<std::string>() == "int" );
    CHECK( lua["has_target"].get<bool>() == expect_target );
    CHECK( lua["state_writable"].get<bool>() == expect_target );
}

#endif // CATA_ENABLE_LUA_PLATFORM
