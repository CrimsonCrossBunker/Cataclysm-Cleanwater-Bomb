#pragma once
#ifndef CATA_SRC_ADAPTIVE_CHARACTER_CREATOR_H
#define CATA_SRC_ADAPTIVE_CHARACTER_CREATOR_H

#if defined(TILES)

#include <deque>
#include <functional>
#include <optional>
#include <string>
#include <vector>

#include "cata_imgui.h"

enum character_creator_tab : int;

namespace cata::ui
{
struct profile;
} // namespace cata::ui

struct adaptive_character_creator_row_snapshot {
    int index = 0;
    std::string label;
    bool enabled = true;
    bool selected = false;
    bool active = false;
};

struct adaptive_character_creator_snapshot {
    bool ready = false;
    character_creator_tab tab{};
    std::vector<adaptive_character_creator_row_snapshot> rows;
    std::string name;
    std::string gender;
    int age = 0;
    int height = 0;
    std::string blood;
    bool preview_available = false;
};

enum class adaptive_character_creator_action_type : int {
    select_tab,
    select_row,
    activate_row,
    command,
    set_name,
    set_age,
    set_height,
    save_template,
};

struct adaptive_character_creator_action {
    adaptive_character_creator_action_type type;
    int index = 0;
    std::string command;
    std::string value;
};

class adaptive_character_creator_ui : public cataimgui::window
{
    public:
        using inline_renderer = std::function<void()>;
        using detail_renderer = std::function<void( character_creator_tab,
                                const inline_renderer & )>;
        using preview_renderer = std::function<void( const ImVec2 & )>;

        adaptive_character_creator_ui( detail_renderer render_details,
                                       preview_renderer render_preview );

        void set_snapshot( adaptive_character_creator_snapshot next );
        void show_loading();
        std::optional<adaptive_character_creator_action> take_action();

    protected:
        cataimgui::bounds get_bounds() override;
        void draw_controls() override;

    private:
        adaptive_character_creator_snapshot snapshot_;
        detail_renderer render_details_;
        preview_renderer render_preview_;
        std::deque<adaptive_character_creator_action> actions_;
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
        void queue_value( adaptive_character_creator_action_type type, const std::string &value );
        void draw_loading_page();
        void draw_identity_bar( const cata::ui::profile &profile );
        void draw_age_input( const char *id, float width );
        void draw_height_input( const char *id, float width );
        void draw_summary_description_inputs( const cata::ui::profile &profile );
        bool draw_template_save_controls( const cata::ui::profile &profile );
        void draw_tabs( const cata::ui::profile &profile );
        bool handle_vertical_drag( drag_state &state, const cata::ui::profile &profile );
        void draw_selection_page( float footer_height, const cata::ui::profile &profile );
        void draw_preview_panel( float height );
        const adaptive_character_creator_row_snapshot *selected_row() const;
        void draw_current_details( const cata::ui::profile &profile );
        void draw_summary_page( float footer_height, const cata::ui::profile &profile );
        void draw_footer( const cata::ui::profile &profile );
};

#endif // TILES

#endif // CATA_SRC_ADAPTIVE_CHARACTER_CREATOR_H
