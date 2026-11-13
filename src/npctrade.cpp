#include "npctrade.h"

#include <coordinates.h>
#include <algorithm>
#include <cmath>
#include <cstdint>
#include <cstdlib>
#include <limits>
#include <list>
#include <memory>
#include <optional>
#include <ostream>
#include <string>
#include <tuple>
#include <unordered_set>
#include <utility>
#include <vector>

#include "avatar.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_action_guard.h"
#include "character_attire.h"
#include "craft_reservation.h"
#include "debug.h"
#include "enums.h"
#include "faction.h"
#include "item.h"
#include "item_category.h" // IWYU pragma: keep
#include "item_contents.h"
#include "item_location.h"
#include "item_pocket.h"
#include "map_selector.h"
#include "npc.h"
#include "npc_opinion.h"
#include "npctrade_utils.h"
#include "options.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "rng.h"
#include "skill.h"
#include "trade_ui.h"
#include "type_id.h"
#include "units.h"

static const flag_id json_flag_NO_UNWIELD( "NO_UNWIELD" );
static const skill_id skill_speech( "speech" );

const npc *npc_trading::merchant( const Character &who )
{
    return who.has_native_player_control() ? nullptr : who.as_npc();
}

namespace
{
bool valid_selection( const trade_selector::select_t &sales,
                      const trade_selector::select_t &purchases )
{
    std::unordered_set<const item *> selected;
    for( const auto *side : {
             &sales, &purchases
         } ) {
        for( const auto &[loc, count] : *side ) {
            const item *entry = loc.get_item();
            if( !loc || !entry || count <= 0 || count > entry->count() ||
                craft_reservation::contains_reserved_or_live_craft( *entry ) ||
                ( count < entry->count() && !entry->container_type_pockets_empty() ) ||
                !selected.insert( entry ).second ) {
                return false;
            }
        }
    }
    for( const auto *side : {
             &sales, &purchases
         } ) {
        for( const auto &line : *side ) {
            for( item_location parent = line.first; parent.has_parent(); ) {
                parent = parent.parent_item();
                if( !parent || selected.count( parent.get_item() ) != 0 ) {
                    return false;
                }
            }
        }
    }
    return true;
}

struct trade_goods {
    std::list<item> offered;
    std::list<item> excluded_contents;
};

trade_goods prepare_trade_goods( const trade_selector::select_t &selection,
                                 const Character &giver, const Character &receiver )
{
    trade_goods result;
    const npc *seller = npc_trading::merchant( giver );
    const npc *buyer = npc_trading::merchant( receiver );
    for( const auto &[loc, count] : selection ) {
        result.offered.push_back( *loc );
        item &gift = result.offered.back();
        if( gift.is_container() ) {
            for( item *entry : gift.get_contents().all_items_top() ) {
                const item_location nested( loc, entry );
                const int price = npc_trading::trading_price( receiver, giver, { nested, 1 } );
                if( ( seller && !seller->wants_to_sell( nested, price, receiver ).success() ) ||
                    ( buyer && !buyer->wants_to_buy( *entry, price, giver ).success() ) ) {
                    result.excluded_contents.push_back( *entry );
                    gift.remove_item( *entry );
                }
            }
        }
        if( gift.count_by_charges() ) {
            gift.charges = count;
        }
        gift.set_owner( receiver );
    }
    return result;
}

void remove_trade_goods( const trade_selector::select_t &selection )
{
    for( auto [loc, count] : selection ) {
        if( loc->count_by_charges() && count < loc->charges ) {
            loc->charges -= count;
            loc.on_contents_changed();
            if( Character *carrier = loc.carrier() ) {
                carrier->invalidate_weight_carried_cache();
            }
        } else {
            loc.remove_item();
        }
    }
}

void exchange_goods( Character &player, npc &trader,
                     const trade_selector::select_t &sales,
                     const trade_selector::select_t &purchases,
                     std::vector<tripoint_abs_ms> *changed_tiles = nullptr )
{
    // Prepare both sides before touching their sources. Remove every selected
    // source before deliveries can merge charges into another selected stack.
    trade_goods outgoing = prepare_trade_goods( sales, player, trader );
    trade_goods incoming = prepare_trade_goods( purchases, trader, player );
    if( changed_tiles ) {
        changed_tiles->push_back( player.pos_abs() );
        changed_tiles->push_back( trader.pos_abs() );
        for( const auto *side : {
                 &sales, &purchases
             } ) {
            for( const auto &line : *side ) {
                if( !line.first.carrier() ) {
                    changed_tiles->push_back( line.first.pos_abs() );
                }
            }
        }
    }
    remove_trade_goods( sales );
    remove_trade_goods( purchases );

    for( item &entry : outgoing.excluded_contents ) {
        player.i_add_or_drop( entry );
    }
    for( item &entry : incoming.excluded_contents ) {
        trader.i_add_or_drop( entry );
    }
    const bool allow_wield = player.is_avatar();
    for( item &entry : incoming.offered ) {
        if( entry.count_by_charges() ) {
            player.i_add_or_fill( entry, true, nullptr, nullptr,
                                  /*allow_drop=*/true, allow_wield, false );
        } else {
            player.i_add( std::move( entry ), true, nullptr, nullptr,
                          /*allow_drop=*/true, allow_wield );
        }
    }
    if( trader.is_shopkeeper() ) {
        outgoing.offered = distribute_items_to_npc_zones( outgoing.offered, trader, changed_tiles );
    }
    for( item &entry : outgoing.offered ) {
        trader.i_add( std::move( entry ), true, nullptr, nullptr, true, false );
    }
}

bool fits_trade_account( const int64_t value )
{
    return value >= std::numeric_limits<int>::min() && value <= std::numeric_limits<int>::max();
}
} // namespace

