#pragma once
#ifndef CATA_SRC_CATALUA_UI_I18N_H
#define CATA_SRC_CATALUA_UI_I18N_H

#include "catalua_sol.h"

namespace cata::lua_ui
{

// Installs the renderer-independent translation facade.  Mod code supplies
// untranslated catalogue keys and receives an owned Lua string.
void install_i18n_api( sol::state &lua );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_I18N_H
