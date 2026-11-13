#include "mp_npc_trade.h"

#include <algorithm>
#include <tuple>
#include <unordered_set>

#include "cata_scope_helpers.h"
#include "character.h"
#include "item.h"
#include "item_location.h"
#include "item_uid.h"
#include "json.h"
#include "map.h"
#include "npc.h"
#include "options.h"
#include "output.h"
#include "point.h"
#include "rng.h"
#include "string_formatter.h"
#include "trade_ui.h"
#include "translations.h"
#include "uilist.h"

namespace cata_mp
{

void npc_trade_row::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "uid", uid );
    out.member( "name", name );
    out.member( "available", available );
    out.member( "quantity", quantity );
    out.member( "price", price );
    out.member( "sale", sale );
    out.end_object();
}

void npc_trade_row::deserialize( const JsonObject &in )
{
    in.allow_omitted_members();
    in.read( "uid", uid, true );
    in.read( "name", name, true );
    in.read( "available", available, true );
    in.read( "quantity", quantity, true );
    in.read( "price", price, true );
    in.read( "sale", sale, true );
}

void npc_trade_prompt::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "id", id );
    out.member( "revision", revision );
    out.member( "title", title );
    out.member( "merchant", merchant );
    out.member( "status", status );
    out.member( "sale", sale );
    out.member( "previous_page", previous_page );
    out.member( "next_page", next_page );
    out.member( "bank_available", bank_available );
    out.member( "use_bank", use_bank );
    out.member( "reviewing", reviewing );
    out.member( "free_exchange", free_exchange );
    out.member( "selected", selected );
    out.member( "service_cost", service_cost );
    out.member( "balance", balance );
    out.member( "owed_after", owed_after );
    out.member( "bank_change", bank_change );
    out.member( "rows", rows );
    out.end_object();
}

void npc_trade_prompt::deserialize( const JsonObject &in )
{
    in.allow_omitted_members();
    in.read( "id", id, true );
    in.read( "revision", revision, true );
    in.read( "title", title, true );
    in.read( "merchant", merchant, true );
    in.read( "status", status, true );
    in.read( "sale", sale, true );
    in.read( "previous_page", previous_page, true );
    in.read( "next_page", next_page, true );
    in.read( "bank_available", bank_available, true );
    in.read( "use_bank", use_bank, true );
    in.read( "reviewing", reviewing, true );
    in.read( "free_exchange", free_exchange, true );
    in.read( "selected", selected, true );
    in.read( "service_cost", service_cost, true );
    in.read( "balance", balance, true );
    in.read( "owed_after", owed_after, true );
    in.read( "bank_change", bank_change, true );
    in.read( "rows", rows, true );
}

void npc_trade_choice::serialize( JsonOut &out ) const
{
    out.start_object();
    out.member( "id", id );
    out.member( "revision", revision );
    out.member( "action", action );
    out.member( "uid", uid );
    out.member( "quantity", quantity );
    out.end_object();
}

void npc_trade_choice::deserialize( const JsonObject &in )
{
    in.allow_omitted_members();
    in.read( "id", id, true );
    in.read( "revision", revision, true );
    in.read( "action", action, true );
    in.read( "uid", uid, true );
    in.read( "quantity", quantity, true );
}

namespace
{
constexpr std::size_t page_size = 48;
constexpr std::size_t max_order_lines = 256;

trade_ui::item_locations_t live_trade_locations( Character &player, npc &trader, const map &here )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    trade_ui::item_locations_t stock = trade_ui::get_item_locations( player, trader );
    const auto filter = [&]( std::vector<item_location> &locations, const Character & seller,
    bool require_player_reach ) {
        std::unordered_set<int64_t> seen;
        locations.erase( std::remove_if( locations.begin(), locations.end(),
        [&]( const item_location & loc ) {
            if( !loc || !loc->uid().is_valid() || loc->count() <= 0 ) {
                return true;
            }
            if( const Character *carrier = loc.carrier() ) {
                if( carrier != &seller ) {
                    return true;
                }
            } else {
                const tripoint_bub_ms position = loc.pos_bub( here );
                if( !here.inbounds( position ) ) {
                    return true;
                }
                if( require_player_reach ) {
                    const tripoint_bub_ms from = player.pos_bub( here );
                    if( position.z() != from.z() || rl_dist( from, position ) > 1 ||
                        ( position != from && !here.clear_path( from, position, 1, 1, 100 ) ) ) {
                        return true;
                    }
                }
            }
            return !seen.insert( loc->uid().get_value() ).second;
        } ), locations.end() );
    };
    filter( stock.you, player, true );
    filter( stock.trader, trader, false );
    return stock;
}

