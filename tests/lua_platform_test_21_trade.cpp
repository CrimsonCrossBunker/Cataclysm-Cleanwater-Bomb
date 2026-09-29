#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include "player_helpers.h"

TEST_CASE( "lua_platform_allowance_quote_rejects_nonactive_avatar",
           "[lua][platform][trade][semantic]" )
{
    platform_trade_quote_fixture fixture( 941, 942, 943001, 943002 );
    REQUIRE( fixture.ready() );
    sol::table options = fixture.options();
    sol::table settlement = options["settlement"];
    settlement["strategy"] = "npc_allowance";
    settlement["allowance"] = 100;
    sol::table lines = fixture.lua.create_table();
    lines[1] = fixture.line( "seller_to_buyer", 1, fixture.item_handle,
                             fixture.buyer_handle, fixture.seller_handle );
    const int owed = fixture.buyer->op_of_u.owed;
    const int charges = fixture.live_item->charges;
    const auto call = fixture.quote_participants(
                          fixture.buyer_handle, fixture.seller_handle, lines, options );
    REQUIRE( call.valid() );
    const sol::table result = call.get<sol::table>();
    REQUIRE_FALSE( result["ok"].get<bool>() );
    const sol::table error = result["error"];
    CHECK( error["code"].get<std::string>() == "unsupported_participants" );
    CHECK( fixture.buyer->op_of_u.owed == owed );
    CHECK( fixture.live_item->charges == charges );
}

TEST_CASE( "lua_platform_allowance_quote_rejects_malformed_settlement_without_mutation",
           "[lua][platform][trade][semantic]" )
{
    platform_trade_quote_fixture fixture( 961, 962, 963001, 963002 );
    REQUIRE( fixture.ready() );
    sol::table options = fixture.options();
    sol::table settlement = options["settlement"];
    settlement["strategy"] = "npc_allowance";
    SECTION( "missing allowance" ) {}
    SECTION( "string allowance" ) {
        settlement["allowance"] = "100";
    }
    SECTION( "fractional allowance" ) {
        settlement["allowance"] = 1.5;
    }
    SECTION( "allowance above native range" ) {
        settlement["allowance"] = static_cast<lua_Integer>( std::numeric_limits<int>::max() ) + 1;
    }
    SECTION( "allowance below native range" ) {
        settlement["allowance"] = static_cast<lua_Integer>( std::numeric_limits<int>::min() ) - 1;
    }
    SECTION( "allowance on ordinary debt settlement" ) {
        settlement["strategy"] = "npc_debt";
        settlement["allowance"] = 100;
    }
    SECTION( "caller supplied offer price" ) {
        settlement["allowance"] = 100;
        settlement["allowance_offer_price"] = 0;
    }
    const int owed = fixture.buyer->op_of_u.owed;
    const int charges = fixture.live_item->charges;
    const auto call = fixture.quote( fixture.lines( 1 ), options );
    REQUIRE_FALSE( call.valid() );
    CHECK( fixture.buyer->op_of_u.owed == owed );
    CHECK( fixture.live_item->charges == charges );
    CHECK( fixture.seller.has_item( *fixture.live_item ) );
}

TEST_CASE( "lua_platform_allowance_commit_transfers_whole_item_and_debits_even_allies",
           "[lua][platform][trade][semantic]" )
{
    const int allowance = GENERATE( -1, 0, 10 );
    const int rejection = GENERATE( 0, 1, 2 );
    const bool change_debt = rejection == 1;
    const bool change_strategy = rejection == 2;
    const bool exact_budget = GENERATE( false, true );
    clear_avatar();
    avatar &recipient = get_avatar();
    platform_trade_quote_fixture fixture( 951, 952, 953001, 953002 );
    REQUIRE( fixture.ready() );
    fixture.buyer->op_of_u.owed = 100000;
    item stock( itype_id( "2x4" ), calendar::turn );
    stock.set_owner( *fixture.buyer );
    item *offered = &fixture.buyer->inv->add_item( std::move( stock ), false, false, false );
    std::vector<item_pricing> native_offers = npc_trading::init_selling( *fixture.buyer );
    std::optional<double> native_price;
    for( item_pricing &offer : native_offers ) {
        if( offer.loc.get_item() == offered ) {
            native_price = offer.price;
        }
    }
    REQUIRE( native_price );
    REQUIRE( *native_price < fixture.buyer->op_of_u.owed + allowance );
    if( exact_budget ) {
        REQUIRE( *native_price == static_cast<int>( *native_price ) );
        fixture.buyer->op_of_u.owed = static_cast<int>( *native_price ) - allowance;
    }
    const int remainder = static_cast<int>( allowance - *native_price );
    const int expected_owed = 100000 + ( remainder < 0 ? remainder : 0 );
    const auto recipient_handle = cata::lua_platform::game_handle::from_creature(
                                      recipient, { "avatar", recipient.getID().get_value(), 0, 0, 0, {} },
                                      fixture.runtime, fixture.active_world_generation );
    const auto offered_handle = cata::lua_platform::game_handle::from_item(
                                    *offered, { "npc_inventory", offered->uid().get_value(), 0, 0, 0, {} },
                                    fixture.runtime, fixture.active_world_generation );
    sol::table lines = fixture.lua.create_table();
    lines[1] = fixture.line( "seller_to_buyer", 1, offered_handle, fixture.buyer_handle,
                             recipient_handle );
    sol::table options = fixture.options();
    sol::table requested = options["settlement"];
    requested["strategy"] = "npc_allowance";
    requested["allowance"] = allowance;
    const auto quoted = fixture.quote_participants( fixture.buyer_handle, recipient_handle,
                        lines, options );
    REQUIRE( quoted.valid() );
    const sol::table quote_result = quoted.get<sol::table>();
    if( exact_budget ) {
        REQUIRE_FALSE( quote_result["ok"].get<bool>() );
        CHECK( quote_result["error"].get<sol::table>()["code"].get<std::string>() == "allowance_exceeded" );
        CHECK( fixture.buyer->has_item( *offered ) );
        CHECK( fixture.buyer->op_of_u.owed == static_cast<int>( *native_price ) - allowance );
        clear_avatar();
        return;
    }
    REQUIRE( quote_result["ok"].get<bool>() );
    const sol::table value = quote_result["value"];
    CHECK( value["debt_after"].get<int>() == expected_owed );
    CHECK( value["allowance"].get<int>() == allowance );
    CHECK( value["allowance_offer_price"].get<double>() == *native_price );
    CHECK( value["net"].get<int>() == 0 );
    const sol::table quoted_lines = value["lines"];
    const sol::table quoted_line = quoted_lines[1];
    CHECK( quoted_line["unit_price"].get<int>() == 0 );
    CHECK( quoted_line["total"].get<int>() == 0 );
    const auto token = value["token"].get<cata::lua_platform::trade_quote_token>();
    sol::table settlement = fixture.lua.create_table();
    settlement["strategy"] = "npc_allowance";
    settlement["currency"] = "cash";
    const int cash_before = recipient.cash;
    const int npc_cash_before = fixture.buyer->cash;
    const int sold_before = fixture.buyer->op_of_u.sold;
    sol::protected_function commit = fixture.services["trade"]["commit"];
    if( change_debt ) {
        ++fixture.buyer->op_of_u.owed;
    }
    if( change_strategy ) {
        settlement["strategy"] = "npc_debt";
    }
    const auto committed = commit( token, settlement );
    REQUIRE( committed.valid() );
    const sol::table result = committed.get<sol::table>();
    if( change_debt || change_strategy ) {
        REQUIRE_FALSE( result["ok"].get<bool>() );
        CHECK( result["error"].get<sol::table>()["code"].get<std::string>() ==
               ( change_debt ? "pricing_changed" : "settlement_changed" ) );
        CHECK( fixture.buyer->op_of_u.owed == ( change_debt ? 100001 : 100000 ) );
        CHECK( fixture.buyer->has_item( *offered ) );
        CHECK( recipient.items_with( []( const item & entry ) {
            return entry.typeId() == itype_id( "2x4" );
        } ).empty() );
        CHECK( recipient.cash == cash_before );
        CHECK( fixture.buyer->cash == npc_cash_before );
        CHECK( fixture.buyer->op_of_u.sold == sold_before );
        clear_avatar();
        return;
    }
    REQUIRE( result["ok"].get<bool>() );
    CHECK( fixture.buyer->op_of_u.owed == expected_owed );
    CHECK( fixture.buyer->op_of_u.sold == sold_before );
    CHECK( recipient.cash == cash_before );
    CHECK( fixture.buyer->cash == npc_cash_before );
    const auto received = recipient.items_with( []( const item & entry ) {
        return entry.typeId() == itype_id( "2x4" );
    } );
    REQUIRE( received.size() == 1 );
    CHECK( received.front()->is_owned_by( recipient ) );
    const auto repeated = commit( token, settlement );
    REQUIRE( repeated.valid() );
    const sol::table repeat_result = repeated.get<sol::table>();
    REQUIRE_FALSE( repeat_result["ok"].get<bool>() );
    CHECK( repeat_result["error"].get<sol::table>()["code"].get<std::string>() == "consumed_quote" );
    CHECK( fixture.buyer->op_of_u.owed == expected_owed );
    clear_avatar();
}

