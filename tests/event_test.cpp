#include <functional>
#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "cata_variant.h"
#include "character.h"
#include "character_id.h"
#include "coordinates.h"
#include "damage.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "game.h"
#include "game_constants.h"
#include "global_vars.h"
#include "map.h"
#include "map_helpers.h"
#include "monster.h"
#include "npc.h"
#include "npc_lifetime.h"
#include "overmapbuffer.h"
#include "player_helpers.h"
#include "talker.h"
#include "type_id.h"
#include "vehicle.h"

class Creature;

static const mtype_id zombie( "zombie" );

TEST_CASE( "construct_event", "[event]" )
{
    cata::event e = cata::event::make<event_type::character_kills_monster>(
                        character_id( 7 ), zombie, 100 );
    CHECK( e.type() == event_type::character_kills_monster );
    CHECK( e.time() == calendar::turn );
    CHECK( e.get<cata_variant_type::character_id>( "killer" ) == character_id( 7 ) );
    CHECK( e.get<cata_variant_type::mtype_id>( "victim_type" ) == zombie );
    CHECK( e.get<cata_variant_type::int_>( "exp" ) == 100 );
    CHECK( e.get<character_id>( "killer" ) == character_id( 7 ) );
    CHECK( e.get<mtype_id>( "victim_type" ) == zombie );
    CHECK( e.get<int>( "exp" ) == 100 );
}

namespace
{

struct test_subscriber : public event_subscriber {
    using event_subscriber::notify;
    void notify( const cata::event &e ) override {
        events.push_back( e );
    }

    std::vector<cata::event> events;
};

struct talker_subscriber : public event_subscriber {
    void notify( const cata::event & ) override {
        FAIL( "Expected an event with talkers" );
    }

    void notify( const cata::event &, std::unique_ptr<talker> event_alpha,
                 std::unique_ptr<talker> event_beta ) override {
        alpha = std::move( event_alpha );
        beta = std::move( event_beta );
    }

    std::unique_ptr<talker> alpha;
    std::unique_ptr<talker> beta;
};

struct damage_talker_subscriber : public event_subscriber {
    explicit damage_talker_subscriber( character_id target ) : target( target ) {}

    void notify( const cata::event &e ) override {
        if( matches( e ) ) {
            data_only_events.push_back( e );
        }
    }

    void notify( const cata::event &e, std::unique_ptr<talker> alpha,
                 std::unique_ptr<talker> beta ) override {
        if( !matches( e ) ) {
            return;
        }
        REQUIRE( alpha );
        Character *who = alpha->get_character();
        REQUIRE( who );
        CHECK( who->getID() == target );
        CHECK( ( beta ? beta->get_creature() : nullptr ) == expected_source );
        talker_events.push_back( e );
        ++calls;
        if( on_damage ) {
            on_damage( *who );
        }
    }

    character_id target;
    Creature *expected_source = nullptr;
    int calls = 0;
    std::vector<cata::event> talker_events;
    std::vector<cata::event> data_only_events;
    std::function<void( Character & )> on_damage;

    private:
        bool matches( const cata::event &e ) const {
            return e.type() == event_type::character_takes_damage &&
                   e.get<character_id>( "character" ) == target;
        }
};

} // namespace

TEST_CASE( "push_event_on_vector", "[event]" )
{
    std::vector<cata::event> test_events;
    cata::event original_event = cata::event::make<event_type::character_kills_monster>(
                                     character_id( 5 ), zombie, 0 );
    test_events.push_back( original_event );
    REQUIRE( test_events.size() == 1 );
}

TEST_CASE( "notify_subscriber", "[event]" )
{
    test_subscriber sub;
    cata::event original_event = cata::event::make<event_type::character_kills_monster>(
                                     character_id( 5 ), zombie, 0 );
    sub.notify( original_event );
    REQUIRE( sub.events.size() == 1 );
}

TEST_CASE( "send_event_through_bus", "[event]" )
{
    event_bus bus;
    test_subscriber sub;
    bus.subscribe( &sub );

    bus.send( cata::event::make<event_type::character_kills_monster>(
                  character_id( 5 ), zombie, 0 ) );
    REQUIRE( sub.events.size() == 1 );
    const cata::event &e = sub.events[0];
    CHECK( e.type() == event_type::character_kills_monster );
    CHECK( e.time() == calendar::turn );
    CHECK( e.get<character_id>( "killer" ) == character_id( 5 ) );
    CHECK( e.get<mtype_id>( "victim_type" ) == zombie );
}

