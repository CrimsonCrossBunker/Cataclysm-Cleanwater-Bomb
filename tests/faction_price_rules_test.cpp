#include <optional>
#include <string>

#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "faction.h"
#include "game.h"
#include "item.h"
#include "item_location.h"
#include "itype.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "npc.h"
#include "npctrade.h"
#include "cata_scope_helpers.h"
#include "player_control.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "point.h"
#include "ret_val.h"
#include "trade_ui.h"
#include "type_id.h"
#include "units.h"

class Character;

static const itype_id itype_FMCNote( "FMCNote" );
static const itype_id itype_battery( "battery" );
static const itype_id itype_debug_backpack( "debug_backpack" );
static const itype_id itype_debug_modular_m4_carbine( "debug_modular_m4_carbine" );
static const itype_id itype_hammer( "hammer" );
static const itype_id itype_log( "log" );
static const itype_id itype_scrap( "scrap" );
static const itype_id itype_test_battery_disposable( "test_battery_disposable" );
static const itype_id itype_test_bomba( "test_bomba" );
static const itype_id itype_test_multitool( "test_multitool" );
static const itype_id itype_test_nuclear_carafe( "test_nuclear_carafe" );
static const itype_id itype_test_pants_fur( "test_pants_fur" );

static const skill_id skill_speech( "speech" );

TEST_CASE( "basic_price_check", "[npc][trade]" )
{
    using namespace npc_trading;
    clear_avatar();
    avatar &u = get_avatar();
    npc &guy = spawn_npc( { 50, 50 }, "test_npc_trader" );
    clear_character( guy );

    bool const u_buy = GENERATE( true, false );
    CAPTURE( u_buy );

    Character *seller = nullptr;
    Character *buyer = nullptr;
    if( u_buy ) {
        buyer = &u;
        seller = &guy;
    } else {
        buyer = &guy;
        seller = &u;
    }

    item m4( itype_debug_modular_m4_carbine );
    item mag( m4.magazine_default() );
    int const ammo_amount = mag.remaining_ammo_capacity();
    item ammo( mag.ammo_default(), calendar::turn, ammo_amount );
    item bomba( itype_test_bomba );
    REQUIRE( bomba.type->price_post != units::from_cent( 0 ) );
    item backpack( itype_debug_backpack );

    int const price_separate = adjusted_price( &m4, 1, *buyer, *seller ) +
                               adjusted_price( &mag, 1, *buyer, *seller ) +
                               adjusted_price( &ammo, ammo_amount, *buyer, *seller ) +
                               adjusted_price( &backpack, 1, *buyer, *seller );

    mag.put_in( ammo, pocket_type::MAGAZINE );
    m4.put_in( mag, pocket_type::MAGAZINE_WELL );
    backpack.put_in( m4, pocket_type::CONTAINER );
    if( !u_buy ) {
        REQUIRE( !guy.wants_to_buy( bomba ) );
        backpack.put_in( bomba, pocket_type::CONTAINER );
    }

    trade_selector::entry_t bck_entry{
        item_location{ map_cursor( tripoint_bub_ms::zero ), &backpack }, 1 };

    int const price_combined = trading_price( *buyer, *seller, bck_entry );

    CHECK( price_separate == Approx( price_combined ).margin( 1 ) );
}

