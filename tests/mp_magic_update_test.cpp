#include <chrono>
#include <string>
#include <thread>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "creature_tracker.h"
#include "effect.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "json_loader.h"
#include "magic.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_magic.h"
#include "mp_queue.h"
#include "mp_server.h"
#include "mtype.h"
#include "npc.h"
#include "player_helpers.h"

namespace
{
// Start the actual server on an ephemeral local port; feed its ordinary game
// thread queue.  This exercises role/proxy guards without a GUI or WAN peer.
class host_scope
{
    public:
        host_scope() {
            cata_mp::mp_on_world_exit();
            clear_map_without_vision();
            clear_avatar();
            get_avatar().consumption_history.clear();
            listener = std::thread( [] { cata_mp::run_server( 0, "" ); } );
            for( int retry = 0; retry < 200 && !cata_mp::is_hosting(); ++retry ) {
                std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
            }
        }
        ~host_scope() {
            if( cata_mp::get_partner_npc() ) {
                cata_mp::get_partner_npc()->consumption_history.clear();
                cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, name, "" } );
                cata_mp::process_mp_events();
            }
            if( cata_mp::server *server = cata_mp::get_active_server() ) {
                server->stop();
            }
            if( listener.joinable() ) {
                listener.join();
            }
            cata_mp::mp_on_world_exit();
            calendar::turn = old_turn;
        }
        void connect() const {
            cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::connect, name, "" } );
            cata_mp::process_mp_events();
        }
        void apply( const std::string &message ) const {
            cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, name, message } );
            cata_mp::process_mp_events();
        }
        const std::string name = "Spell regression partner";
    private:
        const time_point old_turn = calendar::turn;
        std::thread listener;
};

std::string guarded_message( const std::string &body, const std::string &generation, int sequence )
{
    return body + ",\"generation\":\"" + generation + "\",\"seq\":" +
           std::to_string( sequence ) + "}";
}

void load_attack_spell()
{
    spell_type::load_spell( json_loader::from_string( R"({
        "id":"test_mp_single_target", "name":"MP target test", "description":"test",
        "effect":"attack", "shape":"blast", "valid_targets":["ally","hostile"],
        "damage_type":"none",
        "effect_str":"stunned", "min_duration":500, "max_duration":500,
        "min_aoe":3, "max_aoe":3, "max_level":5
    })" ).get_object(), "test" );
}
} // namespace

TEST_CASE( "mp_magic_host_applies_resolved_ops_once_and_rejects_old_generations",
           "[multiplayer][mp_magic]" )
{
    host_scope host;
    REQUIRE( cata_mp::is_hosting() );
    host.connect();
    REQUIRE( cata_mp::get_partner_npc() );
    cata_mp::get_partner_npc()->name = "Renamed character";
    monster &target = spawn_test_monster( "mon_zombie", tripoint_bub_ms( 65, 65, 0 ) );
    const shared_ptr_fast<monster> held_target = get_creature_tracker().find( target.pos_abs() );
    target.mp_net_id = 7001;
    const int moves_before = get_avatar().get_moves();
    const std::string generation = cata_mp::mp_magic_host_generation();
    const std::string charm = guarded_message(
                                  R"({"type":"client_monster_op","op":"charm","nid":7001,"fr":-1,"pet":true)",
                                  generation, 1 );
    host.apply( charm );
    CHECK( target.friendly == -1 );
    CHECK( target.has_effect( efftype_id( "pet" ) ) );
    CHECK( target.get_effect( efftype_id( "pet" ) ).is_permanent() );
    // Receiving the same sequence cannot change the resolved outcome again.
    target.friendly = 17;
    host.apply( charm );
    CHECK( target.friendly == 17 );
    host.apply( guarded_message(
                    R"({"type":"client_monster_op","op":"poly","nid":7001,"to":"mon_skeleton","fr":-1)",
                    generation, 2 ) );
    CHECK( target.type->id == mtype_id( "mon_skeleton" ) );
    CHECK( target.friendly == -1 );
    const std::string effect = guarded_message(
                                   R"({"type":"client_monster_op","op":"effect","nid":7001,"eff":"stunned","turns":12)",
                                   generation, 3 );
    host.apply( effect );
    REQUIRE( target.has_effect( efftype_id( "stunned" ) ) );
    const time_duration duration = target.get_effect_dur( efftype_id( "stunned" ) );
    host.apply( effect );
    CHECK( target.get_effect_dur( efftype_id( "stunned" ) ) == duration );
    host.apply( guarded_message(
                    R"({"type":"client_monster_op","op":"poly","nid":7001,"to":"not_a_monster")",
                    generation, 4 ) );
    CHECK( target.type->id == mtype_id( "mon_skeleton" ) );
    host.apply( guarded_message(
                    R"({"type":"client_monster_op","op":"charm","nid":7001,"fr":900,"pet":"invalid")",
                    generation, 5 ) );
    CHECK( target.friendly == -1 );
    calendar::turn -= 1_turns;
    CHECK( cata_mp::mp_magic_host_generation() != generation );
    host.apply( guarded_message(
                    R"({"type":"client_monster_op","op":"charm","nid":7001,"fr":900)",
                    generation, 5 ) );
    CHECK( target.friendly == -1 );
    CHECK( get_avatar().get_moves() == moves_before );
    const std::string next_generation = cata_mp::mp_magic_host_generation();
    const std::string banish = guarded_message(
                                   R"({"type":"client_monster_op","op":"banish","nid":7001)",
                                   next_generation, 1 );
    host.apply( banish );
    CHECK_FALSE( held_target->death_drops );
    CHECK( get_creature_tracker().creature_at<monster>( tripoint_bub_ms( 65, 65, 0 ) ) == nullptr );
    host.apply( banish );
    // Reconnection invalidates every previously accepted effect envelope.
    cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::disconnect, host.name, "" } );
    cata_mp::process_mp_events();
    host.connect();
    CHECK( cata_mp::mp_magic_host_generation() != next_generation );
}

