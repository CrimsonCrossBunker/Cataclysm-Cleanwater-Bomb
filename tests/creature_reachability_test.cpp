#include <algorithm>
#include <functional>
#include <set>
#include <sstream>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "creature_tracker.h"
#include "flexbuffer_json.h"
#include "json.h"
#include "json_loader.h"
#include "memory_fast.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "npc.h"
#include "player_helpers.h"
#include "rng.h"
#include "type_id.h"

namespace
{
void prepare_reachability_rooms()
{
    clear_map_without_vision();
    clear_avatar();
    map &here = get_map();
    for( int z = -1; z <= 1; ++z ) {
        for( int x = 48; x <= 64; ++x ) {
            for( int y = 48; y <= 62; ++y ) {
                const bool wall = x == 48 || x == 64 || y == 48 || y == 62 || x == 56;
                here.ter_set( tripoint_bub_ms{ x, y, z }, ter_id( z == -1 ? "t_rock" :
                              wall ? "t_wall" : "t_floor" ) );
            }
        }
    }
    get_avatar().setpos( here, { 53, 53, 0 } );
}

std::vector<Creature *> reachable_from( const Creature &origin )
{
    map &here = get_map();
    for( int z = -1; z <= 1; ++z ) {
        here.invalidate_map_cache( z );
        here.build_map_cache( z );
    }
    creature_tracker &tracker = get_creature_tracker();
    tracker.invalidate_reachability_cache();
    const cata_default_random_engine before = rng_get_engine();
    std::vector<Creature *> result;
    tracker.for_each_reachable( origin, [&result]( Creature * other ) {
        result.push_back( other );
    } );
    CHECK( rng_get_engine() == before );
    return result;
}

void check_members( const std::vector<Creature *> &found,
                    const std::set<Creature *> &expected )
{
    CHECK( found.size() == expected.size() );
    CHECK( std::set<Creature *>( found.begin(), found.end() ) == expected );
}
} // namespace

TEST_CASE( "creature_reachability_preserves_owner_lookup_and_lifecycle",
           "[monster][reachability]" )
{
    prepare_reachability_rooms();
    map &here = get_map();
    creature_tracker &tracker = get_creature_tracker();
    avatar &player = get_avatar();
    monster &origin = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    monster &hallucination = spawn_test_monster( "mon_zombie", { 51, 50, 0 } );
    hallucination.hallucination = true;
    monster &separate = spawn_test_monster( "mon_zombie", { 60, 50, 0 } );
    npc &person = spawn_npc( { 52, 50 }, "test_talker" );
    check_members( reachable_from( origin ), { &origin, &hallucination, &person, &player } );

    SECTION( "marked_cells_keep_monster_before_avatar_precedence" ) {
        player.setpos( here, origin.pos_bub( here ) );
        check_members( reachable_from( origin ), { &origin, &hallucination, &person } );
    }
    SECTION( "new_search_observes_movement_and_removal" ) {
        separate.setpos( here, { 54, 50, 0 } );
        tracker.remove( hallucination );
        check_members( reachable_from( origin ), { &origin, &separate, &person, &player } );
        separate.setpos( here, { 60, 50, 0 } );
        check_members( reachable_from( origin ), { &origin, &person, &player } );
    }
    SECTION( "door_change_preserves_membership_and_traversal_order" ) {
        here.ter_set( tripoint_bub_ms{ 56, 53, 0 }, ter_id( "t_door_o" ) );
        const auto first = reachable_from( origin );
        check_members( first, { &origin, &hallucination, &separate, &person, &player } );
        CHECK( reachable_from( origin ) == first );
        here.ter_set( tripoint_bub_ms{ 56, 53, 0 }, ter_id( "t_wall" ) );
        check_members( reachable_from( origin ), { &origin, &hallucination, &person, &player } );
    }
    SECTION( "dead_and_replaced_monster_locations_are_requeried" ) {
        hallucination.set_hp( 0 );
        REQUIRE( hallucination.is_dead() );
        check_members( reachable_from( origin ), { &origin, &person, &player } );
        tracker.remove( hallucination );
        monster &replacement = spawn_test_monster( "mon_zombie", { 51, 50, 0 } );
        check_members( reachable_from( origin ), { &origin, &replacement, &person, &player } );
    }
    SECTION( "vertical_connection_keeps_level_occupancy_separate" ) {
        monster &above = spawn_test_monster( "mon_zombie", { 54, 55, 1 } );
        check_members( reachable_from( origin ), { &origin, &hallucination, &person, &player } );
        here.ter_set( tripoint_bub_ms{ 54, 54, 0 }, ter_id( "t_stairs_up" ) );
        here.ter_set( tripoint_bub_ms{ 54, 54, 1 }, ter_id( "t_stairs_down" ) );
        check_members( reachable_from( origin ), { &origin, &hallucination, &above, &person, &player } );
    }
    SECTION( "subsequent_zone_search_captures_its_own_members" ) {
        // Query both rooms in the same validity generation.  The historical
        // two-invalidation sign alias is tracked by the separate behavior fix;
        // this optimization preserves existing simulation behavior.
        std::vector<Creature *> other_room;
        tracker.for_each_reachable( separate, [&other_room]( Creature * other ) {
            other_room.push_back( other );
        } );
        check_members( other_room, { &separate } );
        std::vector<Creature *> first_room;
        tracker.for_each_reachable( origin, [&first_room]( Creature * other ) {
            first_room.push_back( other );
        } );
        check_members( first_room, { &origin, &hallucination, &person, &player } );
    }
}

