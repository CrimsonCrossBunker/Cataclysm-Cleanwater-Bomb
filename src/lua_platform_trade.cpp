#if CATA_ENABLE_LUA_PLATFORM

#include "lua_platform_trade.h"

#include <character_id.h>
#include <item_uid.h>
extern "C" {
#include <lua.h>
}
#include <npc_opinion.h>
#include <cstddef>
#include <cstdint>
#include <exception>
#include <limits>
#include <memory>
#include <optional>
#include <set>
#include <stdexcept>
#include <string>
#include <string_view>
#include <unordered_map>
#include <utility>
#include <vector>

#include "calendar.h"
#include "character.h"
#include "faction.h"
#include "item.h"
#include "item_location.h"
#include "lua_platform_handle.h"
#include "lua_platform_items.h"
#include "npc.h"
#include "npctrade.h"
#include "type_id.h"

namespace cata::lua_platform
{

struct trade_quote_token::state {
    struct line {
        std::string direction;
        game_handle item;
        std::int64_t item_uid = 0;
        std::size_t item_identity_generation = 0;
        std::int64_t quantity = 0;
        std::int64_t charges = 0;
        game_handle source_holder;
        std::string source_slot;
        game_handle_locator source_holder_locator;
        game_handle destination_holder;
        std::string destination_slot;
        game_handle_locator destination_holder_locator;
        std::uint64_t source_holder_generation = 0;
        std::uint64_t destination_holder_generation = 0;
        std::int64_t unit_price = 0;
        std::int64_t total = 0;
    };

