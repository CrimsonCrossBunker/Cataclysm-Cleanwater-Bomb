#pragma once
#ifndef CATA_SRC_CATALUA_UI_MANIFEST_H
#define CATA_SRC_CATALUA_UI_MANIFEST_H

#include <set>
#include <string>
#include <string_view>
#include <vector>

class JsonValue;

namespace cata::lua_ui
{

struct script_manifest {
    std::string id;
    std::string version;
    int api_version = 0;
    std::set<std::string> capabilities;
    std::vector<std::string> dependencies;

    bool has_capability( std::string_view capability ) const;
    bool depends_on( std::string_view dependency ) const;
};

const std::set<std::string> &supported_script_capabilities();
int capability_minimum_api_version( std::string_view capability );
script_manifest read_script_manifest( const JsonValue &input );
script_manifest default_script_manifest( const std::string &id, bool allow_actions );
void validate_script_manifests( const std::vector<script_manifest> &manifests );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_MANIFEST_H