npc_trade_row make_row( const Character &buyer, const Character &seller,
                        const item_location &loc, int quantity, bool sale )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const int price = npc_trading::trading_price( buyer, seller, { loc, std::max( 1, quantity ) } );
    return { loc->uid().get_value(), loc->tname(), loc->count(), quantity, price, sale };
}
} // namespace

npc_trade_session::npc_trade_session( Character &player, npc &trader, const map &here, int64_t id,
                                      dialogue_trade_request request )
    : player_( player ), trader_( trader ), request_( std::move( request ) ),
      merchant_( trader.get_name() ), id_( id )
{
    if( belongs_to( player, trader, here ) ) {
        trader.shop_restock();
        if( trader_ ) {
            trader.drop_invalid_inventory();
        }
        if( belongs_to( player, trader, here ) ) {
            refresh( player, trader, here );
        }
    }
}

bool npc_trade_session::belongs_to( const Character &player, const npc &trader,
                                    const map &here ) const
{
    return player_.get() == &player && trader_.get() == &trader && &player != &trader &&
           player.has_native_player_control() && npc_trading::merchant( trader ) &&
           here.inbounds( player.pos_abs() ) && here.inbounds( trader.pos_abs() );
}

void npc_trade_session::refresh( Character &player, npc &trader, const map &here )
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const trade_ui::item_locations_t stock = live_trade_locations( player, trader, here );
    bank_available_ = get_option<bool>( "CAPITALISM" ) && !trader.will_exchange_items_freely();
    use_bank_ = use_bank_ && bank_available_;
    const auto collect = [&]( const Character & buyer, const Character & seller,
    const std::vector<item_location> &items, bool sale ) {
        auto &rows = offers_[sale];
        rows.clear();
        rows.reserve( items.size() );
        for( const item_location &loc : items ) {
            rows.push_back( make_row( buyer, seller, loc, 0, sale ) );
        }
        std::sort( rows.begin(), rows.end(), []( const npc_trade_row & lhs, const npc_trade_row & rhs ) {
            return std::tie( lhs.name, lhs.uid ) < std::tie( rhs.name, rhs.uid );
        } );
    };
    collect( trader, player, stock.you, true );
    collect( player, trader, stock.trader, false );

    // Remove unavailable selections, but never silently change a quantity.
    for( auto it = basket_.begin(); it != basket_.end(); ) {
        const auto &rows = offers_[it->first.first];
        const int64_t uid = it->first.second;
        if( std::none_of( rows.begin(), rows.end(), [&]( const npc_trade_row & row ) {
        return row.uid == uid && row.available >= it->second;
    } ) ) {
            it = basket_.erase( it );
        } else {
            ++it;
        }
    }
    page_ = 0;
}

npc_trade_prompt npc_trade_session::prompt() const
{
    npc_trade_prompt result;
    result.id = id_;
    result.revision = revision_;
    result.title = request_.title;
    result.merchant = merchant_;
    result.status = status_;
    result.sale = selling_;
    result.bank_available = bank_available_;
    result.use_bank = use_bank_;
    result.selected = static_cast<int>( basket_.size() );
    result.service_cost = request_.service_cost;
    if( quote_ ) {
        result.reviewing = true;
        result.free_exchange = quote_->terms.free_exchange;
        result.balance = quote_->terms.balance;
        result.owed_after = quote_->terms.owed_after;
        result.bank_change = quote_->terms.bank_change;
        result.rows = quote_->rows;
        return result;
    }

    const auto &rows = offers_[selling_];
    const std::size_t begin = page_ * page_size;
    const std::size_t end = std::min( begin + page_size, rows.size() );
    result.previous_page = page_ > 0;
    result.next_page = end < rows.size();
    for( std::size_t index = begin; index < end; ++index ) {
        const npc_trade_row &row = rows[index];
        result.rows.push_back( row );
        const auto found = basket_.find( { selling_, row.uid } );
        if( found != basket_.end() ) {
            result.rows.back().quantity = found->second;
        }
    }
    return result;
}

