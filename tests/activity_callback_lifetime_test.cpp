#include <functional>
#include <memory>
#include <string>

#include "activity_actor.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_action_guard.h"
#include "coordinates.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "game.h"
#include "json.h"
#include "map_helpers.h"
#include "npc.h"
#include "player_activity.h"
#include "player_helpers.h"

namespace
{
const activity_id activity_wait( "ACT_WAIT" );

class callback_activity_actor : public activity_actor
{
    public:
        std::function<void( Character & )> on_start;
        std::function<void( Character & )> on_turn;
        std::function<void( Character & )> on_cancel;
        std::function<void( Character & )> on_finish;

        const activity_id &get_type() const override {
            return activity_wait;
        }
        void start( player_activity &act, Character &who ) override {
            act.moves_total = act.moves_left = 100;
            invoke( on_start, who );
        }
        void do_turn( player_activity &, Character &who ) override {
            invoke( on_turn, who );
        }
        void canceled( player_activity &, Character &who ) override {
            invoke( on_cancel, who );
        }
        void finish( player_activity &, Character &who ) override {
            invoke( on_finish, who );
        }
        std::unique_ptr<activity_actor> clone() const override {
            return std::make_unique<callback_activity_actor>( *this );
        }
        void serialize( JsonOut &json ) const override {
            json.write_null();
        }

    private:
        // A callback may replace the activity and destroy this actor.
        static void invoke( std::function<void( Character & )> callback, Character &who ) {
            if( callback ) {
                callback( who );
            }
        }
};

struct activity_start_counter : event_subscriber {
    using event_subscriber::notify;
    int starts = 0;
    void notify( const cata::event &event ) override {
        if( event.type() == event_type::character_starts_activity ) {
            ++starts;
        }
    }
};
} // namespace

TEST_CASE( "activity_callbacks_preserve_replacement_activity", "[activity_callback_lifetime]" )
{
    clear_avatar();
    avatar &who = get_avatar();
    const on_out_of_scope cleanup( []() {
        clear_avatar();
    } );
    callback_activity_actor actor;
    activity_start_counter counter;
    get_event_bus().subscribe( &counter );

    SECTION( "replacement_from_start_emits_only_its_own_start" ) {
        actor.on_start = []( Character & target ) {
            target.assign_activity( player_activity( activity_wait, 733 ) );
        };
        who.assign_activity( actor );
        CHECK( counter.starts == 1 );
    }
    SECTION( "replacement_from_cancel_is_not_canceled_by_the_outer_call" ) {
        actor.on_cancel = []( Character & target ) {
            target.assign_activity( player_activity( activity_wait, 733 ) );
        };
        who.assign_activity( actor );
        who.cancel_activity();
        CHECK( counter.starts == 2 );
    }
    CHECK( who.activity.id() == activity_wait );
    CHECK( who.activity.moves_left == 733 );
}

TEST_CASE( "cancel_callback_can_clear_itself_without_skipping_backlog_cleanup",
           "[activity_callback_lifetime]" )
{
    clear_avatar();
    avatar &who = get_avatar();
    const on_out_of_scope cleanup( []() {
        clear_avatar();
    } );
    callback_activity_actor actor;
    actor.on_cancel = []( Character & target ) {
        target.activity.set_to_null();
    };
    who.assign_activity( actor );
    who.backlog.push_back( player_activity( activity_wait, 733 ) );
    who.cancel_activity();
    CHECK_FALSE( who.activity );
    CHECK( who.backlog.empty() );
}

TEST_CASE( "activity_callbacks_stop_after_npc_unload_or_removal", "[activity_callback_lifetime]" )
{
    clear_map();
    clear_avatar();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
        clear_avatar();
    } );
    npc &who = spawn_npc( point_bub_ms( 65, 65 ), "test_talker" );
    const character_action_guard original( who );
    REQUIRE( original.get() == &who );
    SECTION( "nested_scope_cannot_revive_an_unloaded_incarnation" ) {
        who.on_unload();
        CHECK_FALSE( original );
        CHECK_FALSE( character_action_guard( who ) );
        activate_npc_lifetime( who );
        CHECK( character_action_guard( who ) );
        CHECK_FALSE( original );
    }
    SECTION( "removed_actor_cannot_finish_in_the_same_turn" ) {
        bool finished = false;
        callback_activity_actor actor;
        actor.on_turn = []( Character & target ) {
            g->remove_npc( target.getID() );
        };
        actor.on_finish = [&]( Character & ) {
            finished = true;
        };
        who.assign_activity( actor );
        who.set_moves( 100 );
        CHECK( who.do_player_activity() );
        CHECK_FALSE( original );
        CHECK_FALSE( finished );
    }
    SECTION( "unload_callback_stops_the_outer_npc_loop_with_moves_remaining" ) {
        callback_activity_actor actor;
        actor.on_turn = []( Character & target ) {
            target.set_moves( 321 );
            target.as_npc()->on_unload();
        };
        who.assign_activity( actor );
        who.set_moves( 100 );
        CHECK( who.do_player_activity() );
        CHECK_FALSE( original );
        CHECK( who.get_moves() == 321 );
    }

}

