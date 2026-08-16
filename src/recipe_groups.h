#pragma once
#ifndef CATA_SRC_RECIPE_GROUPS_H
#define CATA_SRC_RECIPE_GROUPS_H

#include <cstddef>
#include <map>
#include <optional>
#include <set>
#include <string>
#include <string_view>
#include <vector>

#include "translation.h"
#include "type_id.h"

class JsonObject;
class translation;
struct mapgen_arguments;

namespace recipe_group
{

void load( const JsonObject &jo, const std::string &src );
void finalize();
void check();
void reset();

std::map<recipe_id, translation> get_recipes_by_bldg( const std::string &bldg );
std::map<recipe_id, translation> get_recipes_by_id( const std::string &id );
bool has_recipes_by_id( const std::string &id, const oter_id &omt_ter,
                        const std::optional<mapgen_arguments> *maybe_args );
std::map<recipe_id, translation> get_recipes_by_id( const std::string &id, const oter_id &omt_ter,
        const std::optional<mapgen_arguments> *maybe_args, size_t limit = 0 );
std::string get_building_of_recipe( const std::string &recipe );
} // namespace recipe_group

namespace cata::lua_platform::detail
{

struct recipe_group_terrain_definition {
    std::string overmap_terrain;
    std::string match_type = "TYPE";
    std::map<std::string, std::set<std::string>> parameters;
};

struct recipe_group_recipe_definition {
    std::string id;
    translation description;
    std::vector<recipe_group_terrain_definition> overmap_terrains;
};

struct recipe_group_native_definition {
    std::string id;
    std::string building_type = "NONE";
    std::vector<std::pair<std::string, mod_id>> sources;
    std::vector<recipe_group_recipe_definition> recipes;
};

bool recipe_group_exists( std::string_view id );
std::optional<recipe_group_native_definition> recipe_group_get( std::string_view id );
void recipe_group_set( const recipe_group_native_definition &definition );
void recipe_group_erase( std::string_view id );
std::vector<recipe_group_native_definition> recipe_group_snapshot();

} // namespace cata::lua_platform::detail

#endif // CATA_SRC_RECIPE_GROUPS_H
