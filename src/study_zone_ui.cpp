#include "study_zone_ui.h"

#include <algorithm>
#include <array>
#include <cctype>
#include <cstring>
#include <memory>
#include <set>
#include <string>
#include <utility>
#include <vector>

#include "cata_imgui.h"
#include "character_id.h"
#include "character_action_guard.h"
#include "avatar.h"
#include "clzones.h"
#include "mp_gamestate.h"
#include "game.h"
#include "imgui/imgui.h"
#include "input_context.h"
#include "localized_comparator.h"
#include "memory_fast.h"
#include "npc.h"
#include "overmapbuffer.h"
#include "skill.h"
#include "translations.h"
#include "ui_manager.h"


static int filter_skill_input_callback( ImGuiInputTextCallbackData *data )
{
    if( data->EventChar < 256 ) {
        char c = static_cast<char>( data->EventChar );
        if( !std::islower( c ) && c != ' ' ) {
            return 1;
        }
    }
    return 0;
}

namespace
{
class study_zone_window : public cataimgui::window
{
    public:
        explicit study_zone_window( const study_zone_options &options ) :
            cataimgui::window( _( "Study Zone Skill Preferences" ), ImGuiWindowFlags_NoNavInputs ) {
            ctxt = input_context( "STUDY_ZONE_UI" );
            ctxt.register_action( "CONFIRM" );
            ctxt.register_action( "FILTER" );
            ctxt.register_action( "QUIT" );
            ctxt.set_timeout( 10 );

            // Get all skills
            for( const Skill &s : Skill::skills ) {
                all_skills.push_back( s.ident() );
            }
            std::sort( all_skills.begin(), all_skills.end(),
            []( const skill_id & a, const skill_id & b ) {
                return localized_compare( a->name(), b->name() );
            } );

            const auto add_character = [&]( Character & who ) {
                const std::string key = study_zone_options::preference_key( who );
                if( characters.count( key ) ) {
                    return;
                }
                characters.emplace( key, character_action_guard( who ) );
                labels.emplace( key, who.disp_name() );
                npc_names.push_back( key );
                const std::set<skill_id> *selected = options.get_skill_preferences( who );
                npc_skill_preferences[key] = selected ? *selected :
                                             std::set<skill_id>( all_skills.begin(), all_skills.end() );
            };
            add_character( get_avatar() );
            // Use the operator's followers and the visible player identities, not names.
            for( const character_id &id : g->get_follower_list() ) {
                shared_ptr_fast<npc> follower = overmap_buffer.find_npc( id );
                if( follower && !follower->is_hallucination() && follower->is_obeying( get_avatar() ) ) {
                    add_character( *follower );
                }
            }
            for( npc *person : g->get_npcs_if( []( const npc & candidate ) {
            return cata_mp::partner_identity( candidate.getID() ).valid();
            } ) ) {
                add_character( *person );
            }
            std::sort( npc_names.begin(), npc_names.end(), [&]( const std::string & a, const std::string & b ) {
                return localized_compare( labels.at( a ), labels.at( b ) );
            } );

            max_skill_name_width = 0.0f;
            for( const skill_id &skill : all_skills ) {
                ImVec2 text_size = ImGui::CalcTextSize( skill->name().c_str() );
                float width = text_size.x + ImGui::GetStyle().FramePadding.x * 2.0f;
                max_skill_name_width = std::max( max_skill_name_width, width );
            }

            max_npc_name_width = 0.0f;
            for( const std::string &npc_name : npc_names ) {
                ImVec2 text_size = ImGui::CalcTextSize( labels.at( npc_name ).c_str() );
                float width = text_size.x + ImGui::GetStyle().FramePadding.x * 2.0f;
                if( width > max_npc_name_width ) {
                    max_npc_name_width = width;
                }
            }
        }

        void apply( study_zone_options &options ) const {
            for( const auto &entry : characters ) {
                if( Character *who = entry.second.get() ) {
                    options.set_skill_preferences( *who, npc_skill_preferences.at( entry.first ) );
                }
            }
        }

        study_zone_ui_result execute() {
            bool canceled_result = false;
            bool confirmed = false;
            while( get_is_open() ) {
                ui_manager::redraw();
                std::string action = ctxt.handle_input();

                if( action == "CONFIRM" ) {
                    confirmed = true;
                    break;
                }

                if( action == "QUIT" ) {
                    if( !skill_filter.empty() ) {
                        skill_filter.clear();
                    } else {
                        canceled_result = true;
                        break;
                    }
                }
                if( action == "FILTER" ) {
                    filter_just_focused = true;
                }
            }

            if( done_clicked ) {
                confirmed = true;
            }

            if( !get_is_open() && !confirmed && !canceled_result ) {
                canceled_result = true;
            }

            if( canceled_result ) {
                return study_zone_ui_result::canceled;
            }
            return preferences_changed ? study_zone_ui_result::changed : study_zone_ui_result::successful;
        }

    protected:
        void draw_skill_row( const skill_id &skill ) {
            ImGui::TableNextRow();
            ImGui::TableNextColumn();
            ImGui::AlignTextToFramePadding();
            ImGui::Text( "%s", skill->name().c_str() );

            for( const std::string &npc_name : npc_names ) {
                ImGui::TableNextColumn();

                std::set<skill_id> &npc_skills = npc_skill_preferences[npc_name];

                bool is_selected = npc_skills.count( skill ) > 0;
                bool was_selected = is_selected;

                // center the checkbox
                float offset = ( ImGui::GetColumnWidth() - ImGui::GetFrameHeight() ) * 0.5f;
                ImGui::SetCursorPosX( ImGui::GetCursorPosX() + offset );

                ImGui::PushID( checkbox_id_counter++ );
                if( ImGui::Checkbox( "##checkbox", &is_selected ) ) {
                    preferences_changed = true;
                }
                ImGui::PopID();
                if( is_selected != was_selected ) {
                    if( is_selected ) {
                        npc_skills.insert( skill );
                    } else {
                        npc_skills.erase( skill );
                    }
                }
            }
        }

