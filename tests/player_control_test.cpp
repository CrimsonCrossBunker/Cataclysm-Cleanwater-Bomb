#include "cata_catch.h"

#include <memory>
#include <functional>
#include <string>
#include <utility>

#include "avatar.h"
#include "bodypart.h"
#include "npc.h"
#include "options_helpers.h"
#include "player_control.h"
#include "rng.h"

namespace
{
const player_id first_player( std::string( 32, '3' ) );
const player_id second_player( std::string( 32, '4' ) );

void prepare( Character &actor, int id )
{
    actor.normalize();
    actor.setID( character_id( id ), true );
}
} // namespace

TEST_CASE( "player_controls_share_one_world_and_exclude_duplicate_owners", "[player_control]" )
{
    avatar local;
    npc second;
    npc copied_id;
    prepare( local, 12100 );
    prepare( second, 12101 );
    prepare( copied_id, 12100 );
    player_control_registry world;
    player_control_registry unrelated;
    const auto before = rng_get_engine();
    auto first = world.claim( first_player, local );
    CHECK( local.is_player_controlled() );
    CHECK( local.has_native_player_control() );
    CHECK_FALSE( copied_id.is_player_controlled() );
    CHECK_THROWS( unrelated.claim( second_player, local ) );
    const auto first_reference = world.find( first_player );
    CHECK_THROWS( world.claim( first_player, second ) );
    CHECK_THROWS( world.claim( second_player, local ) );
    CHECK_THROWS( world.claim( second_player, copied_id ) );
    CHECK( first_reference.resolve( world ) == &local );
    auto other = world.claim( second_player, second );
    const auto second_reference = world.find( second_player );
    CHECK( second_reference.resolve( world ) == &second );
    CHECK_FALSE( first_reference.resolve( unrelated ) );
    CHECK_FALSE( second_reference.resolve( unrelated ) );
    CHECK( rng_get_engine() == before );

    auto moved = std::move( first );
    CHECK_FALSE( first.get() );
    CHECK( moved.get() == &local );
    CHECK( first_reference.resolve( world ) == &local );
    moved.reset();
    CHECK_FALSE( local.is_player_controlled() );
    CHECK_FALSE( first_reference.resolve( world ) );
    CHECK( second_reference.resolve( world ) == &second );
    first = world.claim( first_player, local );
    CHECK_FALSE( first_reference.resolve( world ) );
    CHECK( world.find( first_player ).resolve( world ) == &local );
    world.reset();
    CHECK_FALSE( local.is_player_controlled() );
    CHECK_FALSE( second.is_player_controlled() );
    CHECK_FALSE( first.get() );
    CHECK_FALSE( other.get() );
    CHECK_FALSE( second_reference.resolve( world ) );
    first = world.claim( first_player, local );
    CHECK_FALSE( first_reference.resolve( world ) );
    CHECK( world.find( first_player ).resolve( world ) == &local );
}

TEST_CASE( "player_control_does_not_survive_actor_replacement_or_world_destruction",
           "[player_control][lifetime]" )
{
    auto actor = std::make_unique<npc>();
    prepare( *actor, 12102 );
    player_control lease;
    player_control_reference reference;
    {
        player_control_registry world;
        lease = world.claim( first_player, *actor );
        reference = world.find( first_player );
        REQUIRE( reference.resolve( world ) == actor.get() );
        // Replacing an actor must not let its earlier controller follow it.
        npc replacement;
        prepare( replacement, 12102 );
        *actor = std::move( replacement );
        CHECK_FALSE( actor->is_player_controlled() );
        CHECK_FALSE( lease.get() );
        CHECK_FALSE( reference.resolve( world ) );
        lease = world.claim( first_player, *actor );
        CHECK_FALSE( reference.resolve( world ) );
        reference = world.find( first_player );
        actor.reset();
        CHECK_FALSE( lease.get() );
        CHECK_FALSE( reference.resolve( world ) );
        actor = std::make_unique<npc>();
        prepare( *actor, 12102 );
        lease = world.claim( first_player, *actor );
        reference = world.find( first_player );
    }
    CHECK_FALSE( lease.get() );
    CHECK_FALSE( actor->is_player_controlled() );
    player_control_registry another_world;
    CHECK_FALSE( reference.resolve( another_world ) );
}

TEST_CASE( "player_control_rejects_invalid_claims_and_retains_dead_actor_for_save",
           "[player_control][lifetime]" )
{
    npc actor;
    actor.normalize();
    player_control_registry world;
    CHECK_THROWS( world.claim( first_player, actor ) );
    actor.setID( character_id( 12103 ), true );
    CHECK_THROWS( world.claim( player_id(), actor ) );
    auto lease = world.claim( first_player, actor );
    const auto reference = world.find( first_player );
    actor.set_part_hp_cur( bodypart_id( "torso" ), 0 );
    REQUIRE( actor.is_dead_state() );
    CHECK_FALSE( reference.resolve( world ) );
    CHECK( lease.get() == &actor );
    CHECK( world.is_claimed( actor ) );
    CHECK( world.is_reserved( first_player ) );
    npc successor;
    prepare( successor, 12104 );
    CHECK_THROWS( world.claim( first_player, successor ) );
    lease.reset();
    CHECK_THROWS( world.claim( first_player, actor ) );
    CHECK_FALSE( world.is_reserved( first_player ) );
    lease = world.claim( first_player, successor );
    CHECK( lease.get() == &successor );
    CHECK_FALSE( reference.resolve( world ) );
}

