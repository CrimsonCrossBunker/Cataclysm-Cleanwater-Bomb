#include <iterator>
#include <list>
#include <string>
#include <vector>

#include "calendar.h"
#include "cata_catch.h"
#include "item.h"
#include "item_pocket.h"
#include "rng.h"
#include "type_id.h"
#include "units.h"

static const itype_id itype_9mm( "9mm" );
static const itype_id itype_milk( "milk" );
static const itype_id itype_nail( "nail" );
static const itype_id itype_string_6( "string_6" );
static const itype_id itype_test_screwdriver( "test_screwdriver" );
static const itype_id itype_water_clean( "water_clean" );

namespace
{
// item_pocket::restack's non-magazine loop before restack_charge_items, kept as the reference:
// every count_by_charges item scans all of `contents`, and the outer scan restarts at
// contents.begin() after every merge.
item *original_restack( std::list<item> &contents, item *ret )
{
    for( auto outer_iter = contents.begin(); outer_iter != contents.end(); ++outer_iter ) {
        if( !outer_iter->count_by_charges() ) {
            continue;
        }
        for( auto inner_iter = contents.begin(); inner_iter != contents.end(); ) {
            if( outer_iter == inner_iter || !inner_iter->count_by_charges() ) {
                ++inner_iter;
                continue;
            }
            if( outer_iter->combine( *inner_iter ) ) {
                if( &( *inner_iter ) == ret ) {
                    ret = &( *outer_iter );
                }
                inner_iter = contents.erase( inner_iter );
                outer_iter = contents.begin();
            } else {
                ++inner_iter;
            }
        }
    }
    return ret;
}

struct stack_state {
    itype_id type;
    int charges;
    int damage;
    faction_id owner;
    faction_id old_owner;
    float thermal_energy;
    double relative_rot;
    int counter;
    bool operator==( const stack_state &other ) const {
        return type == other.type && charges == other.charges && damage == other.damage &&
               owner == other.owner && old_owner == other.old_owner &&
               thermal_energy == other.thermal_energy && relative_rot == other.relative_rot &&
               counter == other.counter;
    }
};

std::vector<stack_state> state_of( const std::list<item> &contents )
{
    std::vector<stack_state> ret;
    for( const item &it : contents ) {
        ret.push_back( { it.typeId(), it.charges, it.damage(), it.get_owner(), it.get_old_owner(),
                         it.get_item_thermal_energy(), it.get_relative_rot(), it.item_counter } );
    }
    return ret;
}

int index_of( const std::list<item> &contents, const item *it )
{
    int idx = 0;
    for( const item &candidate : contents ) {
        if( &candidate == it ) {
            return idx;
        }
        ++idx;
    }
    return -1;
}

item *nth( std::list<item> &contents, int idx )
{
    return idx < 0 ? nullptr : &*std::next( contents.begin(), idx );
}
} // namespace

TEST_CASE( "restack_charge_items_matches_original_algorithm", "[item][stacking][charges]" )
{
    // 9mm, nail and string_6 are counted by charges; test_screwdriver is not.  A damaged
    // copy cannot combine with an undamaged one, so some stacks must stay apart.
    const std::vector<itype_id> types = {
        itype_9mm, itype_nail, itype_string_6, itype_test_screwdriver
    };
    for( const itype_id &type : types ) {
        CAPTURE( type.str() );
        const bool by_charges = type != itype_test_screwdriver;
        REQUIRE( item( type, calendar::turn ).count_by_charges() == by_charges );
    }

    // Fixed seed so that a failing round can be reproduced.
    rng_set_engine_seed( 20261104 );
    for( int round = 0; round < 1000; ++round ) {
        std::list<item> actual;
        const int count = rng( 0, 24 );
        for( int i = 0; i < count; ++i ) {
            const itype_id &type = types[rng( 0, static_cast<int>( types.size() ) - 1 )];
            item it( type, calendar::turn );
            if( it.count_by_charges() ) {
                it.charges = rng( 1, 20 );
            }
            if( rng( 0, 3 ) == 0 ) {
                it.force_set_damage( 1000 );
            }
            actual.push_back( it );
        }
        std::list<item> expected = actual;
        const int tracked = count == 0 ? -1 : rng( -1, count - 1 );

        item *expected_tracked = original_restack( expected, nth( expected, tracked ) );
        item *actual_tracked = restack_charge_items( actual, nth( actual, tracked ) );

        CAPTURE( round, count, tracked );
        REQUIRE( state_of( actual ) == state_of( expected ) );
        CHECK( index_of( actual, actual_tracked ) == index_of( expected, expected_tracked ) );
    }
}

