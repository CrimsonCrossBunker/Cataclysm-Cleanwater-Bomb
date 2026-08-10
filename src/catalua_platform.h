#pragma once
#ifndef CATA_SRC_CATALUA_PLATFORM_H
#define CATA_SRC_CATALUA_PLATFORM_H

#include <filesystem>
#include <string>
#include <vector>

namespace cata::lua_platform
{

constexpr int platform_version = 1;

constexpr bool is_enabled() noexcept
{
#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI
    return true;
#else
    return false;
#endif
}

/** Native metadata returned by a Platform Mod's optional mod.lua. */
struct mod_definition {
    std::string id;
    std::string name;
    std::string version;
    std::string entry = "main.lua";
    std::vector<std::string> dependencies;
    bool core = false;

    bool id_set = false;
    bool name_set = false;
    bool version_set = false;
    bool entry_set = false;
    bool dependencies_set = false;
    bool core_set = false;
};

/** A resolved Platform source.  Paths must already be confined to root. */
struct mod_source {
    std::string id;
    std::filesystem::path root;
    std::filesystem::path entry;
};

/** Execute root/mod.lua and require exactly one native ccb.ModDefinition result. */
bool read_mod_definition( const std::filesystem::path &root, mod_definition &result,
                          std::string &error );

/**
 * Execute every entry in fresh per-Mod states.  Successful states remain candidates
 * until commit_prepared_mods() or discard_prepared_mods() is called.
 */
bool prepare_mods( const std::vector<mod_source> &sources, std::string &error );

/** Validate and inject every prepared native definition before global finalization. */
bool apply_prepared_content( std::string &error );

/** Confirm global finalization retained every prepared native definition. */
bool validate_finalized_prepared_content( std::string &error );

/** Replace the active Platform states with the last completely prepared candidate. */
void commit_prepared_mods();

/** Drop the last candidate without changing the active Platform states. */
void discard_prepared_mods();

/** Execute entries in isolated candidate states and always discard them. */
bool validate_mods( const std::vector<mod_source> &sources, std::string &error );

/** Destroy active and candidate states. */
void shutdown();

/** IDs whose entry states are currently active, in dependency/load order. */
std::vector<std::string> loaded_mod_ids();

/** Deterministic fingerprint of the currently prepared static definitions. */
std::string prepared_content_fingerprint();

/**
 * Re-execute active entries and swap runtime registrations only when their
 * static content fingerprint is unchanged.  A changed fingerprint returns
 * false with `requires_full_data_reload` in @p error.
 */
bool reload_active_mods( std::string &error );

/** Activate world-bound services and load engine-owned Platform sidecars. */
void on_world_ready( bool new_game );

/** Dispatch the synchronous pre-save lifecycle hook. */
void before_save();

/** Persist Platform character/world state and named tasks. */
bool save_persistent_state( std::string &error );

/** Report the final save outcome to lifecycle subscribers. */
void after_save( bool success, const std::string &error );

/** Run due named persistent tasks at the current game turn. */
void on_turn();

} // namespace cata::lua_platform

#endif // CATA_SRC_CATALUA_PLATFORM_H
