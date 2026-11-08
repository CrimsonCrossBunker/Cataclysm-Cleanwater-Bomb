#include "cata_catch.h"

#include <sstream>

#include "avatar.h"
#include "calendar.h"
#include "cata_scope_helpers.h"
#include "creature_tracker.h"
#include "game.h"
#include "game_constants.h"
#include "item.h"
#include "item_disposition.h"
#include "item_location.h"
#include "item_stack.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "monster.h"
#include "mp_client_conn.h"
#include "mp_gamestate.h"
#include "mp_queue.h"
#include "mp_test_helpers.h"
#include "mp_throw.h"
#include "npc.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "projectile.h"
#include "ranged_actions.h"
#include "ret_val.h"
#include "rng.h"
#include "skill.h"

namespace
{
const itype_id projectile_id( "throwing_stick_with_charges" );

void prepare_thrower( Character &who, const tripoint_bub_ms &where )
{
    clear_character( who, true );
    who.setpos( get_map(), where );
    who.set_wielded_item( item( projectile_id, calendar::turn, 10 ) );
    who.set_skill_level( skill_id( "throw" ), 5 );
    who.set_moves( 1000 );
    who.set_stamina( who.get_stamina_max() );
}

class throw_fixture
{
    public:
        restore_on_out_of_scope<time_point> time{ calendar::turn };
        restore_on_out_of_scope<cata_default_random_engine> rng{ rng_get_engine() };

        throw_fixture() {
            clear_avatar();
            clear_map();
            g->multiplayer_session().reset();
            calendar::turn = calendar::turn_zero + 12_hours;
            get_avatar().setpos( get_map(), tripoint_bub_ms( 90, 90, 0 ) );
        }
        ~throw_fixture() {
            g->multiplayer_session().reset();
            cata_mp::get_mp_queue().clear();
            clear_npcs();
            get_creature_tracker().clear();
            clear_avatar();
        }
        npc &remote() {
            npc &who = spawn_npc( { 60, 60 }, "test_talker" );
            prepare_thrower( who, tripoint_bub_ms( 60, 60, 0 ) );
            const cata_mp::player_id owner( std::string( 32, '7' ) );
            who.set_value( "mp_proxy", std::string( "1" ) );
            who.set_value( "mp_player_id", owner.str() );
            auto &peer = make_test_remote( g->multiplayer_session() );
            peer.actor.bind_player( who, owner, g->npc_lifetimes(),
                                    g->player_controls().claim( owner, who ) );
            peer.connected = true;
            peer.turn.remote_moves = 1000;
            peer.turn.granted_this_turn = true;
            who.set_stamina( who.get_stamina_max() );
            return who;
        }
};

item_location add_projectile_to_backpack( Character &who )
{
    const auto worn = who.wear_item( item( itype_id( "backpack" ) ), false );
    REQUIRE( worn );
    item_location backpack( who, & **worn );
    const auto inserted = backpack->put_in( item( projectile_id, calendar::turn, 5 ),
                                            pocket_type::CONTAINER );
    REQUIRE( inserted.success() );
    REQUIRE( backpack->all_items_top().size() == 1 );
    return item_location( backpack, backpack->all_items_top().front() );
}
} // namespace