TEST_CASE( "destroy_bus_before_subscriber", "[event]" )
{
    test_subscriber sub;
    event_bus bus;
    bus.subscribe( &sub );

    bus.send( cata::event::make<event_type::character_kills_monster>(
                  character_id( 5 ), zombie, 0 ) );
    CHECK( sub.events.size() == 1 );
}

TEST_CASE( "event_talkers_preserve_optional_creature", "[event]" )
{
    event_bus bus;
    talker_subscriber subscriber;
    bus.subscribe( &subscriber );
    avatar &actor = get_avatar();
    Creature *secondary = nullptr;

    SECTION( "vehicle_actor" ) {
        vehicle source{ vproto_id() };
        SECTION( "without_driver" ) {}
        SECTION( "with_driver" ) {
            secondary = &actor;
        }
        bus.send_with_talker( &source, secondary, cata::event::make<event_type::vehicle_moves>(
                                  false, false, false, false, false, true, false, false, false, 100, 0 ) );
        REQUIRE( subscriber.alpha );
        CHECK( subscriber.alpha->get_vehicle() == &source );
    }

    SECTION( "creature_actor" ) {
        SECTION( "without_source" ) {}
        SECTION( "with_source" ) {
            secondary = &actor;
        }
        bus.send_with_talker( &actor, secondary,
                              cata::event::make<event_type::character_kills_monster>( character_id( 5 ), zombie, 0 ) );
        REQUIRE( subscriber.alpha );
        CHECK( subscriber.alpha->get_creature() == &actor );
    }

    SECTION( "lethal_monster_damage" ) {
        monster target( mtype_id( "mon_zombie" ) );
        target.set_hp( 0 );
        secondary = &actor;
        bus.send_with_talker( &target, secondary,
                              cata::event::make<event_type::monster_takes_damage>( 1, true ) );
        REQUIRE( subscriber.alpha );
        CHECK( subscriber.alpha->get_creature() == &target );
    }

    if( secondary ) {
        REQUIRE( subscriber.beta );
        CHECK( subscriber.beta->get_creature() == secondary );
    } else {
        CHECK_FALSE( subscriber.beta );
    }
}

TEST_CASE( "source_less_damage_talkers_follow_the_original_identity", "[event]" )
{
    npc target;
    target.normalize();
    const character_id id( 13370 );
    target.setID( id, true );
    REQUIRE_FALSE( target.is_dead() );

    event_bus bus;
    damage_talker_subscriber first( id );
    damage_talker_subscriber later( id );
    bus.subscribe( &first );
    bus.subscribe( &later );

    bool expect_later_talker = true;
    SECTION( "ordinary damage reaches both subscribers" ) {}
    SECTION( "a lethal hit still reaches both subscribers" ) {
        target.set_part_hp_cur( body_part_torso, 0 );
        REQUIRE( target.is_dead() );
    }
    SECTION( "a subscriber can kill the target of a nonlethal hit" ) {
        first.on_damage = []( Character & who ) {
            who.set_part_hp_cur( body_part_torso, 0 );
        };
        expect_later_talker = false;
    }
    SECTION( "a subscriber can change the target's id in place" ) {
        first.on_damage = []( Character & who ) {
            who.setID( character_id( 13371 ), true );
        };
        expect_later_talker = false;
    }
    SECTION( "a subscriber can replace the target at the same address and id" ) {
        first.on_damage = [&target, id]( Character & ) {
            npc replacement;
            replacement.normalize();
            replacement.setID( id, true );
            target = std::move( replacement );
        };
        expect_later_talker = false;
    }

    const cata::event event = cata::event::make<event_type::character_takes_damage>(
                                  id, 1, body_part_torso, 0 );
    bus.send_with_talker( &target, static_cast<Creature *>( nullptr ), event );
    CHECK( first.calls == 1 );
    CHECK( later.calls == ( expect_later_talker ? 1 : 0 ) );
    CHECK( later.data_only_events.size() == ( expect_later_talker ? 0 : 1 ) );
    if( !expect_later_talker ) {
        REQUIRE( later.data_only_events.size() == 1 );
        const cata::event &observed = later.data_only_events.front();
        CHECK( observed.time() == event.time() );
        CHECK( observed.data() == event.data() );
    }
}