TEST_CASE( "mp_magic_polymorph_preserves_unconfirmed_absolute_hit_without_double_damage",
           "[multiplayer][mp_magic]" )
{
    host_scope host;
    REQUIRE( cata_mp::is_hosting() );
    host.connect();
    REQUIRE( cata_mp::get_partner_npc() );
    monster &target = spawn_test_monster( "mon_zombie", tripoint_bub_ms( 65, 65, 0 ) );
    target.mp_net_id = 7002;
    const int damaged_hp = target.get_hp() - 10;
    monster expected( mtype_id( "mon_zombie" ) );
    expected.set_hp( damaged_hp );
    expected.poly( mtype_id( "mon_skeleton" ) );
    SECTION( "unreported_hit_is_applied_before_polymorph" ) {
        CHECK( target.get_hp() > damaged_hp );
    }
    SECTION( "already_applied_hit_is_not_subtracted_twice" ) {
        host.apply( "{\"type\":\"action\",\"action\":\"wait\",\"client_monster_hits\":[{\"nid\":7002,\"hp\":"
                    +
                    std::to_string( damaged_hp ) + "}]}" );
        REQUIRE( target.get_hp() == damaged_hp );
    }
    host.apply( guarded_message(
                    "{\"type\":\"client_monster_op\",\"op\":\"poly\",\"nid\":7002,\"to\":\"mon_skeleton\",\"prior_hp\":"
                    +
                    std::to_string( damaged_hp ), cata_mp::mp_magic_host_generation(), 1 ) );
    CHECK( target.type->id == mtype_id( "mon_skeleton" ) );
    CHECK( target.get_hp() == expected.get_hp() );
    // The exact reset used by world/reset and load invalidates a packet even
    // when calendar::turn is unchanged.
    const std::string old_generation = cata_mp::mp_magic_host_generation();
    cata_mp::mp_magic_reset();
    host.apply( guarded_message(
                    R"({"type":"client_monster_op","op":"charm","nid":7002,"fr":900)",
                    old_generation, 2 ) );
    CHECK( target.friendly != 900 );
}

