#include <cata_path.h>
#include <type_id.h>
#include <exception>
#include <functional>
#include <utility>
#include <vector>

#include "cata_scope_helpers.h"
#include "debug.h"
#include "filesystem.h"
#include "flexbuffer_json.h"
#include "json_loader.h"
#include "past_achievements_info.h"
#include "past_games_info.h"
#include "path_info.h"
#include "string_formatter.h"

void past_achievements_info::clear()
{
    *this = past_achievements_info();
}

bool past_achievements_info::is_completed( const achievement_id &ach ) const
{
    return !avatars_completed( ach ).empty();
}

std::vector<std::string> past_achievements_info::avatars_completed(
    const achievement_id &ach ) const
{
    std::vector<std::string> completed;
    const auto it = completed_achievements_.find( ach );
    if( it != completed_achievements_.end() ) {
        completed = it->second;
    }
    // Legacy data from memorials
    const achievement_completion_info *legacy = get_past_games().legacy_achievement( ach );
    if( legacy ) {
        for( const past_game_info *const info : legacy->games_completed ) {
            if( info ) {
                completed.emplace_back( info->avatar_name() );
            }
        }
    }
    return completed;
}

void past_achievements_info::load()
{
    if( loaded_ ) {
        return;
    }
    const cata_path &achievement_dir = PATH_INFO::achievementdir_path();
    if( !assure_dir_exist( achievement_dir ) ) {
        debugmsg( "Could not access past achievements directory %s", achievement_dir.generic_u8string() );
        return;
    }

    std::vector<cata_path> filenames = get_files_from_path( ".json", achievement_dir, true, true );
    loaded_ = true;
    on_out_of_scope reset_loaded( [this]() {
        loaded_ = false;
    } );
    decltype( completed_achievements_ ) completed;
    std::string errors;

    for( const cata_path &filename : filenames ) {
        try {
            JsonObject jo = json_loader::from_path( filename ).get_object();
            const int version = jo.get_int( "achievement_version" );
            if( version == 0 ) {
                continue;
            } else if( version != 1 ) {
                jo.throw_error( string_format( "unexpected past achievements version %d", version ) );
            }
            std::vector<achievement_id> achievements;
            jo.get_member( "achievements" ).read( achievements, true );
            const std::string avatar_name = jo.get_string( "avatar_name" );
            for( const achievement_id &id : achievements ) {
                completed[id].emplace_back( avatar_name );
            }
        } catch( const std::exception &err ) {
            errors += string_format( "%s: %s\n", filename.generic_u8string(), err.what() );
        }
    }

    // Ensure memorial data are also loaded for legacy dead character achievements
    get_past_games();
    completed_achievements_.swap( completed );
    reset_loaded.cancel();
    if( !errors.empty() ) {
        debugmsg( "Some past achievement records could not be loaded:\n%s", errors );
    }
}

static past_achievements_info past_achievements;
past_achievements_info::past_achievements_info() = default;

const past_achievements_info &get_past_achievements()
{
    past_achievements.load();
    return past_achievements;
}

void clear_past_achievements()
{
    past_achievements.clear();
}
