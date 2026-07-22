#pragma once
#ifndef CATA_SRC_ANDROID_IMGUI_DIALOG_H
#define CATA_SRC_ANDROID_IMGUI_DIALOG_H

#if defined(__ANDROID__)

#include <optional>
#include <string>
#include <vector>

namespace android_imgui_dialog
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

} // namespace android_imgui_dialog

#endif // __ANDROID__

#endif // CATA_SRC_ANDROID_IMGUI_DIALOG_H