TEST_CASE( "mp_magic_effect_snapshots_use_host_expiry_and_defer_on_add_damage",
           "[multiplayer][mp_magic]" )
{
    const restore_on_out_of_scope<time_point> restore_turn( calendar::turn );
    clear_map_without_vision();
    clear_avatar();
    monster source( mtype_id( "mon_zombie" ) );
    source.add_effect( efftype_id( "stunned" ), 12_turns );
    source.add_effect( efftype_id( "pet" ), 1_turns, true );
    monster copy( mtype_id( "mon_zombie" ) );
    copy.add_effect( efftype_id( "downed" ), 3_turns );
    const int hp_before = copy.get_hp();
    const std::string snapshot = "{\"eff\":" + cata_mp::mp_monster_effects_wire( source ) + "}";
    cata_mp::mp_apply_monster_effects( copy, json_loader::from_string( snapshot ).get_object() );
    CHECK_FALSE( copy.has_effect( efftype_id( "downed" ) ) );
    CHECK( copy.get_effect_dur( efftype_id( "stunned" ) ) == 12_turns );
    CHECK( copy.get_effect( efftype_id( "pet" ) ).is_permanent() );
    CHECK( copy.get_hp() == hp_before );
    calendar::turn += 5_turns;
    cata_mp::mp_apply_monster_effects( copy, json_loader::from_string( snapshot ).get_object() );
    CHECK( copy.get_effect_dur( efftype_id( "stunned" ) ) == 7_turns );
    cata_mp::mp_apply_monster_effects( copy, json_loader::from_string( "{}" ).get_object() );
    CHECK( copy.has_effect( efftype_id( "stunned" ) ) );
    cata_mp::mp_apply_monster_effects( copy,
                                       json_loader::from_string( R"({"eff":[["invalid_effect",1,1,""]]})" ).get_object() );
    CHECK( copy.has_effect( efftype_id( "stunned" ) ) );
    cata_mp::mp_apply_monster_effects( copy,
                                       json_loader::from_string( R"({"eff":[]})" ).get_object() );
    CHECK_FALSE( copy.has_effect( efftype_id( "stunned" ) ) );
    CHECK_FALSE( copy.has_effect( efftype_id( "pet" ) ) );
}

TEST_CASE( "mp_magic_client_reload_waits_for_a_new_host_generation",
           "[multiplayer][mp_magic]" )
{
    const bool was_client = cata_mp::is_client_mode();
    const on_out_of_scope restore_mode( [was_client]() {
        cata_mp::mp_magic_reset();
        cata_mp::set_client_mode( was_client );
    } );
    cata_mp::set_client_mode( true );
    cata_mp::mp_magic_reset();
    const JsonObject old_state = json_loader::from_string(
                                     R"({"spell_generation":"before-load"})" ).get_object();
    CHECK( cata_mp::mp_magic_client_state( old_state ) );
    cata_mp::mp_magic_reset( true );
    CHECK_FALSE( cata_mp::mp_magic_client_state( old_state ) );
    // reset_game_state and load both run; a second reset must preserve the wait.
    cata_mp::mp_magic_reset( true );
    CHECK_FALSE( cata_mp::mp_magic_client_state( old_state ) );
    CHECK( cata_mp::mp_magic_client_state( json_loader::from_string(
            R"({"spell_generation":"after-load"})" ).get_object() ) );
}

TEST_CASE( "mp_magic_resync_rotates_once_and_accepts_sequence_one_without_extra_ap",
           "[multiplayer][mp_magic]" )
{
    host_scope host;
    REQUIRE( cata_mp::is_hosting() );
    host.connect();
    REQUIRE( cata_mp::get_partner_npc() );
    monster &target = spawn_test_monster( "mon_zombie", tripoint_bub_ms( 65, 65, 0 ) );
    target.mp_net_id = 7003;
    const std::string before = cata_mp::mp_magic_host_generation();
    const std::string old_message = guarded_message(
                                        R"({"type":"client_monster_op","op":"charm","nid":7003,"fr":17)",
                                        before, 7 );
    host.apply( old_message );
    REQUIRE( target.friendly == 17 );
    const int host_moves = get_avatar().get_moves();
    const int proxy_moves = cata_mp::get_partner_npc()->get_moves();
    const std::string request = "{\"type\":\"magic_resync_request\",\"generation\":\"" +
                                before + "\"}";
    host.apply( request );
    const std::string after = cata_mp::mp_magic_host_generation();
    REQUIRE( after != before );
    host.apply( request );
    CHECK( cata_mp::mp_magic_host_generation() == after );
    target.friendly = 0;
    host.apply( old_message );
    CHECK( target.friendly == 0 );
    host.apply( guarded_message(
                    R"({"type":"client_monster_op","op":"charm","nid":7003,"fr":-1)",
                    after, 1 ) );
    CHECK( target.friendly == -1 );
    CHECK( get_avatar().get_moves() == host_moves );
    CHECK( cata_mp::get_partner_npc()->get_moves() == proxy_moves );
}