TEST_CASE( "lethal_source_less_damage_events_require_the_same_active_npc", "[event]" )
{
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    npc &target = spawn_npc( point_bub_ms( 65, 65 ), "test_talker" );
    const character_id id = target.getID();
    const int hp = target.get_part_hp_cur( body_part_torso );
    REQUIRE( hp > 0 );

    damage_talker_subscriber first( id );
    damage_talker_subscriber later( id );
    get_event_bus().subscribe( &first );
    get_event_bus().subscribe( &later );

    bool expect_later_talker = true;
    SECTION( "the lethal hit reaches both listeners when the target stays active" ) {}
    SECTION( "the first listener unloads the already lethally hit target" ) {
        first.on_damage = [&target]( Character & ) {
            target.on_unload();
        };
        expect_later_talker = false;
    }

    target.apply_damage( nullptr, body_part_torso, hp, true );
    CHECK( target.is_dead() );
    CHECK( first.calls == 1 );
    CHECK( later.calls == ( expect_later_talker ? 1 : 0 ) );
    CHECK( later.data_only_events.size() == ( expect_later_talker ? 0 : 1 ) );
}

TEST_CASE( "damage_event_eocs_stop_on_target_invalidation", "[event][eoc]" )
{
    clear_avatar();
    clear_map_without_vision();
    npc &target = spawn_npc( point_bub_ms( 65, 65 ), "test_talker" );
    const on_out_of_scope cleanup( []() {
        get_globals().remove_global_value( "event_test_damage_enabled" );
        get_globals().remove_global_value( "event_test_damage_retire" );
        get_avatar().remove_value( "event_test_damage_first" );
        get_avatar().remove_value( "event_test_damage_second" );
        clear_npcs();
    } );
    get_globals().set_global_value( "event_test_damage_enabled", "yes" );

    const int hp = target.get_part_hp_cur( body_part_torso );
    REQUIRE( hp > 1 );
    int damage = 1;
    Creature *source = nullptr;
    bool expect_later_talker = false;
    SECTION( "the first EOC kills the victim of a nonlethal hit" ) {}
    SECTION( "the first EOC retires the victim of an initially lethal hit" ) {
        damage = hp;
        get_globals().set_global_value( "event_test_damage_retire", "yes" );
    }
    SECTION( "an initially lethal hit still runs both EOCs" ) {
        damage = hp;
        expect_later_talker = true;
    }
    SECTION( "a source does not preserve a newly killed target" ) {
        source = &get_avatar();
    }
    SECTION( "a lethal hit with a source still reaches both EOCs" ) {
        source = &get_avatar();
        damage = hp;
        expect_later_talker = true;
    }

    damage_talker_subscriber observer( target.getID() );
    observer.expected_source = source;
    get_event_bus().subscribe( &observer );
    target.apply_damage( source, body_part_torso, damage, true );

    CHECK( target.is_dead() );
    CHECK( target.get_value( "event_test_damage_first" ) == "yes" );
    if( expect_later_talker ) {
        CHECK( target.get_value( "event_test_damage_second" ) == damage );
    } else {
        CHECK_FALSE( target.maybe_get_value( "event_test_damage_second" ) );
    }
    CHECK_FALSE( get_avatar().maybe_get_value( "event_test_damage_first" ) );
    CHECK_FALSE( get_avatar().maybe_get_value( "event_test_damage_second" ) );
    CHECK( observer.calls == ( expect_later_talker ? 1 : 0 ) );
    CHECK( observer.data_only_events.size() == ( expect_later_talker ? 0 : 1 ) );
    if( !expect_later_talker ) {
        REQUIRE( observer.data_only_events.size() == 1 );
        const cata::event &observed = observer.data_only_events.front();
        CHECK( observed.get<int>( "damage" ) == damage );
        CHECK( observed.get<bodypart_id>( "bodypart" ) == body_part_torso.id() );
        CHECK( observed.get<int>( "pain" ) == 0 );
    }
}

