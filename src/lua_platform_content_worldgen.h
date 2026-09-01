#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_CONTENT_WORLDGEN_H
#define CATA_SRC_LUA_PLATFORM_CONTENT_WORLDGEN_H

#include <cstddef>
#include <cstdint>
#include <memory>
#include <set>
#include <string>

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    #include "lua_platform_sol.h"
#endif

namespace cata::lua_platform
{

/**
 * Staged native ids supplied by the surrounding content transaction.
 *
 * The worldgen transaction deliberately does not depend on the outer
 * transaction implementation.  These sets are the only cross-domain lookup
 * state needed by its validation pass.
 */
struct worldgen_validation_index {
    std::set<std::string> skill_ids;
    std::set<std::string> map_extra_collection_ids;
    std::set<std::string> furniture_ids;
    std::set<std::string> terrain_ids;
    std::set<std::string> weather_generator_ids;
    std::set<std::string> item_group_ids;
    std::set<std::string> overmap_connection_ids;
};

/**
 * Transactional Platform-Lua definitions backed by the native worldgen
 * registries (regional settings, dimensions, placeholders, and related
 * forest/city content).
 */
class worldgen_content_transaction
{
    public:
        worldgen_content_transaction( std::string owner, std::size_t generation );
        ~worldgen_content_transaction();

        worldgen_content_transaction( const worldgen_content_transaction & ) = delete;
        worldgen_content_transaction &operator=( const worldgen_content_transaction & ) = delete;

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
        void install_lua_api( sol::state &lua, sol::table &ccb, sol::table &content );
        bool register_definition( const sol::object &value, int operation );
#endif

        bool validate( const worldgen_validation_index &index,
                       bool check_engine_state, std::string &error ) const;
        bool apply( std::string &error );
        bool validate_finalized( std::string &error ) const;
        void rollback();
        void commit();
        void seal();
        void discard();
        void append_fingerprint( std::uint64_t &state ) const;

    private:
        struct impl;
        std::unique_ptr<impl> pimpl_;
};

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_CONTENT_WORLDGEN_H