TEST_CASE( "npc_trade_settles_the_player_and_exact_charge_stack",
           "[npc][trade][multiplayer]" )
{
    using namespace npc_trading;
    clear_avatar();
    clear_map();
    avatar &host = get_avatar();
    npc &trader = spawn_npc( { 50, 50 }, "test_npc_trader" );
    npc &remote = spawn_npc( { 51, 50 }, "test_talker" );
    const on_out_of_scope cleanup( []() {
        clear_npcs();
    } );
    const auto control = g->player_controls().claim(
                             player_id( std::string( 32, 'b' ) ), remote );
    REQUIRE( control.get() == &remote );
    REQUIRE( merchant( remote ) == nullptr );
    REQUIRE( merchant( trader ) == &trader );
    REQUIRE( trader.is_shopkeeper() );
    REQUIRE_FALSE( trader.will_exchange_items_freely() );

    clear_character( remote );
    const itype_id ammo( "9mm" );
    item pack( itype_debug_backpack );
    pack.force_insert_item( item( ammo, calendar::turn, 80 ), pocket_type::CONTAINER );
    const auto worn = remote.wear_item( pack, false );
    REQUIRE( worn );
    item *other_stack = ( *worn )->get_contents().all_items_top().front();
    remote.set_wielded_item( item( ammo, calendar::turn, 40 ) );
    item_location selected = remote.get_wielded_item();
    REQUIRE( selected );
    selected->set_owner( remote );

    map &here = get_map();
    const tripoint_bub_ms stock_tile = trader.pos_bub( here );
    item gated_stock( itype_hammer );
    const item_location gated( map_cursor( here.get_abs( stock_tile ) ), &gated_stock );
    remote.set_value( "bool_test_tools_access", "no" );
    CHECK_FALSE( trader.wants_to_sell( gated, 1, remote ).success() );
    remote.set_value( "bool_test_tools_access", "yes" );
    CHECK( trader.wants_to_sell( gated, 1, remote ).success() );

    item stock( itype_hammer );
    stock.set_owner( trader );
    item &listed = here.add_item_or_charges( stock_tile, stock );
    REQUIRE_FALSE( listed.is_null() );
    const trade_selector::select_t sales{ { selected, 13 } };
    const trade_selector::select_t purchases{
        { item_location( map_cursor( here.get_abs( stock_tile ) ), &listed ), 1 }
    };
    trader.op_of_u.owed = 80;
    trader.opinion_of( remote.getID() ).owed = 30000;
    trader.opinion_of( remote.getID() ).sold = 0;
    remote.cash = 56;
    host.cash = 11;

    const auto offer = quote_trade( remote, trader, sales, purchases, 0, false );
    REQUIRE( offer );
    REQUIRE( offer->sale_value > 0 );
    trader.opinion_of( remote.getID() ).owed += 1;
    CHECK_FALSE( commit_trade( remote, trader, sales, purchases, 0, false, *offer ) );
    CHECK( selected->charges == 40 );
    CHECK( other_stack->charges == 80 );
    REQUIRE( purchases.front().first );

    const auto current = quote_trade( remote, trader, sales, purchases, 0, false );
    REQUIRE( current );
    REQUIRE( commit_trade( remote, trader, sales, purchases, 0, false, *current ) );
    CHECK( selected->charges == 27 );
    CHECK( other_stack->charges == 80 );
    CHECK_FALSE( purchases.front().first );
    CHECK( remote.has_amount( itype_hammer, 1 ) );
    CHECK_FALSE( host.has_amount( itype_hammer, 1 ) );
    CHECK( trader.opinion_of( remote.getID() ).owed == current->owed_after );
    CHECK( trader.opinion_of( remote.getID() ).sold == current->sale_value );
    CHECK( trader.op_of_u.owed == 80 );
    CHECK( remote.cash == 56 );
    CHECK( host.cash == 11 );
    CHECK_FALSE( commit_trade( remote, trader, sales, purchases, 0, false, *current ) );
    CHECK( selected->charges == 27 );
}

