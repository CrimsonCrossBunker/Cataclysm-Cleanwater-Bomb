#pragma once
#ifndef CATA_SRC_BUILTIN_MODS_H
#define CATA_SRC_BUILTIN_MODS_H

#if __has_include( "builtin_mods_generated.h" )
#include "builtin_mods_generated.h"
#else
#include <array>
#include <string_view>

inline constexpr bool builtin_mod_manifest_available = false;
inline constexpr std::array<std::string_view, 0> builtin_mod_ids = {};
inline constexpr std::array<std::string_view, 0> builtin_mod_roots = {};
#endif

#endif // CATA_SRC_BUILTIN_MODS_H
