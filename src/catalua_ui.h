#pragma once
#ifndef CATA_SRC_CATALUA_UI_H
#define CATA_SRC_CATALUA_UI_H

class mapgendata;

namespace cata::lua
{

// Thin engine boundary for Platform map generation. Lua-facing lifecycle,
// content, and hook contracts live in catalua_loader.h/catalua_runtime.h and
// catalua_hook.h; this header contains no UI registry or compatibility API.
void dispatch_mapgen_postprocess( mapgendata &data );
bool dispatch_mapgen_generate( mapgendata &data );

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_H