TEST_CASE( "world_phase_dispatch_requires_exact_live_controlled_actor",
           "[player_control][dispatch]" )
{
    npc actor;
    npc copied;
    prepare( actor, 12105 );
    prepare( copied, 12105 );
    player_control_registry world;
    player_control_registry unrelated;
    auto control = world.claim( first_player, actor );
    const auto before = rng_get_engine();
    CHECK_FALSE( world.update_body( copied ) );
    CHECK_FALSE( world.process_turn( copied ) );
    CHECK_FALSE( unrelated.update_body( actor ) );
    CHECK_FALSE( unrelated.process_turn( actor ) );
    control.reset();
    CHECK_FALSE( world.update_body( actor ) );
    CHECK_FALSE( world.process_turn( actor ) );
    control = world.claim( first_player, actor );
    world.reset();
    CHECK_FALSE( world.update_body( actor ) );
    CHECK_FALSE( world.process_turn( actor ) );
    control = world.claim( first_player, actor );
    actor.set_part_hp_cur( bodypart_id( "torso" ), 0 );
    REQUIRE( actor.is_dead_state() );
    CHECK( world.is_claimed( actor ) );
    CHECK_FALSE( world.update_body( actor ) );
    CHECK_FALSE( world.process_turn( actor ) );
    CHECK( rng_get_engine() == before );
}

TEST_CASE( "legacy_proxy_control_does_not_adopt_native_physiology_or_clock",
           "[player_control][dispatch][multiplayer]" )
{
    npc actor;
    prepare( actor, 12106 );
    player_control_registry world;
    auto control = world.claim( first_player, actor, player_control_kind::legacy_proxy );
    REQUIRE( actor.is_player_controlled() );
    CHECK_FALSE( actor.has_native_player_control() );
    const auto rng_before = rng_get_engine();
    actor.set_stamina( 123 );
    CHECK( actor.get_stamina() == actor.get_stamina_max() );
    CHECK_FALSE( world.update_body( actor ) );
    CHECK_FALSE( world.process_turn( actor ) );
    CHECK_THROWS( control.update_body() );
    CHECK_THROWS( control.process_turn() );
    CHECK( rng_get_engine() == rng_before );
    control.reset();
    CHECK_FALSE( actor.is_player_controlled() );
}

TEST_CASE( "moving_character_state_does_not_transfer_player_authority",
           "[player_control][lifetime]" )
{
    npc actor;
    prepare( actor, 12107 );
    player_control_registry world;
    auto control = world.claim( first_player, actor );
    npc moved( std::move( actor ) );
    CHECK_FALSE( actor.is_player_controlled() );
    CHECK_FALSE( moved.is_player_controlled() );
    CHECK_FALSE( moved.has_native_player_control() );
    CHECK_FALSE( world.process_turn( moved ) );
    CHECK_FALSE( world.update_body( moved ) );
    control = world.claim( first_player, moved );
    CHECK( moved.has_native_player_control() );
}

TEST_CASE( "native_player_needs_do_not_inherit_foodless_npc_policy",
           "[player_control][character_turn]" )
{
    const override_option no_npc_food( "NO_NPC_FOOD", "true" );
    npc actor;
    prepare( actor, 12108 );
    REQUIRE_FALSE( actor.needs_food() );
    player_control_registry world;
    auto control = world.claim( first_player, actor );
    CHECK( actor.needs_food() );
    control.reset();
    CHECK_FALSE( actor.needs_food() );
    control = world.claim( first_player, actor, player_control_kind::legacy_proxy );
    CHECK_FALSE( actor.needs_food() );
}

TEST_CASE( "control_release_during_native_dispatch_revokes_authority_immediately",
           "[player_control][dispatch][lifetime]" )
{
    struct callback_npc : npc {
        std::function<void()> callback;
        void process_turn() override {
            callback();
        }
    } actor;
    npc replacement;
    prepare( actor, 12109 );
    prepare( replacement, 12110 );
    player_control_registry world;
    auto control = std::make_unique<player_control>( world.claim( first_player, actor ) );
    const auto reference = world.find( first_player );
    const int release = GENERATE( 0, 1, 2 );
    CAPTURE( release );
    actor.callback = [&]() {
        REQUIRE( actor.is_player_controlled() );
        if( release == 0 ) {
            control->reset();
        } else if( release == 1 ) {
            *control = world.claim( second_player, replacement );
        } else {
            control.reset();
        }
        CHECK_FALSE( actor.is_player_controlled() );
        CHECK_FALSE( reference.resolve( world ) );
        CHECK_FALSE( world.is_reserved( first_player ) );
    };
    CHECK( world.process_turn( actor ) );
    CHECK_FALSE( world.process_turn( actor ) );
    CHECK_FALSE( world.update_body( actor ) );
}