    std::uint64_t quote_id = 0;
    game_handle_runtime runtime;
    std::size_t world_generation = 0;
    game_handle seller;
    game_handle buyer;
    std::size_t seller_identity_generation = 0;
    std::size_t buyer_identity_generation = 0;
    std::uint64_t holder_mutation_generation = 0;
    std::uint64_t pricing_generation = 0;
    std::uint64_t faction_generation = 0;
    std::uint64_t debt_generation = 0;
    std::uint64_t opinion_generation = 0;
    std::int64_t issued_turn = 0;
    std::int64_t expires_turn = 0;
    std::string settlement_strategy;
    std::string currency;
    std::vector<std::string> available_settlement_modes;
    std::int64_t seller_to_buyer_total = 0;
    std::int64_t buyer_to_seller_total = 0;
    std::int64_t net = 0;
    std::int64_t tax = 0;
    std::int64_t settlement_amount = 0;
    std::int64_t buyer_cash_before = 0;
    std::int64_t seller_cash_before = 0;
    std::int64_t buyer_cash_after = 0;
    std::int64_t seller_cash_after = 0;
    std::int64_t debt_before = 0;
    std::int64_t debt_after = 0;
    std::int64_t sold_before = 0;
    std::int64_t sold_after = 0;
    bool debt_account_is_seller = false;
    bool has_debt_account = false;
    bool free_exchange = false;
    bool active = true;
    bool consumed = false;
    std::uint64_t commit_generation = 0;
    std::vector<line> lines;
};

namespace
{

constexpr std::int64_t maximum_trade_quantity = 1000000000;
constexpr std::size_t maximum_trade_quote_lines = 256;
constexpr std::int64_t default_trade_quote_expiry_turns = 10;
constexpr std::int64_t maximum_trade_quote_expiry_turns = 10000;

struct trade_holder_input {
    game_handle character;
    std::string slot;
};

struct trade_line_input {
    std::string direction;
    game_handle item;
    trade_holder_input source;
    trade_holder_input destination;
    std::int64_t quantity = 0;
};

struct trade_quote_options {
    std::string settlement_strategy;
    std::string currency;
    std::int64_t expiry_turns = default_trade_quote_expiry_turns;
};

struct trade_commit_settlement {
    std::string settlement_strategy;
    std::string currency;
};

struct trade_settlement_plan {
    std::int64_t amount = 0;
    std::int64_t buyer_cash_before = 0;
    std::int64_t seller_cash_before = 0;
    std::int64_t buyer_cash_after = 0;
    std::int64_t seller_cash_after = 0;
    std::int64_t debt_before = 0;
    std::int64_t debt_after = 0;
    std::int64_t sold_before = 0;
    std::int64_t sold_after = 0;
    bool has_debt_account = false;
    bool debt_account_is_seller = false;
    bool free_exchange = false;
};

std::unordered_map<std::uint64_t, std::shared_ptr<trade_quote_token::state>>
        trade_quote_registry;
std::uint64_t next_trade_quote_id = 1;

bool present( const sol::object &value )
{
    return value.valid() && value.get_type() != sol::type::nil;
}

void hash_trade_part( std::uint64_t &value, const std::string_view part )
{
    // FNV-1a is used only as a compact change generation.  It is never used
    // as an identity or as a substitute for the native Item/Character checks.
    for( const unsigned char byte : part ) {
        value ^= byte;
        value *= 1099511628211ULL;
    }
    value ^= 0xffU;
    value *= 1099511628211ULL;
}

template<typename T>
void hash_trade_integer( std::uint64_t &value, const T part )
{
    hash_trade_part( value, std::to_string( part ) );
}

void hash_trade_optional_double( std::uint64_t &value,
                                 const std::optional<double> &part )
{
    hash_trade_part( value, part ? std::to_string( *part ) : "none" );
}

void hash_trade_optional_int( std::uint64_t &value,
                              const std::optional<int> &part )
{
    hash_trade_part( value, part ? std::to_string( *part ) : "none" );
}

void hash_trade_faction_inputs( std::uint64_t &value, const Character &party )
{
    if( !party.is_npc() ) {
        hash_trade_part( value, "no_faction" );
        return;
    }
    const npc *entry = party.as_npc();
    if( entry == nullptr ) {
        hash_trade_part( value, "invalid_npc" );
        return;
    }
    hash_trade_part( value, entry->get_fac_id().str() );
    const faction *entry_faction = entry->get_faction();
    if( entry_faction == nullptr ) {
        hash_trade_part( value, "missing_faction" );
        return;
    }
    hash_trade_part( value, entry_faction->id.str() );
    hash_trade_part( value, entry_faction->currency.str() );
    hash_trade_integer( value, entry_faction->likes_u );
    hash_trade_integer( value, entry_faction->respects_u );
    hash_trade_integer( value, entry_faction->trusts_u );
    hash_trade_integer( value, entry_faction->wealth );
    hash_trade_integer( value, entry_faction->price_rules.size() );
    for( const faction_price_rule &rule : entry_faction->price_rules ) {
        hash_trade_part( value, rule.itype.str() );
        hash_trade_part( value, rule.item_group.str() );
        hash_trade_integer( value, rule.markup );
        hash_trade_integer( value, rule.premium );
        hash_trade_optional_double( value, rule.fixed_adj );
        hash_trade_optional_int( value, rule.price );
    }
}

void hash_trade_npc_inputs( std::uint64_t &value, const Character &party )
{
    hash_trade_part( value, party.is_npc() ? "npc" :
                     party.is_avatar() ? "avatar" : "character" );
    hash_trade_integer( value, party.get_int() );
    hash_trade_integer( value, party.get_skill_level( skill_id( "speech" ) ) );
    if( const npc *entry = party.as_npc() ) {
        hash_trade_integer( value, entry->op_of_u.trust );
        hash_trade_integer( value, entry->op_of_u.fear );
        hash_trade_integer( value, entry->op_of_u.value );
        hash_trade_integer( value, entry->op_of_u.anger );
        hash_trade_integer( value, entry->op_of_u.owed );
        hash_trade_integer( value, entry->op_of_u.sold );
        hash_trade_integer( value, entry->max_credit_extended() );
        hash_trade_integer( value, entry->max_willing_to_owe() );
        hash_trade_part( value, entry->will_exchange_items_freely() ?
                         "free" : "priced" );
        hash_trade_part( value, entry->is_shopkeeper() ?
                         "shopkeeper" : "ordinary" );
    }
    hash_trade_faction_inputs( value, party );
}

void hash_trade_opinion_inputs( std::uint64_t &value, const Character &party )
{
    const npc *entry = party.as_npc();
    if( entry == nullptr ) {
        hash_trade_part( value, "no_opinion" );
        return;
    }
    hash_trade_integer( value, entry->op_of_u.trust );
    hash_trade_integer( value, entry->op_of_u.fear );
    hash_trade_integer( value, entry->op_of_u.value );
    hash_trade_integer( value, entry->op_of_u.anger );
    hash_trade_integer( value, entry->op_of_u.sold );
}

void hash_trade_debt_inputs( std::uint64_t &value, const Character &party )
{
    const npc *entry = party.as_npc();
    if( entry == nullptr ) {
        hash_trade_part( value, "no_debt" );
        return;
    }
    hash_trade_integer( value, entry->op_of_u.owed );
    hash_trade_integer( value, entry->max_credit_extended() );
    hash_trade_integer( value, entry->max_willing_to_owe() );
}

void hash_trade_item_inputs( std::uint64_t &value, const item &entry,
                             const Character &pricing_buyer,
                             const Character &pricing_seller )
{
    hash_trade_part( value, entry.typeId().str() );
    hash_trade_integer( value, entry.uid().get_value() );
    hash_trade_integer( value, entry.charges );
    hash_trade_integer( value, entry.price( true ) );
    hash_trade_integer( value, entry.price_no_contents( true ) );
    if( const npc *party = pricing_buyer.as_npc() ) {
        if( const faction_price_rule *rule = party->get_price_rules( entry ) ) {
            hash_trade_part( value, "buyer_rule" );
            hash_trade_part( value, rule->itype.str() );
            hash_trade_part( value, rule->item_group.str() );
            hash_trade_integer( value, rule->markup );
            hash_trade_integer( value, rule->premium );
            hash_trade_optional_double( value, rule->fixed_adj );
            hash_trade_optional_int( value, rule->price );
        }
    }
    if( const npc *party = pricing_seller.as_npc() ) {
        if( const faction_price_rule *rule = party->get_price_rules( entry ) ) {
            hash_trade_part( value, "seller_rule" );
            hash_trade_part( value, rule->itype.str() );
            hash_trade_part( value, rule->item_group.str() );
            hash_trade_integer( value, rule->markup );
            hash_trade_integer( value, rule->premium );
            hash_trade_optional_double( value, rule->fixed_adj );
            hash_trade_optional_int( value, rule->price );
        }
    }
}

std::uint64_t trade_faction_generation( const Character &seller,
                                        const Character &buyer )
{
    std::uint64_t result = 1469598103934665603ULL;
    hash_trade_faction_inputs( result, seller );
    hash_trade_faction_inputs( result, buyer );
    return result;
}

std::uint64_t trade_debt_generation( const Character &seller,
                                     const Character &buyer )
{
    std::uint64_t result = 1469598103934665603ULL;
    hash_trade_debt_inputs( result, seller );
    hash_trade_debt_inputs( result, buyer );
    return result;
}

std::uint64_t trade_opinion_generation( const Character &seller,
                                        const Character &buyer )
{
    std::uint64_t result = 1469598103934665603ULL;
    hash_trade_opinion_inputs( result, seller );
    hash_trade_opinion_inputs( result, buyer );
    return result;
}

std::optional<game_handle_error> read_trade_holder(
    const sol::table &requested, const std::string_view api_name,
    trade_holder_input &result )
{
    const sol::object raw_kind = requested.raw_get<sol::object>( "kind" );
    if( !raw_kind.is<std::string>() ) {
        throw std::invalid_argument(
            std::string( api_name ) + " holder.kind must be a string" );
    }
    if( raw_kind.as<std::string>() != "character" ) {
        return game_handle_error{
            "unsupported_holder",
            "trade quote holders must be explicit Character holders"
        };
    }
    for( const auto &field : requested ) {
        if( !field.first.is<std::string>() ) {
            throw std::invalid_argument(
                std::string( api_name ) + " holder keys must be strings" );
        }
        const std::string name = field.first.as<std::string>();
        if( name != "kind" && name != "character" && name != "slot" ) {
            throw std::invalid_argument(
                std::string( api_name ) + " holder received unknown field '" +
                name + "'" );
        }
    }
    const sol::object raw_character =
        requested.raw_get<sol::object>( "character" );
    const sol::object raw_slot = requested.raw_get<sol::object>( "slot" );
    if( !raw_character.is<game_handle>() || !raw_slot.is<std::string>() ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " Character holders require character and slot" );
    }
    result.character = raw_character.as<game_handle>();
    result.slot = raw_slot.as<std::string>();
    if( result.slot != "inventory" && result.slot != "worn" &&
        result.slot != "wielded" ) {
        throw std::invalid_argument(
            std::string( api_name ) +
            " Character holder.slot must be inventory, worn, or wielded" );
    }
    return std::nullopt;
}

std::optional<game_handle_error> resolve_trade_participant(
    const game_handle &handle, const game_handle_runtime &runtime,
    const std::size_t world_generation, Character *&result )
{
    std::optional<game_handle_error> error;
    result = resolve_exact_character( handle, runtime, world_generation, error );
    if( result == nullptr ) {
        return error;
    }
    const std::string subtype = handle.subtype_name();
    if( subtype != "avatar" && subtype != "character" && subtype != "npc" ) {
        return game_handle_error{
            "wrong_subtype",
            "trade participants require an exact avatar, Character, or NPC handle"
        };
    }
    if( subtype == "avatar" && result->as_avatar() == nullptr ) {
        return game_handle_error{
            "wrong_subtype", "The trade participant is not the exact avatar subtype"
        };
    }
    if( subtype == "npc" && result->as_npc() == nullptr ) {
        return game_handle_error{
            "wrong_subtype", "The trade participant is not the exact NPC subtype"
        };
    }
    if( subtype == "character" && ( result->is_avatar() || result->is_npc() ) ) {
        return game_handle_error{
            "wrong_subtype", "The trade participant is not the exact Character subtype"
        };
    }
    if( !result->getID().is_valid() || handle.locator().stable_id <= 0 ||
        result->getID().get_value() != handle.locator().stable_id ) {
        return game_handle_error{
            "stale_identity", "The trade participant handle has no exact stable identity"
        };
    }
    return std::nullopt;
}

std::optional<game_handle_error> resolve_trade_holder(
    const trade_holder_input &holder, const game_handle_runtime &runtime,
    const std::size_t world_generation, Character *&character )
{
    return resolve_trade_participant( holder.character, runtime,
                                      world_generation, character );
}

bool trade_holder_contains_item( const Character &character, const item &entry,
                                 const std::string &slot )
{
    if( !character.has_item( entry ) ) {
        return false;
    }
    if( slot == "wielded" ) {
        return character.is_wielding( entry );
    }
    if( slot == "worn" ) {
        return character.is_worn( entry );
    }
    return !character.is_wielding( entry ) && !character.is_worn( entry ) &&
           character.parents( entry ).empty();
}

bool same_trade_locator( const game_handle_locator &lhs,
                         const game_handle_locator &rhs )
{
    return lhs.scope == rhs.scope && lhs.stable_id == rhs.stable_id &&
           lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z &&
           lhs.path == rhs.path &&
           lhs.owner_generation == rhs.owner_generation;
}

std::optional<game_handle_error> validate_trade_item_line(
    const trade_line_input &line, Character &seller, Character &buyer,
    const game_handle_runtime &runtime, const std::size_t world_generation,
    item *&resolved_item )
{
    std::optional<game_handle_error> error;
    Character *source = nullptr;
    Character *destination = nullptr;
    if( const std::optional<game_handle_error> holder_error = resolve_trade_holder(
                line.source, runtime, world_generation, source ) ) {
        return holder_error;
    }
    if( const std::optional<game_handle_error> holder_error = resolve_trade_holder(
                line.destination, runtime, world_generation, destination ) ) {
        return holder_error;
    }
    const bool seller_to_buyer = line.direction == "seller_to_buyer";
    const bool buyer_to_seller = line.direction == "buyer_to_seller";
    if( !seller_to_buyer && !buyer_to_seller ) {
        return game_handle_error{
            "invalid_direction", "trade quote direction is not supported"
        };
    }
    if( ( seller_to_buyer && ( source != &seller || destination != &buyer ) ) ||
        ( buyer_to_seller && ( source != &buyer || destination != &seller ) ) ) {
        return game_handle_error{
            "wrong_holder",
            "trade line source and destination holders do not match its direction"
        };
    }
    if( source == destination ) {
        return game_handle_error{
            "overlapping_holder", "trade line source and destination must differ"
        };
    }
    const native_handle_result<item> native_item = line.item.resolve_item(
                runtime, world_generation );
    if( !native_item ) {
        return native_item.error;
    }
    resolved_item = native_item.value;
    if( resolved_item == nullptr || resolved_item->is_null() ||
        !resolved_item->uid().is_valid() ||
        line.item.identity_generation() == 0 ) {
        return game_handle_error{
            "invalid_identity", "trade quote requires a live generation-safe Item"
        };
    }
    if( !trade_holder_contains_item( *source, *resolved_item, line.source.slot ) ) {
        return game_handle_error{
            "stale_holder", "trade quote source holder no longer owns the Item"
        };
    }
    const std::int64_t available = resolved_item->count_by_charges() ?
                                   resolved_item->charges : 1;
    if( line.quantity <= 0 || line.quantity > available ||
        ( !resolved_item->count_by_charges() && line.quantity != 1 ) ) {
        return game_handle_error{
            "invalid_quantity", "trade quote quantity is outside the exact Item bounds"
        };
    }
    if( line.quantity < available && resolved_item->is_container() &&
        !resolved_item->container_type_pockets_empty() ) {
        return game_handle_error{
            "unsupported_item",
            "partial charge quotes for containers with contents are unsupported"
        };
    }
    if( line.destination.slot != "inventory" ) {
        return game_handle_error{
            "unsupported_holder",
            "trade quote destinations must be the other Character inventory"
        };
    }
    return std::nullopt;
}

std::vector<trade_line_input> read_trade_lines( const sol::table &requested )
{
    const std::size_t count = requested.size();
    if( count == 0 || count > maximum_trade_quote_lines ) {
        throw std::invalid_argument(
            "services.trade.quote requires 1..256 dense line entries" );
    }
    for( const auto &entry : requested ) {
        if( !entry.first.is<lua_Integer>() ||
            entry.first.as<lua_Integer>() <= 0 ||
            static_cast<std::size_t>( entry.first.as<lua_Integer>() ) > count ) {
            throw std::invalid_argument(
                "services.trade.quote lines must be a dense one-based array" );
        }
    }
    std::vector<trade_line_input> result;
    result.reserve( count );
    for( std::size_t index = 1; index <= count; ++index ) {
        const sol::object raw_line = requested[static_cast<int>( index )];
        if( !raw_line.is<sol::table>() ) {
            throw std::invalid_argument(
                "services.trade.quote line entries must be tables" );
        }
        const sol::table line_table = raw_line.as<sol::table>();
        for( const auto &field : line_table ) {
            if( !field.first.is<std::string>() ) {
                throw std::invalid_argument(
                    "services.trade.quote line keys must be strings" );
            }
            const std::string name = field.first.as<std::string>();
            if( name != "direction" && name != "item" && name != "quantity" &&
                name != "source_holder" && name != "destination_holder" ) {
                throw std::invalid_argument(
                    "services.trade.quote line received unknown field '" + name + "'" );
            }
        }
        const sol::object raw_direction =
            line_table.raw_get<sol::object>( "direction" );
        const sol::object raw_item = line_table.raw_get<sol::object>( "item" );
        const sol::object raw_quantity =
            line_table.raw_get<sol::object>( "quantity" );
        const sol::object raw_source =
            line_table.raw_get<sol::object>( "source_holder" );
        const sol::object raw_destination =
            line_table.raw_get<sol::object>( "destination_holder" );
        if( !raw_direction.is<std::string>() || !raw_item.is<game_handle>() ||
            !raw_quantity.is<lua_Integer>() || !raw_source.is<sol::table>() ||
            !raw_destination.is<sol::table>() ) {
            throw std::invalid_argument(
                "services.trade.quote lines require direction, Item, quantity, and both holders" );
        }
        trade_line_input parsed;
        parsed.direction = raw_direction.as<std::string>();
        parsed.item = raw_item.as<game_handle>();
        parsed.quantity = static_cast<std::int64_t>( raw_quantity.as<lua_Integer>() );
        if( parsed.quantity <= 0 || parsed.quantity > maximum_trade_quantity ||
            parsed.quantity > std::numeric_limits<int>::max() ) {
            throw std::invalid_argument(
                "services.trade.quote line quantity is outside native bounds" );
        }
        if( const std::optional<game_handle_error> error = read_trade_holder(
                    raw_source.as<sol::table>(), "services.trade.quote", parsed.source ) ) {
            throw std::invalid_argument( error->message );
        }
        if( const std::optional<game_handle_error> error = read_trade_holder(
                    raw_destination.as<sol::table>(), "services.trade.quote",
                    parsed.destination ) ) {
            throw std::invalid_argument( error->message );
        }
        result.push_back( std::move( parsed ) );
    }
    return result;
}

trade_quote_options read_trade_quote_options( const sol::table &requested )
{
    trade_quote_options result;
    for( const auto &field : requested ) {
        if( !field.first.is<std::string>() ) {
            throw std::invalid_argument(
                "services.trade.quote options keys must be strings" );
        }
        const std::string name = field.first.as<std::string>();
        if( name != "settlement" && name != "expiry_turns" ) {
            throw std::invalid_argument(
                "services.trade.quote options received unknown field '" + name + "'" );
        }
    }
    const sol::object raw_settlement =
        requested.raw_get<sol::object>( "settlement" );
    if( !raw_settlement.is<sol::table>() ) {
        throw std::invalid_argument(
            "services.trade.quote options.settlement is required" );
    }
    const sol::table settlement = raw_settlement.as<sol::table>();
    for( const auto &field : settlement ) {
        if( !field.first.is<std::string>() ) {
            throw std::invalid_argument(
                "services.trade.quote settlement keys must be strings" );
        }
        const std::string name = field.first.as<std::string>();
        if( name != "strategy" && name != "currency" ) {
            throw std::invalid_argument(
                "services.trade.quote settlement received unknown field '" + name + "'" );
        }
    }
    const sol::object raw_strategy =
        settlement.raw_get<sol::object>( "strategy" );
    const sol::object raw_currency =
        settlement.raw_get<sol::object>( "currency" );
    if( !raw_strategy.is<std::string>() || !raw_currency.is<std::string>() ) {
        throw std::invalid_argument(
            "services.trade.quote settlement requires strategy and currency" );
    }
    result.settlement_strategy = raw_strategy.as<std::string>();
    result.currency = raw_currency.as<std::string>();
    const sol::object raw_expiry =
        requested.raw_get<sol::object>( "expiry_turns" );
    if( present( raw_expiry ) ) {
        if( !raw_expiry.is<lua_Integer>() ) {
            throw std::invalid_argument(
                "services.trade.quote options.expiry_turns must be an integer" );
        }
        result.expiry_turns = static_cast<std::int64_t>( raw_expiry.as<lua_Integer>() );
    }
    if( result.expiry_turns <= 0 ||
        result.expiry_turns > maximum_trade_quote_expiry_turns ) {
        throw std::invalid_argument(
            "services.trade.quote options.expiry_turns must be within 1..10000" );
    }
    return result;
}

trade_commit_settlement read_trade_commit_settlement( const sol::table &requested )
{
    trade_commit_settlement result;
    for( const auto &field : requested ) {
        if( !field.first.is<std::string>() ) {
            throw std::invalid_argument(
                "services.trade.commit settlement keys must be strings" );
        }
        const std::string name = field.first.as<std::string>();
        if( name != "strategy" && name != "currency" ) {
            throw std::invalid_argument(
                "services.trade.commit settlement received unknown field '" +
                name + "'" );
        }
    }
    const sol::object raw_strategy =
        requested.raw_get<sol::object>( "strategy" );
    const sol::object raw_currency =
        requested.raw_get<sol::object>( "currency" );
    if( !raw_strategy.is<std::string>() || !raw_currency.is<std::string>() ) {
        throw std::invalid_argument(
            "services.trade.commit settlement requires strategy and currency" );
    }
    result.settlement_strategy = raw_strategy.as<std::string>();
    result.currency = raw_currency.as<std::string>();
    return result;
}

std::optional<game_handle_error> prepare_trade_settlement(
    const trade_quote_options &options, Character &seller, Character &buyer,
    npc *seller_npc, npc *buyer_npc, const std::int64_t seller_to_buyer_total,
    const std::int64_t buyer_to_seller_total, const std::int64_t net,
    trade_settlement_plan &result )
{
    result = {};
    result.amount = net;
    result.buyer_cash_before = buyer.cash;
    result.seller_cash_before = seller.cash;
    result.buyer_cash_after = buyer.cash;
    result.seller_cash_after = seller.cash;
    if( seller_npc != nullptr && seller_npc->will_exchange_items_freely() ) {
        result.free_exchange = true;
    }
    if( buyer_npc != nullptr && buyer_npc->will_exchange_items_freely() ) {
        result.free_exchange = true;
    }
    if( options.currency != "cash" ) {
        return game_handle_error{
            "unsupported_currency",
            "trade quote currently supports only explicit currency 'cash'"
        };
    }
    if( options.settlement_strategy != "cash" &&
        options.settlement_strategy != "npc_debt" ) {
        return game_handle_error{
            "unsupported_settlement",
            "trade quote settlement strategy is unsupported; choose cash or npc_debt"
        };
    }
    if( options.settlement_strategy == "npc_debt" &&
        ( ( seller_npc == nullptr ) == ( buyer_npc == nullptr ) ||
          ( seller_npc == nullptr && !seller.is_avatar() ) ||
          ( buyer_npc == nullptr && !buyer.is_avatar() ) ) ) {
        return game_handle_error{
            "unsupported_settlement",
            "npc_debt requires exactly one explicit NPC and one explicit avatar"
        };
    }

    if( seller_npc != nullptr ) {
        result.has_debt_account = true;
        result.debt_account_is_seller = true;
        result.debt_before = seller_npc->op_of_u.owed;
        result.debt_after = result.debt_before;
        result.sold_before = seller_npc->op_of_u.sold;
        result.sold_after = result.sold_before;
    } else if( buyer_npc != nullptr ) {
        result.has_debt_account = true;
        result.debt_account_is_seller = false;
        result.debt_before = buyer_npc->op_of_u.owed;
        result.debt_after = result.debt_before;
        result.sold_before = buyer_npc->op_of_u.sold;
        result.sold_after = result.sold_before;
    }

    if( result.free_exchange ) {
        result.amount = 0;
        return std::nullopt;
    }

    if( options.settlement_strategy == "cash" ) {
        if( result.amount > 0 ) {
            if( result.buyer_cash_before < result.amount ) {
                return game_handle_error{
                    "insufficient_funds", "The explicit buyer lacks enough cash"
                };
            }
            result.buyer_cash_after -= result.amount;
            result.seller_cash_after += result.amount;
        } else if( result.amount < 0 ) {
            const std::int64_t due = -result.amount;
            if( result.seller_cash_before < due ) {
                return game_handle_error{
                    "insufficient_funds", "The explicit seller lacks enough cash"
                };
            }
            result.seller_cash_after -= due;
            result.buyer_cash_after += due;
        }
    } else {
        npc *account = seller_npc != nullptr ? seller_npc : buyer_npc;
        const std::int64_t desired = result.debt_before +
                                     ( account == buyer_npc ? result.amount : -result.amount );
        if( desired < std::numeric_limits<int>::min() ||
            desired > std::numeric_limits<int>::max() ) {
            return game_handle_error{
                "numeric_overflow", "The explicit NPC debt would overflow native storage"
            };
        }
        if( !npc_trading::npc_will_accept_trade( *account, static_cast<int>( desired ) ) ) {
            return game_handle_error{
                "credit_limit", "The authoritative NPC credit rule rejects this trade"
            };
        }
        const int accepted_debt = npc_trading::calc_npc_owes_you(
                                      *account, static_cast<int>( desired ) );
        if( accepted_debt != desired ) {
            return game_handle_error{
                "debt_limit", "The authoritative NPC debt rule cannot retain this quote"
            };
        }
        result.debt_after = accepted_debt;
        const std::int64_t sold_delta = account == buyer_npc ?
                                        seller_to_buyer_total : buyer_to_seller_total;
        if( sold_delta < 0 ||
            result.sold_before > std::numeric_limits<int>::max() - sold_delta ) {
            return game_handle_error{
                "numeric_overflow", "The NPC opinion sold value would overflow native storage"
            };
        }
        result.sold_after += sold_delta;
    }
    if( result.buyer_cash_after < std::numeric_limits<int>::min() ||
        result.buyer_cash_after > std::numeric_limits<int>::max() ||
        result.seller_cash_after < std::numeric_limits<int>::min() ||
        result.seller_cash_after > std::numeric_limits<int>::max() ) {
        return game_handle_error{
            "numeric_overflow", "The explicit cash settlement would overflow native storage"
        };
    }
    return std::nullopt;
}

int authoritative_trade_price( Character &pricing_buyer,
                               Character &pricing_seller, Character &source,
                               const item &entry, const int quantity )
{
    if( quantity <= 0 ||
        ( !entry.count_by_charges() && quantity != 1 ) ||
        ( entry.count_by_charges() && quantity > entry.charges ) ) {
        return 0;
    }
    // Price the exact requested quantity through a detached copy.  The live
    // source Item is never changed by a read-only quote.
    item priced_item = entry;
    priced_item.set_owner( source );
    if( priced_item.count_by_charges() ) {
        priced_item.charges = quantity;
    }
    item_location location( source, &priced_item );
    return npc_trading::trading_price(
               pricing_buyer, pricing_seller,
    { location, priced_item.count_by_charges() ? quantity : 1 } );
}

sol::table trade_error_result( sol::state_view lua,
                               const game_handle_error &error,
                               const std::optional<std::size_t> line_index = std::nullopt )
{
    sol::table result = make_game_error_result( lua, error );
    if( line_index ) {
        result["error"]["line_index"] = *line_index;
    }
    return result;
}

void retire_trade_quote( trade_quote_token::state &snapshot,
                         const bool consumed = false ) noexcept
{
    snapshot.active = false;
    if( consumed ) {
        snapshot.consumed = true;
        ++snapshot.commit_generation;
    }
    const auto registered = trade_quote_registry.find( snapshot.quote_id );
    if( registered != trade_quote_registry.end() &&
        registered->second.get() == &snapshot ) {
        trade_quote_registry.erase( registered );
    }
}

bool is_trade_commit_stale_error( const std::string_view code )
{
    return code == "stale_quote" || code == "stale_runtime" ||
           code == "stale_world" || code == "expired_quote" ||
           code == "stale_holder" || code == "stale_identity" ||
           code == "stale_participant" || code == "stale_item" ||
           code == "wrong_holder" || code == "wrong_subtype" ||
           code == "destroyed_creature" || code == "dead_creature" ||
           code == "pricing_changed" || code == "faction_changed" ||
           code == "debt_changed" || code == "opinion_changed" ||
           code == "settlement_changed" || code == "source_changed" ||
           code == "rollback_failed";
}

bool trade_settlement_matches_snapshot(
    const trade_quote_token::state &snapshot,
    const trade_settlement_plan &settlement )
{
    return settlement.amount == snapshot.settlement_amount &&
           settlement.buyer_cash_before == snapshot.buyer_cash_before &&
           settlement.seller_cash_before == snapshot.seller_cash_before &&
           settlement.buyer_cash_after == snapshot.buyer_cash_after &&
           settlement.seller_cash_after == snapshot.seller_cash_after &&
           settlement.debt_before == snapshot.debt_before &&
           settlement.debt_after == snapshot.debt_after &&
           settlement.sold_before == snapshot.sold_before &&
           settlement.sold_after == snapshot.sold_after &&
           settlement.has_debt_account == snapshot.has_debt_account &&
           settlement.debt_account_is_seller == snapshot.debt_account_is_seller &&
           settlement.free_exchange == snapshot.free_exchange;
}

sol::table trade_commit_result(
    sol::state_view lua, const trade_quote_token::state &snapshot,
    const trade_settlement_plan &settlement,
    const std::vector<platform_trade_item_result> &transfers,
    const std::uint64_t commit_generation )
{
    sol::table value = lua.create_table();
    value["committed"] = true;
    value["consumed"] = true;
    value["quote_id"] = static_cast<lua_Integer>( snapshot.quote_id );
    value["commit_generation"] = static_cast<lua_Integer>( commit_generation );
    value["settlement_strategy"] = snapshot.settlement_strategy;
    value["currency"] = snapshot.currency;
    value["settlement_amount"] = settlement.amount;
    value["debt_before"] = settlement.debt_before;
    value["debt_after"] = settlement.debt_after;
    value["sold_before"] = settlement.sold_before;
    value["sold_after"] = settlement.sold_after;
    value["buyer_cash_before"] = settlement.buyer_cash_before;
    value["seller_cash_before"] = settlement.seller_cash_before;
    value["buyer_cash_after"] = settlement.buyer_cash_after;
    value["seller_cash_after"] = settlement.seller_cash_after;

    sol::table lines = lua.create_table(
                           static_cast<int>( transfers.size() ), 0 );
    for( std::size_t index = 0; index < transfers.size(); ++index ) {
        const trade_quote_token::state::line &quoted = snapshot.lines[index];
        const platform_trade_item_result &transfer = transfers[index];
        sol::table line = lua.create_table();
        line["direction"] = quoted.direction;
        line["item_uid"] = transfer.source_uid;
        line["transferred_item_uid"] = transfer.destination_uid;
        line["quantity"] = transfer.quantity;
        line["total"] = quoted.total;
        lines[index + 1] = std::move( line );
    }
    value["lines"] = std::move( lines );
    return value;
}

sol::table trade_locator_to_lua( sol::state_view lua,
                                 const game_handle_locator &locator )
{
    sol::table result = lua.create_table();
    result["scope"] = locator.scope;
    result["stable_id"] = locator.stable_id;
    sol::table position = lua.create_table();
    position["x"] = locator.x;
    position["y"] = locator.y;
    position["z"] = locator.z;
    result["position"] = std::move( position );
    sol::table path = lua.create_table();
    for( std::size_t index = 0; index < locator.path.size(); ++index ) {
        path[index + 1] = locator.path[index];
    }
    result["path"] = std::move( path );
    return result;
}

sol::table trade_holder_to_lua( sol::state_view lua,
                                const game_handle &character,
                                const std::string &slot,
                                const game_handle_locator &locator,
                                const std::uint64_t generation )
{
    sol::table result = lua.create_table();
    result["kind"] = "character";
    result["character"] = character;
    result["slot"] = slot;
    result["locator"] = trade_locator_to_lua( lua, locator );
    result["mutation_generation"] = static_cast<lua_Integer>( generation );
    return result;
}

sol::table trade_quote_snapshot( sol::state_view lua,
                                 const trade_quote_token &token )
{
    sol::table value = lua.create_table();
    const trade_quote_token::state *snapshot_ptr = token.state_ptr();
    if( snapshot_ptr == nullptr ) {
        return value;
    }
    const trade_quote_token::state &snapshot = *snapshot_ptr;
    value["token"] = token;
    value["seller"] = snapshot.seller;
    value["buyer"] = snapshot.buyer;
    value["seller_stable_id"] = snapshot.seller.locator().stable_id;
    value["buyer_stable_id"] = snapshot.buyer.locator().stable_id;
    value["seller_identity_generation"] = static_cast<lua_Integer>(
            snapshot.seller_identity_generation );
    value["buyer_identity_generation"] = static_cast<lua_Integer>(
            snapshot.buyer_identity_generation );
    value["holder_mutation_generation"] = static_cast<lua_Integer>(
            snapshot.holder_mutation_generation );
    value["pricing_generation"] = static_cast<lua_Integer>( snapshot.pricing_generation );
    value["faction_generation"] = static_cast<lua_Integer>( snapshot.faction_generation );
    value["debt_generation"] = static_cast<lua_Integer>( snapshot.debt_generation );
    value["opinion_generation"] = static_cast<lua_Integer>( snapshot.opinion_generation );
    value["settlement_strategy"] = snapshot.settlement_strategy;
    value["currency"] = snapshot.currency;
    value["seller_to_buyer_total"] = snapshot.seller_to_buyer_total;
    value["buyer_to_seller_total"] = snapshot.buyer_to_seller_total;
    value["net"] = snapshot.net;
    value["tax"] = snapshot.tax;
    value["settlement_amount"] = snapshot.settlement_amount;
    value["debt_before"] = snapshot.has_debt_account ?
                           sol::make_object( lua, snapshot.debt_before ) :
                           sol::make_object( lua, sol::nil );
    value["debt_after"] = snapshot.has_debt_account ?
                          sol::make_object( lua, snapshot.debt_after ) :
                          sol::make_object( lua, sol::nil );
    value["sold_before"] = snapshot.has_debt_account ?
                           sol::make_object( lua, snapshot.sold_before ) :
                           sol::make_object( lua, sol::nil );
    value["sold_after"] = snapshot.has_debt_account ?
                          sol::make_object( lua, snapshot.sold_after ) :
                          sol::make_object( lua, sol::nil );
    value["buyer_cash_before"] = snapshot.buyer_cash_before;
    value["seller_cash_before"] = snapshot.seller_cash_before;
    value["buyer_cash_after"] = snapshot.buyer_cash_after;
    value["seller_cash_after"] = snapshot.seller_cash_after;
    value["free_exchange"] = snapshot.free_exchange;
    value["issued_turn"] = snapshot.issued_turn;
    value["expires_turn"] = snapshot.expires_turn;

    sol::table modes = lua.create_table();
    for( std::size_t index = 0; index < snapshot.available_settlement_modes.size();
         ++index ) {
        modes[index + 1] = snapshot.available_settlement_modes[index];
    }
    value["available_settlement_modes"] = std::move( modes );

    sol::table lines = lua.create_table(
                           static_cast<int>( snapshot.lines.size() ), 0 );
    for( std::size_t index = 0; index < snapshot.lines.size(); ++index ) {
        const trade_quote_token::state::line &line = snapshot.lines[index];
        sol::table entry = lua.create_table();
        entry["direction"] = line.direction;
        entry["item"] = line.item;
        entry["item_uid"] = line.item_uid;
        entry["item_identity_generation"] = static_cast<lua_Integer>(
                                                line.item_identity_generation );
        entry["quantity"] = line.quantity;
        entry["charges_at_quote"] = line.charges;
        entry["source_holder"] = trade_holder_to_lua(
                                     lua, line.source_holder, line.source_slot,
                                     line.source_holder_locator,
                                     line.source_holder_generation );
        entry["destination_holder"] = trade_holder_to_lua(
                                          lua, line.destination_holder,
                                          line.destination_slot,
                                          line.destination_holder_locator,
                                          line.destination_holder_generation );
        entry["source_holder_mutation_generation"] = static_cast<lua_Integer>(
                    line.source_holder_generation );
        entry["destination_holder_mutation_generation"] = static_cast<lua_Integer>(
                    line.destination_holder_generation );
        entry["unit_price"] = line.unit_price;
        entry["total"] = line.total;
        entry["tax"] = 0;
        entry["accepted"] = true;
        entry["rejection_reason"] = sol::nil;
        lines[index + 1] = std::move( entry );
    }
    value["lines"] = std::move( lines );
    value["rejection_reasons"] = lua.create_table();
    return value;
}

std::optional<game_handle_error> validate_trade_quote(
    const trade_quote_token::state &snapshot,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    const auto registered = trade_quote_registry.find( snapshot.quote_id );
    if( !snapshot.active || registered == trade_quote_registry.end() ||
        registered->second.get() != &snapshot ) {
        return game_handle_error{
            "stale_quote", "The TradeQuoteToken is no longer registered"
        };
    }
    if( !snapshot.runtime.is_active_match( runtime ) ) {
        return game_handle_error{
            "stale_runtime", "The TradeQuoteToken belongs to another runtime"
        };
    }
    if( snapshot.world_generation != world_generation ) {
        return game_handle_error{
            "stale_world", "The TradeQuoteToken belongs to another world"
        };
    }
    if( to_turn<std::int64_t>( calendar::turn ) >= snapshot.expires_turn ) {
        return game_handle_error{
            "expired_quote", "The TradeQuoteToken has passed its expiry turn"
        };
    }
    if( item_holder_mutation_generation() != snapshot.holder_mutation_generation ) {
        return game_handle_error{
            "stale_holder", "An Item holder mutation invalidated the quote"
        };
    }

    Character *seller = nullptr;
    Character *buyer = nullptr;
    if( const std::optional<game_handle_error> error = resolve_trade_participant(
                snapshot.seller, runtime, world_generation, seller ) ) {
        return error;
    }
    if( const std::optional<game_handle_error> error = resolve_trade_participant(
                snapshot.buyer, runtime, world_generation, buyer ) ) {
        return error;
    }
    if( seller == buyer ||
        seller->getID().get_value() != snapshot.seller.locator().stable_id ||
        buyer->getID().get_value() != snapshot.buyer.locator().stable_id ||
        snapshot.seller.identity_generation() != snapshot.seller_identity_generation ||
        snapshot.buyer.identity_generation() != snapshot.buyer_identity_generation ||
        seller->is_dead_state() || buyer->is_dead_state() ||
        ( seller->as_npc() != nullptr && seller->as_npc()->is_dead() ) ||
        ( buyer->as_npc() != nullptr && buyer->as_npc()->is_dead() ) ) {
        return game_handle_error{
            "stale_participant", "A quoted trade participant changed identity"
        };
    }

    std::vector<item *> items;
    items.reserve( snapshot.lines.size() );
    std::set<std::int64_t> seen_uids;
    std::int64_t seller_to_buyer_total = 0;
    std::int64_t buyer_to_seller_total = 0;
    std::uint64_t pricing_generation = 1469598103934665603ULL;
    hash_trade_npc_inputs( pricing_generation, *seller );
    hash_trade_npc_inputs( pricing_generation, *buyer );
    for( const trade_quote_token::state::line &line : snapshot.lines ) {
        const game_handle &expected_source =
            line.direction == "seller_to_buyer" ? snapshot.seller : snapshot.buyer;
        const game_handle &expected_destination =
            line.direction == "seller_to_buyer" ? snapshot.buyer : snapshot.seller;
        if( line.source_holder_generation != snapshot.holder_mutation_generation ||
            line.destination_holder_generation != snapshot.holder_mutation_generation ||
            !same_trade_locator( line.source_holder.locator(),
                                 expected_source.locator() ) ||
            !same_trade_locator( line.destination_holder.locator(),
                                 expected_destination.locator() ) ||
            line.source_holder.identity_generation() !=
            expected_source.identity_generation() ||
            line.destination_holder.identity_generation() !=
            expected_destination.identity_generation() ||
            ( line.source_slot != "inventory" &&
              line.source_slot != "worn" &&
              line.source_slot != "wielded" ) ||
            line.destination_slot != "inventory" ) {
            return game_handle_error{
                "stale_holder", "A quoted trade holder is not the canonical participant holder"
            };
        }
        if( !same_trade_locator( line.source_holder.locator(),
                                 line.source_holder_locator ) ||
            !same_trade_locator( line.destination_holder.locator(),
                                 line.destination_holder_locator ) ) {
            return game_handle_error{
                "stale_holder", "A quoted holder locator changed"
            };
        }
        const native_handle_result<item> resolved = line.item.resolve_item(
                    runtime, world_generation );
        if( !resolved ) {
            return resolved.error;
        }
        if( resolved.value == nullptr ||
            resolved.value->uid().get_value() != line.item_uid ||
            line.item.identity_generation() != line.item_identity_generation ||
            ( resolved.value->count_by_charges() ? resolved.value->charges : 1 ) !=
            line.charges || !seen_uids.insert( line.item_uid ).second ) {
            return game_handle_error{
                "stale_item", "A quoted Item UID, generation, or charges changed"
            };
        }
        trade_line_input input;
        input.direction = line.direction;
        input.item = line.item;
        input.source.character = line.source_holder;
        input.source.slot = line.source_slot;
        input.destination.character = line.destination_holder;
        input.destination.slot = line.destination_slot;
        input.quantity = line.quantity;
        if( input.quantity <= 0 ) {
            return game_handle_error{
                "invalid_quote", "The quoted line has no exact quantity"
            };
        }
        item *resolved_item = resolved.value;
        if( const std::optional<game_handle_error> error = validate_trade_item_line(
                    input, *seller, *buyer, runtime, world_generation, resolved_item ) ) {
            return error;
        }
        Character *pricing_buyer = line.direction == "seller_to_buyer" ? buyer : seller;
        Character *pricing_seller = line.direction == "seller_to_buyer" ? seller : buyer;
        const int unit_price = authoritative_trade_price(
                                   *pricing_buyer, *pricing_seller,
                                   line.direction == "seller_to_buyer" ? *seller : *buyer,
                                   *resolved_item, 1 );
        const int total_price = authoritative_trade_price(
                                    *pricing_buyer, *pricing_seller,
                                    line.direction == "seller_to_buyer" ? *seller : *buyer,
                                    *resolved_item, static_cast<int>( input.quantity ) );
        if( unit_price != line.unit_price || total_price != line.total ||
            unit_price <= 0 || total_price <= 0 ) {
            return game_handle_error{
                "price_changed", "The authoritative trade price or permission changed"
            };
        }
        hash_trade_part( pricing_generation, line.direction );
        hash_trade_integer( pricing_generation, input.quantity );
        hash_trade_integer( pricing_generation, unit_price );
        hash_trade_integer( pricing_generation, total_price );
        hash_trade_item_inputs( pricing_generation, *resolved_item,
                                *pricing_buyer, *pricing_seller );
        items.push_back( resolved_item );
        if( line.direction == "seller_to_buyer" ) {
            seller_to_buyer_total += total_price;
        } else {
            buyer_to_seller_total += total_price;
        }
    }
    const std::int64_t net = seller_to_buyer_total - buyer_to_seller_total;
    if( pricing_generation != snapshot.pricing_generation ) {
        return game_handle_error{
            "pricing_changed", "The quoted pricing inputs changed"
        };
    }
    if( trade_faction_generation( *seller, *buyer ) != snapshot.faction_generation ) {
        return game_handle_error{
            "faction_changed", "The quoted faction pricing inputs changed"
        };
    }
    if( trade_debt_generation( *seller, *buyer ) != snapshot.debt_generation ) {
        return game_handle_error{
            "debt_changed", "The quoted debt inputs changed"
        };
    }
    if( trade_opinion_generation( *seller, *buyer ) != snapshot.opinion_generation ) {
        return game_handle_error{
            "opinion_changed", "The quoted NPC opinion inputs changed"
        };
    }

    trade_quote_options options;
    options.settlement_strategy = snapshot.settlement_strategy;
    options.currency = snapshot.currency;
    trade_settlement_plan settlement;
    if( const std::optional<game_handle_error> error = prepare_trade_settlement(
                options, *seller, *buyer, seller->as_npc(), buyer->as_npc(),
                seller_to_buyer_total, buyer_to_seller_total, net, settlement ) ) {
        return error;
    }
    if( settlement.amount != snapshot.settlement_amount ||
        settlement.buyer_cash_before != snapshot.buyer_cash_before ||
        settlement.seller_cash_before != snapshot.seller_cash_before ||
        settlement.buyer_cash_after != snapshot.buyer_cash_after ||
        settlement.seller_cash_after != snapshot.seller_cash_after ||
        settlement.debt_before != snapshot.debt_before ||
        settlement.debt_after != snapshot.debt_after ||
        settlement.sold_before != snapshot.sold_before ||
        settlement.sold_after != snapshot.sold_after ||
        settlement.has_debt_account != snapshot.has_debt_account ||
        settlement.debt_account_is_seller != snapshot.debt_account_is_seller ||
        settlement.free_exchange != snapshot.free_exchange ) {
        return game_handle_error{
            "settlement_changed", "The quoted settlement inputs changed"
        };
    }
    return std::nullopt;
}

sol::table commit_trade(
    sol::this_state lua, const trade_quote_token &token,
    const sol::table &requested_settlement,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    sol::state_view state( lua );
    const trade_quote_token::state *snapshot = token.state_ptr();
    if( snapshot == nullptr ) {
        return make_game_error_result( state, {
            "invalid_quote", "The TradeQuoteToken is empty"
        } );
    }
    if( snapshot->consumed ) {
        return make_game_error_result( state, {
            "consumed_quote", "The TradeQuoteToken has already been committed"
        } );
    }

    const trade_commit_settlement requested = read_trade_commit_settlement(
                requested_settlement );
    if( requested.settlement_strategy != "npc_debt" ) {
        return make_game_error_result( state, {
            "unsupported_settlement",
            "trade commit currently supports only explicit npc_debt settlement"
        } );
    }
    if( requested.currency != "cash" || snapshot->currency != "cash" ) {
        return make_game_error_result( state, {
            "unsupported_currency",
            "trade commit currently supports only explicit currency cash"
        } );
    }
    if( snapshot->settlement_strategy != "npc_debt" ||
        requested.currency != snapshot->currency ) {
        return make_game_error_result( state, {
            "settlement_changed",
            "The requested settlement does not match the quoted debt settlement"
        } );
    }

    const auto validation_failure = [&state, snapshot](
    const game_handle_error & error ) {
        if( is_trade_commit_stale_error( error.code ) ) {
            retire_trade_quote( *const_cast<trade_quote_token::state *>( snapshot ) );
        }
        return make_game_error_result( state, error );
    };
    if( const std::optional<game_handle_error> error = validate_trade_quote(
                *snapshot, runtime, world_generation ) ) {
        return validation_failure( *error );
    }

    Character *seller = nullptr;
    if( const std::optional<game_handle_error> error = resolve_trade_participant(
                snapshot->seller, runtime, world_generation, seller ) ) {
        return validation_failure( *error );
    }
    Character *buyer = nullptr;
    if( const std::optional<game_handle_error> error = resolve_trade_participant(
                snapshot->buyer, runtime, world_generation, buyer ) ) {
        return validation_failure( *error );
    }
    npc *seller_npc = seller->as_npc();
    npc *buyer_npc = buyer->as_npc();
    if( ( seller_npc == nullptr ) == ( buyer_npc == nullptr ) ||
        ( seller_npc == nullptr && !seller->is_avatar() ) ||
        ( buyer_npc == nullptr && !buyer->is_avatar() ) ) {
        return make_game_error_result( state, {
            "unsupported_participants",
            "npc_debt requires exactly one explicit avatar and one explicit NPC"
        } );
    }

    trade_quote_options options;
    options.settlement_strategy = "npc_debt";
    options.currency = snapshot->currency;
    trade_settlement_plan settlement;
    if( const std::optional<game_handle_error> error = prepare_trade_settlement(
                options, *seller, *buyer, seller_npc, buyer_npc,
                snapshot->seller_to_buyer_total,
                snapshot->buyer_to_seller_total, snapshot->net, settlement ) ) {
        return validation_failure( *error );
    }
    if( !trade_settlement_matches_snapshot( *snapshot, settlement ) ) {
        return validation_failure( {
            "settlement_changed", "The quoted debt settlement inputs changed"
        } );
    }

    std::vector<platform_trade_item_request> requests;
    requests.reserve( snapshot->lines.size() );
    for( const trade_quote_token::state::line &line : snapshot->lines ) {
        if( line.destination_slot != "inventory" ||
            ( line.source_slot != "inventory" &&
              line.source_slot != "worn" &&
              line.source_slot != "wielded" ) ) {
            return make_game_error_result( state, {
                "unsupported_holder",
                "trade commit supports Character inventory, worn, or wielded sources and inventory destinations only"
            } );
        }
        platform_trade_item_request request;
        request.item_handle = line.item;
        request.source_holder.character = line.source_holder;
        request.source_holder.slot = line.source_slot;
        request.destination_holder.character = line.destination_holder;
        request.destination_holder.slot = line.destination_slot;
        request.quantity = line.quantity;
        requests.push_back( std::move( request ) );
    }

    std::vector<platform_trade_item_result> transfers;
    platform_item_transaction item_transaction;
    if( const std::optional<game_handle_error> error = stage_platform_trade_items(
                requests, runtime, world_generation,
                snapshot->holder_mutation_generation, transfers,
                item_transaction ) ) {
        if( is_trade_commit_stale_error( error->code ) ||
            item_holder_mutation_generation() != snapshot->holder_mutation_generation ) {
            retire_trade_quote( *const_cast<trade_quote_token::state *>( snapshot ) );
        }
        return make_game_error_result( state, *error );
    }
    if( transfers.size() != snapshot->lines.size() ) {
        const bool restored = item_transaction.rollback_now();
        retire_trade_quote( *const_cast<trade_quote_token::state *>( snapshot ) );
        return make_game_error_result( state, {
            "rollback_failed",
            restored ? "trade transaction produced an incomplete transfer result"
            : "trade transaction produced an incomplete result and rollback failed"
        } );
    }

    if( item_holder_mutation_generation() !=
        snapshot->holder_mutation_generation + 1 ) {
        const bool restored = item_transaction.rollback_now();
        retire_trade_quote( *const_cast<trade_quote_token::state *>( snapshot ) );
        return make_game_error_result( state, {
            restored ? "stale_holder" : "rollback_failed",
            restored ? "An Item holder mutation changed during trade staging"
            : "trade Item staging changed the holder epoch and rollback failed"
        } );
    }

    const auto rollback_after_item_stage = [&state, snapshot, &item_transaction](
    const game_handle_error & error ) {
        const bool restored = item_transaction.rollback_now();
        if( !restored ) {
            retire_trade_quote( *const_cast<trade_quote_token::state *>( snapshot ) );
            return make_game_error_result( state, {
                "rollback_failed",
                "trade settlement validation failed and Item rollback failed"
            } );
        }
        if( is_trade_commit_stale_error( error.code ) ) {
            retire_trade_quote( *const_cast<trade_quote_token::state *>( snapshot ) );
        }
        return make_game_error_result( state, error );
    };

    if( item_holder_mutation_generation() !=
        snapshot->holder_mutation_generation + 1 ) {
        return rollback_after_item_stage( {
            "stale_holder", "An Item holder mutation changed after trade staging"
        } );
    }

    Character *post_seller = nullptr;
    if( const std::optional<game_handle_error> error = resolve_trade_participant(
                snapshot->seller, runtime, world_generation, post_seller ) ) {
        return rollback_after_item_stage( *error );
    }
    Character *post_buyer = nullptr;
    if( const std::optional<game_handle_error> error = resolve_trade_participant(
                snapshot->buyer, runtime, world_generation, post_buyer ) ) {
        return rollback_after_item_stage( *error );
    }
    if( post_seller == nullptr || post_buyer == nullptr ||
        post_seller != seller || post_buyer != buyer ||
        post_seller->getID().get_value() != snapshot->seller.locator().stable_id ||
        post_buyer->getID().get_value() != snapshot->buyer.locator().stable_id ||
        post_seller->is_dead_state() || post_buyer->is_dead_state() ||
        ( post_seller->as_npc() != nullptr && post_seller->as_npc()->is_dead() ) ||
        ( post_buyer->as_npc() != nullptr && post_buyer->as_npc()->is_dead() ) ) {
        return rollback_after_item_stage( {
            "stale_participant", "A trade participant changed during Item commit"
        } );
    }
    if( trade_faction_generation( *post_seller, *post_buyer ) !=
        snapshot->faction_generation ) {
        return rollback_after_item_stage( {
            "faction_changed", "The quoted faction pricing inputs changed"
        } );
    }
    if( trade_debt_generation( *post_seller, *post_buyer ) !=
        snapshot->debt_generation ) {
        return rollback_after_item_stage( {
            "debt_changed", "The quoted debt inputs changed during Item commit"
        } );
    }
    if( trade_opinion_generation( *post_seller, *post_buyer ) !=
        snapshot->opinion_generation ) {
        return rollback_after_item_stage( {
            "opinion_changed", "The quoted NPC opinion inputs changed during Item commit"
        } );
    }

    seller_npc = post_seller->as_npc();
    buyer_npc = post_buyer->as_npc();
    trade_settlement_plan post_settlement;
    if( const std::optional<game_handle_error> error = prepare_trade_settlement(
                options, *post_seller, *post_buyer, seller_npc, buyer_npc,
                snapshot->seller_to_buyer_total,
                snapshot->buyer_to_seller_total, snapshot->net, post_settlement ) ) {
        return rollback_after_item_stage( *error );
    }
    if( !trade_settlement_matches_snapshot( *snapshot, post_settlement ) ) {
        return rollback_after_item_stage( {
            "settlement_changed", "The quoted debt settlement changed during Item commit"
        } );
    }

    npc *account = seller_npc != nullptr ? seller_npc : buyer_npc;
    if( account == nullptr || account->op_of_u.owed != post_settlement.debt_before ||
        account->op_of_u.sold != post_settlement.sold_before ) {
        return rollback_after_item_stage( {
            "debt_changed", "The NPC debt account changed before settlement publish"
        } );
    }

    if( post_settlement.debt_after < std::numeric_limits<int>::min() ||
        post_settlement.debt_after > std::numeric_limits<int>::max() ||
        !npc_trading::npc_will_accept_trade(
            *account, static_cast<int>( post_settlement.debt_after ) ) ||
        npc_trading::calc_npc_owes_you(
            *account, static_cast<int>( post_settlement.debt_after ) ) !=
        post_settlement.debt_after ) {
        return rollback_after_item_stage( {
            "credit_limit", "The authoritative NPC debt rule rejected the new owed value"
        } );
    }

    if( snapshot->commit_generation == std::numeric_limits<std::uint64_t>::max() ) {
        return rollback_after_item_stage( {
            "rollback_failed", "The trade commit generation would overflow"
        } );
    }

    const std::uint64_t next_commit_generation = snapshot->commit_generation + 1;
    sol::table committed_value;
    try {
        committed_value = trade_commit_result(
                              state, *snapshot, post_settlement, transfers,
                              next_commit_generation );
    } catch( const std::exception &exception ) {
        return rollback_after_item_stage( {
            "rollback_failed", std::string( "The trade commit result could not be prepared: " ) +
            exception.what()
        } );
    }

    const npc_opinion previous_opinion = account->op_of_u;
    account->op_of_u.owed = static_cast<int>( post_settlement.debt_after );
    account->op_of_u.sold = static_cast<int>( post_settlement.sold_after );
    if( account->op_of_u.owed != post_settlement.debt_after ||
        account->op_of_u.sold != post_settlement.sold_after ) {
        account->op_of_u = previous_opinion;
        return rollback_after_item_stage( {
            "settlement_publish_failed", "The NPC debt settlement could not be published"
        } );
    }

    item_transaction.commit();
    retire_trade_quote( *const_cast<trade_quote_token::state *>( snapshot ), true );
    return make_game_value_result(
               state, sol::make_object( state, std::move( committed_value ) ) );
}

sol::table quote_trade(
    sol::this_state lua, const game_handle &seller_handle,
    const game_handle &buyer_handle, const sol::table &requested_lines,
    const sol::table &requested_options,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    sol::state_view state( lua );
    const trade_quote_options options = read_trade_quote_options( requested_options );
    std::optional<game_handle_error> error;
    Character *seller = nullptr;
    Character *buyer = nullptr;
    if( const std::optional<game_handle_error> participant_error =
            resolve_trade_participant( seller_handle, runtime, world_generation, seller ) ) {
        return make_game_error_result( state, *participant_error );
    }
    if( const std::optional<game_handle_error> participant_error =
            resolve_trade_participant( buyer_handle, runtime, world_generation, buyer ) ) {
        return make_game_error_result( state, *participant_error );
    }
    if( seller == buyer ) {
        return trade_error_result( state, {
            "same_participant", "trade quote seller and buyer must differ"
        } );
    }
    if( seller->as_npc() == nullptr && buyer->as_npc() == nullptr ) {
        return trade_error_result( state, {
            "unsupported_pricing",
            "authoritative NPC pricing requires an explicit NPC participant"
        } );
    }
    const std::vector<trade_line_input> input_lines = read_trade_lines( requested_lines );
    auto snapshot = std::make_shared<trade_quote_token::state>();
    snapshot->runtime = runtime;
    snapshot->world_generation = world_generation;
    snapshot->seller = seller_handle;
    snapshot->buyer = buyer_handle;
    snapshot->seller_identity_generation = seller_handle.identity_generation();
    snapshot->buyer_identity_generation = buyer_handle.identity_generation();
    snapshot->holder_mutation_generation = item_holder_mutation_generation();
    snapshot->settlement_strategy = options.settlement_strategy;
    snapshot->currency = options.currency;
    snapshot->issued_turn = to_turn<std::int64_t>( calendar::turn );
    snapshot->expires_turn = snapshot->issued_turn + options.expiry_turns;
    snapshot->tax = 0;
    snapshot->available_settlement_modes.push_back( "cash" );
    if( ( seller->as_npc() == nullptr ) != ( buyer->as_npc() == nullptr ) &&
        ( seller->is_avatar() || buyer->is_avatar() ) ) {
        snapshot->available_settlement_modes.push_back( "npc_debt" );
    }

    std::set<std::int64_t> seen_uids;
    std::uint64_t pricing_generation = 1469598103934665603ULL;
    hash_trade_npc_inputs( pricing_generation, *seller );
    hash_trade_npc_inputs( pricing_generation, *buyer );
    for( std::size_t index = 0; index < input_lines.size(); ++index ) {
        const trade_line_input &input = input_lines[index];
        item *entry = nullptr;
        if( const std::optional<game_handle_error> line_error = validate_trade_item_line(
                    input, *seller, *buyer, runtime, world_generation, entry ) ) {
            return trade_error_result( state, *line_error, index + 1 );
        }
        if( !seen_uids.insert( entry->uid().get_value() ).second ) {
            return trade_error_result( state, {
                "duplicate_item", "trade quote lines cannot overlap the same Item UID"
            }, index + 1 );
        }
        Character *pricing_buyer = input.direction == "seller_to_buyer" ? buyer : seller;
        Character *pricing_seller = input.direction == "seller_to_buyer" ? seller : buyer;
        Character &source = input.direction == "seller_to_buyer" ? *seller : *buyer;
        const int unit_price = authoritative_trade_price(
                                   *pricing_buyer, *pricing_seller, source, *entry, 1 );
        const int total_price = authoritative_trade_price(
                                    *pricing_buyer, *pricing_seller, source, *entry,
                                    static_cast<int>( input.quantity ) );
        if( unit_price <= 0 || total_price <= 0 ) {
            return trade_error_result( state, {
                "trade_refused",
                "The authoritative NPC permission or price rule rejected this Item"
            }, index + 1 );
        }
        trade_quote_token::state::line line;
        line.direction = input.direction;
        line.item = input.item;
        line.item_uid = entry->uid().get_value();
        line.item_identity_generation = input.item.identity_generation();
        line.quantity = input.quantity;
        line.charges = entry->count_by_charges() ? entry->charges : 1;
        line.source_holder = input.source.character;
        line.source_slot = input.source.slot;
        line.source_holder_locator = input.source.character.locator();
        line.destination_holder = input.destination.character;
        line.destination_slot = input.destination.slot;
        line.destination_holder_locator = input.destination.character.locator();
        line.source_holder_generation = snapshot->holder_mutation_generation;
        line.destination_holder_generation = snapshot->holder_mutation_generation;
        line.unit_price = unit_price;
        line.total = total_price;
        snapshot->lines.push_back( std::move( line ) );
        hash_trade_part( pricing_generation, input.direction );
        hash_trade_integer( pricing_generation, input.quantity );
        hash_trade_integer( pricing_generation, unit_price );
        hash_trade_integer( pricing_generation, total_price );
        hash_trade_item_inputs( pricing_generation, *entry,
                                *pricing_buyer, *pricing_seller );
        if( input.direction == "seller_to_buyer" ) {
            snapshot->seller_to_buyer_total += total_price;
        } else {
            snapshot->buyer_to_seller_total += total_price;
        }
    }
    snapshot->net = snapshot->seller_to_buyer_total - snapshot->buyer_to_seller_total;
    snapshot->pricing_generation = pricing_generation;
    snapshot->faction_generation = trade_faction_generation( *seller, *buyer );
    snapshot->debt_generation = trade_debt_generation( *seller, *buyer );
    snapshot->opinion_generation = trade_opinion_generation( *seller, *buyer );

    trade_settlement_plan settlement;
    if( const std::optional<game_handle_error> settlement_error = prepare_trade_settlement(
                options, *seller, *buyer, seller->as_npc(), buyer->as_npc(),
                snapshot->seller_to_buyer_total, snapshot->buyer_to_seller_total,
                snapshot->net, settlement ) ) {
        return make_game_error_result( state, *settlement_error );
    }
    snapshot->settlement_amount = settlement.amount;
    snapshot->buyer_cash_before = settlement.buyer_cash_before;
    snapshot->seller_cash_before = settlement.seller_cash_before;
    snapshot->buyer_cash_after = settlement.buyer_cash_after;
    snapshot->seller_cash_after = settlement.seller_cash_after;
    snapshot->debt_before = settlement.debt_before;
    snapshot->debt_after = settlement.debt_after;
    snapshot->sold_before = settlement.sold_before;
    snapshot->sold_after = settlement.sold_after;
    snapshot->debt_account_is_seller = settlement.debt_account_is_seller;
    snapshot->has_debt_account = settlement.has_debt_account;
    snapshot->free_exchange = settlement.free_exchange;

    if( next_trade_quote_id == 0 ) {
        return trade_error_result( state, {
            "quote_registry_exhausted", "The trade quote registry is exhausted"
        } );
    }
    snapshot->quote_id = next_trade_quote_id++;
    trade_quote_registry.emplace( snapshot->quote_id, snapshot );
    const trade_quote_token token( std::move( snapshot ) );
    return make_game_value_result(
               state, sol::make_object( state, trade_quote_snapshot( state, token ) ) );
}

sol::table get_trade_quote(
    sol::this_state lua, const trade_quote_token &token,
    const game_handle_runtime &runtime, const std::size_t world_generation )
{
    sol::state_view state( lua );
    const trade_quote_token::state *snapshot = token.state_ptr();
    if( snapshot == nullptr ) {
        return make_game_error_result( state, {
            "invalid_quote", "The TradeQuoteToken is empty"
        } );
    }
    if( const std::optional<game_handle_error> error = validate_trade_quote(
                *snapshot, runtime, world_generation ) ) {
        return make_game_error_result( state, *error );
    }
    return make_game_value_result(
               state, sol::make_object( state, trade_quote_snapshot( state, token ) ) );
}

} // namespace

