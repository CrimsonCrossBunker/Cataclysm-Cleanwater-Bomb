#pragma once
#ifndef CATA_SRC_CATALUA_UI_RETAINED_H
#define CATA_SRC_CATALUA_UI_RETAINED_H

#include <functional>
#include <memory>
#include <optional>
#include <string>
#include <vector>

#include "catalua_ui_renderer.h"

namespace cata::lua_ui
{

struct retained_ui_node {
    std::string type;
    std::string id;
    std::string label;
    std::string text;
    std::string string_value;
    double number_value = 0.0;
    double minimum = 0.0;
    double maximum = 0.0;
    double height = 0.0;
    int integer_value = 0;
    int count = 0;
    int columns = 0;
    bool bool_value = false;
    bool selected = false;
    bool truncated = false;
    std::vector<retained_ui_node> children;
};

struct retained_ui_document {
    std::vector<retained_ui_node> nodes;
};

struct retained_ui_surface {
    std::string id;
    std::string title;
    std::string kind;
    std::string anchor;
    double offset_x = 0.0;
    double offset_y = 0.0;
    double alpha = 1.0;
    double default_width = 0.28;
    double default_height = 0.18;
    bool interactive = true;
    bool movable = true;
    bool scalable = true;
    bool user_toggleable = true;
    retained_ui_document document;
};

// Values are encoded as click, bool:0/1, int:<n>, number:<n>, or text:<utf8>.
using retained_interaction_reader =
    std::function<std::optional<std::string>( const std::string &widget_id )>;

std::unique_ptr<script_ui_renderer> make_retained_script_ui_renderer(
    retained_ui_document &document, std::string id_prefix,
    retained_interaction_reader interaction_reader = {} );

std::string retained_document_json( const retained_ui_document &document );
std::string retained_surfaces_json( const std::vector<retained_ui_surface> &surfaces,
                                    std::size_t generation,
                                    const std::string &selected_page );

} // namespace cata::lua_ui

#endif // CATA_SRC_CATALUA_UI_RETAINED_H
