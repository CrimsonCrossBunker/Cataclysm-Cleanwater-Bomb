#pragma once
#ifndef CATA_SRC_ANDROID_CHARACTER_CREATOR_H
#define CATA_SRC_ANDROID_CHARACTER_CREATOR_H

#if defined(__ANDROID__)

#include <deque>
#include <functional>
#include <optional>
#include <string>
#include <vector>

#include "cata_imgui.h"

enum character_creator_tab : int;

struct android_character_creator_row_snapshot {
    int index = 0;
    std::string label;
    bool enabled = true;
    bool selected = false;
    bool active = false;
};

struct android_character_creator_snapshot {
    bool ready = false;
    character_creator_tab tab{};
    std::vector<android_character_creator_row_snapshot> rows;
    std::string name;
    std::string gender;
    std::string age;
    std::string height;
    std::string blood;
};

enum class android_character_creator_action_type : int {
    select_tab,
    select_row,
    activate_row,
    command,
};

struct android_character_creator_action {
    android_character_creator_action_type type;
    int index = 0;
    std::string command;
};

class android_character_creator_ui : public cataimgui::window
{
    public:
        using detail_renderer = std::function<void( character_creator_tab )>;

        explicit android_character_creator_ui( detail_renderer render_details );

        void set_snapshot( android_character_creator_snapshot next );
        void show_loading();
        std::optional<android_character_creator_action> take_action();

    protected:
        cataimgui::bounds get_bounds() override;
        void draw_controls() override;

    private:
        android_character_creator_snapshot snapshot_;
        detail_renderer render_details_;
        std::deque<android_character_creator_action> actions_;
        std::string filter_;
        bool dragging_ = false;
        ImVec2 drag_start_;

        void queue_command( const std::string &command );
        void draw_loading_page();
        void draw_identity_bar();
        void draw_tabs();
        bool handle_vertical_drag();
        void draw_selection_page( float footer_height );
        const android_character_creator_row_snapshot *selected_row() const;
        void draw_current_details();
        void draw_summary_page( float footer_height );
        void draw_footer();
};

#endif // __ANDROID__

#endif // CATA_SRC_ANDROID_CHARACTER_CREATOR_H
