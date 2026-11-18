#include <flexbuffer_json.h>
#include <filesystem>
#include <fstream>
#include <functional>
#include <string>
#include <system_error>
#include <vector>

#include "cata_catch.h"
#include "cata_path.h"
#include "cata_scope_helpers.h"
#include "debug.h"
#include "json_loader.h"
#include "past_achievements_info.h"
#include "past_games_info.h"
#include "path_info.h"
#include "type_id.h"

static const achievement_id achievement_achievement_cut_1_tree( "achievement_cut_1_tree" );
static std::filesystem::path past_records_directory()
{
    for( int attempt = 0; attempt < 100; ++attempt ) {
        const std::filesystem::path candidate = std::filesystem::temp_directory_path() /
                                                std::filesystem::u8path( "ccb-past-records-test-" + std::to_string( attempt ) );
        if( std::filesystem::create_directory( candidate ) ) {
            return candidate;
        }
    }
    FAIL( "Could not create a past records test directory" );
    return {};
}



TEST_CASE( "past_records_isolate_corrupt_files", "[past_records][nogame]" )
{
    const std::filesystem::path directory = past_records_directory();
    const std::string previous_user_dir = PATH_INFO::user_dir();
    on_out_of_scope cleanup( [&]() {
        clear_past_games();
        PATH_INFO::init_user_dir( previous_user_dir );
        PATH_INFO::set_standard_filenames();
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    PATH_INFO::init_user_dir( directory.generic_u8string() + "/" );
    PATH_INFO::set_standard_filenames();
    clear_past_games();
    std::filesystem::create_directory( directory / std::filesystem::u8path( "memorial" ) );
    std::ofstream( directory /
                   std::filesystem::u8path( "memorial/avatar-2026-11-15-12-00-00.json" ) ).close();
    CHECK_FALSE( capture_debugmsg_during( []() {
        CHECK_NOTHROW( get_past_games( false ) );
    } ).empty() );

    const std::filesystem::path achievements = directory / std::filesystem::u8path( "achievements" );
    REQUIRE( std::filesystem::create_directory( achievements ) );
    std::ofstream( achievements / std::filesystem::u8path( "a-valid.json" ) ) <<
            R"({"achievement_version":1,"achievements":["achievement_cut_1_tree"],"avatar_name":"Survivor"})";
    std::ofstream( achievements / std::filesystem::u8path( "b-empty.json" ) ).close();
    std::ofstream( achievements / std::filesystem::u8path( "c-partial.json" ) ) << "{";
    std::ofstream( achievements / std::filesystem::u8path( "d-invalid.json" ) ) <<
            R"({"achievement_version":1,"achievements":["achievement_cut_1_tree"]})";
    std::ofstream( achievements / std::filesystem::u8path( "e-version.json" ) ) <<
            R"({"achievement_version":99})";
    std::ofstream( achievements / std::filesystem::u8path( "f-legacy.json" ) ) <<
            R"({"achievement_version":0})";
    past_achievements_info records;
    const std::string errors = capture_debugmsg_during( [&]() {
        CHECK_NOTHROW( records.load() );
    } );
    CHECK( errors.find( "b-empty.json" ) != std::string::npos );
    CHECK( errors.find( "c-partial.json" ) != std::string::npos );
    CHECK( errors.find( "d-invalid.json" ) != std::string::npos );
    CHECK( errors.find( "e-version.json" ) != std::string::npos );
    const achievement_id &achievement = achievement_achievement_cut_1_tree;
    CHECK( records.avatars_completed( achievement ) == std::vector<std::string> { "Survivor" } );
    CHECK( capture_debugmsg_during( [&]() {
        records.load();
    } ).empty() );
    CHECK( std::filesystem::file_size( achievements / std::filesystem::u8path( "b-empty.json" ) ) ==
           0 );
    CHECK( std::filesystem::file_size( achievements / std::filesystem::u8path( "c-partial.json" ) ) ==
           1 );
}

TEST_CASE( "json_caches_follow_user_directories", "[past_records][nogame]" )
{
    const std::filesystem::path directory = past_records_directory();
    const std::string previous_user_dir = PATH_INFO::user_dir();
    on_out_of_scope cleanup( [&]() {
        PATH_INFO::init_user_dir( previous_user_dir );
        PATH_INFO::set_standard_filenames();
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    const bool memorial = GENERATE( false, true );
    const auto read_record = [&]( const std::filesystem::path & root, int value ) {
        PATH_INFO::init_user_dir( root.generic_u8string() + "/" );
        PATH_INFO::set_standard_filenames();
        if( memorial ) {
            PATH_INFO::set_memorialdir( ( root / std::filesystem::u8path( "memorial" ) ).generic_u8string() +
                                        "/" );
        }
        const cata_path records = memorial ? PATH_INFO::memorialdir_path() : PATH_INFO::user_dir_path();
        std::filesystem::create_directories( records.get_unrelative_path() );
        const cata_path path = records / ( std::to_string( value ) + ".json" );
        std::ofstream( path.get_unrelative_path() ) << "{\"value\":" << value << "}";
        CHECK( json_loader::from_path( path ).get_object().get_int( "value" ) == value );
        CHECK( std::filesystem::is_directory( ( records /
                                                std::filesystem::u8path( "cache" ) ).get_unrelative_path() ) );
    };
    const std::filesystem::path first = directory / std::filesystem::u8path( "first" );
    const std::filesystem::path second = directory / std::filesystem::u8path( "second" );
    read_record( first, 1 );
    read_record( second, 2 );
    REQUIRE( std::filesystem::remove_all( first ) > 0 );
    read_record( second, 3 );
    CHECK_FALSE( std::filesystem::exists( first ) );
    read_record( first, 4 );
}

TEST_CASE( "memorial_version_is_required", "[past_records][nogame]" )
{
    const int version = GENERATE( 0, 1 );
    const std::string version_member = "\"memorial_version\":" + std::to_string( version ) + ",";
    std::string contents = "{" + version_member + R"(
        "log":[],
        "stats":{
            "data":{
                "game_avatar_new":{"event_counts":[[{"avatar_name":["string","Survivor"]},1]]}
            },
            "initial_scores":[]
        },
        "achievements":{"enabled":true,"initial_achievements":[],"achievements_status":{}},
        "scores":{}
    })";
    const past_game_info record( json_loader::from_string( contents ).get_object() );
    CHECK( record.avatar_name() == "Survivor" );
    CHECK( record.is_legacy_achievements() == ( version == 0 ) );
    contents.erase( 1, version_member.size() );
    CHECK_THROWS_WITH( past_game_info( json_loader::from_string( contents ).get_object() ),
                       Catch::Matchers::Contains( "memorial_version" ) );
}

TEST_CASE( "memorial_achievements_isolate_corrupt_values", "[past_records][nogame]" )
{
    const std::filesystem::path directory = past_records_directory();
    const std::string previous_user_dir = PATH_INFO::user_dir();
    on_out_of_scope cleanup( [&]() {
        clear_past_games();
        PATH_INFO::init_user_dir( previous_user_dir );
        PATH_INFO::set_standard_filenames();
        std::error_code error;
        std::filesystem::remove_all( directory, error );
    } );
    PATH_INFO::init_user_dir( directory.generic_u8string() + "/" );
    PATH_INFO::set_standard_filenames();
    clear_past_games();
    const std::string enabled = GENERATE( "invalid", "999999999999999999999999999999" );
    const std::filesystem::path memorial = directory / std::filesystem::u8path( "memorial" );
    REQUIRE( std::filesystem::create_directory( memorial ) );
    const std::string contents = R"({
        "memorial_version":0,
        "log":[],
        "stats":{
            "data":{
                "game_avatar_new":{"event_counts":[[{"avatar_name":["string","Survivor"]},1]]},
                "player_gets_achievement":{"event_counts":[
                    [{"achievement":["achievement_id","achievement_cut_1_tree"],
                      "achievements_enabled":["bool",")" + enabled + R"("]},1],
                    [{"achievement":["achievement_id","achievement_cut_1_tree"],
                      "achievements_enabled":["bool","1"]},1]
                ]}
            },
            "initial_scores":[]
        },
        "achievements":{"enabled":true,"initial_achievements":[],"achievements_status":{}},
        "scores":{}
    })";
    std::ofstream( memorial / std::filesystem::u8path( "avatar-2026-11-15-12-00-00.json" ) ) <<
            contents;
    std::string missing_version = contents;
    const std::string version_member = "\"memorial_version\":0,";
    missing_version.erase( missing_version.find( version_member ), version_member.size() );
    std::ofstream( memorial / std::filesystem::u8path( "avatar-2026-11-15-12-00-01.json" ) ) <<
            missing_version;
    const std::string errors = capture_debugmsg_during( []() {
        CHECK_NOTHROW( get_past_games( false ) );
    } );
    CHECK_FALSE( errors.empty() );
    CHECK( errors.find( "memorial_version" ) != std::string::npos );
    const achievement_completion_info *completed = get_past_games( false ).legacy_achievement(
                achievement_achievement_cut_1_tree );
    REQUIRE( completed != nullptr );
    REQUIRE( completed->games_completed.size() == 1 );
    CHECK( completed->games_completed.front()->avatar_name() == "Survivor" );
    CHECK( capture_debugmsg_during( []() {
        get_past_games( false );
    } ).empty() );
}
