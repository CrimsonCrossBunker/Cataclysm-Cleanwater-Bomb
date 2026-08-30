#pragma once
#ifndef CATA_SRC_LUA_PLATFORM_MAPGEN_DISPATCH_H
#define CATA_SRC_LUA_PLATFORM_MAPGEN_DISPATCH_H

class mapgendata;

namespace cata::lua_platform
{

// Thin engine boundary for Platform map generation. Lua-facing lifecycle,
// content, and hook contracts live in lua_platform_loader.h/lua_platform_runtime.h and
// lua_platform_hooks.h; this header contains no UI registry or compatibility API.
void dispatch_mapgen_postprocess( mapgendata &data );
bool dispatch_mapgen_generate( mapgendata &data );

} // namespace cata::lua_platform

#endif // CATA_SRC_LUA_PLATFORM_MAPGEN_DISPATCH_H