TEST_CASE( "mp_magic_resync_crosses_the_authenticated_tcp_dispatcher",
           "[multiplayer][mp_magic]" )
{
    host_scope host;
    REQUIRE( cata_mp::is_hosting() );
    const uint16_t port = cata_mp::get_active_server()->port();
    REQUIRE( port != 0 );
    REQUIRE( cata_mp::client_connect( "127.0.0.1", port, host.name ) );
    const on_out_of_scope quit_peer( []() {
        if( cata_mp::get_partner_npc() ) {
            cata_mp::get_partner_npc()->consumption_history.clear();
        }
        cata_mp::client_send( R"({"type":"quit"})" );
        for( int poll = 0; poll < 200 && cata_mp::get_partner_npc(); ++poll ) {
            cata_mp::process_mp_events();
            std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
        }
        std::string message;
        while( cata_mp::client_recv_pop( message ) ) {}
    } );
    cata_mp::client_send_join();
    REQUIRE( cata_mp::client_join_is_sent() );
    for( int poll = 0; poll < 200 && !cata_mp::get_partner_npc(); ++poll ) {
        cata_mp::process_mp_events();
        std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
    }
    REQUIRE( cata_mp::get_partner_npc() );
    const std::string before = cata_mp::mp_magic_host_generation();
    const int host_moves = get_avatar().get_moves();
    const std::string request = "{\"type\":\"magic_resync_request\",\"generation\":\"" +
                                before + "\"}";
    cata_mp::client_send( request );
    bool received_response = false;
    std::string after;
    for( int poll = 0; poll < 200 && !received_response; ++poll ) {
        cata_mp::process_mp_events();
        std::string message;
        while( cata_mp::client_recv_pop( message ) ) {
            JsonObject state = json_loader::from_string( message ).get_object();
            state.allow_omitted_members();
            const std::string generation = state.get_string( "spell_generation", "" );
            if( !generation.empty() && generation != before ) {
                after = generation;
                received_response = true;
            }
        }
        std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
    }
    REQUIRE( received_response );
    CHECK( after == cata_mp::mp_magic_host_generation() );
    CHECK( get_avatar().get_moves() == host_moves );
}

TEST_CASE( "mp_magic_friendly_fire_hits_only_the_real_host_tile",
           "[multiplayer][mp_magic]" )
{
    host_scope host;
    REQUIRE( cata_mp::is_hosting() );
    host.connect();
    REQUIRE( cata_mp::get_partner_npc() );
    load_attack_spell();
    avatar &avatar = get_avatar();
    monster &nearby = spawn_test_monster( "mon_zombie", avatar.pos_bub() + tripoint_rel_ms( 2, 0, 0 ) );
    const std::string message = guarded_message(
                                    R"({"type":"partner_spell","spell":"test_mp_single_target","level":2,"hit":true)",
                                    cata_mp::mp_magic_host_generation(), 1 );
    host.apply( message );
    REQUIRE( avatar.has_effect( efftype_id( "stunned" ) ) );
    CHECK_FALSE( nearby.has_effect( efftype_id( "stunned" ) ) );
    CHECK( cata_mp::get_partner_npc()->magic->get_spell(
               spell_id( "test_mp_single_target" ) ).get_level() == 2 );
    avatar.remove_effect( efftype_id( "stunned" ) );
    host.apply( message );
    CHECK_FALSE( avatar.has_effect( efftype_id( "stunned" ) ) );
    host.apply( guarded_message(
                    R"({"type":"partner_spell","spell":"test_mp_single_target","level":99,"hit":true)",
                    cata_mp::mp_magic_host_generation(), 2 ) );
    CHECK_FALSE( avatar.has_effect( efftype_id( "stunned" ) ) );
    CHECK( cata_mp::get_partner_npc()->magic->get_spell(
               spell_id( "test_mp_single_target" ) ).get_level() == 2 );
}