TEST_CASE( "sourced_direct_damage_rechecks_participants_before_continuing", "[event]" )
{
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    npc &target = spawn_npc( point_bub_ms( 65, 65 ), "test_talker" );
    npc &source = spawn_npc( point_bub_ms( 66, 65 ), "test_talker" );
    const auto source_reference = source.get_safe_reference();
    const int hp = target.get_part_hp_cur( body_part_torso );
    REQUIRE( hp > 1 );

    damage_talker_subscriber first( target.getID() );
    damage_talker_subscriber later( target.getID() );
    first.expected_source = &source;
    get_event_bus().subscribe( &first );
    get_event_bus().subscribe( &later );

    bool target_retired = false;
    bool source_removed = false;
    int damage = 1;
    SECTION( "a listener retires the victim before hit follow-up" ) {
        target_retired = true;
        first.on_damage = [&target]( Character & ) {
            target.on_unload();
            target.recoil = MAX_RECOIL + 1;
        };
    }
    SECTION( "a listener removes the attacker from both NPC owners" ) {
        source_removed = true;
        first.on_damage = [source_id = source.getID()]( Character & ) {
            g->remove_npc( source_id );
            overmap_buffer.remove_npc( source_id );
        };
    }
    SECTION( "an already lethal hit keeps both participants for listeners" ) {
        damage = hp;
        later.expected_source = &source;
    }

    const damage_instance hit( damage_type_id( "pure" ), damage );
    const dealt_damage_instance dealt = target.deal_damage( &source, body_part_torso, hit );
    CHECK( dealt.total_damage() == damage );
    CHECK( target.get_part_hp_cur( body_part_torso ) == hp - damage );
    CHECK( first.calls == 1 );
    if( target_retired ) {
        CHECK( target.recoil == MAX_RECOIL + 1 );
        CHECK( later.calls == 0 );
        CHECK( later.data_only_events.size() == 1 );
    } else {
        CHECK( later.calls == 1 );
        CHECK( later.data_only_events.empty() );
    }
    if( source_removed ) {
        CHECK( source_reference.get() == nullptr );
    }
}

TEST_CASE( "damage_commit_rechecks_the_victim_after_a_pain_callback", "[event]" )
{
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() { clear_npcs(); } );
    npc &target = spawn_npc( point_bub_ms( 65, 65 ), "test_talker" );
    npc &source = spawn_npc( point_bub_ms( 66, 65 ), "test_talker" );
    target.clear_effects();
    target.clear_mutations();
    target.set_painkiller( 0 );
    constexpr int hp = 80;
    target.set_part_hp_max( body_part_torso, hp );
    target.set_part_hp_cur( body_part_torso, hp );
    target.set_sensitive( 100 );
    const efftype_id sleep( "sleep" );
    target.add_effect( sleep, 1_hours, false, 1, false, true );
    REQUIRE( target.get_effect_dur( sleep ) == 1_hours );

    struct wake_subscriber : event_subscriber {
        using event_subscriber::notify;
        std::function<void()> on_wake;
        void notify( const cata::event &event ) override {
            if( event.type() == event_type::character_wakes_up ) {
                on_wake();
            }
        }
    } wake;
    const bool retire_victim = GENERATE( false, true );
    CAPTURE( retire_victim );
    bool woke = false;
    wake.on_wake = [&]() {
        CHECK_FALSE( woke );
        CHECK( target.get_part_hp_cur( body_part_torso ) == hp );
        ( retire_victim ? target : source ).on_unload();
        woke = true;
    };
    get_event_bus().subscribe( &wake );
    damage_talker_subscriber damage( target.getID() );
    get_event_bus().subscribe( &damage );
    const damage_instance hit( damage_type_id( "pure" ), 40 );
    const int expected_damage = retire_victim ? 0 : 40;
    CHECK( target.deal_damage( &source, body_part_torso, hit ).total_damage() == expected_damage );
    CHECK( woke );
    CHECK( target.get_part_hp_cur( body_part_torso ) == hp - expected_damage );
    CHECK( damage.calls == ( retire_victim ? 0 : 1 ) );
    CHECK( damage.data_only_events.empty() );
}

