#pragma once
#ifndef CATA_SRC_CATALUA_UI_MODULES_H
#define CATA_SRC_CATALUA_UI_MODULES_H

#include <cstddef>
#include <cstdint>
#include <filesystem>
#include <optional>
#include <string>
#include <string_view>
#include <vector>

#include "catalua_ui_manifest.h"

namespace cata::lua_ui
{

inline constexpr std::size_t maximum_module_name_bytes = 192;
inline constexpr std::uintmax_t maximum_module_source_bytes =
    1024U * 1024U;
inline constexpr std::size_t maximum_module_load_depth = 32;
inline constexpr std::size_t maximum_modules_per_source = 128;
inline constexpr std::size_t maximum_modules_per_runtime = 512;

struct script_module_source {
    script_manifest manifest;
    std::filesystem::path root;
};

struct script_module_resolution {
    std::size_t source_index = 0;
    std::filesystem::path path;
    std::string cache_key;
};

// Resolves modules without executing Lua.  API v4 sources are isolated to
// their own root.  Cross-Mod imports must name a dependency declared by the
// caller's manifest.  Modules execute with the consumer's capability identity
// and receive a consumer-scoped cache; cross-Mod privileged calls use services
// instead.  API v2/v3 retain their legacy reverse-load-order lookup.
class script_module_resolver
{
    public:
        explicit script_module_resolver( std::vector<script_module_source> sources );

        std::optional<script_module_resolution> resolve_local(
            std::size_t caller_index, std::string_view module_name ) const;
        std::optional<script_module_resolution> resolve_import(
            std::size_t caller_index, std::string_view provider_id,
            std::string_view module_name ) const;

        const std::vector<script_module_source> &sources() const;

    private:
        std::vector<script_module_source> sources_;

        std::optional<script_module_resolution> resolve_in_source(
            std::size_t source_index, std::string_view module_name ) const;
        std::optional<std::size_t> source_index_for_id( std::string_view id ) const;
};

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_MODULES_H
