#include "guyuan_hud.h"

#include <algorithm>
#include <list>
#include <string>
#include <utility>
#include <vector>

#if defined(TILES)
#include <imgui/imgui.h>

#include "avatar.h"
#include "bodypart.h"
#include "cached_options.h"
#include "cata_imgui.h"
#include "character.h"
#include "display.h"
#include "game.h"
#include "item.h"
#include "item_location.h"
#include "messages.h"
#include "npc.h"
#include "options.h"
#include "output.h"
#include "panels.h"
#include "sdltiles.h"
#include "skill.h"
#include "string_formatter.h"
#include "translation.h"
#include "translations.h"

namespace
{
class guyuan_hud_view
{
    public:
        explicit guyuan_hud_view( avatar &player ) : you( player ) {}

        void draw() {
            cataimgui::PushGuiFont();
            ImGui::PushStyleVar( ImGuiStyleVar_WindowRounding, 2.0F );
            ImGui::PushStyleVar( ImGuiStyleVar_FrameRounding, 0.0F );
            ImGui::PushStyleVar( ImGuiStyleVar_TabRounding, 0.0F );
            ImGui::PushStyleVar( ImGuiStyleVar_WindowPadding, ImVec2( 12.0F, 8.0F ) );
            ImGui::PushStyleColor( ImGuiCol_Text, ImVec4( 0.87F, 0.87F, 0.84F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_TextDisabled, ImVec4( 0.66F, 0.67F, 0.65F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_WindowBg, ImVec4( 0.075F, 0.085F, 0.095F, 0.98F ) );
            ImGui::PushStyleColor( ImGuiCol_Border, ImVec4( 0.30F, 0.31F, 0.31F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_Separator, ImVec4( 0.36F, 0.37F, 0.37F, 0.9F ) );
            ImGui::PushStyleColor( ImGuiCol_Tab, ImVec4( 0.22F, 0.17F, 0.11F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_TabHovered, ImVec4( 0.40F, 0.30F, 0.17F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_TabSelected, ImVec4( 0.34F, 0.25F, 0.14F, 1.0F ) );
            ImGui::PushStyleColor( ImGuiCol_FrameBg, ImVec4( 0.21F, 0.22F, 0.22F, 1.0F ) );
            const ImVec2 viewport = ImGui::GetMainViewport()->WorkSize;
            const ImVec2 origin = ImGui::GetMainViewport()->WorkPos;
            const float map_size = std::min( { 280.0F, viewport.x * 0.26F, viewport.y * 0.32F } );
            const int map_columns = std::clamp( static_cast<int>( map_size / std::max( fontwidth, 1 ) ),
                                               4, std::max( TERMX - 2, 4 ) );
            const int map_rows = std::clamp( static_cast<int>( map_size / std::max( fontheight, 1 ) ),
                                            4, std::max( TERMY - 2, 4 ) );
            const point map_position( TERMX - map_columns - 1, TERMY - map_rows - 1 );
            draw_minimap( map_position, map_columns, map_rows );
            const float map_left = static_cast<float>( map_position.x * fontwidth );
            const bool stacked = map_left - origin.x < 480.0F;
            const float bottom = stacked ? map_position.y * fontheight - 8.0F :
                                 origin.y + viewport.y - 8.0F;
            const float width = std::max( 1.0F, std::min( stacked ? viewport.x - 16.0F :
                                          map_left - origin.x - 16.0F, 1120.0F ) );
            const float height = std::max( 1.0F, std::min( { viewport.y * 0.44F,
                                          ImGui::GetTextLineHeightWithSpacing() * 16.0F,
                                          bottom - origin.y - 8.0F
                                        } ) );
            ImGui::SetNextWindowPos( ImVec2( origin.x + 8.0F, bottom - height ) );
            ImGui::SetNextWindowSize( ImVec2( width, height ) );
            constexpr ImGuiWindowFlags flags = ImGuiWindowFlags_NoTitleBar |
                                               ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoMove |
                                               ImGuiWindowFlags_NoSavedSettings | ImGuiWindowFlags_NoNav |
                                               ImGuiWindowFlags_NoFocusOnAppearing |
                                               ImGuiWindowFlags_NoBringToFrontOnFocus;
            if( ImGui::Begin( "##GuyuanHud", nullptr, flags ) ) {
                draw_controls();
            }
            ImGui::End();
            ImGui::PopStyleColor( 9 );
            ImGui::PopStyleVar( 4 );
            ImGui::PopFont();
        }

    private:
        void draw_minimap( const point &position, int columns, int rows ) const {
            const catacurses::window frame = catacurses::newwin( rows, columns, position );
            werase( frame );
            draw_border( frame );
            center_print( frame, 0, c_light_gray, _( "Map" ) );
            wnoutrefresh( frame );

            const catacurses::window map_window = catacurses::newwin( rows - 2, columns - 2,
                                                  position + point( 1, 1 ) );
            werase( map_window );
            if( pixel_minimap_option ) {
                g->draw_pixel_minimap( map_window );
            } else {
                overmap_ui::draw_overmap_chunk( map_window, you, you.pos_abs_omt(), point::zero,
                                               columns - 2, rows - 2 );
            }
            wnoutrefresh( map_window );
        }

        void draw_controls() {
            ImGui::PushStyleVar( ImGuiStyleVar_FramePadding,
                                 ImVec2( ImGui::GetFontSize(), ImGui::GetFontSize() * 0.3F ) );
            if( ImGui::BeginTabBar( "##GuyuanHudTabs", ImGuiTabBarFlags_FittingPolicyScroll ) ) {
                if( ImGui::BeginTabItem( _( "角色" ) ) ) {
                    draw_identity();
                    draw_character_tab();
                    ImGui::EndTabItem();
                }
                if( ImGui::BeginTabItem( _( "需求" ) ) ) {
                    draw_identity();
                    draw_needs_tab();
                    ImGui::EndTabItem();
                }
                if( ImGui::BeginTabItem( _( "健康" ) ) ) {
                    draw_identity();
                    draw_health_tab();
                    ImGui::EndTabItem();
                }
                if( ImGui::BeginTabItem( _( "装备" ) ) ) {
                    draw_identity();
                    draw_equipment_tab();
                    ImGui::EndTabItem();
                }
                if( ImGui::BeginTabItem( _( "技能" ) ) ) {
                    draw_identity();
                    draw_skills( 0 );
                    ImGui::EndTabItem();
                }
                if( ImGui::BeginTabItem( _( "社交" ) ) ) {
                    draw_identity();
                    draw_social_tab();
                    ImGui::EndTabItem();
                }
                if( ImGui::BeginTabItem( _( "日志" ) ) ) {
                    draw_identity();
                    draw_log_tab();
                    ImGui::EndTabItem();
                }
                ImGui::EndTabBar();
            }
            ImGui::PopStyleVar();
        }

        avatar &you;

        static void section_heading( const char *title ) {
            ImGui::TextColored( ImVec4( 0.82F, 0.75F, 0.60F, 1.0F ), "%s", title );
            ImGui::Separator();
        }

        static void status_line( const char *label, const std::pair<std::string, nc_color> &status ) {
            ImGui::PushID( label );
            if( ImGui::BeginTable( "##Status", 2, ImGuiTableFlags_SizingStretchProp ) ) {
                ImGui::TableSetupColumn( "##Label", ImGuiTableColumnFlags_WidthFixed,
                                         ImGui::GetFontSize() * 4.0F );
                ImGui::TableSetupColumn( "##Value" );
                ImGui::TableNextRow();
                ImGui::TableSetColumnIndex( 0 );
                ImGui::TextUnformatted( label );
                ImGui::TableSetColumnIndex( 1 );
                cataimgui::draw_colored_text( status.first, status.second );
                ImGui::EndTable();
            }
            ImGui::PopID();
        }

        static void progress_row( const char *label, float value, const char *overlay,
                                  const nc_color &color ) {
            ImGui::PushID( label );
            if( ImGui::BeginTable( "##Progress", 3, ImGuiTableFlags_SizingStretchProp ) ) {
                ImGui::TableSetupColumn( "##Label", ImGuiTableColumnFlags_WidthFixed,
                                         ImGui::GetFontSize() * 4.0F );
                ImGui::TableSetupColumn( "##Bar" );
                ImGui::TableSetupColumn( "##Number", ImGuiTableColumnFlags_WidthFixed,
                                         ImGui::CalcTextSize( "100%" ).x );
                ImGui::TableNextRow();
                ImGui::TableSetColumnIndex( 0 );
                ImGui::TextUnformatted( label );
                ImGui::TableSetColumnIndex( 1 );
                const ImVec4 fill = color == c_red ? ImVec4( 0.65F, 0.18F, 0.12F, 1.0F ) :
                                    color == c_yellow ? ImVec4( 0.54F, 0.47F, 0.06F, 1.0F ) :
                                    ImVec4( 0.25F, 0.52F, 0.06F, 1.0F );
                ImGui::PushStyleColor( ImGuiCol_PlotHistogram, fill );
                ImGui::ProgressBar( std::clamp( value, 0.0F, 1.0F ),
                                    ImVec2( -1.0F, ImGui::GetTextLineHeight() ), "" );
                ImGui::PopStyleColor();
                ImGui::TableSetColumnIndex( 2 );
                ImGui::TextUnformatted( overlay );
                ImGui::EndTable();
            }
            ImGui::PopID();
        }

        void draw_identity() const {
            cataimgui::PushGuiFontScaled( 1.2F );
            ImGui::TextWrapped( "%s", you.disp_name().c_str() );
            cataimgui::PopGuiFontScaled();
            ImGui::TextWrapped( "%s | %s | %d %s | %s %d", you.disp_profession().c_str(),
                                you.male ? _( "男性" ) : _( "女性" ), you.age(), _( "岁" ),
                                _( "专注" ), you.get_focus() );
            ImGui::Separator();
        }

        void draw_character_tab() const {
            if( ImGui::BeginTable( "##CharacterOverview", 2,
                                   ImGuiTableFlags_SizingStretchProp | ImGuiTableFlags_BordersInnerV ) ) {
                ImGui::TableSetupColumn( "##Condition", ImGuiTableColumnFlags_WidthStretch, 0.46F );
                ImGui::TableSetupColumn( "##Skills", ImGuiTableColumnFlags_WidthStretch, 0.54F );
                ImGui::TableNextRow();
                ImGui::TableSetColumnIndex( 0 );
                {
                    section_heading( _( "状态" ) );
                    const float hp = std::clamp( you.hp_percentage() / 100.0F, 0.0F, 1.0F );
                    progress_row( _( "健康" ), hp, string_format( "%d%%", you.hp_percentage() ).c_str(),
                                  hp > 0.5F ? c_green : c_red );
                    const int stamina_max = std::max( you.get_stamina_max(), 1 );
                    const float stamina = static_cast<float>( you.get_stamina() ) / stamina_max;
                    progress_row( _( "体力" ), stamina,
                                  string_format( "%d%%", static_cast<int>( stamina * 100.0F ) ).c_str(), c_light_green );
                    const float nutrition = std::clamp( you.get_kcal_percent(), 0.0F, 1.0F );
                    progress_row( _( "营养" ), nutrition,
                                  string_format( "%d%%", static_cast<int>( nutrition * 100.0F ) ).c_str(), c_yellow );
                    ImGui::Spacing();
                    status_line( _( "饥饿" ), display::hunger_text_color( you ) );
                    status_line( _( "口渴" ), display::thirst_text_color( you ) );
                    status_line( _( "休息" ), display::sleepiness_text_color( you ) );
                }
                ImGui::TableSetColumnIndex( 1 );
                {
                    section_heading( _( "技能" ) );
                    draw_skills( 12 );
                }
                ImGui::EndTable();
                ImGui::Separator();
                const std::string activity = you.activity.is_null() ? _( "空闲" ) :
                                             you.activity.get_verb().translated();
                ImGui::TextWrapped( "%s: %s | %s: %s", _( "当前活动" ), activity.c_str(),
                                    _( "时间" ), display::time_string( you ).c_str() );
            }
        }

        void draw_needs_tab() const {
            if( ImGui::BeginTable( "##NeedsGrid", 2, ImGuiTableFlags_SizingStretchProp ) ) {
                ImGui::TableNextRow();
                ImGui::TableSetColumnIndex( 0 );
                section_heading( _( "身体需求" ) );
                status_line( _( "饥饿" ), display::hunger_text_color( you ) );
                status_line( _( "口渴" ), display::thirst_text_color( you ) );
                status_line( _( "困倦" ), display::sleepiness_text_color( you ) );
                status_line( _( "疼痛" ), display::pain_text_color( you ) );
                status_line( _( "体重" ), display::weight_text_color( you ) );
                ImGui::TableSetColumnIndex( 1 );
                section_heading( _( "精神与活动" ) );
                const auto morale = display::morale_face_color( you );
                status_line( _( "心情" ), morale );
                ImGui::TextDisabled( "%s  %d", _( "专注" ), you.get_focus() );
                ImGui::TextDisabled( "%s  %s", _( "活动" ), you.activity_level_str().c_str() );
                ImGui::TextDisabled( "%s  %s", _( "负重" ), display::carry_weight_text_color( you ).first.c_str() );
                ImGui::EndTable();
            }
        }

        void draw_health_tab() const {
            section_heading( _( "身体状态" ) );
            const std::vector<bodypart_id> parts = you.get_all_body_parts( get_body_part_flags::only_main );
            const int columns = ImGui::GetContentRegionAvail().x > 850.0F ? 3 : 2;
            if( ImGui::BeginTable( "##BodyHealth", columns, ImGuiTableFlags_SizingStretchProp ) ) {
                for( const bodypart_id &part : parts ) {
                    ImGui::TableNextColumn();
                    const int maximum = std::max( you.get_hp_max( part ), 1 );
                    const int current = you.get_hp( part );
                    const float ratio = std::clamp( static_cast<float>( current ) / maximum, 0.0F, 1.0F );
                    const std::string label = string_format( "%s  %d / %d",
                                              part.obj().name_as_heading.translated(), current, maximum );
                    const nc_color color = ratio > 0.65F ? c_green : ratio > 0.3F ? c_yellow : c_red;
                    ImGui::PushStyleColor( ImGuiCol_PlotHistogram, cataimgui::imvec4_from_color( color ) );
                    ImGui::ProgressBar( ratio, ImVec2( -1.0F, 18.0F ), label.c_str() );
                    ImGui::PopStyleColor();
                }
                ImGui::EndTable();
            }
        }

        void draw_equipment_tab() const {
            if( ImGui::BeginTable( "##EquipmentGrid", 2, ImGuiTableFlags_BordersInnerV |
                                   ImGuiTableFlags_SizingStretchProp ) ) {
                ImGui::TableNextRow();
                ImGui::TableSetColumnIndex( 0 );
                section_heading( _( "武器" ) );
                const item_location wielded = you.get_wielded_item();
                if( wielded ) {
                    cataimgui::draw_colored_text( wielded->tname(), ImGui::GetContentRegionAvail().x );
                } else {
                    ImGui::TextDisabled( "%s", _( "未持有武器" ) );
                }
                ImGui::Spacing();
                ImGui::TextDisabled( "%s  %s", _( "负重" ), display::carry_weight_text_color( you ).first.c_str() );
                ImGui::TableSetColumnIndex( 1 );
                section_heading( _( "穿戴" ) );
                const std::list<item_location> worn = you.get_visible_worn_items();
                if( worn.empty() ) {
                    ImGui::TextDisabled( "%s", _( "没有穿戴物品" ) );
                }
                for( const item_location &entry : worn ) {
                    cataimgui::draw_colored_text( entry->tname(), ImGui::GetContentRegionAvail().x );
                }
                ImGui::EndTable();
            }
        }

        void draw_skills( int limit ) const {
            std::vector<std::pair<std::string, int>> skills;
            for( const auto &entry : you.get_all_skills() ) {
                const Skill &skill = entry.first.obj();
                if( !skill.obsolete() && skill.can_chr_use( you ) ) {
                    skills.emplace_back( skill.name(), entry.second.level() );
                }
            }
            std::sort( skills.begin(), skills.end(), []( const auto &lhs, const auto &rhs ) {
                return lhs.second == rhs.second ? lhs.first < rhs.first : lhs.second > rhs.second;
            } );
            if( limit > 0 && static_cast<int>( skills.size() ) > limit ) {
                skills.resize( limit );
            }
            const int groups = ImGui::GetContentRegionAvail().x > 360.0F ? 2 : 1;
            if( ImGui::BeginTable( "##SkillsTable", groups * 2, ImGuiTableFlags_SizingStretchProp ) ) {
                for( int column = 0; column < groups; ++column ) {
                    ImGui::TableSetupColumn( "##Name", ImGuiTableColumnFlags_WidthStretch );
                    ImGui::TableSetupColumn( "##Level", ImGuiTableColumnFlags_WidthFixed,
                                             ImGui::GetFontSize() * 2.0F );
                }
                const size_t split = ( skills.size() + groups - 1 ) / groups;
                for( size_t row = 0; row < split; ++row ) {
                    ImGui::TableNextRow();
                    for( int column = 0; column < groups; ++column ) {
                        const size_t index = static_cast<size_t>( column ) * split + row;
                        if( index >= skills.size() ) {
                            continue;
                        }
                        ImGui::TableSetColumnIndex( column * 2 );
                        ImGui::TextUnformatted( skills[index].first.c_str() );
                        if( ImGui::IsItemHovered() ) {
                            ImGui::SetTooltip( "%s", skills[index].first.c_str() );
                        }
                        ImGui::TableSetColumnIndex( column * 2 + 1 );
                        ImGui::TextColored( ImVec4( 0.85F, 0.78F, 0.59F, 1.0F ), "%d", skills[index].second );
                    }
                }
                ImGui::EndTable();
            }
            if( skills.empty() ) {
                ImGui::TextDisabled( "%s", _( "暂无技能" ) );
            }
        }

        void draw_social_tab() const {
            if( g == nullptr ) {
                return;
            }
            const std::vector<npc *> companions = g->allies();
            ImGui::TextDisabled( "%s  %d", _( "同伴" ), static_cast<int>( companions.size() ) );
            ImGui::Separator();
            if( companions.empty() ) {
                ImGui::TextDisabled( "%s", _( "当前没有同伴" ) );
                return;
            }
            for( const npc *companion : companions ) {
                if( companion != nullptr ) {
                    ImGui::BulletText( "%s", companion->disp_name().c_str() );
                }
            }
        }

        void draw_log_tab() const {
            const auto entries = Messages::recent_messages_with_formatting( 12 );
            if( ImGui::BeginChild( "##RecentMessages", ImVec2( 0.0F, 0.0F ), false ) ) {
                for( const auto &entry : entries ) {
                    ImGui::TextDisabled( "%s", entry.first.c_str() );
                    ImGui::SameLine();
                    cataimgui::draw_colored_text( entry.second, ImGui::GetContentRegionAvail().x );
                }
            }
            ImGui::EndChild();
        }
};

}
#endif

namespace guyuan_hud
{
bool enabled()
{
#if defined(TILES)
    return get_option<std::string>( "HUD_STYLE" ) == "guyuan_hud";
#else
    return false;
#endif
}

void draw( avatar &player )
{
#if defined(TILES)
    guyuan_hud_view view( player );
    view.draw();
#else
    ( void )player;
#endif
}
}