std::vector<item_pricing> npc_trading::init_selling( npc &np )
{
    std::vector<item_pricing> result;
    const std::vector<item *> inv_all = np.items_with( []( const item & it ) {
        return !it.made_of( phase_id::LIQUID );
    } );
    for( item *i : inv_all ) {
        item &it = *i;

        int val = np.value( it );
        // FIXME: this item_location is a hack
        if( np.wants_to_sell( item_location{ np, i }, val ).success() ) {
            result.emplace_back( np, it, val, static_cast<int>( it.count() ) );
        }
    }

    item_location weapon = np.get_wielded_item();
    if(
        np.will_exchange_items_freely() && weapon && !weapon->has_flag( json_flag_NO_UNWIELD )
    ) {
        result.emplace_back( np, *weapon, np.value( *weapon ), false );
    }

    return result;
}

double npc_trading::net_price_adjustment( const Character &buyer, const Character &seller )
{
    // Adjust the prices based on your social skill.
    // cap adjustment so nothing is ever sold below value
    ///\EFFECT_INT_NPC slightly increases bartering price changes, relative to your INT

    ///\EFFECT_BARTER_NPC increases bartering price changes, relative to your BARTER

    ///\EFFECT_INT slightly increases bartering price changes, relative to NPC INT

    ///\EFFECT_BARTER increases bartering price changes, relative to NPC BARTER
    int const int_diff = seller.get_int() - buyer.get_int();
    double const int_adj = 1 + 0.05 * std::min( 19, std::abs( int_diff ) );
    double const soc_adj = price_adjustment( round( seller.get_skill_level( skill_speech ) -
                           buyer.get_skill_level( skill_speech ) ) );
    double const adjust = int_diff >= 0 ? int_adj * soc_adj : soc_adj / int_adj;
    return merchant( seller ) ? adjust : -1 / adjust;
}

int npc_trading::bionic_install_price( Character &installer, Character &patient,
                                       item_location const &bionic )
{
    return bionic->price( true ) * 2 +
           ( bionic->is_owned_by( patient )
             ? 0
             : npc_trading::trading_price( patient, installer, { bionic, 1 } ) );
}

