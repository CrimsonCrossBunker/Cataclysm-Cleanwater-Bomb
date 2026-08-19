#include "mod_tileset.h"

#include <algorithm>
#include <map>
#include <string>
#include <utility>

#include "flexbuffer_json.h"

std::vector<mod_tileset> all_mod_tilesets;

namespace
{

std::map<std::string, platform_sprite_sheet> platform_sheets;
uint64_t platform_sheets_generation = 0;

} // namespace

const platform_sprite_sheet *find_platform_sprite_sheet( const std::string_view id )
{
    const auto found = platform_sheets.find( std::string( id ) );
    return found == platform_sheets.end() ? nullptr : &found->second;
}

void set_platform_sprite_sheet( platform_sprite_sheet value )
{
    platform_sheets.insert_or_assign( value.id, std::move( value ) );
    ++platform_sheets_generation;
}

void erase_platform_sprite_sheet( const std::string_view id )
{
    if( platform_sheets.erase( std::string( id ) ) > 0 ) {
        ++platform_sheets_generation;
    }
}

std::vector<platform_sprite_sheet> platform_sprite_sheets()
{
    std::vector<platform_sprite_sheet> result;
    result.reserve( platform_sheets.size() );
    for( const auto &[id, sheet] : platform_sheets ) {
        static_cast<void>( id );
        result.push_back( sheet );
    }
    return result;
}

uint64_t platform_sprite_sheet_generation()
{
    return platform_sheets_generation;
}

void load_mod_tileset( const JsonObject &jsobj, std::string_view, const cata_path &base_path,
                       const cata_path &full_path )
{
    // This function only checks whether mod tileset is compatible.
    // Actual sprites are loaded when the main tileset is loaded.
    // As such, most JSON members are skipped here.
    jsobj.allow_omitted_members();

    int new_num_in_file = 1;
    // Check mod tileset num in file
    for( const mod_tileset &mts : all_mod_tilesets ) {
        if( mts.get_full_path() == full_path ) {
            new_num_in_file++;
        }
    }

    all_mod_tilesets.emplace_back( base_path, full_path, new_num_in_file );
    std::vector<std::string> compatibility = jsobj.get_string_array( "compatibility" );
    for( const std::string &compatible_tileset_id : compatibility ) {
        all_mod_tilesets.back().add_compatible_tileset( compatible_tileset_id );
    }
}

void reset_mod_tileset()
{
    all_mod_tilesets.clear();
    if( !platform_sheets.empty() ) {
        platform_sheets.clear();
        ++platform_sheets_generation;
    }
}

bool mod_tileset::is_compatible( const std::string &tileset_id ) const
{
    const auto iter = std::find( compatibility.begin(), compatibility.end(), tileset_id );
    return iter != compatibility.end();
}

void mod_tileset::add_compatible_tileset( const std::string &tileset_id )
{
    compatibility.push_back( tileset_id );
}
