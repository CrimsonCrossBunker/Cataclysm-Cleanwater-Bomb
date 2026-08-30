#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_ITEMS_H
#define CATA_SRC_LUA_PLATFORM_ITEMS_H

#include <cstddef>
#include <cstdint>
#include <functional>
#include <optional>
#include <string>
#include <utility>
#include <vector>

#include "lua_platform_handle.h"
#include "lua_platform_sol.h"

struct basecamp_platform_recipe_escrow_item;

namespace cata::lua_platform
{


/** Rollback handle for a staged, all-or-nothing Platform item transaction. */
struct platform_item_transaction {
    std::function<bool()> rollback;

    void commit() noexcept {
        rollback = {};
    }

    bool rollback_now() {
        if( !rollback ) {
            return true;
        }
        std::function<bool()> action = std::move( rollback );
        return action();
    }
};

// Existing recipe callers keep their descriptive type name while trade and
// future item-bearing services share the same rollback boundary.
using platform_recipe_item_transaction = platform_item_transaction;

/** One exact Item and its explicit Character holder for recipe escrow. */
struct platform_recipe_item_request {
    game_handle item_handle;
    sol::table source_holder;
    std::int64_t quantity = 0;
    bool tool = false;
};

/** One explicit Character holder used by the atomic trade transaction. */
struct platform_trade_item_holder {
    game_handle character;
    std::string slot;
};

/** One exact Item and its explicit source/destination Character holders. */
struct platform_trade_item_request {
    game_handle item_handle;
    platform_trade_item_holder source_holder;
    platform_trade_item_holder destination_holder;
    std::int64_t quantity = 0;
};

/** Detached result metadata for one successfully transferred trade Item. */
struct platform_trade_item_result {
    std::int64_t source_uid = 0;
    std::int64_t destination_uid = 0;
    std::int64_t quantity = 0;
};

// Any Platform write invalidates outstanding item-page continuations.  The
// runtime calls this from its common write gate so holder changes made by
// another domain cannot resume a cursor against a changed topology.
void bump_item_query_mutation_epoch();

// Read-only generation shared by every exact Platform Item holder.  This is
// intentionally a monotonic mutation generation rather than a content hash;
// callers bind it to a detached read snapshot and recheck it before reuse.
std::uint64_t item_holder_mutation_generation() noexcept;

/**
 * Stage a complete Character-inventory trade atomically.  All source and
 * destination checks happen before source mutation.  The returned transaction
 * owns rollback until the surrounding trade publishes its settlement.
 */
std::optional<game_handle_error> stage_platform_trade_items(
    const std::vector<platform_trade_item_request> &requests,
    const game_handle_runtime &current_runtime,
    std::size_t current_world_generation,
    std::uint64_t expected_holder_mutation_generation,
    std::vector<platform_trade_item_result> &result,
    platform_item_transaction &transaction );

/** Move one exact Character-held Item into a task-owned value escrow.  The
 * holder table is explicit and is rejected for unsupported holder kinds. */
std::optional<game_handle_error> stage_platform_recipe_item(
    const game_handle &item_handle, const sol::table &source_holder,
    std::int64_t quantity, bool tool,
    const game_handle_runtime &current_runtime,
    std::size_t current_world_generation,
    basecamp_platform_recipe_escrow_item &result );

/** Stage a complete recipe input set after all exact holders, quantities,
 * identity checks, vector capacity, and serializations have passed.  The
 * caller must keep the resulting vector task-owned; no source mutation is
 * performed while the preflight phase can still fail. */
std::optional<game_handle_error> stage_platform_recipe_items(
    const std::vector<platform_recipe_item_request> &requests,
    const game_handle_runtime &current_runtime,
    std::size_t current_world_generation,
    std::vector<basecamp_platform_recipe_escrow_item> &result,
    platform_recipe_item_transaction &transaction );

/** Restore one escrow item to an explicit holder.  The caller retains the
 * rollback transaction until the surrounding task commit succeeds. */
std::optional<game_handle_error> restore_platform_recipe_item(
    const basecamp_platform_recipe_escrow_item &item,
    const sol::table &destination_holder,
    const game_handle_runtime &current_runtime,
    std::size_t current_world_generation,
    platform_recipe_item_transaction &transaction );

/** Restore a complete persisted escrow atomically into one explicit holder.
 * The task remains the owner until the returned transaction is committed by
 * the camp subsystem. */
std::optional<game_handle_error> restore_platform_recipe_items(
    const std::vector<basecamp_platform_recipe_escrow_item> &items,
    const sol::table &destination_holder,
    const game_handle_runtime &current_runtime,
    std::size_t current_world_generation,
    platform_recipe_item_transaction &transaction );

/** Insert detached recipe outputs atomically into one explicit holder. */
std::optional<game_handle_error> insert_platform_recipe_outputs(
    const std::vector<std::string> &serialized_items,
    const sol::table &destination_holder,
    const game_handle_runtime &current_runtime,
    std::size_t current_world_generation,
    platform_recipe_item_transaction &transaction );

/** Convert one valid task-owned serialized Item into a bounded detached
 * snapshot.  The result never contains an Item GameHandle or native pointer. */
sol::table recipe_escrow_item_snapshot(
    sol::state_view lua,
    const basecamp_platform_recipe_escrow_item &item );

// Install bounded inventory traversal and item operations.  Native items
// cross the Lua boundary only through generation-checked GameHandle values.
void install_item_api(
    sol::table &services,
    std::function<game_handle_runtime()> current_runtime_generation,
    std::function<std::size_t()> current_world_generation,
    std::function<void()> require_read,
    std::function<void()> require_write );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_ITEMS_H