TEST_CASE( "lua_platform_allowance_item_rollback_restores_mixed_content_owners",
           "[lua][platform][trade][semantic]" )
{
    platform_trade_quote_fixture fixture( 971, 972, 973001, 973002 );
    REQUIRE( fixture.ready() );
    item bag( itype_id( "backpack" ), calendar::turn );
    bag.force_insert_item( item( itype_id( "rock" ), calendar::turn ), pocket_type::CONTAINER );
    bag.set_owner( *fixture.buyer );
    const auto contents = bag.get_contents().all_items_top();
    REQUIRE( contents.size() == 1 );
    contents.front()->set_owner( faction_id::NULL_ID() );
    const faction_id original_owner = bag.get_owner();
    const std::int64_t bag_uid = bag.uid().get_value();
    const std::int64_t child_uid = contents.front()->uid().get_value();
    item &source = fixture.buyer->inv->add_item( std::move( bag ), false, false, false );
    cata::lua_platform::platform_trade_item_request request;
    request.item_handle = cata::lua_platform::game_handle::from_item(
                              source, { "npc_inventory", bag_uid, 0, 0, 0, {} }, fixture.runtime,
                              fixture.active_world_generation );
    request.source_holder = { fixture.buyer_handle, "inventory", {}, -1 };
    request.destination_holder = { fixture.seller_handle, "inventory", {}, -1 };
    request.quantity = 1;
    request.transfer_ownership = true;
    std::vector<cata::lua_platform::platform_trade_item_result> transferred;
    cata::lua_platform::platform_item_transaction transaction;
    const auto error = cata::lua_platform::stage_platform_trade_items(
    { request }, fixture.runtime, fixture.active_world_generation,
    cata::lua_platform::item_holder_mutation_generation(), transferred, transaction );
    REQUIRE_FALSE( error );
    const auto received = fixture.seller.items_with( [bag_uid]( const item & entry ) {
        return entry.uid().get_value() == bag_uid;
    } );
    REQUIRE( received.size() == 1 );
    CHECK( received.front()->is_owned_by( fixture.seller ) );
    const auto received_contents = received.front()->get_contents().all_items_top();
    REQUIRE( received_contents.size() == 1 );
    CHECK( received_contents.front()->is_owned_by( fixture.seller ) );
    REQUIRE( transaction.rollback_now() );
    const auto restored = fixture.buyer->items_with( [bag_uid]( const item & entry ) {
        return entry.uid().get_value() == bag_uid;
    } );
    REQUIRE( restored.size() == 1 );
    CHECK( restored.front()->get_owner() == original_owner );
    const auto restored_contents = restored.front()->get_contents().all_items_top();
    REQUIRE( restored_contents.size() == 1 );
    CHECK( restored_contents.front()->uid().get_value() == child_uid );
    CHECK( restored_contents.front()->get_owner().is_null() );
    CHECK( count_platform_trade_items( fixture.seller, bag_uid ) == 0 );
}

