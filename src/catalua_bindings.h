#pragma once
#ifndef CATA_SRC_CATALUA_BINDINGS_H
#define CATA_SRC_CATALUA_BINDINGS_H

#include <functional>
#include <string_view>
#include <vector>

#include "catalua_sol.h"

namespace cata::lua_ui
{

enum class binding_implementation_status : int {
    planned,
    partial,
    covered,
    not_applicable
};

struct binding_domain {
    std::string_view id;
    std::string_view lua_namespace;
    std::string_view capability;
    int minimum_api_version = 0;
    binding_implementation_status status = binding_implementation_status::planned;
};

// The catalog is the stable, machine-readable contract used to track CBN API
// parity.  Entries describe whole domains; individual symbols are documented
// separately and must not be inferred from a partial domain.
const std::vector<binding_domain> &binding_catalog();
const binding_domain *find_binding_domain( std::string_view id );
std::string_view binding_status_name( binding_implementation_status status );
bool binding_domain_is_covered( std::string_view id );

// Install detached catalog snapshots under game.api_catalog() and the strict
// full-domain query game.api_supports().  Neither function exposes references
// to the native catalog.
void install_binding_catalog_api( sol::table &game, std::function<void()> require_read );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_BINDINGS_H
