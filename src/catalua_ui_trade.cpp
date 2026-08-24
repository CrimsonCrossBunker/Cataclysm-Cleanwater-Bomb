#if CATA_ENABLE_LUA_UI

#include "catalua_ui_trade.h"

#include <algorithm>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <limits>
#include <memory>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

#include "avatar.h"
#include "calendar.h"
#include "catalua_bindings_values.h"
#include "catalua_game_handle.h"
#include "character.h"
#include "creature.h"
#include "faction.h"
#include "flag.h"
#include "item.h"
#include "item_location.h"
#include "npc.h"
#include "npctrade.h"
#include "output.h"
#include "talker.h"
#include "translations.h"
#include "type_id.h"

namespace cata::lua_ui
{

namespace
{

constexpr std::size_t maximum_trade_deal_bytes = 256;
constexpr std::int64_t maximum_trade_quantity = 1000000000;
constexpr std::int64_t maximum_trade_balance = 1000000000;
constexpr std::int64_t maximum_favor_cash = 1000000000;
constexpr std::int64_t maximum_monster_purchase_count = 1000;
constexpr std::size_t maximum_monster_purchase_name_bytes = 256;

static const flag_id json_flag_NO_UNLOAD( "NO_UNLOAD" );

struct matching_transfer_options {
    std::optional<std::int64_t> limit;
    bool confirm = false;
    std::optional<game_handle> settle_with;
    bool include_debt = true;
};

struct matching_inventory {
    std::vector<item *> roots;
    std::int64_t quantity = 0;
    std::int64_t raw_value = 0;
    std::size_t container_roots = 0;
};

struct faction_settlement_plan {
    npc *account = nullptr;
    Character *counterparty = nullptr;
    itype_id currency;
    int unit_value = 0;
    int debt_before = 0;
    std::int64_t amount = 0;
    std::int64_t net_before_payment = 0;
    bool include_debt = true;
};

struct monster_purchase_options {
    std::int64_t count = 1;
    bool pacified = false;
    std::string name;
};

bool present( const sol::object &value )
{
    return value.valid() && value.get_type() != sol::type::nil;
}

monster_purchase_options read_monster_purchase_options(
    const sol::optional<sol::table> &requested )
{
    monster_purchase_options result;
    if( !requested ) {
        return result;
    }
    for( const auto &entry : *requested ) {
        if( entry.first.get_type() != sol::type::string ) {
            throw std::invalid_argument(
                "game.trade.buy_monsters option keys must be strings" );
        }
        const std::string key = entry.first.as<std::string>();
        if( key != "count" && key != "pacified" && key != "name" ) {
            throw std::invalid_argument(
                "game.trade.buy_monsters received unknown option '" + key + "'" );
        }
    }

    const sol::object count = ( *requested )["count"];
    if( present( count ) ) {
        if( !count.is<lua_Integer>() ) {
            throw std::invalid_argument(
                "game.trade.buy_monsters options.count must be an integer" );
        }
        result.count = static_cast<std::int64_t>( count.as<lua_Integer>() );
        if( result.count <= 0 ||
            result.count > maximum_monster_purchase_count ) {
            throw std::invalid_argument(
                "game.trade.buy_monsters options.count must be within 1..1000" );
        }
    }

    const sol::object pacified = ( *requested )["pacified"];
    if( present( pacified ) ) {
        if( !pacified.is<bool>() ) {
            throw std::invalid_argument(
                "game.trade.buy_monsters options.pacified must be boolean" );
        }
        result.pacified = pacified.as<bool>();
    }

    const sol::object name = ( *requested )["name"];
    if( present( name ) ) {
        if( !name.is<std::string>() ) {
            throw std::invalid_argument(
                "game.trade.buy_monsters options.name must be a string" );
        }
        result.name = name.as<std::string>();
        if( result.name.size() > maximum_monster_purchase_name_bytes ||
            result.name.find( '\0' ) != std::string::npos ) {
            throw std::invalid_argument(
                "game.trade.buy_monsters options.name must be at most 256 bytes" );
        }
    }
    return result;
}

matching_transfer_options read_matching_transfer_options(
    const sol::optional<sol::table> &requested )
{
    matching_transfer_options result;
    if( !requested ) {
        return result;
    }

    const sol::object limit = ( *requested )["limit"];
    if( present( limit ) ) {
        if( !limit.is<lua_Integer>() ) {
            throw std::invalid_argument(
                "game.trade.transfer_matching options.limit must be an integer" );
        }
        result.limit = static_cast<std::int64_t>(
                           limit.as<lua_Integer>() );
        if( *result.limit <= 0 ||
            *result.limit > maximum_trade_quantity ) {
            throw std::invalid_argument(
                "game.trade.transfer_matching options.limit is outside native bounds" );
        }
    }

    const sol::object confirm = ( *requested )["confirm"];
    if( present( confirm ) ) {
        if( !confirm.is<bool>() ) {
            throw std::invalid_argument(
                "game.trade.transfer_matching options.confirm must be boolean" );
        }
        result.confirm = confirm.as<bool>();
    }

    const sol::object settle_with = ( *requested )["settle_with"];
    if( present( settle_with ) ) {
        if( !settle_with.is<game_handle>() ) {
            throw std::invalid_argument(
                "game.trade.transfer_matching options.settle_with must be a GameHandle" );
        }
        result.settle_with = settle_with.as<game_handle>();
    }

    const sol::object include_debt = ( *requested )["include_debt"];
    if( present( include_debt ) ) {
        if( !include_debt.is<bool>() ) {
            throw std::invalid_argument(
                "game.trade.transfer_matching options.include_debt must be boolean" );
        }
        result.include_debt = include_debt.as<bool>();
    }
    return result;
}

bool read_include_debt( const sol::optional<sol::table> &requested,
                        const std::string &api_name )
{
    if( !requested ) {
        return true;
    }
    const sol::object value = ( *requested )["include_debt"];
    if( !present( value ) ) {
        return true;
    }
    if( !value.is<bool>() ) {
        throw std::invalid_argument(
            api_name + " options.include_debt must be boolean" );
    }
    return value.as<bool>();
}

Character *resolve_character(
    const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    const native_handle_result<Creature> resolved =
        handle.resolve_creature(
            runtime_generation, world_generation );
    if( !resolved ) {
        error = *resolved.error;
        return nullptr;
    }
    Character *character = resolved.value->as_character();
    if( character == nullptr ) {
        error = game_handle_error{
            "wrong_target", "The handle does not reference a character"
        };
    }
    return character;
}

npc *resolve_npc(
    const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation,
    std::optional<game_handle_error> &error )
{
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return nullptr;
    }
    npc *result = character->as_npc();
    if( result == nullptr ) {
        error = game_handle_error{
            "wrong_target", "The handle does not reference an NPC"
        };
    }
    return result;
}

std::pair<std::int64_t, std::int64_t> matching_root_totals(
    item &root, const itype_id &item_id )
{
    std::int64_t quantity = 0;
    std::int64_t raw_value = 0;
    root.visit_items( [&]( item *entry, item * ) {
        if( entry->typeId() == item_id ) {
            quantity += entry->count_by_charges() ?
                        std::max( entry->charges, 0 ) : 1;
            raw_value += entry->price( true );
        }
        return VisitResponse::NEXT;
    } );
    return { quantity, raw_value };
}

matching_inventory find_matching_inventory(
    Character &seller, const itype_id &item_id,
    const std::optional<std::int64_t> &limit )
{
    std::set<item *> candidates;
    std::unordered_map<item *, item *> parents;
    seller.visit_items( [&]( item *entry, item *parent ) {
        parents[entry] = parent;
        if( entry->typeId() == item_id ) {
            if( parent != nullptr &&
                ( parent->all_pockets_sealed() ||
                  entry->made_of( phase_id::LIQUID ) ||
                  parent->has_flag( json_flag_NO_UNLOAD ) ) ) {
                candidates.emplace( parent );
            } else {
                candidates.emplace( entry );
            }
        }
        return VisitResponse::NEXT;
    } );

    std::vector<item *> roots;
    roots.reserve( candidates.size() );
    for( item *candidate : candidates ) {
        bool contained_by_candidate = false;
        auto parent = parents.find( candidate );
        while( parent != parents.end() && parent->second != nullptr ) {
            if( candidates.count( parent->second ) != 0 ) {
                contained_by_candidate = true;
                break;
            }
            parent = parents.find( parent->second );
        }
        if( !contained_by_candidate ) {
            roots.push_back( candidate );
        }
    }

    matching_inventory result;
    for( item *root : roots ) {
        const auto [quantity, raw_value] =
            matching_root_totals( *root, item_id );
        if( quantity <= 0 ) {
            continue;
        }
        result.roots.push_back( root );
        result.quantity += quantity;
        result.raw_value += raw_value;
        if( root->typeId() != item_id ) {
            ++result.container_roots;
        }
        if( limit && result.quantity >= *limit ) {
            break;
        }
    }
    return result;
}

std::optional<faction_settlement_plan> prepare_faction_settlement(
    npc &account, Character &counterparty, const std::int64_t amount,
    const bool include_debt, std::optional<game_handle_error> &error )
{
    faction *account_faction = account.get_faction();
    if( account_faction == nullptr ||
        account_faction->currency.is_empty() ) {
        error = game_handle_error{
            "missing_currency",
            "The NPC faction has no currency for account settlement"
        };
        return std::nullopt;
    }

    item currency_unit( account_faction->currency, calendar::turn );
    const double native_unit_value = account.value( currency_unit );
    if( !std::isfinite( native_unit_value ) ||
        native_unit_value <= 0.0 ||
        native_unit_value > std::numeric_limits<int>::max() ) {
        error = game_handle_error{
            "invalid_currency",
            "The NPC faction currency does not have a positive native value"
        };
        return std::nullopt;
    }

    faction_settlement_plan result;
    result.account = &account;
    result.counterparty = &counterparty;
    result.currency = account_faction->currency;
    result.unit_value = static_cast<int>( native_unit_value );
    result.debt_before = account.op_of_u.owed;
    result.amount = amount;
    result.include_debt = include_debt;
    result.net_before_payment = amount;
    if( include_debt ) {
        result.net_before_payment += result.debt_before;
    }
    if( result.net_before_payment < std::numeric_limits<int>::min() ||
        result.net_before_payment > std::numeric_limits<int>::max() ) {
        error = game_handle_error{
            "numeric_overflow",
            "The faction account settlement would overflow native debt"
        };
        return std::nullopt;
    }
    return result;
}

sol::table apply_faction_settlement(
    sol::state_view state, faction_settlement_plan &plan )
{
    std::int64_t remaining = plan.net_before_payment;
    std::int64_t signed_currency_units = 0;
    item currency_unit( plan.currency, calendar::turn );

    if( remaining > 0 ) {
        const std::int64_t units = remaining / plan.unit_value;
        if( units > 0 ) {
            plan.counterparty->i_add_or_drop(
                currency_unit, static_cast<int>( units ) );
            remaining -= units * plan.unit_value;
            signed_currency_units = units;
        }
    } else if( remaining < 0 ) {
        const std::int64_t requested_units =
            ( -remaining ) / plan.unit_value;
        const std::int64_t available_units =
            plan.counterparty->charges_of( plan.currency );
        const std::int64_t units =
            std::min( requested_units, available_units );
        if( units > 0 ) {
            plan.counterparty->use_charges(
                plan.currency, static_cast<int>( units ) );
            plan.account->i_add_or_drop(
                currency_unit, static_cast<int>( units ) );
            remaining += units * plan.unit_value;
            signed_currency_units = -units;
        }
    }

    std::int64_t debt_after = remaining;
    if( !plan.include_debt ) {
        debt_after += plan.debt_before;
    }
    plan.account->op_of_u.owed = static_cast<int>( debt_after );

    sol::table value = state.create_table();
    value["amount"] = plan.amount;
    value["net_before_payment"] = plan.net_before_payment;
    value["currency"] = script_game_id(
                            "item", plan.currency.str() );
    value["currency_unit_value"] = plan.unit_value;
    value["currency_units"] = signed_currency_units;
    value["debt_before"] = plan.debt_before;
    value["debt_after"] = plan.account->op_of_u.owed;
    value["include_debt"] = plan.include_debt;
    return value;
}

sol::table matching_stock(
    sol::this_state lua, const game_handle &seller_handle,
    const script_game_id &item_id,
    const sol::optional<std::int64_t> &requested_limit,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( item_id.kind() != "item" || !item_id.is_valid() ) {
        throw std::invalid_argument(
            "game.trade.matching_stock requires a valid GameId<item>" );
    }
    if( requested_limit &&
        ( *requested_limit <= 0 ||
          *requested_limit > maximum_trade_quantity ) ) {
        throw std::invalid_argument(
            "game.trade.matching_stock limit is outside native bounds" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *seller = resolve_character(
                            seller_handle, runtime_generation,
                            world_generation, error );
    if( seller == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const std::optional<std::int64_t> limit = requested_limit ?
            std::optional<std::int64_t>( *requested_limit ) : std::nullopt;
    const matching_inventory stock = find_matching_inventory(
                                         *seller, itype_id( item_id.value() ),
                                         limit );
    sol::table value = state.create_table();
    value["id"] = item_id;
    value["quantity"] = stock.quantity;
    value["raw_value"] = stock.raw_value;
    value["roots"] = stock.roots.size();
    value["container_roots"] = stock.container_roots;
    value["available"] = stock.quantity > 0;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table cash_to_favor(
    sol::this_state lua, const game_handle &npc_handle,
    const std::int64_t cash,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( cash < 0 || cash > maximum_favor_cash ) {
        throw std::invalid_argument(
            "game.trade.cash_to_favor cash must be within 0..1000000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *account = resolve_npc(
                       npc_handle, runtime_generation,
                       world_generation, error );
    if( account == nullptr ) {
        return make_game_error_result( state, *error );
    }
    sol::table value = state.create_table();
    value["cash"] = cash;
    value["favor"] = npc_trading::cash_to_favor(
                         *account, static_cast<int>( cash ) );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table buy_monsters(
    sol::this_state lua, const game_handle &seller_handle,
    const script_game_id &monster_id, const std::int64_t cost,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( monster_id.kind() != "monster" || !monster_id.is_valid() ) {
        throw std::invalid_argument(
            "game.trade.buy_monsters requires a valid GameId<monster>" );
    }
    if( cost < -maximum_trade_balance || cost > maximum_trade_balance ) {
        throw std::invalid_argument(
            "game.trade.buy_monsters cost must be within -1000000000..1000000000" );
    }
    const monster_purchase_options options =
        read_monster_purchase_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *seller = resolve_npc(
                      seller_handle, runtime_generation,
                      world_generation, error );
    if( seller == nullptr ) {
        return make_game_error_result( state, *error );
    }

    std::unique_ptr<talker> buyer_talker =
        get_talker_for( get_avatar() );
    std::unique_ptr<talker> seller_talker =
        get_talker_for( *seller );
    const bool purchased = buyer_talker->buy_monster(
                               *seller_talker, mtype_id( monster_id.value() ),
                               static_cast<int>( cost ),
                               static_cast<int>( options.count ),
                               options.pacified,
                               no_translation( options.name ) );

    sol::table value = state.create_table();
    value["monster"] = monster_id;
    value["seller"] = seller_handle;
    value["cost"] = cost;
    value["count"] = options.count;
    value["pacified"] = options.pacified;
    value["name"] = options.name;
    value["purchased"] = purchased;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table settle_faction_account(
    sol::this_state lua, const game_handle &account_handle,
    const game_handle &counterparty_handle,
    const std::int64_t amount,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( amount < -maximum_trade_balance ||
        amount > maximum_trade_balance ) {
        throw std::invalid_argument(
            "game.trade.settle_faction_account amount must be within -1000000000..1000000000" );
    }
    const bool include_debt = read_include_debt(
                                  requested_options,
                                  "game.trade.settle_faction_account" );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *account = resolve_npc(
                       account_handle, runtime_generation,
                       world_generation, error );
    if( account == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *counterparty = resolve_character(
                                  counterparty_handle,
                                  runtime_generation,
                                  world_generation, error );
    if( counterparty == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( account == counterparty ) {
        throw std::invalid_argument(
            "game.trade.settle_faction_account parties must differ" );
    }
    std::optional<faction_settlement_plan> plan =
        prepare_faction_settlement(
            *account, *counterparty, amount,
            include_debt, error );
    if( !plan ) {
        return make_game_error_result( state, *error );
    }
    sol::table value = apply_faction_settlement(
                           state, *plan );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table transfer_matching_items(
    sol::this_state lua,
    const game_handle &seller_handle,
    const game_handle &buyer_handle,
    const script_game_id &item_id,
    const sol::optional<sol::table> &requested_options,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( item_id.kind() != "item" || !item_id.is_valid() ) {
        throw std::invalid_argument(
            "game.trade.transfer_matching requires a valid GameId<item>" );
    }
    const matching_transfer_options options =
        read_matching_transfer_options( requested_options );
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *seller = resolve_character(
                            seller_handle, runtime_generation,
                            world_generation, error );
    if( seller == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *buyer = resolve_character(
                           buyer_handle, runtime_generation,
                           world_generation, error );
    if( buyer == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( seller == buyer ) {
        throw std::invalid_argument(
            "game.trade.transfer_matching seller and buyer must differ" );
    }

    const itype_id native_id( item_id.value() );
    const matching_inventory selected = find_matching_inventory(
                                            *seller, native_id,
                                            options.limit );

    npc *settlement_account = nullptr;
    Character *settlement_counterparty = nullptr;
    std::optional<faction_settlement_plan> settlement;
    if( options.settle_with ) {
        settlement_account = resolve_npc(
                                 *options.settle_with,
                                 runtime_generation,
                                 world_generation, error );
        if( settlement_account == nullptr ) {
            return make_game_error_result( state, *error );
        }
        if( settlement_account != seller &&
            settlement_account != buyer ) {
            throw std::invalid_argument(
                "game.trade.transfer_matching settle_with must reference the seller or buyer" );
        }
        settlement_counterparty = settlement_account == seller ?
                                  buyer : seller;
        const std::int64_t amount = settlement_account == buyer ?
                                    selected.raw_value : -selected.raw_value;
        settlement = prepare_faction_settlement(
                         *settlement_account,
                         *settlement_counterparty,
                         amount, options.include_debt, error );
        if( !settlement ) {
            return make_game_error_result( state, *error );
        }
    }

    if( options.confirm && seller->is_avatar() &&
        !selected.roots.empty() ) {
        std::string warning =
            _( "Really continue?  You will hand over the following items:" );
        for( item *root : selected.roots ) {
            warning += "\n" + root->tname();
        }
        if( !query_yn( warning ) ) {
            sol::table value = state.create_table();
            value["accepted"] = false;
            value["cancelled"] = true;
            value["id"] = item_id;
            value["quantity"] = 0;
            value["selected_quantity"] = selected.quantity;
            value["raw_value"] = selected.raw_value;
            value["roots"] = selected.roots.size();
            value["container_roots"] = selected.container_roots;
            return make_game_value_result(
                       state, sol::make_object(
                           state, std::move( value ) ) );
        }
    }

    matching_inventory transferred;
    for( item *root : selected.roots ) {
        const auto [quantity, raw_value] =
            matching_root_totals( *root, native_id );
        const bool container_root = root->typeId() != native_id;
        const faction_id original_owner = root->get_owner();
        item moved = seller->i_rem( root );
        if( moved.is_null() ) {
            continue;
        }
        moved.set_owner( *buyer );
        if( !buyer->i_add_or_drop( moved ) ) {
            moved.set_owner( original_owner );
            seller->i_add_or_drop( moved );
            continue;
        }
        transferred.quantity += quantity;
        transferred.raw_value += raw_value;
        transferred.container_roots += container_root ? 1 : 0;
        transferred.roots.push_back( nullptr );
    }
    seller->invalidate_crafting_inventory();
    buyer->invalidate_crafting_inventory();

    sol::object settlement_value =
        sol::make_object( state, sol::nil );
    if( settlement ) {
        settlement->amount = settlement_account == buyer ?
                             transferred.raw_value :
                             -transferred.raw_value;
        settlement->net_before_payment = settlement->amount;
        if( settlement->include_debt ) {
            settlement->net_before_payment +=
                settlement->debt_before;
        }
        sol::table applied = apply_faction_settlement(
                                 state, *settlement );
        settlement_value = sol::make_object(
                               state, std::move( applied ) );
    }

    sol::table value = state.create_table();
    value["accepted"] = true;
    value["cancelled"] = false;
    value["id"] = item_id;
    value["quantity"] = transferred.quantity;
    value["selected_quantity"] = selected.quantity;
    value["raw_value"] = transferred.raw_value;
    value["roots"] = transferred.roots.size();
    value["container_roots"] = transferred.container_roots;
    value["settlement"] = std::move( settlement_value );
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table open_trade(
    sol::this_state lua, const game_handle &handle,
    const int cost, const std::string &deal,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( cost < 0 ) {
        throw std::invalid_argument(
            "game.trade.open cost cannot be negative" );
    }
    if( deal.empty() || deal.size() > maximum_trade_deal_bytes ||
        deal.find( '\0' ) != std::string::npos ) {
        throw std::invalid_argument(
            "game.trade.open deal must contain 1 to 256 bytes" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, npc_trading::trade(
                       *entry, cost, deal ) ) );
}

sol::table pay_npc(
    sol::this_state lua, const game_handle &handle,
    const int cost,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( cost <= 0 ) {
        throw std::invalid_argument(
            "game.trade.pay cost must be positive" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object(
                   state, npc_trading::pay_npc(
                       *entry, cost ) ) );
}

sol::table settle_npc_payment(
    sol::this_state lua, const game_handle &handle,
    const std::int64_t amount,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( amount < -maximum_trade_balance ||
        amount > maximum_trade_balance ) {
        throw std::invalid_argument(
            "game.trade.settle amount must be within -1000000000..1000000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const int debt_before = entry->op_of_u.owed;
    const bool accepted = npc_trading::pay_npc(
                              *entry, static_cast<int>( amount ) );
    sol::table value = state.create_table();
    value["accepted"] = accepted;
    value["amount"] = amount;
    value["debt_before"] = debt_before;
    value["debt_after"] = entry->op_of_u.owed;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table settle_npc_credit(
    sol::this_state lua, const game_handle &handle,
    const int cost,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( cost <= 0 ) {
        throw std::invalid_argument(
            "game.trade.settle_credit cost must be positive" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    npc *entry = resolve_npc(
                     handle, runtime_generation,
                     world_generation, error );
    if( entry == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const int before = entry->op_of_u.owed;
    const bool accepted = before >= cost;
    if( accepted ) {
        entry->op_of_u.owed -= cost;
    }
    sol::table value = state.create_table();
    value["accepted"] = accepted;
    value["cost"] = cost;
    value["before"] = before;
    value["after"] = entry->op_of_u.owed;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table character_balance(
    sol::this_state lua, const game_handle &handle,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object( state, character->cash ) );
}

sol::table set_character_balance(
    sol::this_state lua, const game_handle &handle,
    const std::int64_t requested,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( requested < -maximum_trade_balance ||
        requested > maximum_trade_balance ) {
        throw std::invalid_argument(
            "game.trade.set_balance amount must be within -1000000000..1000000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const int before = character->cash;
    character->cash = static_cast<int>( requested );
    sol::table value = state.create_table();
    value["before"] = before;
    value["after"] = character->cash;
    value["changed"] = before != character->cash;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table adjust_character_balance(
    sol::this_state lua, const game_handle &handle,
    const std::int64_t delta,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( delta < -maximum_trade_balance ||
        delta > maximum_trade_balance ) {
        throw std::invalid_argument(
            "game.trade.adjust_balance delta must be within -1000000000..1000000000" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *character = resolve_character(
                               handle, runtime_generation,
                               world_generation, error );
    if( character == nullptr ) {
        return make_game_error_result( state, *error );
    }
    const int before = character->cash;
    const std::int64_t after =
        static_cast<std::int64_t>( before ) + delta;
    if( after < -maximum_trade_balance ||
        after > maximum_trade_balance ) {
        return make_game_error_result( state, {
            "out_of_range",
            "The adjusted character balance would exceed the supported range"
        } );
    }
    character->cash = static_cast<int>( after );
    sol::table value = state.create_table();
    value["before"] = before;
    value["delta"] = delta;
    value["after"] = character->cash;
    return make_game_value_result(
               state, sol::make_object( state, std::move( value ) ) );
}

sol::table quote_trade_item(
    sol::this_state lua,
    const game_handle &buyer_handle,
    const game_handle &seller_handle,
    const script_game_id &item_id,
    const std::int64_t quantity,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( item_id.kind() != "item" || !item_id.is_valid() ) {
        throw std::invalid_argument(
            "game.trade.quote requires a valid GameId<item>" );
    }
    if( quantity <= 0 || quantity > maximum_trade_quantity ||
        quantity > std::numeric_limits<int>::max() ) {
        throw std::invalid_argument(
            "game.trade.quote quantity is outside native bounds" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *buyer = resolve_character(
                           buyer_handle, runtime_generation,
                           world_generation, error );
    if( buyer == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *seller = resolve_character(
                            seller_handle, runtime_generation,
                            world_generation, error );
    if( seller == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( npc *seller_npc = seller->as_npc() ) {
        seller = &seller_npc->get_trade_delegate();
    }
    const itype_id native_id( item_id.value() );
    item quoted( native_id, calendar::turn );
    if( quoted.count_by_charges() ) {
        quoted.charges = static_cast<int>( quantity );
    }
    const int price = npc_trading::trading_price_for_order(
                          *buyer, *seller, quoted,
                          static_cast<int>( quantity ) );
    sol::table value = state.create_table();
    value["id"] = item_id;
    value["name"] = item::nname(
                        native_id,
                        static_cast<unsigned int>( quantity ) );
    value["quantity"] = quantity;
    value["cost"] = price > 0 ? price : -1;
    value["accepted"] = price > 0;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

sol::table transfer_trade_item(
    sol::this_state lua,
    const game_handle &seller_handle,
    const game_handle &buyer_handle,
    const game_handle &item_handle,
    const std::int64_t quantity,
    const game_handle_runtime &runtime_generation,
    const std::size_t world_generation )
{
    if( quantity <= 0 || quantity > maximum_trade_quantity ||
        quantity > std::numeric_limits<int>::max() ) {
        throw std::invalid_argument(
            "game.trade.transfer quantity is outside native bounds" );
    }
    sol::state_view state( lua );
    std::optional<game_handle_error> error;
    Character *seller = resolve_character(
                            seller_handle, runtime_generation,
                            world_generation, error );
    if( seller == nullptr ) {
        return make_game_error_result( state, *error );
    }
    Character *buyer = resolve_character(
                           buyer_handle, runtime_generation,
                           world_generation, error );
    if( buyer == nullptr ) {
        return make_game_error_result( state, *error );
    }
    if( seller == buyer ) {
        throw std::invalid_argument(
            "game.trade.transfer seller and buyer must differ" );
    }
    const native_handle_result<item> resolved =
        item_handle.resolve_item(
            runtime_generation, world_generation );
    if( !resolved ) {
        return make_game_error_result( state, *resolved.error );
    }
    item *entry = resolved.value;
    if( !seller->has_item( *entry ) ) {
        return make_game_error_result( state, {
            "not_owned",
            "The seller does not carry the referenced item"
        } );
    }
    const bool by_charges = entry->count_by_charges();
    const std::int64_t available = by_charges ? entry->charges : 1;
    if( quantity > available || ( !by_charges && quantity != 1 ) ) {
        return make_game_error_result( state, {
            "insufficient_quantity",
            "The requested transfer quantity is unavailable"
        } );
    }

    const bool partial = by_charges && quantity < available;
    item transferred;
    if( partial ) {
        transferred = entry->split(
                          static_cast<int>( quantity ) );
    } else {
        transferred = seller->i_rem( entry );
    }
    if( transferred.is_null() ) {
        return make_game_error_result( state, {
            "operation_failed",
            "The seller could not release the item"
        } );
    }
    const faction_id original_owner =
        transferred.get_owner();
    transferred.set_owner( *buyer );
    item_location added = buyer->i_add(
                              transferred, true, nullptr,
                              nullptr, true, true );
    if( !added ) {
        if( partial ) {
            entry->charges += static_cast<int>( quantity );
        } else {
            transferred.set_owner( original_owner );
            seller->i_add(
                transferred, true, nullptr,
                nullptr, true, true );
        }
        return make_game_error_result( state, {
            "operation_failed",
            "The buyer could not receive or drop the item"
        } );
    }
    seller->invalidate_crafting_inventory();
    buyer->invalidate_crafting_inventory();
    sol::table value = state.create_table();
    value["id"] = script_game_id(
                      "item", added->typeId().str() );
    value["quantity"] = quantity;
    value["uid"] = added->uid().get_value();
    value["carried"] = added.held_by( *buyer );
    value["partial"] = partial;
    return make_game_value_result(
               state, sol::make_object(
                   state, std::move( value ) ) );
}

} // namespace

void install_trade_api(
    sol::table &game,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( game.lua_state() );
    sol::table trade = lua.create_table();
    trade.set_function(
        "open",
        [current_runtime_generation,
         current_world_generation, require_write](
             sol::this_state state,
             const game_handle &npc_handle,
             const sol::optional<int> &cost,
             const sol::optional<std::string> &deal ) {
        require_write();
        return open_trade(
                   state, npc_handle, cost.value_or( 0 ),
                   deal.value_or( "Trade" ),
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "pay",
        [current_runtime_generation,
         current_world_generation, require_write](
             sol::this_state state,
             const game_handle &npc_handle,
             const int cost ) {
        require_write();
        return pay_npc(
                   state, npc_handle, cost,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "settle",
        [current_runtime_generation,
         current_world_generation, require_write](
             sol::this_state state,
             const game_handle &npc_handle,
             const std::int64_t amount ) {
        require_write();
        return settle_npc_payment(
                   state, npc_handle, amount,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "settle_credit",
        [current_runtime_generation,
         current_world_generation, require_write](
             sol::this_state state,
             const game_handle &npc_handle,
             const int cost ) {
        require_write();
        return settle_npc_credit(
                   state, npc_handle, cost,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "balance",
        [current_runtime_generation,
         current_world_generation, require_read](
             sol::this_state state,
             const game_handle &character ) {
        require_read();
        return character_balance(
                   state, character,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "set_balance",
        [current_runtime_generation,
         current_world_generation, require_write](
             sol::this_state state,
             const game_handle &character,
             const std::int64_t amount ) {
        require_write();
        return set_character_balance(
                   state, character, amount,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "adjust_balance",
        [current_runtime_generation,
         current_world_generation, require_write](
             sol::this_state state,
             const game_handle &character,
             const std::int64_t delta ) {
        require_write();
        return adjust_character_balance(
                   state, character, delta,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "matching_stock",
        [current_runtime_generation,
         current_world_generation, require_read](
             sol::this_state state,
             const game_handle &seller,
             const script_game_id &item_id,
             const sol::optional<std::int64_t> &limit ) {
        require_read();
        return matching_stock(
                   state, seller, item_id, limit,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "cash_to_favor",
        [current_runtime_generation,
         current_world_generation, require_read](
             sol::this_state state,
             const game_handle &npc,
             const std::int64_t cash ) {
        require_read();
        return cash_to_favor(
                   state, npc, cash,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "buy_monsters",
        [current_runtime_generation,
         current_world_generation, require_write](
             sol::this_state state,
             const game_handle &seller,
             const script_game_id &monster,
             const std::int64_t cost,
             const sol::optional<sol::table> &options ) {
        require_write();
        return buy_monsters(
                   state, seller, monster, cost, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "settle_faction_account",
        [current_runtime_generation,
         current_world_generation, require_write](
             sol::this_state state,
             const game_handle &account,
             const game_handle &counterparty,
             const std::int64_t amount,
             const sol::optional<sol::table> &options ) {
        require_write();
        return settle_faction_account(
                   state, account, counterparty,
                   amount, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "transfer_matching",
        [current_runtime_generation,
         current_world_generation, require_write](
             sol::this_state state,
             const game_handle &seller,
             const game_handle &buyer,
             const script_game_id &item_id,
             const sol::optional<sol::table> &options ) {
        require_write();
        return transfer_matching_items(
                   state, seller, buyer,
                   item_id, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "quote",
        [current_runtime_generation,
         current_world_generation, require_read](
             sol::this_state state,
             const game_handle &buyer,
             const game_handle &seller,
             const script_game_id &item_id,
             const std::int64_t quantity ) {
        require_read();
        return quote_trade_item(
                   state, buyer, seller, item_id, quantity,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "transfer",
        [current_runtime_generation,
         current_world_generation, require_write](
             sol::this_state state,
             const game_handle &seller,
             const game_handle &buyer,
             const game_handle &item_handle,
             const std::int64_t quantity ) {
        require_write();
        return transfer_trade_item(
                   state, seller, buyer, item_handle, quantity,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    game["trade"] = std::move( trade );
}

} // namespace cata::lua_ui

#endif // CATA_ENABLE_LUA_UI