std::optional<npc_trade_session::quote> npc_trade_session::price_order(
    Character &player, npc &trader, const map &here, trade_selector::select_t &sales,
    trade_selector::select_t &purchases ) const
{
    const restore_on_out_of_scope restore_rng( rng_get_engine() );
    const trade_ui::item_locations_t stock = live_trade_locations( player, trader, here );
    quote result;
    for( const auto &[key, quantity] : basket_ ) {
        const bool sale = key.first;
        const int64_t uid = key.second;
        const auto &items = sale ? stock.you : stock.trader;
        const auto found = std::find_if( items.begin(), items.end(), [uid]( const item_location & loc ) {
            return loc->uid().get_value() == uid;
        } );
        if( found == items.end() || ( *found )->count() < quantity ) {
            return std::nullopt;
        }
        ( sale ? sales : purchases ).emplace_back( *found, quantity );
        result.rows.push_back( sale ? make_row( trader, player, *found, quantity, true ) :
                               make_row( player, trader, *found, quantity, false ) );
    }
    const auto terms = npc_trading::quote_trade( player, trader, sales, purchases,
        request_.service_cost, use_bank_ );
    if( !terms ) {
        return std::nullopt;
    }
    result.terms = *terms;
    return result;
}

bool npc_trade_session::apply( Character &player, npc &trader, const map &here,
                               const npc_trade_choice &choice, std::vector<tripoint_abs_ms> &changed_tiles )
{
    if( !belongs_to( player, trader, here ) ) {
        return false;
    }
    if( choice.id != id_ || choice.revision != revision_ ) {
        return true;
    }
    if( choice.action == "close" ) {
        return false;
    }
    if( quote_ ) {
        if( choice.action == "confirm" ) {
            const quote confirmed = *std::exchange( quote_, std::nullopt );
            ++revision_;
            trade_selector::select_t sales;
            trade_selector::select_t purchases;
            const auto current = price_order( player, trader, here, sales, purchases );
            if( request_.can_fulfill && !request_.can_fulfill() ) {
                status_ = _( "The service is no longer available." );
                return true;
            }
            const auto same_line = []( const npc_trade_row & lhs, const npc_trade_row & rhs ) {
                return lhs.uid == rhs.uid && lhs.sale == rhs.sale &&
                       lhs.quantity == rhs.quantity && lhs.price == rhs.price;
            };
            const bool same_offer = current && confirmed.terms == current->terms &&
                                    std::equal( confirmed.rows.begin(), confirmed.rows.end(),
                                                current->rows.begin(), current->rows.end(), same_line );
            if( same_offer && npc_trading::commit_trade( player, trader, sales, purchases,
            request_.service_cost, use_bank_, current->terms, &changed_tiles, [&]() {
            if( auto complete = std::exchange( request_.fulfill, std::function<void()> {} ) ) {
                    complete();
                }
            } ) ) {
                return false;
            }
            if( !belongs_to( player, trader, here ) ) {
                return false;
            }
            refresh( player, trader, here );
            status_ = _( "The trade changed. Review your offer again." );
            return true;
        }
        if( choice.action == "back" ) {
            quote_.reset();
            ++revision_;
        }
        return true;
    }

    const auto &rows = offers_[selling_];
    if( choice.action == "side" ) {
        selling_ = !selling_;
        page_ = 0;
    } else if( choice.action == "previous" && page_ > 0 ) {
        --page_;
    } else if( choice.action == "next" && ( page_ + 1 ) * page_size < rows.size() ) {
        ++page_;
    } else if( choice.action == "bank" && bank_available_ ) {
        use_bank_ = !use_bank_;
    } else if( choice.action == "refresh" ) {
        refresh( player, trader, here );
    } else if( choice.action == "adjust" ) {
        const auto begin = rows.begin() + page_ * page_size;
        const auto end = rows.begin() + std::min( ( page_ + 1 ) * page_size, rows.size() );
        const auto row = std::find_if( begin, end, [&]( const npc_trade_row & line ) {
            return line.uid == choice.uid;
        } );
        const order_key key{ selling_, choice.uid };
        if( row == end || choice.quantity < 0 || choice.quantity > row->available ||
            ( choice.quantity > 0 && basket_.size() >= max_order_lines && !basket_.count( key ) ) ) {
            return true;
        }
        if( choice.quantity == 0 ) {
            basket_.erase( key );
        } else {
            basket_[key] = choice.quantity;
        }
    } else if( choice.action == "review" &&
               ( !basket_.empty() || use_bank_ || request_.service_cost > 0 ) ) {
        if( request_.can_fulfill && !request_.can_fulfill() ) {
            status_ = _( "The service is no longer available." );
            ++revision_;
            return true;
        }
        trade_selector::select_t sales;
        trade_selector::select_t purchases;
        quote_ = price_order( player, trader, here, sales, purchases );
        if( !quote_ ) {
            refresh( player, trader, here );
            status_ = _( "The trade is unavailable. Check the items, credit, and available storage." );
            ++revision_;
            return true;
        }
    } else {
        return true;
    }
    status_.clear();
    ++revision_;
    return true;
}

