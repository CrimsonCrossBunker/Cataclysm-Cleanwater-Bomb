#include <cata_utility.h>
#include <array>
#include <climits>
#include <cstddef>
#include <functional>
#include <initializer_list>
#include <list>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "flag.h"
#include "item.h"
#include "item_location.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "temp_crafting_inventory.h"
#include "type_id.h"

static const flag_id json_flag_ITEM_BROKEN( "ITEM_BROKEN" );
static const flag_id json_flag_PSEUDO( "PSEUDO" );
static const flag_id json_flag_USE_UPS( "USE_UPS" );

static const itype_id itype_556( "556" );
static const itype_id itype_9mm( "9mm" );
static const itype_id itype_UPS( "UPS" );
static const itype_id itype_UPS_ON( "UPS_ON" );
static const itype_id itype_any( "any" );
static const itype_id itype_backpack( "backpack" );
static const itype_id itype_battery_ups( "battery_ups" );
static const itype_id itype_bottle_plastic( "bottle_plastic" );
static const itype_id itype_glockmag( "glockmag" );
static const itype_id itype_hammer( "hammer" );
static const itype_id itype_nail( "nail" );
static const itype_id itype_rock( "rock" );
static const itype_id itype_soldering_iron( "soldering_iron" );
static const itype_id itype_stanag30( "stanag30" );
static const itype_id itype_test_multimag_tool_consume( "test_multimag_tool_consume" );
static const itype_id itype_water( "water" );

namespace
{
class counting_crafting_inventory : public temp_crafting_inventory
{
    public:
        mutable int traversals = 0;
        mutable int visits = 0;
        VisitResponse visit_items( const std::function<VisitResponse( item *, item * )> &func ) const
        override {
            ++traversals;
            return temp_crafting_inventory::visit_items( [&]( item * node, item * parent ) {
                ++visits;
                return func( node, parent );
            } );
        }
};

std::vector<int> query_inventory( const temp_crafting_inventory &inv )
{
    const std::array<itype_id, 7> types = { itype_rock, itype_nail, itype_water,
                                            itype_backpack, itype_bottle_plastic, itype_hammer, itype_any
                                          };
    std::vector<int> result;
    for( const itype_id &id : types ) {
        for( int limit : {
                 0, 1, 2, INT_MAX
             } ) {
            for( bool pseudo : {
                     false, true
                 } ) {
                for( bool accept : {
                         false, true
                     } ) {
                    const auto filter = [accept]( const item & it ) {
                        return accept && !it.has_flag( flag_HIDDEN_POISON );
                    };
                    result.push_back( inv.amount_of( id, pseudo, limit, filter ) );
                    result.push_back( inv.charges_of( id, limit, filter ) );
                    result.push_back( inv.charges_of( id, limit, filter, nullptr, true ) );
                }
            }
        }
        result.push_back( inv.count_item( id ) );
        result.push_back( inv.must_use_hallu_poison( id, 2 ) );
    }
    return result;
}
} // namespace

TEST_CASE( "crafting_index_bounds_inventory_work", "[crafting][inventory][cache]" )
{
    counting_crafting_inventory inv;
    for( int i = 0; i < 10000; ++i ) {
        inv.add_item_copy( item( itype_rock ) );
    }
    {
        scoped_crafting_inventory_cache cache( inv );
        for( int i = 0; i < 100; ++i ) {
            CHECK( inv.amount_of( itype_rock ) == 10000 );
            CHECK( inv.amount_of( itype_hammer ) == 0 );
            CHECK( inv.charges_of( itype_nail ) == 0 );
            CHECK( inv.count_item( itype_hammer ) == 0 );
            CHECK_FALSE( inv.must_use_hallu_poison( itype_hammer, 0 ) );
        }
        CHECK( inv.traversals == 2 );
        CHECK( inv.visits == 20000 );
    }
    // Outside the paused menu, borrowed items must be observed afresh.
    const int before = inv.traversals;
    CHECK( inv.amount_of( itype_hammer ) == 0 );
    CHECK( inv.amount_of( itype_hammer ) == 0 );
    CHECK( inv.traversals == before + 2 );
}