TEST_CASE( "authoritative_throw_matches_native_damage_cost_and_rng", "[multiplayer][throw]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    avatar &reference = get_avatar();
    prepare_thrower( reference, tripoint_bub_ms( 60, 80, 0 ) );
    REQUIRE( who.get_cardiofit() == reference.get_cardiofit() );
    REQUIRE( who.get_stamina_max() == reference.get_stamina_max() );
    auto victim = make_shared_fast<monster>( mtype_id( "mon_test_zombie" ),
                  tripoint_bub_ms( 65, 60, 0 ) );
    victim->set_hp( 1000 );
    auto expected_victim = make_shared_fast<monster>( *victim );
    expected_victim->spawn( tripoint_bub_ms( 65, 80, 0 ) );
    REQUIRE( get_creature_tracker().add( victim ) );
    REQUIRE( get_creature_tracker().add( expected_victim ) );
    get_map().build_map_cache( 0 );
    auto intent = cata_mp::make_throw_intent( who, who.get_wielded_item() );
    intent.target = victim->pos_abs();
    std::optional<tripoint_bub_ms> blind;
    SECTION( "normal" ) {}
    SECTION( "blind_around_corner" ) {
        intent.blind_from = get_map().get_abs( tripoint_bub_ms( 61, 60, 0 ) );
        blind = tripoint_bub_ms( 61, 80, 0 );
    }
    const auto before = rng_get_engine();
    if( blind ) {
        reference.mod_moves( -reference.get_speed() * 2 );
    }
    reference.last_target = expected_victim;
    reference.last_target_pos = expected_victim->pos_abs();
    mark_ranged_target( reference, true );
    item thrown = *reference.get_wielded_item();
    reference.get_wielded_item()->mod_charges( -1 );
    thrown.charges = 1;
    reference.throw_item( expected_victim->pos_bub(), thrown, blind );
    const auto expected_rng = rng_get_engine();
    rng_get_engine() = before;
    REQUIRE( cata_mp::execute_throw_intent( who, get_map(), intent ) );
    CHECK( who.get_wielded_item()->charges == 9 );
    CHECK( who.get_moves() == reference.get_moves() );
    CHECK( who.get_stamina() == reference.get_stamina() );
    CHECK( who.get_skill_level_object( skill_id( "throw" ) ).exercise( true ) ==
           reference.get_skill_level_object( skill_id( "throw" ) ).exercise( true ) );
    CHECK( victim->get_hp() == expected_victim->get_hp() );
    CHECK( rng_get_engine() == expected_rng );
}

TEST_CASE( "throw_preparation_uses_selected_disposal_and_keeps_cancel_cost",
           "[multiplayer][throw]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_id( "bat" ) ) );
    item_location source = add_projectile_to_backpack( who );
    auto intent = cata_mp::make_throw_intent( who, source );
    intent.disposition = item_disposition{ "drop", 0, 0 };
    const int before_moves = who.get_moves();
    const int retrieve_cost = who.item_handling_cost( *source, true, INVENTORY_HANDLING_PENALTY );
    // No target represents canceling the targeting UI after choosing preparation.
    CHECK_FALSE( cata_mp::execute_throw_intent( who, get_map(), intent ) );
    REQUIRE( who.get_wielded_item() );
    CHECK( who.get_wielded_item()->typeId() == projectile_id );
    CHECK( who.get_wielded_item()->charges == 5 );
    CHECK( who.get_moves() == before_moves - retrieve_cost );
    CHECK( who.items_with( []( const item & it ) {
        return it.typeId() == projectile_id;
    } ).size() == 1 );
    REQUIRE( get_map().i_at( who.pos_bub() ).size() == 1 );
    CHECK( get_map().i_at( who.pos_bub() ).begin()->typeId() == itype_id( "bat" ) );
}

TEST_CASE( "throwing_a_map_item_removes_the_source_without_creating_a_copy",
           "[multiplayer][throw]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    who.remove_weapon();
    map &here = get_map();
    item_location source = here.add_item_or_charges_ret_loc( who.pos_bub(),
                           item( projectile_id, calendar::turn, 5 ) );
    auto intent = cata_mp::make_throw_intent( who, source );
    intent.target = here.get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    REQUIRE( cata_mp::execute_throw_intent( who, here, intent ) );
    REQUIRE( who.get_wielded_item() );
    int charges = who.get_wielded_item()->charges;
    CHECK( charges == 4 );
    for( const tripoint_bub_ms &point : here.points_in_radius( who.pos_bub(), 8 ) ) {
        for( const item &it : here.i_at( point ) ) {
            if( it.typeId() == projectile_id ) {
                charges += it.charges;
            }
        }
    }
    CHECK( charges == 5 );
}

TEST_CASE( "sling_throw_resolves_nested_projectile_without_stowing_the_aid",
           "[multiplayer][throw]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    who.set_wielded_item( item( itype_id( "sling" ) ) );
    const auto aid = who.get_wielded_item()->uid().get_value();
    item_location source = add_projectile_to_backpack( who );
    auto intent = cata_mp::make_throw_intent( who, source );
    REQUIRE( intent.path.size() == 2 );
    intent.target = get_map().get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    REQUIRE( cata_mp::execute_throw_intent( who, get_map(), intent ) );
    CHECK( who.get_wielded_item()->uid().get_value() == aid );
    CHECK( source->charges == 4 );
    CHECK( who.get_moves() < 1000 );
}

