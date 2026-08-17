#pragma once
#ifndef CATA_SRC_CATALUA_PLATFORM_WORLD_CONTENT_H
#define CATA_SRC_CATALUA_PLATFORM_WORLD_CONTENT_H

#include <cstddef>
#include <cstdint>
#include <memory>
#include <string>

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI
#include "catalua_sol.h"
#endif

namespace cata::lua_platform
{

/**
 * Transactional Platform-Lua definitions for world-facing content whose
 * native registries live outside Item_factory and DynamicDataLoader.
 */
class world_content_transaction
{
    public:
        world_content_transaction( std::string owner, std::size_t generation );
        ~world_content_transaction();

        world_content_transaction( const world_content_transaction & ) = delete;
        world_content_transaction &operator=( const world_content_transaction & ) = delete;

#if defined(CATA_ENABLE_LUA_UI) && CATA_ENABLE_LUA_UI
        void install_lua_api( sol::state &lua, sol::table &ccb, sol::table &content );
        bool register_definition( const sol::object &value, int operation );
#endif

        bool validate( bool check_engine_state, std::string &error ) const;
        bool defines_overmap_terrain_type( const std::string &id ) const;
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

#endif // CATA_SRC_CATALUA_PLATFORM_WORLD_CONTENT_H