TEST_CASE( "crafting_index_matches_live_queries_for_containers_and_filters",
           "[crafting][inventory][cache]" )
{
    temp_crafting_inventory inv;
    item bag( itype_backpack );
    REQUIRE( bag.put_in( item( itype_rock ), pocket_type::CONTAINER ).success() );
    REQUIRE( bag.put_in( item( itype_nail, calendar::turn, 30 ),
                         pocket_type::CONTAINER ).success() );
    item bottle( itype_bottle_plastic );
    item poisoned( itype_water, calendar::turn, 2 );
    poisoned.set_flag( flag_HIDDEN_POISON );
    REQUIRE( bottle.put_in( poisoned, pocket_type::CONTAINER ).success() );
    REQUIRE( bag.put_in( bottle, pocket_type::CONTAINER ).success() );
    inv.add_item_ref( bag );
    inv.add_item_copy( item( itype_nail, calendar::turn, 7 ) );
    item &pseudo = inv.add_item_copy( item( itype_rock ) );
    pseudo.set_flag( json_flag_PSEUDO );
    item &broken = inv.add_item_copy( item( itype_hammer ) );
    broken.set_flag( json_flag_ITEM_BROKEN );
    const std::vector<int> baseline = query_inventory( inv );
    {
        scoped_crafting_inventory_cache cache( inv );
        for( int repeat = 0; repeat < 2; ++repeat ) {
            const std::vector<int> indexed = query_inventory( inv );
            REQUIRE( indexed.size() == baseline.size() );
            for( size_t i = 0; i < baseline.size(); ++i ) {
                CAPTURE( repeat, i );
                CHECK( indexed[i] == baseline[i] );
            }
        }
        CHECK( inv.count_item( itype_water ) == 2 );
        CHECK( inv.charges_of( itype_nail ) == 37 );
        CHECK( inv.amount_of( itype_rock, false ) == 1 );
        CHECK( inv.amount_of( itype_rock, true ) == 2 );
    }
    CHECK( query_inventory( inv ) == baseline );
}

TEST_CASE( "crafting_index_invalidates_owned_mutations_and_does_not_follow_copies",
           "[crafting][inventory][cache]" )
{
    clear_avatar();
    counting_crafting_inventory inv;
    item borrowed( itype_nail, calendar::turn, 10 );
    inv.add_item_ref( borrowed );
    {
        scoped_crafting_inventory_cache outer( inv );
        CHECK( inv.charges_of( itype_nail ) == 10 );
        {
            scoped_crafting_inventory_cache inner( inv );
            CHECK( inv.charges_of( itype_nail ) == 10 );
            inv.add_item_copy( item( itype_nail, calendar::turn, 5 ) );
            CHECK( inv.charges_of( itype_nail ) == 15 );
        }
        CHECK( inv.charges_of( itype_nail ) == 15 );
        counting_crafting_inventory copy( inv );
        copy.add_item_copy( item( itype_nail, calendar::turn, 3 ) );
        CHECK( copy.charges_of( itype_nail ) == 18 );
        CHECK( inv.charges_of( itype_nail ) == 15 );
        inv = counting_crafting_inventory();
        CHECK( inv.charges_of( itype_nail ) == 0 );
        const item_location stored = get_avatar().i_add( item( itype_nail, calendar::turn, 10 ) );
        inv.add_item_loc( stored );
        CHECK( inv.charges_of( itype_nail ) == 10 );
        CHECK( inv.remove_items_with( []( const item & ) {
            return true;
        } ).size() == 1 );
        CHECK( inv.charges_of( itype_nail ) == 0 );
        inv.add_pseudo_item( itype_hammer );
        CHECK( inv.amount_of( itype_hammer, false ) == 0 );
        CHECK( inv.amount_of( itype_hammer, true ) == 1 );
        inv.clear();
        CHECK( inv.amount_of( itype_hammer, true ) == 0 );
    }
    // External content changes are permitted between menu sessions.
    borrowed.charges = 25;
    inv.add_item_ref( borrowed );
    {
        scoped_crafting_inventory_cache reopened( inv );
        CHECK( inv.charges_of( itype_nail ) == 25 );
        const auto reject = []( const item & ) {
            return false;
        };
        CHECK( inv.charges_of( itype_nail, INT_MAX, reject ) == 0 );
    }
}

