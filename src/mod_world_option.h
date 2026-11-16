#pragma once
#ifndef CATA_SRC_MOD_WORLD_OPTION_H
#define CATA_SRC_MOD_WORLD_OPTION_H

#include <map>
#include <string>
#include <variant>

using mod_world_option = std::variant<bool, int, float, std::string>;
using mod_world_options = std::map<std::string, mod_world_option>;
using mod_interaction_world_options = std::map<std::string, mod_world_options>;

#endif // CATA_SRC_MOD_WORLD_OPTION_H