TEST_CASE( "proficiency_callback_can_destroy_its_character", "[activity_callback_lifetime]" )
{
    struct destroy_on_proficiency : event_subscriber {
        using event_subscriber::notify;
        std::unique_ptr<npc> character = std::make_unique<npc>();
        void notify( const cata::event &event ) override {
            if( character && event.type() == event_type::gains_proficiency &&
                event.get<character_id>( "character" ) == character->getID() ) {
                character.reset();
            }
        }
    } observer;
    observer.character->normalize();
    observer.character->setID( character_id( 13370 ), true );
    get_event_bus().subscribe( &observer );
    REQUIRE( observer.character->practice_proficiency( proficiency_id( "prof_knapping" ), 365_days ) );
    CHECK_FALSE( observer.character );
}

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "lua_platform_runtime_internal.h"

TEST_CASE( "lua_activity_callbacks_respect_character_and_activity_lifetime",
           "[activity_callback_lifetime][lua][platform]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    clear_map();
    clear_avatar();
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
        clear_npcs();
        clear_avatar();
    } );
    const platform_lua_test_directory directory;
    directory.write( "main.lua", R"lua(
local ccb = require("ccb")
phase = ""
starts = 0
finished = 0
killed = false
replacement_ok = false
ccb.runtime.handler("lifetime_start", function(event)
    if event.data.activity ~= "ACT_TEST_CALLBACK_LIFETIME" then return end
    starts = starts + 1
    if phase == "kill_start" then
        local result = ccb.services.characters.die(event.actors.character,
            { remove_corpse = true, suppress_message = true })
        killed = result.ok and result.value.dead
    end
end)
ccb.runtime.handler("lifetime_cancel", function(event)
    if phase ~= "replace_cancel" or not event.data.canceled
        or event.data.activity ~= "ACT_TEST_CALLBACK_LIFETIME" then return end
    local result = ccb.services.activities.assign_timed(event.actors.character,
        ccb.services.types.id("activity", "ACT_TEST_CALLBACK_REPLACEMENT"),
        ccb.services.time.duration(17, "second"))
    replacement_ok = result.ok
end)
ccb.runtime.handler("lifetime_turn", function(event)
    if phase == "kill_turn" then
        local result = ccb.services.characters.die(event.character,
            { remove_corpse = true, suppress_message = true })
        killed = result.ok and result.value.dead
        return { moves_left = 987654 }
    end
end)
ccb.runtime.handler("lifetime_finish", function(event)
    finished = finished + 1
end)
ccb.runtime.on("game:character_starts_activity", "lifetime_start")
ccb.runtime.on("game:character_finished_activity", "lifetime_cancel")
local original = ccb.content.ActivityType {
    id = "ACT_TEST_CALLBACK_LIFETIME", verb = "checking callbacks", based_on = "time"
}
original:on_turn("lifetime_turn")
original:on_finish("lifetime_finish")
ccb.content.add(original)
ccb.content.add(ccb.content.ActivityType {
    id = "ACT_TEST_CALLBACK_REPLACEMENT", verb = "replacement work", based_on = "time"
})
)lua" );
    std::string error;
    const std::string mod = "activity_callback_lifetime";
    const bool prepared = platform::prepare_mods(
    { { mod, directory.root, directory.root / "main.lua" } }, error );
    INFO( error );
    REQUIRE( prepared );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    platform::runtime_world_ready( true );
    const auto owner = platform::detail::find_active_runtime( mod );
    REQUIRE( owner );
    sol::state &lua = *owner->lua;
    const activity_id original( "ACT_TEST_CALLBACK_LIFETIME" );
    REQUIRE( original.is_valid() );

    // The cancellation event starts a new real Lua-authored activity. The outer
    // native cancel must neither erase it nor reset its move budget.
    avatar &player = get_avatar();
    lua["phase"] = "replace_cancel";
    player.assign_activity( player_activity( original, 1000 ) );
    player.cancel_activity();
    CHECK( lua["replacement_ok"].get<bool>() );
    CHECK( player.activity.id() == activity_id( "ACT_TEST_CALLBACK_REPLACEMENT" ) );
    CHECK( player.activity.moves_left == to_moves<int>( 17_seconds ) );

    // NPC death does not necessarily destroy the C++ object. Assignment must
    // still stop before setting the dead NPC's mission/activity state.
    lua["phase"] = "kill_start";
    npc &first = spawn_npc( point_bub_ms( 65, 65 ), "test_talker" );
    first.assign_activity( player_activity( original, 1000 ) );
    CHECK( lua["killed"].get<bool>() );
    CHECK( first.is_dead() );
    CHECK( first.current_activity_id != original );
    CHECK_FALSE( character_action_guard( first ) );
    const auto dead_activity = first.activity.identity_generation();
    first.assign_activity( player_activity( activity_id( "ACT_TEST_CALLBACK_REPLACEMENT" ), 333 ) );
    CHECK( first.activity.identity_generation() == dead_activity );

    // A policy's return table must not be applied after it kills its actor,
    // and that turn must not run the completion policy.
    lua["phase"] = "kill_turn";
    lua["killed"] = false;
    npc &second = spawn_npc( point_bub_ms( 66, 65 ), "test_talker" );
    second.assign_activity( player_activity( original, 100 ) );
    second.set_moves( 100 );
    second.activity.do_turn( second );
    CHECK( lua["killed"].get<bool>() );
    CHECK( second.is_dead() );
    CHECK( second.activity.moves_left != 987654 );
    CHECK( lua["finished"].get<int>() == 0 );
    CHECK( lua["starts"].get<int>() == 3 );
}
#endif