TEST_CASE( "creature_reachability_empty_border_cells_do_not_hide_live_creatures",
           "[monster][reachability]" )
{
    prepare_reachability_rooms();
    map &here = get_map();
    for( int x = 0; x <= 5; ++x ) {
        for( int y = 0; y <= 5; ++y ) {
            here.ter_set( tripoint_bub_ms{ x, y, -1 }, ter_id( "t_rock" ) );
            here.ter_set( tripoint_bub_ms{ x, y, 1 }, ter_id( "t_floor" ) );
            here.ter_set( tripoint_bub_ms{ x, y, 0 }, ter_id( x == 5 || y == 5 ? "t_wall" : "t_floor" ) );
        }
    }
    monster &origin = spawn_test_monster( "mon_zombie", { 0, 0, 0 } );
    monster &edge = spawn_test_monster( "mon_zombie", { 4, 4, 0 } );
    check_members( reachable_from( origin ), { &origin, &edge } );
}

BENCHMARK_TEST_CASE( "creature_reachability_zone_collection_benchmark", "[reachability]" )
{
    const bool fragmented = GENERATE( false, true );
    clear_map_without_vision();
    clear_avatar();
    map &here = get_map();
    for( int x = 40; x <= 84; ++x ) {
        for( int y = 40; y <= 84; ++y ) {
            const bool wall = x == 40 || x == 84 || y == 40 || y == 84 ||
                              ( fragmented && ( ( x - 40 ) % 3 == 0 || ( y - 40 ) % 3 == 0 ) );
            here.ter_set( tripoint_bub_ms{ x, y, -1 }, ter_id( "t_rock" ) );
            here.ter_set( tripoint_bub_ms{ x, y, 0 }, ter_id( wall ? "t_wall" : "t_floor" ) );
            here.ter_set( tripoint_bub_ms{ x, y, 1 }, ter_id( "t_floor" ) );
        }
    }
    get_avatar().setpos( here, { 90, 90, 0 } );
    std::vector<monster *> creatures;
    for( int x = 41; x < 84 && creatures.size() < 759; ++x ) {
        for( int y = 41; y < 84 && creatures.size() < 759; ++y ) {
            const tripoint_bub_ms pos{ x, y, 0 };
            if( here.passable( pos ) ) {
                creatures.push_back( &spawn_test_monster( "mon_zombie", pos ) );
            }
        }
    }
    REQUIRE( creatures.size() == 759 );
    for( int z = -1; z <= 1; ++z ) {
        here.invalidate_map_cache( z );
        here.build_map_cache( z );
    }
    creature_tracker &tracker = get_creature_tracker();
    BENCHMARK( fragmented ? "759 creatures in small isolated zones" :
               "759 creatures in one open zone" ) {
        tracker.invalidate_reachability_cache();
        size_t found = 0;
        for( const monster *origin : creatures ) {
            tracker.find_reachable( *origin, [&found]( Creature * ) {
                ++found;
                return true;
            } );
        }
        return found;
    };
}