trade_quote_token::trade_quote_token( std::shared_ptr<state> value ) :
    state_( std::move( value ) )
{
}

std::uint64_t trade_quote_token::quote_id() const noexcept
{
    return state_ ? state_->quote_id : 0;
}

std::size_t trade_quote_token::runtime_generation() const noexcept
{
    return state_ ? state_->runtime.generation() : 0;
}

std::size_t trade_quote_token::world_generation() const noexcept
{
    return state_ ? state_->world_generation : 0;
}

std::int64_t trade_quote_token::seller_stable_id() const noexcept
{
    return state_ ? state_->seller.locator().stable_id : 0;
}

std::int64_t trade_quote_token::buyer_stable_id() const noexcept
{
    return state_ ? state_->buyer.locator().stable_id : 0;
}

std::size_t trade_quote_token::seller_identity_generation() const noexcept
{
    return state_ ? state_->seller_identity_generation : 0;
}

std::size_t trade_quote_token::buyer_identity_generation() const noexcept
{
    return state_ ? state_->buyer_identity_generation : 0;
}

std::uint64_t trade_quote_token::holder_mutation_generation() const noexcept
{
    return state_ ? state_->holder_mutation_generation : 0;
}

std::uint64_t trade_quote_token::pricing_generation() const noexcept
{
    return state_ ? state_->pricing_generation : 0;
}

