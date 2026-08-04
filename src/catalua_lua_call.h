#pragma once
#ifndef CATA_SRC_CATALUA_LUA_CALL_H
#define CATA_SRC_CATALUA_LUA_CALL_H

#include <string>
#include <string_view>

#include "catalua_ui.h"
#include "catalua_ui_state.h"

class JsonObject;

namespace cata::lua_ui
{

struct lua_call {
    std::string handler;
    script_value_map args;

    void load( const JsonObject &jo, std::string_view member_name );
};

bool invoke_lua_call( const lua_call &call, std::string_view kind,
                      native_callback_arguments context = {} );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_LUA_CALL_H
