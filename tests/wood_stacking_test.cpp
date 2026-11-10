#include <list>
#include <string>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_utility.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_stack.h"
#include "iuse.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "requirements.h"
#include "type_id.h"

static const faction_id faction_free_merchants( "free_merchants" );
static const faction_id faction_your_followers( "your_followers" );
static const itype_id itype_2x4( "2x4" );
static const itype_id itype_splinter( "splinter" );
static const itype_id itype_stick( "stick" );
static const itype_id itype_stick_long( "stick_long" );

TEST_CASE( "legacy_wood_pieces_stack_without_losing_material", "[item][save][wood_stacking]" )
{
    const itype_id type = GENERATE( itype_stick, itype_stick_long, itype_splinter, itype_2x4 );
    CAPTURE( type.str() );
    item legacy( type, calendar::turn_zero );
    legacy.charges = 0;
    legacy.set_owner( faction_your_followers );
    item unit;
    deserialize_from_string( unit, serialize( legacy ) );
    REQUIRE( unit.count_by_charges() );
    REQUIRE( unit.charges == 1 );
    const auto weight = unit.weight();
    const auto volume = unit.volume();
    item stack = unit;
    for( int i = 1; i < 1300; ++i ) {
        item next = unit;
        REQUIRE( stack.merge_charges( next ) );
    }
    CHECK( stack.charges == 1300 );
    CHECK( stack.weight() == weight * 1300 );
    CHECK( stack.volume() == volume * 1300 );
    item split = stack.split( 17 );
    CHECK( split.charges == 17 );
    CHECK( stack.charges == 1283 );
    CHECK( stack.weight() + split.weight() == weight * 1300 );
    CHECK( stack.volume() + split.volume() == volume * 1300 );
    CHECK( split.get_owner() == faction_your_followers );
    item loaded;
    deserialize_from_string( loaded, serialize( stack ) );
    CHECK( loaded.charges == 1283 );
    CHECK( loaded.weight() == stack.weight() );
    CHECK( loaded.volume() == stack.volume() );
}

TEST_CASE( "wood_stack_crafting_consumes_the_requested_number_of_pieces", "[item][wood_stacking]" )
{
    const itype_id type = GENERATE( itype_stick, itype_stick_long, itype_splinter, itype_2x4 );
    CAPTURE( type.str() );
    clear_avatar();
    clear_map_without_vision();
    item stack( type );
    REQUIRE( stack.count_by_charges() );
    stack.charges = 12;
    avatar &you = get_avatar();
    map &here = get_map();
    REQUIRE_FALSE( here.add_item_or_charges( you.pos_bub(), stack ).is_null() );
    const std::list<item> consumed = you.consume_items( { item_comp( type, 5 ) }, 1,
                                     is_crafting_component );
    int count = 0;
    for( const item &piece : consumed ) {
        REQUIRE( piece.typeId() == type );
        count += piece.charges;
    }
    CHECK( count == 5 );
    const map_stack remaining = here.i_at( you.pos_bub() );
    REQUIRE( remaining.size() == 1 );
    CHECK( remaining.begin()->charges == 7 );
    CHECK( remaining.begin()->weight() + stack.weight() * 5 / 12 == stack.weight() );
}

TEST_CASE( "wood_stacks_preserve_distinct_ownership", "[item][ownership][wood_stacking]" )
{
    const itype_id type = GENERATE( itype_stick, itype_stick_long, itype_splinter, itype_2x4 );
    item owned( type );
    item other( type );
    owned.set_owner( faction_your_followers );
    other.set_owner( faction_free_merchants );
    CHECK_FALSE( owned.merge_charges( other ) );
    CHECK( owned.charges == 1 );
    CHECK( other.charges == 1 );
}

TEST_CASE( "breaking_a_long_stick_consumes_only_one_piece_from_the_stack",
           "[item][iuse][wood_stacking]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    you.set_str_base( 100 );
    item stack( itype_stick_long );
    REQUIRE( stack.count_by_charges() );
    stack.charges = 12;
    map &here = get_map();
    item &long_sticks = here.add_item_or_charges( you.pos_bub(), stack );
    REQUIRE_FALSE( long_sticks.is_null() );
    REQUIRE( iuse::break_stick( &you, &long_sticks, you.pos_bub() ).has_value() );
    int remaining = 0;
    int produced = 0;
    for( const item &it : here.i_at( you.pos_bub() ) ) {
        if( it.typeId() == itype_stick_long ) {
            remaining += it.charges;
        } else if( it.typeId() == itype_stick || it.typeId() == itype_splinter ) {
            produced += it.charges;
        }
    }
    CHECK( remaining == 11 );
    CHECK( produced == 2 );
}