std::uint64_t trade_quote_token::faction_generation() const noexcept
{
    return state_ ? state_->faction_generation : 0;
}

std::uint64_t trade_quote_token::debt_generation() const noexcept
{
    return state_ ? state_->debt_generation : 0;
}

std::uint64_t trade_quote_token::opinion_generation() const noexcept
{
    return state_ ? state_->opinion_generation : 0;
}

std::int64_t trade_quote_token::issued_turn() const noexcept
{
    return state_ ? state_->issued_turn : 0;
}

std::int64_t trade_quote_token::expires_turn() const noexcept
{
    return state_ ? state_->expires_turn : 0;
}

bool trade_quote_token::registered() const noexcept
{
    if( !state_ || !state_->active ) {
        return false;
    }
    const auto found = trade_quote_registry.find( state_->quote_id );
    return found != trade_quote_registry.end() &&
           found->second.get() == state_.get();
}

std::string trade_quote_token::to_string() const
{
    return "TradeQuoteToken<" + std::to_string( quote_id() ) + ">";
}

const trade_quote_token::state *trade_quote_token::state_ptr() const noexcept
{
    return state_.get();
}

bool operator==( const trade_quote_token &lhs,
                 const trade_quote_token &rhs ) noexcept
{
    return lhs.state_ == rhs.state_;
}

