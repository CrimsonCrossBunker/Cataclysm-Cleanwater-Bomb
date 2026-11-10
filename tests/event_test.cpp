#include <memory>
#include <string>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_variant.h"
#include "cata_catch.h"
#include "character_id.h"
#include "creature.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "talker.h"
#include "type_id.h"
#include "vehicle.h"

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

    if( secondary ) {
        REQUIRE( subscriber.beta );
        CHECK( subscriber.beta->get_creature() == secondary );
    } else {
        CHECK_FALSE( subscriber.beta );
    }
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
