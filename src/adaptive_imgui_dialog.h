#pragma once
#ifndef CATA_SRC_ADAPTIVE_IMGUI_DIALOG_H
#define CATA_SRC_ADAPTIVE_IMGUI_DIALOG_H

#if defined(TILES)

#include <optional>
#include <string>
#include <vector>

namespace adaptive_imgui_dialog
{

struct entry {
    std::string label;
    std::string description;
    bool enabled = true;
    bool danger = false;
};

std::optional<int> select( const std::string &title,
                           const std::vector<entry> &entries,
                           const std::string &message = std::string(),
                           int initial_selection = 0 );

bool confirm( const std::string &title,
              const std::string &message,
              const std::string &confirm_label,
              const std::string &cancel_label,
              bool danger = false );

void message( const std::string &title,
              const std::string &message,
              const std::string &button_label = std::string() );

} // namespace adaptive_imgui_dialog

#endif // TILES

#endif // CATA_SRC_ADAPTIVE_IMGUI_DIALOG_H