TEST_CASE( "item_disposition_resolves_identity_and_rejects_missing_destinations",
           "[multiplayer][throw][inventory]" )
{
    throw_fixture fixture;
    avatar &who = get_avatar();
    prepare_thrower( who, tripoint_bub_ms( 60, 60, 0 ) );
    who.set_wielded_item( item( itype_id( "glock_19" ) ) );
    const auto worn = who.wear_item( item( itype_id( "holster" ) ), false );
    REQUIRE( worn );
    item &holster = **worn;
    const item_disposition choice{ "holster", holster.uid().get_value(), 0 };
    item_disposition stale = choice;
    ++stale.container;
    const int moves = who.get_moves();
    CHECK_FALSE( execute_item_disposition( who, who.get_wielded_item(), stale ) );
    CHECK( who.get_moves() == moves );
    REQUIRE( who.get_wielded_item() );
    REQUIRE( execute_item_disposition( who, who.get_wielded_item(), choice ) );
    CHECK_FALSE( who.get_wielded_item() );
    CHECK( holster.has_item_with( []( const item & it ) {
        return it.typeId() == itype_id( "glock_19" );
    } ) );
}

TEST_CASE( "throw_request_rejects_stale_sources_and_duplicates_before_client_mutations",
           "[multiplayer][throw]" )
{
    throw_fixture fixture;
    npc &who = fixture.remote();
    auto &peer = only_test_remote( g->multiplayer_session() );
    auto intent = cata_mp::make_throw_intent( who, who.get_wielded_item() );
    const tripoint_abs_ms target = get_map().get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    const auto packet = [&]( int64_t uid ) {
        std::ostringstream text;
        JsonOut out( text );
        out.start_object();
        out.member( "type", "action" );
        out.member( "action", "throw" );
        out.member( "origin", intent.origin );
        out.member( "target", target );
        out.member( "blind_from", std::optional<tripoint_abs_ms>() );
        out.member( "source", "carried" );
        out.member( "source_position", intent.source_position );
        out.member( "path", std::vector<int64_t> { uid } );
        out.member( "wielded", intent.wielded );
        out.member( "inventory_revision", peer.pickup.revision );
        out.member( "grant_seq", peer.turn.grant_seq );
        out.member( "char_stats" );
        out.start_object();
        out.member( "str", 999 );
        out.end_object();
        out.end_object();
        return text.str();
    };
    const auto send = [&]( const std::string & wire ) {
        REQUIRE( cata_mp::get_mp_queue().push( { cata_mp::mp_event::type::action, "player", wire, peer.admission } ) );
        cata_mp::process_mp_events();
    };
    const auto before = rng_get_engine();
    send( packet( intent.path.front() + 100 ) );
    CHECK( who.get_wielded_item()->charges == 10 );
    CHECK( rng_get_engine() == before );
    const std::string wire = packet( intent.path.front() );
    send( wire );
    REQUIRE( who.get_wielded_item()->charges == 9 );
    CHECK( who.get_str_base() == 8 );
    const int moves = peer.turn.remote_moves;
    const auto after = rng_get_engine();
    send( wire );
    CHECK( who.get_wielded_item()->charges == 9 );
    CHECK( peer.turn.remote_moves == moves );
    CHECK( rng_get_engine() == after );
}

TEST_CASE( "client_throw_request_keeps_inventory_and_gameplay_rng_untouched",
           "[multiplayer][throw]" )
{
    throw_fixture fixture;
    avatar &who = get_avatar();
    prepare_thrower( who, tripoint_bub_ms( 60, 60, 0 ) );
    auto intent = cata_mp::make_throw_intent( who, who.get_wielded_item() );
    intent.target = get_map().get_abs( tripoint_bub_ms( 64, 60, 0 ) );
    const auto uid = who.get_wielded_item()->uid().get_value();
    const auto before = rng_get_engine();
    cata_mp::set_client_mode( true );
    cata_mp::client_request_throw( intent );
    CHECK( who.get_wielded_item()->uid().get_value() == uid );
    CHECK( who.get_wielded_item()->charges == 10 );
    CHECK( who.get_moves() == 0 );
    CHECK( rng_get_engine() == before );
    CHECK( cata_mp::is_client_waiting_for_ack() );
}