        void draw_footer( const std::vector<skill_id> &filtered_skills ) {
            // filter input, buttons, and Done button
            std::string filter_label = _( "Filter skills: " );
            ImGui::TextUnformatted( filter_label.c_str() );
            ImGui::SameLine();

            if( filter_just_focused ) {
                ImGui::SetKeyboardFocusHere();
                filter_just_focused = false;
            }

            ImGui::SetNextItemWidth( 300.0f );
            std::array<char, 256> filter_buffer = {0};
            strncpy( filter_buffer.data(), skill_filter.c_str(), filter_buffer.size() - 1 );
            ImGui::InputText( "##skill_filter", filter_buffer.data(), filter_buffer.size(),
                              ImGuiInputTextFlags_EnterReturnsTrue | ImGuiInputTextFlags_CallbackCharFilter,
                              filter_skill_input_callback );
            skill_filter = filter_buffer.data();

            ImGui::SameLine();
            if( ImGui::Button( _( "Check All" ) ) ) {
                for( const std::string &npc_name : npc_names ) {
                    std::set<skill_id> &npc_skills = npc_skill_preferences[npc_name];
                    for( const skill_id &skill : filtered_skills ) {
                        npc_skills.insert( skill );
                    }
                }
                preferences_changed = true;
            }

            ImGui::SameLine();
            if( ImGui::Button( _( "Clear All" ) ) ) {
                for( const std::string &npc_name : npc_names ) {
                    std::set<skill_id> &npc_skills = npc_skill_preferences[npc_name];
                    for( const skill_id &skill : filtered_skills ) {
                        npc_skills.erase( skill );
                    }
                }
                preferences_changed = true;
            }

            ImGui::SameLine();
            if( ImGui::Button( _( "Done" ) ) ) {
                done_clicked = true;
                is_open = false;
            }
        }

        cataimgui::bounds get_bounds() override {
            ImVec2 viewport_size = ImGui::GetMainViewport()->Size;
            float width = std::min( 1200.0f, viewport_size.x * 0.9f );
            float height = viewport_size.y;
            return { -1.f, -1.f, width, height };
        }

        void draw_controls() override {
            checkbox_id_counter = 0;
            std::vector<skill_id> filtered_skills;
            if( skill_filter.empty() ) {
                filtered_skills = all_skills;
            } else {
                for( const skill_id &skill : all_skills ) {
                    if( skill->name().find( skill_filter ) != std::string::npos ) {
                        filtered_skills.push_back( skill );
                    }
                }
            }

            const float footer_height_to_reserve = ImGui::GetFrameHeightWithSpacing() * 3;

            // inner scroll
            if( ImGui::BeginChild( "table_scroll_region", ImVec2( 0, -footer_height_to_reserve ), false,
                                   ImGuiWindowFlags_HorizontalScrollbar ) ) {
                // Create a table with Skills as rows and npc names as columns
                if( ImGui::BeginTable( "skill_npc_table", static_cast<int>( npc_names.size() ) + 1,
                                       ImGuiTableFlags_Borders | ImGuiTableFlags_ScrollX | ImGuiTableFlags_ScrollY |
                                       ImGuiTableFlags_RowBg ) ) {
                    // table header row
                    ImGui::TableSetupColumn( "Skill", ImGuiTableColumnFlags_WidthFixed | ImGuiTableColumnFlags_NoHide,
                                             max_skill_name_width );
                    for( const std::string &npc_name : npc_names ) {
                        const std::string label = labels.at( npc_name ) + "###" + npc_name;
                        ImGui::TableSetupColumn( label.c_str(), ImGuiTableColumnFlags_WidthFixed,
                                                 max_npc_name_width );
                    }
                    // freeze skill column horizontally and header vertically
                    ImGui::TableSetupScrollFreeze( 1, 1 );
                    ImGui::TableHeadersRow();

                    // skill rows
                    ImGuiListClipper clipper;
                    clipper.Begin( filtered_skills.size() );
                    while( clipper.Step() ) {
                        for( int row = clipper.DisplayStart; row < clipper.DisplayEnd; row++ ) {
                            draw_skill_row( filtered_skills[row] );
                        }
                    }

                    ImGui::EndTable();
                }
            }
            ImGui::EndChild();

            draw_footer( filtered_skills );
        }

    private:
        std::map<std::string, std::set<skill_id>> npc_skill_preferences;
        std::map<std::string, character_action_guard> characters;
        std::map<std::string, std::string> labels;
        std::vector<skill_id> all_skills;
        std::vector<std::string> npc_names;
        std::string skill_filter;
        bool filter_just_focused = false;
        bool preferences_changed = false;
        bool done_clicked = false;
        int checkbox_id_counter = 0;
        float max_skill_name_width = 0.0f;
        float max_npc_name_width = 0.0f;
        input_context ctxt;
};
} // namespace

study_zone_ui_result query_study_zone_skills( study_zone_options &options )
{
    study_zone_window window( options );
    const study_zone_ui_result result = window.execute();
    if( result != study_zone_ui_result::canceled ) {
        // Confirming binds legacy name preferences to current stable identities too.
        window.apply( options );
        return study_zone_ui_result::changed;
    }
    return result;
}
