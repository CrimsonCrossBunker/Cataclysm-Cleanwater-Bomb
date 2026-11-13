#pragma once
#ifndef CATA_SRC_MP_NPC_TRADE_H
#define CATA_SRC_MP_NPC_TRADE_H

#include <array>
#include <cstddef>
#include <cstdint>
#include <map>
#include <optional>
#include <string>
#include <utility>
#include <vector>

#include "character_action_guard.h"
#include "dialogue.h"
#include "npctrade.h"

class Character;
class JsonObject;
class JsonOut;
class map;
class npc;

namespace cata_mp
{

struct npc_trade_row {
    int64_t uid = 0;
    std::string name;
    int available = 0;
    int quantity = 0;
    int price = 0;
    bool sale = false;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &in );
};

struct npc_trade_prompt {
    int64_t id = 0;
    int64_t revision = 0;
    std::string title;
    std::string merchant;
    std::string status;
    bool sale = false;
    bool previous_page = false;
    bool next_page = false;
    bool bank_available = false;
    bool use_bank = false;
    bool reviewing = false;
    bool free_exchange = false;
    int selected = 0;
    int service_cost = 0;
    int balance = 0;
    int owed_after = 0;
    int bank_change = 0;
    std::vector<npc_trade_row> rows;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &in );
};

struct npc_trade_choice {
    int64_t id = 0;
    int64_t revision = 0;
    std::string action;
    int64_t uid = 0;
    int quantity = 0;

    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &in );
};

std::optional<npc_trade_choice> choose_npc_trade( const npc_trade_prompt &prompt );

// Owned by one authoritative conversation. Basket edits are reversible;
// confirmation re-resolves every selected location before moving anything.
class npc_trade_session
{
    public:
        npc_trade_session( Character &player, npc &trader, const map &here, int64_t id,
                           dialogue_trade_request request );
        bool belongs_to( const Character &player, const npc &trader, const map &here ) const;
        npc_trade_prompt prompt() const;
        bool apply( Character &player, npc &trader, const map &here, const npc_trade_choice &choice,
                    std::vector<tripoint_abs_ms> &changed_tiles );

    private:
        using order_key = std::pair<bool, int64_t>;
        struct quote {
            npc_trading::trade_terms terms;
            std::vector<npc_trade_row> rows;
        };

        character_action_guard player_;
        character_action_guard trader_;
        dialogue_trade_request request_;
        std::string merchant_;
        std::string status_;
        std::array<std::vector<npc_trade_row>, 2> offers_;
        std::map<order_key, int> basket_;
        std::optional<quote> quote_;
        int64_t id_;
        int64_t revision_ = 1;
        std::size_t page_ = 0;
        bool selling_ = false;
        bool bank_available_ = false;
        bool use_bank_ = false;

        void refresh( Character &player, npc &trader, const map &here );
        std::optional<quote> price_order( Character &player, npc &trader, const map &here,
                                          trade_selector::select_t &sales,
                                          trade_selector::select_t &purchases ) const;
};

} // namespace cata_mp

#endif // CATA_SRC_MP_NPC_TRADE_H