std::optional<npc_trade_choice> choose_npc_trade( const npc_trade_prompt &prompt )
{
    constexpr int switch_side = -20;
    constexpr int previous = -21;
    constexpr int next = -22;
    constexpr int bank = -23;
    constexpr int refresh = -24;
    constexpr int review = -25;
    constexpr int accept = -26;
    constexpr int back = -27;
    constexpr int close = -28;

    uilist menu;
    menu.title = string_format( _( "%1$s with %2$s" ), prompt.title, prompt.merchant );
    menu.text = prompt.status;
    if( prompt.reviewing ) {
        if( !prompt.free_exchange ) {
            menu.text = string_format( _( "Trade balance: %1$s. Remaining credit: %2$s. Bank payment: %3$s." ),
                                       format_money( prompt.balance ), format_money( prompt.owed_after ),
                                       format_money( prompt.bank_change ) );
        }
        for( const npc_trade_row &row : prompt.rows ) {
            menu.addentry( -1, false, 0, row.sale ?
                           _( "Sell %1$d × %2$s (%3$s)" ) : _( "Buy %1$d × %2$s (%3$s)" ),
                           row.quantity, row.name, format_money( row.price ) );
        }
        menu.addentry( accept, true, 'a', _( "Accept trade" ) );
        menu.addentry( back, true, 'b', _( "Edit offer" ) );
    } else {
        if( prompt.service_cost > 0 ) {
            if( !menu.text.empty() ) {
                menu.text += "\n";
            }
            menu.text += string_format( _( "Service cost: %s" ), format_money( prompt.service_cost ) );
        }
        menu.addentry( switch_side, true, 's', prompt.sale ?
                       _( "Show merchant's goods" ) : _( "Show my goods" ) );
        menu.addentry( previous, prompt.previous_page, '<', _( "Previous page" ) );
        menu.addentry( next, prompt.next_page, '>', _( "Next page" ) );
        if( prompt.bank_available ) {
            menu.addentry( bank, true, 'b', prompt.use_bank ?
                           _( "Stop using bank balance" ) : _( "Use bank balance" ) );
        }
        menu.addentry( refresh, true, 'r', _( "Refresh items" ) );
        menu.addentry( review, prompt.selected > 0 || prompt.use_bank || prompt.service_cost > 0, 'a',
                       _( "Review offer (%d selections)" ), prompt.selected );
        menu.addentry( close, true, 'q', _( "Return to conversation" ) );
        for( std::size_t index = 0; index < prompt.rows.size(); ++index ) {
            const npc_trade_row &row = prompt.rows[index];
            menu.addentry( static_cast<int>( index ), true, 0,
                           _( "%1$s (%2$d of %3$d, %4$s per unit)" ), row.name,
                           row.quantity, row.available, format_money( row.price ) );
        }
    }
    menu.query();
    switch( menu.ret ) {
        case switch_side:
            return npc_trade_choice{ prompt.id, prompt.revision, "side" };
        case previous:
            return npc_trade_choice{ prompt.id, prompt.revision, "previous" };
        case next:
            return npc_trade_choice{ prompt.id, prompt.revision, "next" };
        case bank:
            return npc_trade_choice{ prompt.id, prompt.revision, "bank" };
        case refresh:
            return npc_trade_choice{ prompt.id, prompt.revision, "refresh" };
        case review:
            return npc_trade_choice{ prompt.id, prompt.revision, "review" };
        case accept:
            return npc_trade_choice{ prompt.id, prompt.revision, "confirm" };
        case back:
            return npc_trade_choice{ prompt.id, prompt.revision, "back" };
        case close:
            return npc_trade_choice{ prompt.id, prompt.revision, "close" };
        default:
            break;
    }
    if( menu.ret < 0 ) {
        return npc_trade_choice{ prompt.id, prompt.revision, prompt.reviewing ? "back" : "close" };
    }
    if( prompt.reviewing || static_cast<std::size_t>( menu.ret ) >= prompt.rows.size() ) {
        return std::nullopt;
    }
    const npc_trade_row &row = prompt.rows[menu.ret];
    int quantity = std::max( 1, row.quantity );
    if( row.available == 1 ) {
        quantity = row.quantity == 0 ? 1 : 0;
    } else if( !query_int( quantity, true, _( "%1$s: choose 0 to %2$d (0 removes it)." ), row.name,
                           row.available ) || quantity < 0 || quantity > row.available ) {
        return std::nullopt;
    }
    return npc_trade_choice{ prompt.id, prompt.revision, "adjust", row.uid, quantity };
}

} // namespace cata_mp