void retire_trade_quote_registry() noexcept
{
    for( const auto &entry : trade_quote_registry ) {
        if( entry.second ) {
            entry.second->active = false;
        }
    }
    trade_quote_registry.clear();
}

void install_trade_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write )
{
    sol::state_view lua( services.lua_state() );
    lua.new_usertype<trade_quote_token>(
        "TradeQuoteToken", sol::no_constructor,
        "quote_id", sol::property( &trade_quote_token::quote_id ),
        "runtime_generation",
        sol::property( &trade_quote_token::runtime_generation ),
        "world_generation",
        sol::property( &trade_quote_token::world_generation ),
        "seller_stable_id",
        sol::property( &trade_quote_token::seller_stable_id ),
        "buyer_stable_id",
        sol::property( &trade_quote_token::buyer_stable_id ),
        "seller_identity_generation",
        sol::property( &trade_quote_token::seller_identity_generation ),
        "buyer_identity_generation",
        sol::property( &trade_quote_token::buyer_identity_generation ),
        "holder_mutation_generation",
        sol::property( &trade_quote_token::holder_mutation_generation ),
        "pricing_generation",
        sol::property( &trade_quote_token::pricing_generation ),
        "faction_generation",
        sol::property( &trade_quote_token::faction_generation ),
        "debt_generation",
        sol::property( &trade_quote_token::debt_generation ),
        "opinion_generation",
        sol::property( &trade_quote_token::opinion_generation ),
        "issued_turn", sol::property( &trade_quote_token::issued_turn ),
        "expires_turn", sol::property( &trade_quote_token::expires_turn ),
        "registered", sol::property( &trade_quote_token::registered ),
        "is_valid",
        [current_runtime_generation, current_world_generation, require_read](
    const trade_quote_token & token ) {
        require_read();
        const trade_quote_token::state *snapshot = token.state_ptr();
        return snapshot != nullptr &&
               !validate_trade_quote( *snapshot, current_runtime_generation(),
                                      current_world_generation() );
    },
    sol::meta_function::to_string,
    &trade_quote_token::to_string,
    sol::meta_function::equal_to,
    []( const trade_quote_token & lhs, const trade_quote_token & rhs ) {
        return lhs == rhs;
    } );
    sol::table trade = lua.create_table();
    trade.set_function(
        "quote",
        [current_runtime_generation,
         current_world_generation, require_read](
            sol::this_state state,
            const game_handle & seller,
            const game_handle & buyer,
            const sol::table & lines,
    const sol::table & options ) {
        require_read();
        return quote_trade(
                   state, seller, buyer, lines, options,
                   current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "get",
        [current_runtime_generation,
         current_world_generation, require_read](
            sol::this_state state,
    const trade_quote_token & token ) {
        require_read();
        return get_trade_quote(
                   state, token, current_runtime_generation(),
                   current_world_generation() );
    } );
    trade.set_function(
        "commit",
        [current_runtime_generation,
         current_world_generation, require_write](
            sol::this_state state,
            const trade_quote_token & token,
    const sol::table & settlement ) {
        require_write();
        return commit_trade(
                   state, token, settlement,
                   current_runtime_generation(), current_world_generation() );
    } );
    services["trade"] = std::move( trade );
}

} // namespace cata::lua_platform

#endif // CATA_ENABLE_LUA_PLATFORM