int npc_trading::adjusted_price( item const *it, int amount, Character const &buyer,
                                 Character const &seller )
{
    const npc *buyer_npc = merchant( buyer );
    const npc *seller_npc = merchant( seller );
    const npc *faction_party = buyer_npc ? buyer_npc : seller_npc;
    const Character &customer = buyer_npc ? seller : buyer;
    const faction_price_rule *fpr = faction_party ? faction_party->get_price_rules( *it,
        &customer ) : nullptr;

    double price = it->price_no_contents( true, fpr != nullptr ? fpr->price : std::nullopt );
    if( fpr != nullptr ) {
        price *= fpr->premium;
        if( seller_npc ) {
            price *= fpr->markup;
        }
    }
    if( it->count_by_charges() && amount >= 0 ) {
        if( it->charges <= 0 ) {
            return 0;
        }
        price *= static_cast<double>( amount ) / it->charges;
    }
    if( buyer_npc ) {
        price = buyer_npc->value( *it, price );
    } else if( seller_npc ) {
        price = seller_npc->value( *it, price );
    }

    if( fpr != nullptr && fpr->fixed_adj.has_value() ) {
        double const fixed_adj = fpr->fixed_adj.value();
        price *= 1 + ( seller_npc ? fixed_adj : -fixed_adj );
    } else {
        double const adjust = npc_trading::net_price_adjustment( buyer, seller );
        price *= 1 + 0.25 * adjust;
    }

    if( std::isnan( price ) ) {
        return 0;
    }
    return static_cast<int>( std::clamp( std::ceil( price ),
                                         static_cast<double>( std::numeric_limits<int>::min() ),
                                         static_cast<double>( std::numeric_limits<int>::max() ) ) );
}

namespace
{
int _trading_price( Character const &buyer, Character const &seller, item_location const &it,
                    int amount )
{
    if( const npc *seller_npc = npc_trading::merchant( seller ) ) {
        if( !seller_npc->wants_to_sell( it, 1, buyer ).success() ) {
            return 0;
        }
    } else if( const npc *buyer_npc = npc_trading::merchant( buyer ) ) {
        if( !buyer_npc->wants_to_buy( *it, 1, seller ).success() ) {
            return 0;
        }
    }
    int64_t ret = npc_trading::adjusted_price( it.get_item(), amount, buyer, seller );
    for( item_pocket const *pk : it->get_standard_pockets() ) {
        for( item const *pkit : pk->all_items_top() ) {
            ret += _trading_price( buyer, seller, item_location{ it, const_cast<item *>( pkit ) },
                                   -1 );
        }
    }
    return static_cast<int>( std::clamp<int64_t>( ret, std::numeric_limits<int>::min(),
            std::numeric_limits<int>::max() ) );
}
} // namespace

int npc_trading::trading_price( Character const &buyer, Character const &seller,
                                trade_selector::entry_t const &it )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    return _trading_price( buyer, seller, it.first, it.second );
}

int npc_trading::trading_price_for_order( Character const &buyer, Character const &seller,
        item const &it, int count )
{
    if( count <= 0 ) {
        return 0;
    }

    item quote_item = it;
    quote_item.set_owner( seller );
    if( quote_item.count_by_charges() ) {
        quote_item.charges = count;
    }

    trade_selector::entry_t entry{ item_location{ map_cursor{ tripoint_bub_ms::zero },
                                   &quote_item },
                                   quote_item.count_by_charges() ? count : 1 };
    const int price = npc_trading::trading_price( buyer, seller, entry );
    if( quote_item.count_by_charges() ) {
        return price;
    }

    if( price <= 0 ) {
        return price;
    }
    if( count > std::numeric_limits<int>::max() / price ) {
        return std::numeric_limits<int>::max();
    }
    return price * count;
}

void item_pricing::set_values( int ip_count )
{
    const item *i_p = loc.get_item();
    is_container = i_p->is_container() || i_p->is_ammo_container();
    vol = i_p->volume();
    weight = i_p->weight();
    if( is_container || i_p->count() == 1 ) {
        count = ip_count;
    } else {
        charges = i_p->count();
        if( charges > 0 ) {
            price /= charges;
            vol /= charges;
            weight /= charges;
        } else {
            debugmsg( "item %s has zero or negative charges", i_p->typeId().str() );
        }
    }
}