TEST_CASE( "creature_registration_filter_survives_moves_swaps_and_repeated_rebuilds",
           "[monster][reachability][registration]" )
{
    creature_tracker tracker;
    std::vector<shared_ptr_fast<monster>> members;
    const auto add_at = [&]( const tripoint_abs_ms & pos ) {
        auto who = make_shared_fast<monster>( mtype_id( "mon_zombie" ), tripoint_bub_ms::zero );
        who->spawn( pos );
        REQUIRE( tracker.add( who ) );
        members.push_back( who );
        return who;
    };
    for( int i = 0; i < 80; ++i ) {
        add_at( { 100000 + i, -200000, i % 3 - 1 } );
    }
    const auto verify = [&]() {
        for( const auto &who : members ) {
            CHECK( tracker.find( who->pos_abs() ) == ( who->is_dead() ? nullptr : who ) );
        }
    };
    verify();
    const auto first = members[0];
    const auto second = members[1];
    const auto first_pos = first->pos_abs();
    const auto second_pos = second->pos_abs();
    tracker.swap_positions( *first, *second );
    CHECK( tracker.find( first_pos ) == second );
    CHECK( tracker.find( second_pos ) == first );
    verify();

    // Enough independent location publications to refresh the conservative
    // filter repeatedly. Every live registration must survive each refresh.
    for( int i = 0; i < 4096; ++i ) {
        const auto &who = members[i % members.size()];
        const auto old = who->pos_abs();
        const tripoint_abs_ms next{ 200000 + i, -300000 + i % 7, i % 3 - 1 };
        REQUIRE( tracker.update_pos( *who, old, next ) );
        who->spawn( next );
        CHECK( tracker.find( old ) == nullptr );
        CHECK( tracker.find( next ) == who );
        if( i % 97 == 0 ) {
            verify();
        }
    }
    verify();
    members.back()->set_hp( 0 );
    CHECK_FALSE( tracker.find( members.back()->pos_abs() ) );
    tracker.remove( *members.back() );
    members.pop_back();
    verify();

    std::ostringstream out;
    JsonOut json( out );
    tracker.serialize( json );
    creature_tracker restored;
    restored.deserialize( json_loader::from_string( out.str() ).get_array() );
    REQUIRE( restored.size() == members.size() );
    for( const auto &who : members ) {
        const auto loaded = restored.find( who->pos_abs() );
        REQUIRE( loaded );
        CHECK( loaded->pos_abs() == who->pos_abs() );
        CHECK( loaded->get_hp() == who->get_hp() );
    }
    tracker.clear();
    CHECK( tracker.size() == 0 );
    for( const auto &who : members ) {
        CHECK_FALSE( tracker.find( who->pos_abs() ) );
    }
}

TEST_CASE( "creature_registration_filter_collisions_preserve_authoritative_lookup",
           "[monster][reachability][registration]" )
{
    creature_tracker tracker;
    std::vector<shared_ptr_fast<monster>> members;
    for( int i = 0; i < 80; ++i ) {
        auto who = make_shared_fast<monster>( mtype_id( "mon_zombie" ), tripoint_bub_ms::zero );
        who->spawn( tripoint_abs_ms{ 10000 + i, 20000, 0 } );
        REQUIRE( tracker.add( who ) );
        members.push_back( who );
    }
    // Two different keys with the same current filter bit must remain fully
    // distinct in the authoritative map, including when either is removed.
    const auto original = members[0];
    const auto hash = std::hash<tripoint_abs_ms> {};
    const auto bucket = hash( original->pos_abs() ) % 8192;
    tripoint_abs_ms collision{ 30000, 40000, 0 };
    for( int attempts = 0; attempts < 100000 && hash( collision ) % 8192 != bucket; ++attempts ) {
        collision.x()++;
    }
    REQUIRE( hash( collision ) % 8192 == bucket );
    REQUIRE_FALSE( tracker.find( collision ) );
    auto other = make_shared_fast<monster>( mtype_id( "mon_zombie" ), tripoint_bub_ms::zero );
    other->spawn( collision );
    REQUIRE( tracker.add( other ) );
    CHECK( tracker.find( collision ) == other );
    CHECK( tracker.find( original->pos_abs() ) == original );
    tracker.remove( *original );
    CHECK_FALSE( tracker.find( original->pos_abs() ) );
    CHECK( tracker.find( collision ) == other );
    const auto old = other->pos_abs();
    const tripoint_abs_ms moved{ -50000, 60000, 1 };
    REQUIRE( tracker.update_pos( *other, old, moved ) );
    other->spawn( moved );
    CHECK_FALSE( tracker.find( old ) );
    CHECK( tracker.find( moved ) == other );
}