TEST_CASE( "faction_price_rules", "[npc][factions][trade]" )
{
    clear_avatar();
    npc &guy = spawn_npc( { 50, 50 }, "test_npc_trader" );
    faction const &fac = *guy.my_fac;

    WHEN( "item has no rules (default adjustment)" ) {
        item const hammer( itype_hammer );
        clear_character( guy );
        REQUIRE( npc_trading::adjusted_price( &hammer, 1, get_avatar(), guy ) ==
                 Approx( units::to_cent( hammer.type->price_post ) * 1.25 ).margin( 1 ) );
        REQUIRE( npc_trading::adjusted_price( &hammer, 1, guy, get_avatar() ) ==
                 Approx( units::to_cent( hammer.type->price_post ) * 0.75 ).margin( 1 ) );
    }

    WHEN( "item is main currency (implicit price rule)" ) {
        guy.set_int_base( 1000 );
        guy.set_skill_level( skill_speech, 10 );
        item const fmcnote( itype_FMCNote );
        REQUIRE( npc_trading::adjusted_price( &fmcnote, 1, get_avatar(), guy ) ==
                 units::to_cent( fmcnote.type->price_post ) );
        REQUIRE( npc_trading::adjusted_price( &fmcnote, 1, guy, get_avatar() ) ==
                 units::to_cent( fmcnote.type->price_post ) );
    }

    item const pants_fur( itype_test_pants_fur );
    WHEN( "item is secondary currency (fixed_adj=0)" ) {
        get_avatar().set_int_base( 1000 );
        get_avatar().set_skill_level( skill_speech, 10 );
        REQUIRE( npc_trading::adjusted_price( &pants_fur, 1, get_avatar(), guy ) ==
                 units::to_cent( pants_fur.type->price_post ) );
        REQUIRE( npc_trading::adjusted_price( &pants_fur, 1, guy, get_avatar() ) ==
                 units::to_cent( pants_fur.type->price_post ) );
    }
    WHEN( "faction desperately needs this item (premium=25)" ) {
        item const multitool( itype_test_multitool );
        REQUIRE( fac.get_price_rules( multitool, guy )->premium == 25 );
        REQUIRE( fac.get_price_rules( multitool, guy )->markup == 1.1 );
        THEN( "NPC selling to avatar includes premium and markup" ) {
            REQUIRE( npc_trading::adjusted_price( &multitool, 1, get_avatar(), guy ) ==
                     Approx( units::to_cent( multitool.type->price_post ) * 25 * 1.1 ).margin( 1 ) );
        }
        THEN( "avatar selling to NPC includes only premium" ) {
            REQUIRE( npc_trading::adjusted_price( &multitool, 1, guy, get_avatar() ) ==
                     Approx( units::to_cent( multitool.type->price_post ) * 25 ).margin( 1 ) );
        }
    }
    WHEN( "faction has a custom price for this item (price=10000000)" ) {
        item const log = GENERATE( item( itype_log ), item( itype_scrap ) );
        clear_character( guy );
        double price = *fac.get_price_rules( log, guy )->price;
        REQUIRE( price == 10000000 );
        if( log.count_by_charges() ) {
            price /= log.type->stack_size;
        }
        REQUIRE( npc_trading::adjusted_price( &log, 1, get_avatar(), guy ) ==
                 Approx( price * 1.25 ).margin( 1 ) );
        REQUIRE( npc_trading::adjusted_price( &log, 1, guy, get_avatar() ) ==
                 Approx( price * 0.75 ).margin( 1 ) );
    }
    item const carafe( itype_test_nuclear_carafe );
    WHEN( "condition for price rules not satisfied" ) {
        clear_character( guy );
        REQUIRE( fac.get_price_rules( carafe, guy ) == nullptr );
        REQUIRE( npc_trading::adjusted_price( &carafe, 1, get_avatar(), guy ) ==
                 Approx( units::to_cent( carafe.type->price_post ) * 1.25 ).margin( 1 ) );
    }
    WHEN( "condition for price rules satisfied" ) {
        guy.set_value( "bool_allnighter_thirsty", "yes" );
        REQUIRE( fac.get_price_rules( carafe, guy )->markup == 2.0 );
        THEN( "NPC selling to avatar includes markup and positive fixed adjustment" ) {
            REQUIRE( npc_trading::adjusted_price( &carafe, 1, get_avatar(), guy ) ==
                     Approx( units::to_cent( carafe.type->price_post ) * 2.0 * 1.1 ).margin( 1 ) );
        }
        THEN( "avatar selling to NPC includes only negative fixed adjustment" ) {
            REQUIRE( npc_trading::adjusted_price( &carafe, 1, guy, get_avatar() ) ==
                     Approx( units::to_cent( carafe.type->price_post ) * 0.9 ).margin( 1 ) );
        }
    }
    WHEN( "personal price rule overrides faction rule" ) {
        double const fmarkup = fac.get_price_rules( pants_fur, guy )->markup;
        REQUIRE( guy.get_price_rules( pants_fur )->markup == fmarkup );
        REQUIRE( fmarkup != - 100 );
        guy.set_value( "bool_preference_vegan", "yes" );
        REQUIRE( guy.get_price_rules( pants_fur )->markup == -100 );
    }
    WHEN( "price rule affects magazine contents" ) {
        clear_character( guy );
        item const battery( itype_battery );
        item tbd( itype_test_battery_disposable );
        int const battery_price = *guy.get_price_rules( battery )->price;
        REQUIRE( battery.price( true ) != battery_price );
        trade_selector::entry_t tbd_entry{
            item_location{ map_cursor( tripoint_bub_ms::zero ), &tbd }, 1 };

        REQUIRE( npc_trading::trading_price( get_avatar(), guy, tbd_entry ) ==
                 Approx( units::to_cent( tbd.type->price_post ) * 1.25 +
                         battery_price * 1.25 * tbd.ammo_remaining( nullptr ) / battery.type->stack_size )
                 .margin( 1 ) );
    }
}
