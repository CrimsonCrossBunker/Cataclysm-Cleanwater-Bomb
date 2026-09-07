/* Optional acceptance fixture. Never compiled by the ordinary tool tests. */
#include <lua.h>
#include <lauxlib.h>

static int round_trip( lua_State *state )
{
    /* Exercise the host's auxiliary library and primitive stack API. */
    const lua_Integer value = luaL_checkinteger( state, 1 );
    lua_pushinteger( state, value );
    return 1;
}

#if defined(_WIN32)
__declspec(dllexport)
#elif defined(__GNUC__)
__attribute__((visibility("default")))
#endif
int luaopen_ccb_native_probe( lua_State *state )
{
    luaL_checkversion( state );
    lua_newtable( state );
    lua_pushcfunction( state, round_trip );
    lua_setfield( state, -2, "round_trip" );
    lua_pushliteral( state, "CCB native Lua acceptance probe" );
    lua_setfield( state, -2, "description" );
    return 1;
}