TEST_CASE( "hurtall_rechecks_both_participants_between_notifications", "[event]" )
{
    clear_map_without_vision();
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    npc &target = spawn_npc( point_bub_ms( 65, 65 ), "test_talker" );
    npc &source = spawn_npc( point_bub_ms( 66, 65 ), "test_talker" );
    const auto parts = target.get_all_body_parts( get_body_part_flags::only_main );
    REQUIRE( parts.size() > 1 );
    std::vector<int> before;
    for( const bodypart_id &part : parts ) {
        before.push_back( target.get_part_hp_cur( part ) );
        REQUIRE( before.back() > 1 );
    }

    damage_talker_subscriber first( target.getID() );
    damage_talker_subscriber later( target.getID() );
    first.expected_source = &source;
    get_event_bus().subscribe( &first );
    get_event_bus().subscribe( &later );
    bool target_retired = false;
    SECTION( "retiring the attacker removes that talker but not the hit" ) {
        first.on_damage = [&first, &source]( Character & ) {
            source.on_unload();
            first.expected_source = nullptr;
        };
    }
    SECTION( "retiring the victim stops damage to the remaining body parts" ) {
        target_retired = true;
        first.on_damage = [&target]( Character & ) {
            target.on_unload();
        };
    }

    target.hurtall( 1, &source, false );
    const std::size_t expected_hits = target_retired ? 1 : parts.size();
    REQUIRE( first.talker_events.size() == expected_hits );
    if( target_retired ) {
        CHECK( later.calls == 0 );
        REQUIRE( later.data_only_events.size() == 1 );
        CHECK( later.data_only_events.front().data() == first.talker_events.front().data() );
    } else {
        CHECK( later.talker_events.size() == expected_hits );
        CHECK( later.data_only_events.empty() );
    }
    for( std::size_t index = 0; index < parts.size(); ++index ) {
        CHECK( target.get_part_hp_cur( parts[index] ) == before[index] - ( index < expected_hits ) );
    }
}

TEST_CASE( "npc_load_replay_notifies_damage_with_a_retained_stale_handle", "[event][npc]" )
{
    clear_map_without_vision();
    const restore_on_out_of_scope restore_turn( calendar::turn );
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    calendar::turn = calendar::turn_zero;
    npc &target = spawn_npc( point_bub_ms( 65, 65 ), "test_talker" );
    npc_lifetime_registry &registry = *current_npc_lifetimes();
    const npc_lifetime stale = registry.acquire( target );
    REQUIRE( stale.resolve( registry ) == &target );

    target.on_unload();
    REQUIRE( stale.resolve( registry ) == nullptr );
    target.add_effect( efftype_id( "onfire" ), 10_turns, body_part_hand_l, false, 3, false, true );
    const int hp = target.get_part_hp_cur( body_part_arm_l );
    damage_talker_subscriber observer( target.getID() );
    get_event_bus().subscribe( &observer );

    calendar::turn += 1_turns;
    target.on_load( &get_map() );
    REQUIRE( observer.talker_events.size() == 1 );
    const cata::event &hit = observer.talker_events.front();
    CHECK( hit.get<int>( "damage" ) > 0 );
    CHECK( hit.get<bodypart_id>( "bodypart" ) == body_part_arm_l.id() );
    CHECK( target.get_part_hp_cur( body_part_arm_l ) == hp - hit.get<int>( "damage" ) );
    CHECK( stale.resolve( registry ) == nullptr );
}

namespace
{

struct expect_subscriber : public event_subscriber {
    using event_subscriber::notify;
    void notify( const cata::event & ) override {
        found = true;
    }
    bool found = false;
};

} // namespace

TEST_CASE( "notify_subscriber_2", "[event]" )
{
    cata::event original_event = cata::event::make<event_type::character_kills_monster>(
                                     character_id( 5 ), zombie, 0 );
    expect_subscriber sub;

    sub.notify( original_event );
    REQUIRE( sub.found );
}

TEST_CASE( "event_subscribers_can_opt_out_of_talker_construction", "[event]" )
{
    struct value_subscriber : event_subscriber {
        bool received = false;
        bool needs_talker() const override {
            return false;
        }
        void notify( const cata::event & ) override {
            received = true;
        }
        void notify( const cata::event &, std::unique_ptr<talker>,
                     std::unique_ptr<talker> ) override {
            FAIL( "Value-only subscriber received talkers" );
        }
    } values;
    talker_subscriber context;
    event_bus bus;
    bus.subscribe( &values );
    bus.subscribe( &context );
    avatar &actor = get_avatar();
    bus.send_with_talker( &actor, static_cast<Creature *>( nullptr ),
                         cata::event::make<event_type::character_kills_monster>( character_id( 5 ), zombie, 0 ) );
    CHECK( values.received );
    REQUIRE( context.alpha );
    CHECK( context.alpha->get_creature() == &actor );
    CHECK_FALSE( context.beta );
}