namespace
{
int remembered_balance( const npc &trader, const npc_opinion &account, int balance )
{
    // Prior rewards can exceed what the merchant would agree to owe today.
    return std::min( balance, std::max( account.owed, trader.max_willing_to_owe( account ) ) );
}

std::optional<int> trade_side_value( const Character &buyer, const Character &seller,
                                     const trade_selector::select_t &lines )
{
    const npc *merchant_buyer = npc_trading::merchant( buyer );
    const npc *merchant_seller = npc_trading::merchant( seller );
    int64_t value = 0;
    for( const auto &line : lines ) {
        const restore_on_out_of_scope restore_rng( rng_get_engine() );
        const Character *carrier = line.first.carrier();
        if( ( carrier && carrier != &seller ) || !line.first->is_owned_by( seller ) ) {
            return std::nullopt;
        }
        const int price = npc_trading::trading_price( buyer, seller, line );
        if( price < 0 || !fits_trade_account( value + price ) ||
            ( merchant_buyer && !merchant_buyer->wants_to_buy( *line.first, price, seller ).success() ) ||
            ( merchant_seller && !merchant_seller->wants_to_sell( line.first, price, buyer ).success() ) ) {
            return std::nullopt;
        }
        value += price;
    }
    return static_cast<int>( value );
}
} // namespace

int npc_trading::calc_npc_owes_you( const npc &np, int your_balance )
{
    return np.will_exchange_items_freely() ? 0 : remembered_balance( np, np.op_of_u, your_balance );
}

void npc_trading::update_npc_owed( npc &np, int your_balance, int your_sale_value )
{
    np.op_of_u.owed = calc_npc_owes_you( np, your_balance );
    np.op_of_u.sold += your_sale_value;
}

bool npc_trading::trade_terms::operator==( const trade_terms &rhs ) const
{
    return std::tie( balance, owed_after, bank_change, sale_value, purchase_value,
                     owed_before, sold_before, cash_before, free_exchange ) ==
           std::tie( rhs.balance, rhs.owed_after, rhs.bank_change, rhs.sale_value,
                     rhs.purchase_value, rhs.owed_before, rhs.sold_before, rhs.cash_before,
                     rhs.free_exchange );
}

std::optional<npc_trading::trade_terms> npc_trading::quote_trade(
    const Character &player, const npc &trader, const trade_selector::select_t &sales,
    const trade_selector::select_t &purchases, int service_cost, bool use_bank )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    if( &player == &trader || !player.getID().is_valid() ||
        ( !player.is_avatar() && !player.has_native_player_control() ) ||
        player.is_dead_state() || trader.is_dead_state() || !merchant( trader ) ||
        !valid_selection( sales, purchases ) ||
        ( !trader.is_shopkeeper() && !npc_can_fit_items( trader, sales ) ) ) {
        return std::nullopt;
    }
    const std::optional<int> sale = trade_side_value( trader, player, sales );
    const std::optional<int> purchase = trade_side_value( player, trader, purchases );
    if( !sale || !purchase ) {
        return std::nullopt;
    }

    const npc_opinion &account = trader.opinion_of( player.getID() );
    trade_terms result;
    result.free_exchange = trader.will_exchange_items_freely();
    result.sale_value = *sale;
    result.purchase_value = *purchase;
    result.owed_before = account.owed;
    result.sold_before = account.sold;
    result.cash_before = player.cash;
    result.owed_after = account.owed;
    if( result.free_exchange ) {
        return result;
    }

    int64_t balance = static_cast<int64_t>( account.owed ) - service_cost + *sale - *purchase;
    if( use_bank && get_option<bool>( "CAPITALISM" ) ) {
        const int64_t bank_change = std::min( -balance, static_cast<int64_t>( std::max( 0,
            player.cash ) ) );
        if( !fits_trade_account( bank_change ) ||
            !fits_trade_account( static_cast<int64_t>( player.cash ) - bank_change ) ) {
            return std::nullopt;
        }
        result.bank_change = static_cast<int>( bank_change );
        balance += bank_change;
    }
    if( !fits_trade_account( balance ) || balance < -trader.max_credit_extended( account ) ||
        !fits_trade_account( static_cast<int64_t>( account.sold ) + *sale ) ) {
        return std::nullopt;
    }
    result.balance = static_cast<int>( balance );
    result.owed_after = remembered_balance( trader, account, result.balance );
    return result;
}