TEST_CASE( "restack_charge_items_merges_large_stacks", "[item][stacking][charges]" )
{
    const bool nonstackable_first = GENERATE( false, true );
    const bool track_last = GENERATE( false, true );
    std::list<item> actual;
    if( nonstackable_first ) {
        actual.emplace_back( itype_test_screwdriver, calendar::turn );
    }
    for( int i = 0; i < 1024; ++i ) {
        actual.emplace_back( itype_9mm, calendar::turn, 1 );
    }
    std::list<item> expected = actual;
    const int tracked = track_last ? static_cast<int>( actual.size() ) - 1 :
                        static_cast<int>( nonstackable_first );
    item *expected_tracked = original_restack( expected, nth( expected, tracked ) );
    item *actual_tracked = restack_charge_items( actual, nth( actual, tracked ) );
    REQUIRE( state_of( actual ) == state_of( expected ) );
    CHECK( index_of( actual, actual_tracked ) == index_of( expected, expected_tracked ) );
    CHECK( actual.size() == ( nonstackable_first ? 2 : 1 ) );
    CHECK( actual.back().charges == 1024 );
}

TEST_CASE( "restack_charge_items_preserves_liquid_state", "[item][stacking][charges][liquid]" )
{
    const itype_id type = GENERATE( itype_water_clean, itype_milk );
    const bool owned_first = GENERATE( false, true );
    std::list<item> actual;
    actual.emplace_back( itype_test_screwdriver, calendar::turn );
    for( int i = 0; i < 3; ++i ) {
        item liquid( type, calendar::turn, 10 + i );
        liquid.set_item_temperature( units::from_celsius( 20 + i ) );
        liquid.set_relative_rot( 0.1 * i );
        liquid.item_counter = 10 * i;
        if( i == ( owned_first ? 0 : 2 ) ) {
            liquid.set_owner( faction_id( "your_followers" ) );
            liquid.set_old_owner( faction_id( "free_merchants" ) );
        }
        actual.push_back( liquid );
    }
    REQUIRE( nth( actual, 1 )->can_combine( *nth( actual, 2 ) ) );
    REQUIRE( nth( actual, 2 )->can_combine( *nth( actual, 3 ) ) );
    std::list<item> expected = actual;
    item *expected_tracked = original_restack( expected, nth( expected, 3 ) );
    item *actual_tracked = restack_charge_items( actual, nth( actual, 3 ) );
    REQUIRE( state_of( actual ) == state_of( expected ) );
    CHECK( index_of( actual, actual_tracked ) == index_of( expected, expected_tracked ) );
    REQUIRE( actual.size() == 2 );
    CHECK( actual.back().charges == 33 );
}

BENCHMARK_TEST_CASE( "restack_charge_items_benchmark", "[item][stacking]" )
{
    const int count = GENERATE( 64, 256, 1024 );
    std::list<item> contents;
    SECTION( "mergeable" ) {
        contents.assign( count, item( itype_9mm, calendar::turn, 1 ) );
    }
    SECTION( "unmergeable" ) {
        for( int i = 0; i < count; ++i ) {
            item ammo( itype_9mm, calendar::turn, 1 );
            ammo.set_var( "item_note", i );
            contents.push_back( ammo );
        }
    }
    SECTION( "mostly_nonstackable" ) {
        contents.assign( count, item( itype_test_screwdriver, calendar::turn ) );
        contents.insert( contents.end(), 16, item( itype_9mm, calendar::turn, 1 ) );
    }
    CAPTURE( count );
    BENCHMARK( "original restack including contents copy" ) {
        std::list<item> copy = contents;
        original_restack( copy, &copy.back() );
        return copy.size();
    };
    BENCHMARK( "filtered restack including contents copy" ) {
        std::list<item> copy = contents;
        restack_charge_items( copy, &copy.back() );
        return copy.size();
    };
}
