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
    int age = 0;
    int height = 0;
    std::string blood;
    bool preview_available = false;
};

enum class android_character_creator_action_type : int {
    select_tab,
    select_row,
    activate_row,
    command,
    set_name,
    set_age,
    set_height,
    save_template,
};

struct android_character_creator_action {
    android_character_creator_action_type type;
    int index = 0;
    std::string command;
    std::string value;
};

class android_character_creator_ui : public cataimgui::window
{
    public:
        using inline_renderer = std::function<void()>;
        using detail_renderer = std::function<void( character_creator_tab,
                                const inline_renderer & )>;
        using preview_renderer = std::function<void( const ImVec2 & )>;

        android_character_creator_ui( detail_renderer render_details,
                                      preview_renderer render_preview );

        void set_snapshot( android_character_creator_snapshot next );
        void show_loading();
        std::optional<android_character_creator_action> take_action();

    protected:
        cataimgui::bounds get_bounds() override;
        void draw_controls() override;

    private:
        android_character_creator_snapshot snapshot_;
        detail_renderer render_details_;
        preview_renderer render_preview_;
        std::deque<android_character_creator_action> actions_;
        std::string filter_;
        std::string name_input_;
        std::string age_input_;
        std::string height_input_;
        std::string template_name_input_;
        bool editing_name_ = false;
        bool editing_age_ = false;
        bool editing_height_ = false;

        struct drag_state {
            bool active = false;
            ImVec2 start;
        };

        drag_state list_drag_;
        drag_state detail_drag_;
        drag_state summary_drag_;

        void queue_command( const std::string &command );
        void queue_value( android_character_creator_action_type type, const std::string &value );
        void draw_loading_page();
        void draw_identity_bar();
        void draw_age_input( const char *id, float width );
        void draw_height_input( const char *id, float width );
        void draw_summary_description_inputs();
        bool draw_template_save_controls();
        void draw_tabs();
        bool handle_vertical_drag( drag_state &state );
        void draw_selection_page( float footer_height );
        void draw_preview_panel( float height );
        const android_character_creator_row_snapshot *selected_row() const;
        void draw_current_details();
        void draw_summary_page( float footer_height );
        void draw_footer();
};

#endif // __ANDROID__

#endif // CATA_SRC_ANDROID_CHARACTER_CREATOR_H