bool npc_trading::commit_trade( Character &player, npc &trader,
                                const trade_selector::select_t &sales,
                                const trade_selector::select_t &purchases,
                                int service_cost, bool use_bank, const trade_terms &confirmed,
                                std::vector<tripoint_abs_ms> *changed_tiles,
                                const std::function<void()> &after_settlement )
{
    const std::optional<trade_terms> current = quote_trade(
            player, trader, sales, purchases, service_cost, use_bank );
    if( !current || !( *current == confirmed ) ) {
        return false;
    }
    const character_action_guard player_lifetime( player );
    const character_action_guard trader_lifetime( trader );
    if( !player_lifetime || !trader_lifetime ) {
        return false;
    }
    exchange_goods( player, trader, sales, purchases, changed_tiles );
    if( !player_lifetime || !trader_lifetime ) {
        return false;
    }
    if( !current->free_exchange ) {
        npc_opinion &account = trader.opinion_of( player.getID() );
        player.cash -= current->bank_change;
        account.owed = current->owed_after;
        account.sold += current->sale_value;
    }
    if( after_settlement ) {
        after_settlement();
    }
    if( !current->free_exchange && player_lifetime ) {
        player.practice( skill_speech, current->sale_value / 10000 );
    }
    return true;
}

// Oh my aching head
// op_of_u.owed is the positive when the NPC owes the player, and negative if the player owes the
// NPC
// cost is positive when the player owes the NPC money for a service to be performed
bool npc_trading::trade( npc &np, int cost, const std::string &deal )
{
    np.shop_restock();
    //np.drop_items( np.weight_carried() - np.weight_capacity(),
    //               np.volume_carried() - np.volume_capacity() );
    np.drop_invalid_inventory();

    std::unique_ptr<trade_ui> tradeui = std::make_unique<trade_ui>( get_avatar(), np, cost, deal );
    trade_ui::trade_result_t trade_result = tradeui->perform_trade();

    if( !trade_result.traded ||
        !valid_selection( trade_result.items_you, trade_result.items_trader ) ) {
        return false;
    }

    tradeui.reset();
    avatar &player = get_avatar();
    exchange_goods( player, np, trade_result.items_you, trade_result.items_trader );
    if( !np.will_exchange_items_freely() ) {
        player.cash -= trade_result.delta_bank;
        update_npc_owed( np, trade_result.balance, trade_result.value_you );
        player.practice( skill_speech, trade_result.value_you / 10000 );
    }
    return true;
}

// Will the NPC accept the trade that's currently on offer?
bool npc_trading::npc_will_accept_trade( npc const &np, int your_balance )
{
    return np.will_exchange_items_freely() || your_balance >= -np.max_credit_extended();
}
bool npc_trading::npc_can_fit_items( npc const &np, trade_selector::select_t const &to_trade )
{
    std::vector<item> avail_pockets = np.worn.available_pockets();

    if( !to_trade.empty() && avail_pockets.empty() ) {
        return false;
    }
    for( trade_selector::entry_t const &it : to_trade ) {
        bool item_stored = false;
        item i = *it.first;
        if( i.count_by_charges() ) {
            i.charges = it.second;
        }
        for( item &pkt : avail_pockets ) {
            const units::volume pvol = pkt.max_containable_volume();
            if( pkt.can_holster( i ) || ( pkt.can_contain( i ).success() && pvol > i.volume() ) ) {
                pkt.put_in( i, pocket_type::CONTAINER );
                item_stored = true;
                break;
            }
        }
        if( !item_stored ) {
            return false;
        }
    }
    return true;
}
