#include <coordinates.h>
#include <creature.h>
#include <map_scale_constants.h>
#include <point.h>
#include <algorithm>
#include <array>
#include <cstddef>
#include <functional>
#include <initializer_list>
#include <limits>
#include <memory>
#include <random>
#include <set>
#include <sstream>
#include <stdexcept>
#include <string>
#include <vector>

#include "avatar.h"
#include "cata_catch.h"
#include "creature_reachability_filter.h"
#include "creature_tracker.h"
#include "flexbuffer_json.h"
#include "flood_fill.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "memory_fast.h"
#include "monster.h"
#include "npc.h"
#include "player_helpers.h"
#include "rng.h"
#include "type_id.h"

static const mtype_id mon_dog( "mon_dog" );
static const mtype_id mon_zombie( "mon_zombie" );

namespace
{
class mutable_classification_monster final : public monster
{
    public:
        using monster::monster;
        bool reported_monster = true;
        bool is_monster() const override {
            return reported_monster;
        }
};

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
    const cata_default_random_engine before =
        rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
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

TEST_CASE( "creature_reachability_filter_is_conservative_and_has_call_local_lifetime",
           "[monster][reachability]" )
{
    creature_reachability_filter first;
    first.mark( { 7, 7, 0 } );
    CHECK( first.may_contain( { 0, 0, 0 } ) );
    CHECK_FALSE( first.may_contain( { 8, 7, 0 } ) );
    CHECK_FALSE( first.may_contain( { 7, 7, 1 } ) );
    for( int z : {
             -OVERMAP_DEPTH, OVERMAP_HEIGHT
             } ) {
        for( int x : {
                 0, MAPSIZE_X - 1
             } ) {
            for( int y : {
                     0, MAPSIZE_Y - 1
                 } ) {
                const tripoint_abs_ms edge{ x, y, z };
                first.mark( edge );
                CHECK( first.may_contain( edge ) );
            }
        }
    }
    // Absolute locations outside the loaded bubble are indexed as well.
    for( const tripoint_abs_ms outside : {
             tripoint_abs_ms{ -1, 0, 0 },
             tripoint_abs_ms{ MAPSIZE_X, 0, 0 }, tripoint_abs_ms{ 0, -1, 0 },
             tripoint_abs_ms{ 0, MAPSIZE_Y, 0 },
             tripoint_abs_ms{ 0, 0, -OVERMAP_DEPTH - 1 },
             tripoint_abs_ms{ 0, 0, OVERMAP_HEIGHT + 1 },
             tripoint_abs_ms{ std::numeric_limits<int>::min(), std::numeric_limits<int>::max(),
                              std::numeric_limits<int>::min() },
             tripoint_abs_ms{ std::numeric_limits<int>::max(), std::numeric_limits<int>::min(),
                              std::numeric_limits<int>::max() }
         } ) {
        first.mark( outside );
        CHECK( first.may_contain( outside ) );
    }
    creature_reachability_filter next_pass;
    CHECK_FALSE( next_pass.may_contain( { 7, 7, 0 } ) );
    CHECK_FALSE( next_pass.may_contain( { 0, 0, -OVERMAP_DEPTH } ) );

    creature_reachability_filter negative;
    negative.mark( { -1, -1, -1 } );
    CHECK( negative.may_contain( { -8, -8, -1 } ) );
    CHECK_FALSE( negative.may_contain( { -9, -1, -1 } ) );
    CHECK_FALSE( negative.may_contain( { -1, -9, -1 } ) );
    CHECK_FALSE( negative.may_contain( { 7, 7, -1 } ) );
    // Bucket aliases are allowed false positives, never missing a marked key.
    CHECK( negative.may_contain( { 127, 127, -1 } ) );
    CHECK( negative.may_contain( { -1, -1, 31 } ) );
    creature_reachability_filter snapshot = negative;
    negative.reset();
    CHECK_FALSE( negative.may_contain( { -1, -1, -1 } ) );
    CHECK( snapshot.may_contain( { -1, -1, -1 } ) );
    snapshot.mark( { 0, 0, 0 } );
    CHECK_FALSE( negative.may_contain( { 0, 0, 0 } ) );
}

TEST_CASE( "creature_reachability_mixed_faction_queries_keep_live_membership",
           "[monster][reachability]" )
{
    prepare_reachability_rooms();
    creature_tracker &tracker = get_creature_tracker();
    avatar &player = get_avatar();
    monster &origin = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    monster &mixed = spawn_test_monster( "mon_zombie", { 51, 50, 0 } );
    mixed.faction = player.get_monster_faction();
    npc &person = spawn_npc( { 52, 50 }, "test_talker" );
    check_members( reachable_from( origin ), { &origin, &mixed, &person, &player } );
    tracker.remove( mixed );
    person.die( &get_map(), nullptr );
    REQUIRE( person.is_dead() );
    std::vector<Creature *> actual;
    tracker.for_each_reachable( origin, [&actual]( Creature * other ) {
        actual.push_back( other );
    } );
    check_members( actual, { &origin, &player } );
}

TEST_CASE( "creature_reachability_subclasses_keep_dynamic_classification",
           "[monster][reachability]" )
{
    prepare_reachability_rooms();
    map &here = get_map();
    creature_tracker &tracker = get_creature_tracker();
    monster &origin = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    auto custom = make_shared_fast<mutable_classification_monster>( mon_dog,
                  tripoint_bub_ms::zero );
    custom->spawn( here.get_abs( tripoint_bub_ms{ 54, 52, 0 } ) );
    REQUIRE( tracker.add( custom ) );
    REQUIRE( custom->get_monster_faction() != origin.get_monster_faction() );
    check_members( reachable_from( origin ), { &origin, custom.get(), &get_avatar() } );
    custom->reported_monster = false;
    CHECK_FALSE( tracker.is_present( custom.get() ) );
    std::vector<Creature *> actual;
    tracker.for_each_reachable( origin, [&actual]( Creature * other ) {
        actual.push_back( other );
    } );
    check_members( actual, { &origin, &get_avatar() } );
}

TEST_CASE( "creature_reachability_precompute_filter_preserves_order_and_later_world_changes",
           "[monster][reachability]" )
{
    prepare_reachability_rooms();
    map &here = get_map();
    creature_tracker &tracker = get_creature_tracker();
    avatar &player = get_avatar();
    monster &origin = spawn_test_monster( "mon_zombie", { 50, 50, 0 } );
    monster &hallucination = spawn_test_monster( "mon_zombie", { 51, 50, 0 } );
    hallucination.hallucination = true;
    npc &person = spawn_npc( { 52, 50 }, "test_talker" );
    std::vector<monster *> members;
    for( int x = 49; x <= 55 && members.size() < 80; ++x ) {
        for( int y = 49; y <= 61 && members.size() < 80; ++y ) {
            const tripoint_bub_ms position{ x, y, 0 };
            if( position != origin.pos_bub( here ) && position != hallucination.pos_bub( here ) &&
                position != person.pos_bub( here ) && position != player.pos_bub( here ) ) {
                members.push_back( &spawn_test_monster( "mon_zombie", position ) );
            }
        }
    }
    REQUIRE( members.size() == 80 );
    const auto check_precompute = [&]() {
        const auto expected = reachable_from( origin );
        tracker.invalidate_reachability_cache();
        const cata_default_random_engine before =
            rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
        tracker.precompute_all_zones();
        std::vector<Creature *> actual;
        tracker.for_each_reachable( origin, [&actual]( Creature * other ) {
            actual.push_back( other );
        } );
        CHECK( actual == expected );
        CHECK( rng_get_engine() == before );
    };
    check_precompute();
    members.front()->setpos( here, { 60, 52, 0 } );
    tracker.remove( hallucination );
    player.setpos( here, origin.pos_bub( here ) );
    check_precompute();
    // Mutate after the captured pass, then query lazily without precompute.
    members.front()->setpos( here, { 54, 62, 0 } );
    here.ter_set( tripoint_bub_ms{ 54, 62, 0 }, ter_id( "t_floor" ) );
    const auto after_move = reachable_from( origin );
    CHECK( std::find( after_move.begin(), after_move.end(), members.front() ) != after_move.end() );
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
        std::size_t found = 0;
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
        auto who = make_shared_fast<monster>( mon_zombie, tripoint_bub_ms::zero );
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
    const tripoint_abs_ms first_pos = first->pos_abs();
    const tripoint_abs_ms second_pos = second->pos_abs();
    tracker.swap_positions( *first, *second );
    CHECK( tracker.find( first_pos ) == second );
    CHECK( tracker.find( second_pos ) == first );
    verify();

    // Enough independent location publications to refresh the conservative
    // filter repeatedly. Every live registration must survive each refresh.
    for( int i = 0; i < 4096; ++i ) {
        const auto &who = members[i % members.size()];
        const tripoint_abs_ms old = who->pos_abs();
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
        auto who = make_shared_fast<monster>( mon_zombie, tripoint_bub_ms::zero );
        who->spawn( tripoint_abs_ms{ 10000 + i, 20000, 0 } );
        REQUIRE( tracker.add( who ) );
        members.push_back( who );
    }
    // Two different keys with the same current filter bit must remain fully
    // distinct in the authoritative map, including when either is removed.
    const auto original = members[0];
    const auto hash = std::hash<tripoint_abs_ms> {};
    const std::size_t bucket = hash( original->pos_abs() ) % 8192;
    tripoint_abs_ms collision{ 30000, 40000, 0 };
    for( int attempts = 0; attempts < 100000 && hash( collision ) % 8192 != bucket; ++attempts ) {
        collision.x()++;
    }
    REQUIRE( hash( collision ) % 8192 == bucket );
    REQUIRE_FALSE( tracker.find( collision ) );
    auto other = make_shared_fast<monster>( mon_zombie, tripoint_bub_ms::zero );
    other->spawn( collision );
    REQUIRE( tracker.add( other ) );
    CHECK( tracker.find( collision ) == other );
    CHECK( tracker.find( original->pos_abs() ) == original );
    tracker.remove( *original );
    CHECK_FALSE( tracker.find( original->pos_abs() ) );
    CHECK( tracker.find( collision ) == other );
    const tripoint_abs_ms old = other->pos_abs();
    const tripoint_abs_ms moved{ -50000, 60000, 1 };
    REQUIRE( tracker.update_pos( *other, old, moved ) );
    other->spawn( moved );
    CHECK_FALSE( tracker.find( old ) );
    CHECK( tracker.find( moved ) == other );
}

TEST_CASE( "creature_reachability_scanline_retains_order_across_vertical_spans",
           "[monster][reachability][flood_fill]" )
{
    const auto passable = []( const tripoint_bub_ms & p, int direction ) {
        const bool ground = p.z() == 0 && p.x() >= 2 && p.x() <= 4 &&
                            p.y() >= 2 && p.y() <= 3;
        const bool upper = p.z() == 1 && p.y() == 3 && p.x() >= 3 && p.x() <= 4;
        if( direction == 0 ) {
            return ground || upper;
        }
        return p.x() == 4 && p.y() == 3 &&
               ( ( direction == 1 && p.z() == 1 ) || ( direction == -1 && p.z() == 0 ) );
    };
    const std::vector<tripoint_bub_ms> expected{
        { 2, 2, 0 }, { 3, 2, 0 }, { 4, 2, 0 }, { 3, 3, 0 },
        { 2, 3, 0 }, { 4, 3, 0 }, { 3, 3, 1 }, { 4, 3, 1 }
    };
    const cata_default_random_engine rng_before =
        rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
    for( int repeat = 0; repeat < 2; ++repeat ) {
        std::vector<tripoint_bub_ms> visited;
        ff::flood_fill_visit_10_connected( tripoint_bub_ms{ 3, 3, 0 }, passable,
        [&visited]( const tripoint_bub_ms & p ) {
            visited.push_back( p );
        } );
        CHECK( visited == expected );
    }
    CHECK( rng_get_engine() == rng_before );
}

namespace
{
struct flood_observation {
    std::vector<tripoint_bub_ms> visited;
    std::vector<std::array<int, 5>> checks;
};

bool scanline_pattern( const tripoint_bub_ms &p, int direction, int base_z,
                       const point &offset, bool upper )
{
    const tripoint local = p.raw() - tripoint( offset, base_z );
    const bool ground = local.z == 0 && local.x >= 2 && local.x <= 4 &&
                        local.y >= 2 && local.y <= 3;
    if( direction == 0 ) {
        return ground || ( upper && local.z == 1 && local.y == 3 &&
                           local.x >= 3 && local.x <= 4 );
    }
    return upper && local.x == 4 && local.y == 3 &&
           ( ( direction == 1 && local.z == 1 ) || ( direction == -1 && local.z == 0 ) );
}

flood_observation observe_scanline( ff::flood_fill_10_workspace *workspace,
                                    int base_z, const point &offset, bool upper )
{
    flood_observation observed;
    const auto predicate = [&]( const tripoint_bub_ms & p, int direction ) {
        const bool result = scanline_pattern( p, direction, base_z, offset, upper );
        observed.checks.push_back( { p.x(), p.y(), p.z(), direction, result } );
        return result;
    };
    const auto visitor = [&]( const tripoint_bub_ms & p ) {
        observed.visited.push_back( p );
    };
    const tripoint_bub_ms origin{ 3 + offset.x, 3 + offset.y, base_z };
    if( workspace ) {
        ff::flood_fill_visit_10_connected( origin, predicate, visitor, *workspace );
    } else {
        ff::flood_fill_visit_10_connected( origin, predicate, visitor );
    }
    return observed;
}
} // namespace

TEST_CASE( "creature_flood_workspace_preserves_order_between_layers_and_owners",
           "[monster][reachability][flood_fill]" )
{
    const std::unique_ptr<ff::flood_fill_10_workspace> workspace =
        std::make_unique<ff::flood_fill_10_workspace>();
    const std::unique_ptr<ff::flood_fill_10_workspace> other =
        std::make_unique<ff::flood_fill_10_workspace>();
    const cata_default_random_engine rng_before =
        rng_get_engine(); // NOLINT(cata-determinism) Snapshot only; no independent draws.
    for( const int base_z : {
             -OVERMAP_DEPTH, 0, OVERMAP_HEIGHT - 1, -2, 1, 0
             } ) {
        for( const point offset : {
                 point{ -2, -2 }, point{ MAPSIZE_X - 5, MAPSIZE_Y - 4 },
                 point::zero
             } ) {
            for( const bool upper : {
                     true, false, true
                 } ) {
                CAPTURE( base_z, offset, upper );
                std::vector<tripoint_bub_ms> expected{
                    { 2, 2, 0 }, { 3, 2, 0 }, { 4, 2, 0 }, { 3, 3, 0 },
                    { 2, 3, 0 }, { 4, 3, 0 }, { 3, 3, 1 }, { 4, 3, 1 }
                };
                // Preserve the existing top-layer traversal boundary, too.
                if( !upper || base_z + 1 >= OVERMAP_HEIGHT ) {
                    expected.resize( 6 );
                }
                for( auto &position : expected ) {
                    position.x() += offset.x;
                    position.y() += offset.y;
                    position.z() += base_z;
                }
                const flood_observation fresh = observe_scanline( nullptr, base_z, offset, upper );
                const flood_observation reused = observe_scanline( workspace.get(), base_z, offset, upper );
                const flood_observation independent = observe_scanline( other.get(), base_z, offset, upper );
                CHECK( fresh.visited == expected );
                CHECK( reused.visited == expected );
                CHECK( independent.visited == expected );
                CHECK( reused.checks == fresh.checks );
                CHECK( independent.checks == fresh.checks );
            }
        }
    }
    CHECK( rng_get_engine() == rng_before );
}

TEST_CASE( "creature_flood_workspace_recovers_after_callbacks_throw",
           "[monster][reachability][flood_fill]" )
{
    const std::unique_ptr<ff::flood_fill_10_workspace> workspace =
        std::make_unique<ff::flood_fill_10_workspace>();
    const flood_observation expected = observe_scanline( nullptr, 0, point::zero, true );
    const bool throw_in_predicate = GENERATE( false, true );
    int checks = 0;
    int visits = 0;
    const auto predicate = [&]( const tripoint_bub_ms & p, int direction ) {
        if( ++checks == 12 && throw_in_predicate ) {
            throw std::runtime_error( "predicate failed" );
        }
        return scanline_pattern( p, direction, 0, point::zero, true );
    };
    const auto visitor = [&]( const tripoint_bub_ms & ) {
        if( ++visits == 2 && !throw_in_predicate ) {
            throw std::runtime_error( "visitor failed" );
        }
    };
    REQUIRE_THROWS_AS( ff::flood_fill_visit_10_connected( tripoint_bub_ms{ 3, 3, 0 },
                       predicate, visitor, *workspace ), std::runtime_error );
    const flood_observation after_throw = observe_scanline( workspace.get(), 0, point::zero, true );
    CHECK( after_throw.visited == expected.visited );
    CHECK( after_throw.checks == expected.checks );
}

TEST_CASE( "creature_flood_workspace_isolates_reentrant_calls",
           "[monster][reachability][flood_fill]" )
{
    const std::unique_ptr<ff::flood_fill_10_workspace> workspace =
        std::make_unique<ff::flood_fill_10_workspace>();
    const flood_observation expected = observe_scanline( nullptr, 0, point::zero, true );
    flood_observation outer;
    flood_observation inner;
    const auto predicate = [&]( const tripoint_bub_ms & p, int direction ) {
        const bool result = scanline_pattern( p, direction, 0, point::zero, true );
        outer.checks.push_back( { p.x(), p.y(), p.z(), direction, result } );
        return result;
    };
    const auto visitor = [&]( const tripoint_bub_ms & p ) {
        outer.visited.push_back( p );
        if( outer.visited.size() == 1 ) {
            inner = observe_scanline( workspace.get(), -2, point{ 10, 10 }, true );
        }
    };
    ff::flood_fill_visit_10_connected( tripoint_bub_ms{ 3, 3, 0 }, predicate, visitor, *workspace );
    CHECK( outer.visited == expected.visited );
    CHECK( outer.checks == expected.checks );
    const flood_observation fresh_inner = observe_scanline( nullptr, -2, point{ 10, 10 }, true );
    CHECK( inner.visited == fresh_inner.visited );
    CHECK( inner.checks == fresh_inner.checks );
    CHECK( observe_scanline( workspace.get(), 0, point::zero, true ).visited == expected.visited );
}