TEST_CASE( "lua_platform_contained_trade_preserves_exact_source_and_rollback_order",
           "[lua][platform][trade][semantic]" )
{
    // Native stage modes, followed by public commit and stale-container quote modes.
    const int mode = GENERATE( 0, 1, 2, 3, 4, 5 );
    platform_trade_quote_fixture fixture( 981, 982, 983001, 983002 );
    REQUIRE( fixture.ready() );
    item bag( itype_id( "backpack" ), calendar::turn );
    for( int i = 0; i < 3; ++i ) {
        bag.force_insert_item( item( itype_id( "rock" ), calendar::turn ), pocket_type::CONTAINER );
    }
    bag.set_owner( *fixture.buyer );
    item &container = fixture.buyer->inv->add_item( std::move( bag ), false, false, false );
    const auto children = container.get_contents().all_items_top();
    REQUIRE( children.size() == 3 );
    std::vector<std::int64_t> original_uids;
    for( const item *child : children ) {
        original_uids.push_back( child->uid().get_value() );
    }
    item *selected = *std::next( children.begin() );
    const std::int64_t selected_uid = selected->uid().get_value();
    selected->set_owner( faction_id::NULL_ID() );
    const auto pockets = container.get_contents().get_pockets( []( const item_pocket & ) {
        return true;
    } );
    int pocket_index = -1;
    for( std::size_t i = 0; i < pockets.size(); ++i ) {
        const auto direct = pockets[i]->all_items_top();
        if( std::find( direct.begin(), direct.end(), selected ) != direct.end() ) {
            pocket_index = static_cast<int>( i );
        }
    }
    REQUIRE( pocket_index >= 0 );
    const auto container_handle = cata::lua_platform::game_handle::from_item(
                                      container, { "npc_inventory", container.uid().get_value(), 0, 0, 0, {} },
                                      fixture.runtime, fixture.active_world_generation );
    cata::lua_platform::platform_trade_item_request request;
    request.item_handle = cata::lua_platform::game_handle::from_item(
                              *selected, { "container_pocket", selected_uid, 0, 0, 0, {} },
                              fixture.runtime, fixture.active_world_generation );
    request.source_holder = { fixture.buyer_handle, "contained", container_handle, pocket_index };
    request.destination_holder = { fixture.seller_handle, "inventory", {}, -1 };
    request.quantity = 1;
    request.transfer_ownership = true;
    std::vector<cata::lua_platform::platform_trade_item_request> requests = { request };
    if( mode == 2 ) {
        request.item_handle = container_handle;
        request.source_holder = { fixture.buyer_handle, "inventory", {}, -1 };
        requests.push_back( request );
    } else if( mode == 3 ) {
        requests.front().source_holder.pocket_index = static_cast<int>( pockets.size() );
    }
    if( mode >= 4 ) {
        sol::protected_function selling_offers = fixture.services["trade"]["selling_offers"];
        const auto listed = selling_offers( fixture.buyer_handle );
        REQUIRE( listed.valid() );
        const sol::table listed_result = listed.get<sol::table>();
        REQUIRE( listed_result["ok"].get<bool>() );
        const sol::table offers = listed_result["value"];
        sol::table source_holder;
        for( std::size_t i = 1; i <= offers.size(); ++i ) {
            const sol::table offer = offers[i];
            const auto handle = offer["item"].get<cata::lua_platform::game_handle>();
            if( handle.locator().stable_id == selected_uid ) {
                source_holder = offer["source_holder"].get<sol::table>();
            }
        }
        REQUIRE( source_holder.valid() );
        CHECK( source_holder["slot"].get<std::string>() == "contained" );
        CHECK( source_holder["pocket_index"].get<int>() == pocket_index );
        sol::table line = fixture.line( "seller_to_buyer", 1, request.item_handle,
                                        fixture.buyer_handle, fixture.seller_handle );
        line["source_holder"] = source_holder;
        sol::table lines = fixture.lua.create_table();
        lines[1] = line;
        sol::table options = fixture.options();
        options["settlement"].get<sol::table>()["strategy"] = "npc_debt";
        const auto quoted = fixture.quote_participants( fixture.buyer_handle, fixture.seller_handle,
                            lines, options );
        REQUIRE( quoted.valid() );
        const sol::table quote_result = quoted.get<sol::table>();
        REQUIRE( quote_result["ok"].get<bool>() );
        const sol::table value = quote_result["value"];
        const auto token = value["token"].get<cata::lua_platform::trade_quote_token>();
        const sol::table quoted_line = value["lines"].get<sol::table>()[1];
        const sol::table quoted_holder = quoted_line["source_holder"];
        CHECK( quoted_holder["pocket_index"].get<int>() == pocket_index );
        const auto quoted_container = quoted_holder["container"].get<cata::lua_platform::game_handle>();
        CHECK( quoted_container.locator().stable_id == container.uid().get_value() );
        if( mode == 5 ) {
            item other_bag( itype_id( "backpack" ), calendar::turn );
            item &other = fixture.buyer->inv->add_item( std::move( other_bag ), false, false, false );
            const auto other_pockets = other.get_container_pockets();
            REQUIRE_FALSE( other_pockets.empty() );
            // Preserve the Item UID/address and Character owner, changing only its container.
            pockets[pocket_index]->move_contents_to( *other_pockets.front() );
            const auto checked = fixture.get( token );
            REQUIRE( checked.valid() );
            const sol::table result = checked.get<sol::table>();
            REQUIRE_FALSE( result["ok"].get<bool>() );
            CHECK( result["error"].get<sol::table>()["code"].get<std::string>() == "wrong_holder" );
            CHECK( count_platform_trade_items( fixture.seller, selected_uid ) == 0 );
            CHECK( count_platform_trade_items( *fixture.buyer, selected_uid ) == 1 );
        } else {
            sol::table settlement = fixture.lua.create_table();
            settlement["strategy"] = "npc_debt";
            settlement["currency"] = "cash";
            sol::protected_function commit = fixture.services["trade"]["commit"];
            const auto committed = commit( token, settlement );
            REQUIRE( committed.valid() );
            REQUIRE( committed.get<sol::table>()["ok"].get<bool>() );
            CHECK( count_platform_trade_items( fixture.seller, selected_uid ) == 1 );
            CHECK( count_platform_trade_items( *fixture.buyer, selected_uid ) == 0 );
        }
        return;
    }
    std::vector<cata::lua_platform::platform_trade_item_result> transferred;
    cata::lua_platform::platform_item_transaction transaction;
    const auto error = cata::lua_platform::stage_platform_trade_items(
                           requests, fixture.runtime, fixture.active_world_generation,
                           cata::lua_platform::item_holder_mutation_generation(), transferred, transaction );
    if( mode >= 2 ) {
        REQUIRE( error );
        CHECK( error->code == ( mode == 2 ? "overlapping_holder" : "wrong_holder" ) );
        CHECK( transferred.empty() );
        CHECK( count_platform_trade_items( fixture.seller, selected_uid ) == 0 );
    } else {
        REQUIRE_FALSE( error );
        REQUIRE( transferred.size() == 1 );
        CHECK( transferred.front().source_uid == selected_uid );
        CHECK( transferred.front().destination_uid == selected_uid );
        CHECK( count_platform_trade_items( fixture.seller, selected_uid ) == 1 );
        CHECK( count_platform_trade_items( *fixture.buyer, selected_uid ) == 0 );
        const auto received = fixture.seller.items_with( [selected_uid]( const item & entry ) {
            return entry.uid().get_value() == selected_uid;
        } );
        REQUIRE( received.size() == 1 );
        CHECK( received.front()->is_owned_by( fixture.seller ) );
        if( mode == 0 ) {
            transaction.commit();
            original_uids.erase( original_uids.begin() + 1 );
        } else {
            REQUIRE( transaction.rollback_now() );
            CHECK( count_platform_trade_items( fixture.seller, selected_uid ) == 0 );
        }
    }
    std::vector<std::int64_t> remaining_uids;
    for( const item *child : container.get_contents().all_items_top() ) {
        remaining_uids.push_back( child->uid().get_value() );
        if( child->uid().get_value() == selected_uid ) {
            CHECK( child->get_owner().is_null() );
        }
    }
    CHECK( remaining_uids == original_uids );
}