TEST_CASE( "crafting_index_preserves_shared_ups_and_charge_visitors",
           "[crafting][inventory][cache][ups]" )
{
    clear_avatar();
    temp_crafting_inventory inv;
    item ups( itype_UPS_ON );
    item magazine( ups.magazine_default() );
    magazine.ammo_set( magazine.ammo_default(), 259 );
    REQUIRE( ups.put_in( magazine, pocket_type::MAGAZINE_WELL ).success() );
    inv.add_item_ref( ups );
    for( int i = 0; i < 2; ++i ) {
        item tool( itype_soldering_iron );
        REQUIRE( tool.put_in( item( itype_battery_ups ), pocket_type::MOD ).success() );
        REQUIRE( tool.has_flag( json_flag_USE_UPS ) );
        inv.add_item_copy( tool );
    }
    int baseline_visited = 0;
    const int baseline = inv.charges_of( itype_soldering_iron, INT_MAX, return_true<item>,
    [&]( int charges ) {
        baseline_visited += charges;
    } );
    REQUIRE( baseline == 259 );
    {
        scoped_crafting_inventory_cache cache( inv );
        CHECK( inv.charges_of( itype_UPS ) == 259 );
        int visited = 0;
        CHECK( inv.charges_of( itype_soldering_iron, INT_MAX, return_true<item>,
        [&]( int charges ) {
            visited += charges;
        } ) == baseline );
        CHECK( visited == baseline_visited );
        CHECK( inv.charges_of( itype_soldering_iron, 20 ) == 20 );
        CHECK( inv.charges_of( itype_soldering_iron ) == 259 );
    }
}

TEST_CASE( "crafting_index_preserves_multimag_tools", "[crafting][inventory][cache][multimag]" )
{
    temp_crafting_inventory inv;
    item tool( itype_test_multimag_tool_consume );
    item first( itype_glockmag );
    item second( itype_stanag30 );
    REQUIRE( first.put_in( item( itype_9mm, calendar::turn, 12 ), pocket_type::MAGAZINE ).success() );
    REQUIRE( second.put_in( item( itype_556, calendar::turn, 30 ), pocket_type::MAGAZINE ).success() );
    REQUIRE( tool.put_in( first, pocket_type::MAGAZINE_WELL ).success() );
    REQUIRE( tool.put_in( second, pocket_type::MAGAZINE_WELL ).success() );
    inv.add_item_ref( tool );
    const int baseline = inv.charges_of( itype_test_multimag_tool_consume );
    REQUIRE( baseline == 6 );
    const int ammo_baseline = inv.charges_of( itype_9mm, INT_MAX, return_true<item>, nullptr, true );
    scoped_crafting_inventory_cache cache( inv );
    CHECK( inv.charges_of( itype_test_multimag_tool_consume ) == baseline );
    CHECK( inv.charges_of( itype_test_multimag_tool_consume, 2 ) == 2 );
    CHECK( inv.amount_of( itype_9mm ) == 0 );
    CHECK( inv.charges_of( itype_9mm ) == 0 );
    CHECK( inv.charges_of( itype_9mm, INT_MAX, return_true<item>, nullptr, true ) == ammo_baseline );
}
