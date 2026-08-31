#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_CONTENT_PRESENTATION_H
#define CATA_SRC_LUA_PLATFORM_CONTENT_PRESENTATION_H

#include <cstddef>
#include <cstdint>
#include <memory>
#include <set>
#include <string>
#include <string_view>

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
    #include "lua_platform_sol.h"
#endif

namespace cata::lua_platform
{

class runtime;

/**
 * Transactional Platform-Lua definitions for presentation-facing content.
 *
 * The native registries owned here cover scores, overlay ordering, zone types,
 * speech pools, end screens, activity types, help topics, snippet categories,
 * playlists, and sound effects.  Lua receives only generation-checked handles.
 */
class presentation_content_transaction
{
    public:
        presentation_content_transaction( std::string owner, std::size_t generation );
        ~presentation_content_transaction();

        presentation_content_transaction( const presentation_content_transaction & ) = delete;
        presentation_content_transaction &operator=(
            const presentation_content_transaction & ) = delete;

#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
        void install_lua_api( sol::state &lua, sol::table &ccb, sol::table &content );
        bool register_definition( const sol::object &value, int operation );
#endif

        bool validate( const runtime &owner_runtime, bool check_engine_state,
                       const std::set<std::string> &staged_event_statistics,
                       const std::set<std::string> &staged_field_types,
                       const std::set<std::string> &staged_ascii_arts,
                       std::string &error ) const;
        bool apply( std::string &error );
        bool validate_finalized( std::string &error ) const;
        void rollback();
        void commit();
        void seal();
        void discard();
        void append_fingerprint( std::uint64_t &state ) const;

        bool find_end_screen_handler( std::string_view end_screen_id,
                                      std::string &handler_id ) const;
        bool find_activity_type_handler( std::string_view activity_type_id,
                                         std::string_view phase,
                                         std::string &handler_id ) const;
        bool find_snippet_handler( std::string_view snippet_id,
                                   std::string &category_id,
                                   std::string &handler_id ) const;

    private:
        struct impl;
        std::unique_ptr<impl> pimpl_;
};

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_CONTENT_PRESENTATION_H