TEST_CASE( "lua_platform_native_order_price_uses_explicit_parties_and_native_pricing",
           "[lua][platform][trade][order]" )
{
    platform_trade_quote_fixture fixture( 240, 501, 220001, 220002 );
    REQUIRE( fixture.ready() );
    sol::protected_function price = fixture.services["trade"]["order_price"];
    const cata::lua_platform::script_game_id ammo( "item", "9mm" );
    const int original_charges = fixture.live_item->charges;
    const int original_debt = fixture.buyer->op_of_u.owed;
    // This fixture names the avatar 'seller' and the NPC 'buyer'; reverse them
    // for a made-to-order NPC sale without introducing an implicit avatar.
    const sol::protected_function_result result = price(
                fixture.buyer_handle, fixture.seller_handle, ammo, 500 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table value = envelope["value"];
    const item prototype( itype_id( "9mm" ), calendar::turn );
    CHECK( value["cost_cents"].get<int>() == npc_trading::trading_price_for_order(
               fixture.seller, *fixture.buyer, prototype, 500 ) );
    CHECK( value["count"].get<int>() == 500 );
    CHECK( value["count_by_charges"].get<bool>() );
    CHECK( fixture.live_item->charges == original_charges );
    CHECK( fixture.buyer->op_of_u.owed == original_debt );
    CHECK_FALSE( price( fixture.buyer_handle, fixture.seller_handle, ammo, 0 ).valid() );
    CHECK_FALSE( price( fixture.buyer_handle, fixture.seller_handle, ammo, 1000001 ).valid() );
    const sol::protected_function_result same = price(
                fixture.buyer_handle, fixture.buyer_handle, ammo, 1 );
    REQUIRE( same.valid() );
    CHECK_FALSE( same.get<sol::table>()["ok"].get<bool>() );
}

TEST_CASE( "lua_platform_native_trade_does_not_substitute_the_active_avatar",
           "[lua][platform][trade][order]" )
{
    platform_trade_quote_fixture fixture( 241, 502, 220011, 220012 );
    REQUIRE( fixture.ready() );
    sol::protected_function pay = fixture.services["trade"]["pay"];
    sol::protected_function open = fixture.services["trade"]["open"];
    fixture.buyer->op_of_u.owed = 1000;
    const sol::protected_function_result result = pay(
                fixture.buyer_handle, fixture.seller_handle, 100 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE_FALSE( envelope["ok"].get<bool>() );
    CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "unsupported_participants" );
    CHECK( fixture.buyer->op_of_u.owed == 1000 );
    CHECK_FALSE( pay( fixture.buyer_handle, fixture.seller_handle, -1 ).valid() );
    CHECK_FALSE( open( fixture.buyer_handle, fixture.seller_handle, 0,
                       std::string( 4097, 'x' ) ).valid() );
    // No test opens an interactive window; the identity check rejects first.
    const sol::protected_function_result rejected = open(
                fixture.buyer_handle, fixture.seller_handle, 0, "Test trade" );
    REQUIRE( rejected.valid() );
    CHECK_FALSE( rejected.get<sol::table>()["ok"].get<bool>() );
}

TEST_CASE( "lua_platform_trade_quote_requires_exact_participants_and_holders",
           "[lua][platform][trade][quote]" )
{
    platform_trade_quote_fixture fixture( 140, 401, 120001, 120002 );
    REQUIRE( fixture.ready() );

    sol::table wrong_holders = fixture.lua.create_table();
    wrong_holders[1] = fixture.line(
                           "seller_to_buyer", 3, fixture.item_handle,
                           fixture.buyer_handle, fixture.seller_handle );
    const sol::protected_function_result wrong_holder_result =
        fixture.quote_participants( fixture.seller_handle, fixture.buyer_handle,
                                    wrong_holders, fixture.options() );
    REQUIRE( wrong_holder_result.valid() );
    const sol::table wrong_holder_envelope = wrong_holder_result.get<sol::table>();
    REQUIRE_FALSE( wrong_holder_envelope["ok"].get<bool>() );
    CHECK( wrong_holder_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "wrong_holder" );

    const sol::protected_function_result same_participant_result =
        fixture.quote_participants( fixture.seller_handle, fixture.seller_handle,
                                    fixture.lines( 3 ), fixture.options() );
    REQUIRE( same_participant_result.valid() );
    const sol::table same_participant_envelope =
        same_participant_result.get<sol::table>();
    REQUIRE_FALSE( same_participant_envelope["ok"].get<bool>() );
    CHECK( same_participant_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "same_participant" );

    const int charges_before = fixture.live_item->charges;
    const sol::protected_function_result result = fixture.quote( 3 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table snapshot = envelope["value"];
    CHECK( snapshot["seller"].get<cata::lua_platform::game_handle>()
           .locator().stable_id == fixture.seller_handle.locator().stable_id );
    CHECK( snapshot["buyer"].get<cata::lua_platform::game_handle>()
           .locator().stable_id == fixture.buyer_handle.locator().stable_id );

    sol::table quoted_lines = snapshot["lines"];
    const sol::table quoted_line = quoted_lines[1];
    CHECK( quoted_line["direction"].get<std::string>() == "seller_to_buyer" );
    CHECK( quoted_line["quantity"].get<lua_Integer>() == 3 );
    const sol::table source_holder = quoted_line["source_holder"];
    const sol::table destination_holder = quoted_line["destination_holder"];
    CHECK( source_holder["character"].get<cata::lua_platform::game_handle>()
           .locator().stable_id == fixture.seller_handle.locator().stable_id );
    CHECK( destination_holder["character"].get<cata::lua_platform::game_handle>()
           .locator().stable_id == fixture.buyer_handle.locator().stable_id );
    CHECK( source_holder["locator"].get<sol::table>()
           ["stable_id"].get<lua_Integer>() == fixture.seller_handle.locator().stable_id );
    CHECK( destination_holder["locator"].get<sol::table>()
           ["stable_id"].get<lua_Integer>() == fixture.buyer_handle.locator().stable_id );
    CHECK( fixture.live_item->charges == charges_before );
}

TEST_CASE( "lua_platform_trade_quote_uses_authoritative_price_and_settlement_rules",
           "[lua][platform][trade][quote]" )
{
    platform_trade_quote_fixture fixture( 141, 402, 120011, 120012 );
    REQUIRE( fixture.ready() );
    const int buyer_cash_before = fixture.buyer->cash;
    const int buyer_debt_before = fixture.buyer->op_of_u.owed;
    const int buyer_sold_before = fixture.buyer->op_of_u.sold;
    const int seller_cash_before = fixture.seller.cash;

    const sol::protected_function_result result = fixture.quote( 3 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    const sol::table snapshot = envelope["value"];
    const sol::table quoted_line = snapshot["lines"].get<sol::table>()[1];
    const int expected_total = npc_trading::trading_price_for_order(
                                   *fixture.buyer, fixture.seller, *fixture.live_item, 3 );

    CHECK( quoted_line["unit_price"].is<lua_Integer>() );
    CHECK( quoted_line["total"].is<lua_Integer>() );
    CHECK( quoted_line["total"].get<lua_Integer>() == expected_total );
    CHECK( snapshot["seller_to_buyer_total"].get<lua_Integer>() == expected_total );
    CHECK( snapshot["buyer_to_seller_total"].get<lua_Integer>() == 0 );
    CHECK( snapshot["net"].get<lua_Integer>() == expected_total );
    CHECK( snapshot["settlement_strategy"].get<std::string>() == "cash" );
    CHECK( snapshot["currency"].get<std::string>() == "cash" );
    CHECK( snapshot["available_settlement_modes"].get<sol::table>()[1]
           .get<std::string>() == "cash" );
    const std::int64_t expected_settlement =
        fixture.buyer->will_exchange_items_freely() ? 0 : expected_total;
    CHECK( snapshot["settlement_amount"].get<lua_Integer>() == expected_settlement );
    CHECK( snapshot["buyer_cash_before"].get<lua_Integer>() == buyer_cash_before );
    CHECK( snapshot["seller_cash_before"].get<lua_Integer>() == seller_cash_before );
    CHECK( snapshot["debt_before"].get<lua_Integer>() == buyer_debt_before );
    CHECK( snapshot["sold_before"].get<lua_Integer>() == buyer_sold_before );
    CHECK( fixture.buyer->cash == buyer_cash_before );
    CHECK( fixture.buyer->op_of_u.owed == buyer_debt_before );
    CHECK( fixture.buyer->op_of_u.sold == buyer_sold_before );
    CHECK( fixture.seller.cash == seller_cash_before );
}

TEST_CASE( "lua_platform_trade_quote_rejects_duplicate_uid_and_partial_charge_mismatch",
           "[lua][platform][trade][quote]" )
{
    platform_trade_quote_fixture fixture( 142, 403, 120021, 120022 );
    REQUIRE( fixture.ready() );
    REQUIRE( fixture.live_item->count_by_charges() );

    sol::table duplicate_lines = fixture.lua.create_table();
    duplicate_lines[1] = fixture.line(
                             "seller_to_buyer", 3, fixture.item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    duplicate_lines[2] = fixture.line(
                             "seller_to_buyer", 2, fixture.item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    const sol::protected_function_result duplicate_result =
        fixture.quote( duplicate_lines, fixture.options() );
    REQUIRE( duplicate_result.valid() );
    const sol::table duplicate_envelope = duplicate_result.get<sol::table>();
    REQUIRE_FALSE( duplicate_envelope["ok"].get<bool>() );
    CHECK( duplicate_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "duplicate_item" );

    const sol::protected_function_result partial_mismatch_result = fixture.quote(
                fixture.live_item->charges + 1 );
    REQUIRE( partial_mismatch_result.valid() );
    const sol::table partial_mismatch_envelope =
        partial_mismatch_result.get<sol::table>();
    REQUIRE_FALSE( partial_mismatch_envelope["ok"].get<bool>() );
    CHECK( partial_mismatch_envelope["error"].get<sol::table>()
           ["code"].get<std::string>() == "invalid_quantity" );
}

TEST_CASE( "lua_platform_trade_quote_rejects_stale_participant_item_and_holder",
           "[lua][platform][trade][quote][stale]" )
{
    {
        platform_trade_quote_fixture fixture( 143, 404, 120031, 120032 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3 );
        REQUIRE( quote_result.valid() );
        const sol::table quote_envelope = quote_result.get<sol::table>();
        REQUIRE( quote_envelope["ok"].get<bool>() );
        const cata::lua_platform::trade_quote_token token =
            quote_envelope["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();

        cata::lua_platform::retire_npc_handle_identity( *fixture.buyer );
        const sol::protected_function_result stale_actor_result = fixture.get( token );
        REQUIRE( stale_actor_result.valid() );
        const sol::table stale_actor_envelope = stale_actor_result.get<sol::table>();
        REQUIRE_FALSE( stale_actor_envelope["ok"].get<bool>() );
        CHECK( stale_actor_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_identity" );
    }

    {
        platform_trade_quote_fixture fixture( 144, 405, 120041, 120042 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3 );
        REQUIRE( quote_result.valid() );
        const cata::lua_platform::trade_quote_token token =
            quote_result.get<sol::table>()["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        fixture.live_item->charges += 1;
        const sol::protected_function_result stale_item_result = fixture.get( token );
        REQUIRE( stale_item_result.valid() );
        const sol::table stale_item_envelope = stale_item_result.get<sol::table>();
        REQUIRE_FALSE( stale_item_envelope["ok"].get<bool>() );
        CHECK( stale_item_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_item" );
    }

    {
        platform_trade_quote_fixture fixture( 145, 406, 120051, 120052 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3 );
        REQUIRE( quote_result.valid() );
        const cata::lua_platform::trade_quote_token token =
            quote_result.get<sol::table>()["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        cata::lua_platform::bump_item_query_mutation_epoch();
        const sol::protected_function_result stale_epoch_result = fixture.get( token );
        REQUIRE( stale_epoch_result.valid() );
        const sol::table stale_epoch_envelope = stale_epoch_result.get<sol::table>();
        REQUIRE_FALSE( stale_epoch_envelope["ok"].get<bool>() );
        CHECK( stale_epoch_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_holder" );
    }
}

TEST_CASE( "lua_platform_trade_quote_expires_and_retires_on_runtime_world_or_save_change",
           "[lua][platform][trade][quote][lifecycle]" )
{
    platform_calendar_turn_scope turn_scope;
    {
        platform_trade_quote_fixture fixture( 146, 407, 120061, 120062 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3, 1 );
        REQUIRE( quote_result.valid() );
        const cata::lua_platform::trade_quote_token token =
            quote_result.get<sol::table>()["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        const std::int64_t issued = to_turn<std::int64_t>( calendar::turn );
        calendar::turn = calendar::turn + time_duration::from_turns(
                             token.expires_turn() - issued );
        const sol::protected_function_result expired_result = fixture.get( token );
        REQUIRE( expired_result.valid() );
        const sol::table expired_envelope = expired_result.get<sol::table>();
        REQUIRE_FALSE( expired_envelope["ok"].get<bool>() );
        CHECK( expired_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "expired_quote" );
    }

    {
        platform_trade_quote_fixture fixture( 147, 408, 120071, 120072 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3 );
        REQUIRE( quote_result.valid() );
        const cata::lua_platform::trade_quote_token token =
            quote_result.get<sol::table>()["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        const auto other_owner = cata::lua_platform::make_game_handle_runtime_owner();
        fixture.active_runtime = cata::lua_platform::game_handle_runtime(
                                     other_owner, fixture.runtime.generation() );
        const sol::protected_function_result runtime_result = fixture.get( token );
        REQUIRE( runtime_result.valid() );
        const sol::table runtime_envelope = runtime_result.get<sol::table>();
        REQUIRE_FALSE( runtime_envelope["ok"].get<bool>() );
        CHECK( runtime_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_runtime" );
    }

    {
        platform_trade_quote_fixture fixture( 148, 409, 120081, 120082 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3 );
        REQUIRE( quote_result.valid() );
        const cata::lua_platform::trade_quote_token token =
            quote_result.get<sol::table>()["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        fixture.active_world_generation += 1;
        const sol::protected_function_result world_result = fixture.get( token );
        REQUIRE( world_result.valid() );
        const sol::table world_envelope = world_result.get<sol::table>();
        REQUIRE_FALSE( world_envelope["ok"].get<bool>() );
        CHECK( world_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_world" );
    }

    {
        platform_trade_quote_fixture fixture( 149, 410, 120091, 120092 );
        REQUIRE( fixture.ready() );
        const sol::protected_function_result quote_result = fixture.quote( 3 );
        REQUIRE( quote_result.valid() );
        const cata::lua_platform::trade_quote_token token =
            quote_result.get<sol::table>()["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        cata::lua_platform::runtime_before_save();
        const sol::protected_function_result save_result = fixture.get( token );
        REQUIRE( save_result.valid() );
        const sol::table save_envelope = save_result.get<sol::table>();
        REQUIRE_FALSE( save_envelope["ok"].get<bool>() );
        CHECK( save_envelope["error"].get<sol::table>()
               ["code"].get<std::string>() == "stale_quote" );
    }
}

TEST_CASE( "lua_platform_trade_quote_returns_a_detached_snapshot_without_mutation",
           "[lua][platform][trade][quote][snapshot]" )
{
    platform_trade_quote_fixture fixture( 150, 411, 120101, 120102 );
    REQUIRE( fixture.ready() );
    const int item_charges_before = fixture.live_item->charges;
    const int buyer_cash_before = fixture.buyer->cash;
    const sol::protected_function_result result = fixture.quote( 3 );
    REQUIRE( result.valid() );
    const sol::table envelope = result.get<sol::table>();
    REQUIRE( envelope["ok"].get<bool>() );
    sol::table snapshot = envelope["value"];
    const cata::lua_platform::trade_quote_token token =
        snapshot["token"].get<cata::lua_platform::trade_quote_token>();
    sol::table quoted_lines = snapshot["lines"];
    const sol::table quoted_line = quoted_lines[1];
    const lua_Integer original_net = snapshot["net"].get<lua_Integer>();
    const lua_Integer original_total = quoted_line["total"].get<lua_Integer>();

    CHECK( token.registered() );
    CHECK( token.quote_id() > 0 );
    CHECK( token.runtime_generation() == fixture.runtime.generation() );
    CHECK( token.world_generation() == fixture.active_world_generation );
    CHECK( token.seller_stable_id() == fixture.seller_handle.locator().stable_id );
    CHECK( token.buyer_stable_id() == fixture.buyer_handle.locator().stable_id );
    CHECK( token.seller_identity_generation() == fixture.seller_handle.identity_generation() );
    CHECK( token.buyer_identity_generation() == fixture.buyer_handle.identity_generation() );
    CHECK( token.holder_mutation_generation() ==
           cata::lua_platform::item_holder_mutation_generation() );
    CHECK( token.pricing_generation() == snapshot["pricing_generation"].get<std::uint64_t>() );
    CHECK( token.faction_generation() == snapshot["faction_generation"].get<std::uint64_t>() );
    CHECK( token.debt_generation() == snapshot["debt_generation"].get<std::uint64_t>() );
    CHECK( token.opinion_generation() == snapshot["opinion_generation"].get<std::uint64_t>() );
    CHECK( token.issued_turn() == snapshot["issued_turn"].get<lua_Integer>() );
    CHECK( token.expires_turn() == snapshot["expires_turn"].get<lua_Integer>() );
    CHECK( token.expires_turn() > token.issued_turn() );

    CHECK( quoted_line["item_uid"].get<lua_Integer>() == fixture.live_item->uid().get_value() );
    CHECK( quoted_line["item_identity_generation"].get<std::size_t>() ==
           fixture.item_handle.identity_generation() );
    CHECK( quoted_line["quantity"].get<lua_Integer>() == 3 );
    CHECK( quoted_line["charges_at_quote"].get<lua_Integer>() == item_charges_before );
    CHECK( quoted_line["unit_price"].is<lua_Integer>() );
    CHECK( quoted_line["total"].is<lua_Integer>() );
    CHECK( quoted_line["source_holder_mutation_generation"].get<std::uint64_t>() ==
           token.holder_mutation_generation() );
    CHECK( quoted_line["destination_holder_mutation_generation"].get<std::uint64_t>() ==
           token.holder_mutation_generation() );
    CHECK( quoted_line["source_holder"].get<sol::table>()["locator"]
           .get<sol::table>()["scope"].get<std::string>() == "avatar" );
    CHECK( quoted_line["destination_holder"].get<sol::table>()["locator"]
           .get<sol::table>()["scope"].get<std::string>() == "npc" );

    snapshot["net"] = -999999;
    quoted_lines[1]["quantity"] = 999999;
    quoted_lines[1]["total"] = -999999;
    snapshot["lines"] = fixture.lua.create_table();

    const sol::protected_function_result reread_result = fixture.get( token );
    REQUIRE( reread_result.valid() );
    const sol::table reread_envelope = reread_result.get<sol::table>();
    REQUIRE( reread_envelope["ok"].get<bool>() );
    const sol::table reread_snapshot = reread_envelope["value"];
    const sol::table reread_line = reread_snapshot["lines"].get<sol::table>()[1];
    CHECK( reread_snapshot["net"].get<lua_Integer>() == original_net );
    CHECK( reread_line["quantity"].get<lua_Integer>() == 3 );
    CHECK( reread_line["total"].get<lua_Integer>() == original_total );
    CHECK( fixture.live_item->charges == item_charges_before );
    CHECK( fixture.buyer->cash == buyer_cash_before );
}

TEST_CASE( "lua_platform_trade_commit_two_way_multi_line",
           "[lua][platform][trade][commit]" )
{
    platform_trade_commit_fixture fixture( 151, 501, 121001, 121002 );
    REQUIRE( fixture.ready() );
    const std::int64_t seller_uid = fixture.live_item->uid().get_value();
    const std::int64_t buyer_uid = fixture.buyer_item->uid().get_value();

    sol::table requested_lines = fixture.lua.create_table();
    requested_lines[1] = fixture.line(
                             "seller_to_buyer", 8, fixture.seller_item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    requested_lines[2] = fixture.line(
                             "buyer_to_seller", 1, fixture.buyer_item_handle,
                             fixture.buyer_handle, fixture.seller_handle );
    const sol::protected_function_result quote_result = fixture.quote( requested_lines );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    std::string quote_error_code;
    std::string quote_error_message;
    if( !quote_envelope["ok"].get<bool>() ) {
        const sol::table quote_error = quote_envelope["error"];
        quote_error_code = quote_error["code"].get<std::string>();
        quote_error_message = quote_error["message"].get<std::string>();
    }
    CAPTURE( quote_error_code, quote_error_message );
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();

    const sol::protected_function_result get_result = fixture.get( token );
    REQUIRE( get_result.valid() );
    REQUIRE( get_result.get<sol::table>()["ok"].get<bool>() );

    const sol::protected_function_result commit_result = fixture.commit( token );
    REQUIRE( commit_result.valid() );
    const sol::table commit_envelope = commit_result.get<sol::table>();
    REQUIRE( commit_envelope["ok"].get<bool>() );
    const sol::table committed = commit_envelope["value"];
    CHECK( committed["committed"].get<bool>() );
    CHECK( committed["consumed"].get<bool>() );
    CHECK( committed["commit_generation"].get<lua_Integer>() == 1 );
    CHECK( committed["settlement_strategy"].get<std::string>() == "npc_debt" );
    REQUIRE( committed["lines"].get<sol::table>().size() == 2 );
    CHECK( committed["lines"].get<sol::table>()[1]["item_uid"].get<lua_Integer>() ==
           seller_uid );
    CHECK( committed["lines"].get<sol::table>()[2]["item_uid"].get<lua_Integer>() ==
           buyer_uid );
    CHECK( count_platform_trade_items( fixture.seller, seller_uid ) == 0 );
    CHECK( count_platform_trade_items( *fixture.buyer, seller_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, buyer_uid ) == 0 );
    CHECK( count_platform_trade_items( fixture.seller, buyer_uid ) == 1 );
    CHECK( fixture.buyer->op_of_u.owed == committed["debt_after"].get<lua_Integer>() );
    CHECK_FALSE( token.registered() );
}

TEST_CASE( "lua_platform_trade_commit_partial_charges",
           "[lua][platform][trade][commit]" )
{
    platform_trade_commit_fixture fixture( 152, 502, 121011, 121012 );
    REQUIRE( fixture.ready() );
    const std::int64_t seller_uid = fixture.live_item->uid().get_value();
    const int source_charges = fixture.live_item->charges;

    sol::table requested_lines = fixture.lua.create_table();
    requested_lines[1] = fixture.line(
                             "seller_to_buyer", 3, fixture.seller_item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    const sol::protected_function_result quote_result = fixture.quote( requested_lines );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();
    REQUIRE( fixture.get( token ).get<sol::table>()["ok"].get<bool>() );

    const sol::protected_function_result commit_result = fixture.commit( token );
    REQUIRE( commit_result.valid() );
    const sol::table commit_envelope = commit_result.get<sol::table>();
    REQUIRE( commit_envelope["ok"].get<bool>() );
    const sol::table committed_line =
        commit_envelope["value"].get<sol::table>()["lines"].get<sol::table>()[1];
    const std::int64_t transferred_uid =
        committed_line["transferred_item_uid"].get<lua_Integer>();

    CHECK( fixture.live_item->charges == source_charges - 3 );
    CHECK( transferred_uid != seller_uid );
    item *received = find_platform_trade_item( *fixture.buyer, transferred_uid );
    REQUIRE( received != nullptr );
    CHECK( received->charges == 3 );
    CHECK( count_platform_trade_items( fixture.seller, seller_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, transferred_uid ) == 1 );
}

TEST_CASE( "lua_platform_trade_commit_preserves_compatible_destination_stacks",
           "[lua][platform][trade][commit][semantic]" )
{
    const int quantity = GENERATE( 3, 8 );
    platform_trade_commit_fixture fixture( 153, 503, 121021, 121022 );
    REQUIRE( fixture.ready() );
    item *blocker = fixture.add_buyer_item( itype_id( "9mm" ), 2 );
    REQUIRE( blocker != nullptr );
    const std::int64_t source_uid = fixture.live_item->uid().get_value();
    const std::int64_t blocker_uid = blocker->uid().get_value();
    const int source_charges = fixture.live_item->charges;
    const int blocker_charges = blocker->charges;

    sol::table requested_lines = fixture.lua.create_table();
    requested_lines[1] = fixture.line(
                             "seller_to_buyer", quantity, fixture.seller_item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    const sol::protected_function_result quote_result = fixture.quote( requested_lines );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();

    const sol::protected_function_result commit_result = fixture.commit( token );
    REQUIRE( commit_result.valid() );
    const sol::table commit_envelope = commit_result.get<sol::table>();
    REQUIRE( commit_envelope["ok"].get<bool>() );
    const sol::table transferred_line =
        commit_envelope["value"].get<sol::table>()["lines"].get<sol::table>()[1];
    const auto transferred_uid = transferred_line["transferred_item_uid"].get<lua_Integer>();
    CHECK( transferred_uid != blocker_uid );
    item *received = find_platform_trade_item( *fixture.buyer, transferred_uid );
    REQUIRE( received != nullptr );
    CHECK( received->charges == quantity );
    item *remaining = find_platform_trade_item( fixture.seller, source_uid );
    if( quantity == source_charges ) {
        CHECK( remaining == nullptr );
        CHECK( transferred_uid == source_uid );
    } else {
        REQUIRE( remaining != nullptr );
        CHECK( remaining->charges == source_charges - quantity );
        CHECK( transferred_uid != source_uid );
    }
    item *unchanged_blocker = find_platform_trade_item( *fixture.buyer, blocker_uid );
    REQUIRE( unchanged_blocker != nullptr );
    CHECK( unchanged_blocker->charges == blocker_charges );
    CHECK( count_platform_trade_items( *fixture.buyer, blocker_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, transferred_uid ) == 1 );
    CHECK_FALSE( token.registered() );

}

TEST_CASE( "lua_platform_trade_commit_mid_extract_rollback",
           "[lua][platform][trade][commit][rollback]" )
{
    platform_trade_commit_fixture fixture( 154, 504, 121031, 121032 );
    REQUIRE( fixture.ready() );
    const std::int64_t seller_uid = fixture.live_item->uid().get_value();
    const std::int64_t buyer_uid = fixture.buyer_item->uid().get_value();

    sol::table requested_lines = fixture.lua.create_table();
    requested_lines[1] = fixture.line(
                             "seller_to_buyer", 8, fixture.seller_item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    requested_lines[2] = fixture.line(
                             "buyer_to_seller", 1, fixture.buyer_item_handle,
                             fixture.buyer_handle, fixture.seller_handle );
    const sol::protected_function_result quote_result = fixture.quote( requested_lines );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();
    const sol::protected_function_result get_result = fixture.get( token );
    REQUIRE( get_result.valid() );
    REQUIRE( get_result.get<sol::table>()["ok"].get<bool>() );

    cata::lua_platform::platform_trade_item_request first;
    first.item_handle = fixture.seller_item_handle;
    first.source_holder.character = fixture.seller_handle;
    first.source_holder.slot = "inventory";
    first.destination_holder.character = fixture.buyer_handle;
    first.destination_holder.slot = "inventory";
    first.quantity = 8;
    cata::lua_platform::platform_trade_item_request second;
    second.item_handle = fixture.buyer_item_handle;
    second.source_holder.character = fixture.buyer_handle;
    second.source_holder.slot = "inventory";
    second.destination_holder.character = fixture.seller_handle;
    second.destination_holder.slot = "inventory";
    second.quantity = 1;
    const std::vector<cata::lua_platform::platform_trade_item_request> requests = {
        first, second
    };
    std::vector<cata::lua_platform::platform_trade_item_result> staged;
    cata::lua_platform::platform_item_transaction transaction;
    const std::optional<cata::lua_platform::game_handle_error> stage_error =
        cata::lua_platform::stage_platform_trade_items(
            requests, fixture.runtime,
            fixture.active_world_generation,
            cata::lua_platform::item_holder_mutation_generation(), staged,
            transaction );
    REQUIRE_FALSE( stage_error.has_value() );
    REQUIRE( staged.size() == 2 );
    CHECK( count_platform_trade_items( fixture.seller, seller_uid ) == 0 );
    CHECK( count_platform_trade_items( *fixture.buyer, seller_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, buyer_uid ) == 0 );
    CHECK( count_platform_trade_items( fixture.seller, buyer_uid ) == 1 );

    // No native extraction-failure injector exists; use the existing staged
    // transaction rollback hook that the commit path owns on mid-operation failure.
    REQUIRE( transaction.rollback_now() );
    CHECK( count_platform_trade_items( fixture.seller, seller_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, seller_uid ) == 0 );
    CHECK( count_platform_trade_items( *fixture.buyer, buyer_uid ) == 1 );
    CHECK( count_platform_trade_items( fixture.seller, buyer_uid ) == 0 );

    const sol::protected_function_result stale_commit = fixture.commit( token );
    REQUIRE( stale_commit.valid() );
    const sol::table stale_envelope = stale_commit.get<sol::table>();
    REQUIRE_FALSE( stale_envelope["ok"].get<bool>() );
    CHECK( stale_envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "stale_holder" );
}

TEST_CASE( "lua_platform_trade_commit_debt_publish_rollback",
           "[lua][platform][trade][commit][rollback]" )
{
    platform_trade_commit_fixture fixture( 155, 505, 121041, 121042 );
    REQUIRE( fixture.ready() );
    const std::int64_t source_uid = fixture.live_item->uid().get_value();
    const int source_charges = fixture.live_item->charges;
    const int original_owed = fixture.buyer->op_of_u.owed;

    sol::table requested_lines = fixture.lua.create_table();
    requested_lines[1] = fixture.line(
                             "seller_to_buyer", 3, fixture.seller_item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    const sol::protected_function_result quote_result = fixture.quote( requested_lines );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();
    REQUIRE( fixture.get( token ).get<sol::table>()["ok"].get<bool>() );

    fixture.buyer->op_of_u.owed = original_owed + 1;
    const sol::protected_function_result commit_result = fixture.commit( token );
    REQUIRE( commit_result.valid() );
    const sol::table commit_envelope = commit_result.get<sol::table>();
    REQUIRE_FALSE( commit_envelope["ok"].get<bool>() );
    const std::string code =
        commit_envelope["error"].get<sol::table>()["code"].get<std::string>();
    CHECK( ( code == "pricing_changed" || code == "debt_changed" ) );
    CHECK( fixture.buyer->op_of_u.owed == original_owed + 1 );
    CHECK( fixture.live_item->charges == source_charges );
    CHECK( count_platform_trade_items( fixture.seller, source_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, source_uid ) == 0 );
    CHECK_FALSE( token.registered() );
}

TEST_CASE( "lua_platform_trade_commit_double_commit",
           "[lua][platform][trade][commit]" )
{
    platform_trade_commit_fixture fixture( 156, 506, 121051, 121052 );
    REQUIRE( fixture.ready() );
    const std::int64_t source_uid = fixture.live_item->uid().get_value();

    sol::table requested_lines = fixture.lua.create_table();
    requested_lines[1] = fixture.line(
                             "seller_to_buyer", 3, fixture.seller_item_handle,
                             fixture.seller_handle, fixture.buyer_handle );
    const sol::protected_function_result quote_result = fixture.quote( requested_lines );
    REQUIRE( quote_result.valid() );
    const sol::table quote_envelope = quote_result.get<sol::table>();
    REQUIRE( quote_envelope["ok"].get<bool>() );
    const cata::lua_platform::trade_quote_token token =
        quote_envelope["value"].get<sol::table>()["token"]
        .get<cata::lua_platform::trade_quote_token>();

    const sol::protected_function_result first_commit = fixture.commit( token );
    REQUIRE( first_commit.valid() );
    const sol::table first_envelope = first_commit.get<sol::table>();
    REQUIRE( first_envelope["ok"].get<bool>() );
    const sol::table first_value = first_envelope["value"];
    const std::int64_t transferred_uid =
        first_value["lines"].get<sol::table>()[1]["transferred_item_uid"]
        .get<lua_Integer>();
    const int owed_after_first = fixture.buyer->op_of_u.owed;
    CHECK( first_value["commit_generation"].get<lua_Integer>() == 1 );
    CHECK_FALSE( token.registered() );

    const sol::protected_function_result second_commit = fixture.commit( token );
    REQUIRE( second_commit.valid() );
    const sol::table second_envelope = second_commit.get<sol::table>();
    REQUIRE_FALSE( second_envelope["ok"].get<bool>() );
    CHECK( second_envelope["error"].get<sol::table>()["code"].get<std::string>() ==
           "consumed_quote" );
    CHECK( fixture.live_item->charges == 5 );
    CHECK( count_platform_trade_items( fixture.seller, source_uid ) == 1 );
    CHECK( count_platform_trade_items( *fixture.buyer, transferred_uid ) == 1 );
    CHECK( fixture.buyer->op_of_u.owed == owed_after_first );
}

TEST_CASE( "lua_platform_trade_commit_stale_actor_item_epoch",
           "[lua][platform][trade][commit][stale]" )
{
    {
        platform_trade_commit_fixture fixture( 157, 507, 121061, 121062 );
        REQUIRE( fixture.ready() );
        const int source_charges = fixture.live_item->charges;
        sol::table requested_lines = fixture.lua.create_table();
        requested_lines[1] = fixture.line(
                                 "seller_to_buyer", 3, fixture.seller_item_handle,
                                 fixture.seller_handle, fixture.buyer_handle );
        const sol::protected_function_result quote_result = fixture.quote( requested_lines );
        REQUIRE( quote_result.valid() );
        const sol::table quote_envelope = quote_result.get<sol::table>();
        REQUIRE( quote_envelope["ok"].get<bool>() );
        const cata::lua_platform::trade_quote_token token =
            quote_envelope["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        cata::lua_platform::retire_npc_handle_identity( *fixture.buyer );
        const sol::protected_function_result commit_result = fixture.commit( token );
        REQUIRE( commit_result.valid() );
        const sol::table envelope = commit_result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_identity" );
        CHECK( fixture.live_item->charges == source_charges );
        CHECK_FALSE( token.registered() );
    }

    {
        platform_trade_commit_fixture fixture( 158, 508, 121071, 121072 );
        REQUIRE( fixture.ready() );
        const int source_charges = fixture.live_item->charges;
        sol::table requested_lines = fixture.lua.create_table();
        requested_lines[1] = fixture.line(
                                 "seller_to_buyer", 3, fixture.seller_item_handle,
                                 fixture.seller_handle, fixture.buyer_handle );
        const sol::protected_function_result quote_result = fixture.quote( requested_lines );
        REQUIRE( quote_result.valid() );
        const sol::table quote_envelope = quote_result.get<sol::table>();
        REQUIRE( quote_envelope["ok"].get<bool>() );
        const cata::lua_platform::trade_quote_token token =
            quote_envelope["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        fixture.live_item->charges += 1;
        const sol::protected_function_result commit_result = fixture.commit( token );
        REQUIRE( commit_result.valid() );
        const sol::table envelope = commit_result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_item" );
        CHECK( fixture.live_item->charges == source_charges + 1 );
        CHECK_FALSE( token.registered() );
    }

    {
        platform_trade_commit_fixture fixture( 159, 509, 121081, 121082 );
        REQUIRE( fixture.ready() );
        const int source_charges = fixture.live_item->charges;
        sol::table requested_lines = fixture.lua.create_table();
        requested_lines[1] = fixture.line(
                                 "seller_to_buyer", 3, fixture.seller_item_handle,
                                 fixture.seller_handle, fixture.buyer_handle );
        const sol::protected_function_result quote_result = fixture.quote( requested_lines );
        REQUIRE( quote_result.valid() );
        const sol::table quote_envelope = quote_result.get<sol::table>();
        REQUIRE( quote_envelope["ok"].get<bool>() );
        const cata::lua_platform::trade_quote_token token =
            quote_envelope["value"].get<sol::table>()["token"]
            .get<cata::lua_platform::trade_quote_token>();
        cata::lua_platform::bump_item_query_mutation_epoch();
        const sol::protected_function_result commit_result = fixture.commit( token );
        REQUIRE( commit_result.valid() );
        const sol::table envelope = commit_result.get<sol::table>();
        REQUIRE_FALSE( envelope["ok"].get<bool>() );
        CHECK( envelope["error"].get<sol::table>()["code"].get<std::string>() ==
               "stale_holder" );
        CHECK( fixture.live_item->charges == source_charges );
        CHECK_FALSE( token.registered() );
    }
}

#endif // CATA_ENABLE_LUA_PLATFORM
