#include <cstddef>
#include <iterator>
#include <list>
#include <random>
#include <vector>

#include "calendar.h"
#include "cata_catch.h"
#include "item.h"
#include "item_pocket.h"
#include "type_id.h"

static const itype_id itype_9mm( "9mm" );
static const itype_id itype_nail( "nail" );
static const itype_id itype_string_6( "string_6" );
static const itype_id itype_test_screwdriver( "test_screwdriver" );

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
    bool operator==( const stack_state &other ) const {
        return type == other.type && charges == other.charges && damage == other.damage;
    }
};

std::vector<stack_state> state_of( const std::list<item> &contents )
{
    std::vector<stack_state> ret;
    for( const item &it : contents ) {
        ret.push_back( { it.typeId(), it.charges, it.damage() } );
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

    std::mt19937 rng( 20261104 );
    auto roll = [&rng]( int lo, int hi ) {
        return std::uniform_int_distribution<int>( lo, hi )( rng );
    };
    for( int round = 0; round < 1000; ++round ) {
        std::list<item> actual;
        const int count = roll( 0, 24 );
        for( int i = 0; i < count; ++i ) {
            const itype_id &type = types[roll( 0, static_cast<int>( types.size() ) - 1 )];
            item it( type, calendar::turn );
            if( it.count_by_charges() ) {
                it.charges = roll( 1, 20 );
            }
            if( roll( 0, 3 ) == 0 ) {
                it.force_set_damage( 1000 );
            }
            actual.push_back( it );
        }
        std::list<item> expected = actual;
        const int tracked = count == 0 ? -1 : roll( -1, count - 1 );

        item *expected_tracked = original_restack( expected, nth( expected, tracked ) );
        item *actual_tracked = restack_charge_items( actual, nth( actual, tracked ) );

        CAPTURE( round, count, tracked );
        REQUIRE( state_of( actual ) == state_of( expected ) );
        CHECK( index_of( actual, actual_tracked ) == index_of( expected, expected_tracked ) );
    }
}
