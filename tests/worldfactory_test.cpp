#include <filesystem>
#include <fstream>
#include <memory>
#include <string>
#include <system_error>
#include <vector>

#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "filesystem.h"
#include "worldfactory.h"

TEST_CASE( "world_create_timestamp" )
{
    std::unique_ptr<WORLD> world = std::make_unique<WORLD>();
    REQUIRE( world->create_timestamp() );
    INFO( world->timestamp );
    CHECK( world->timestamp.size() + 1 == sizeof( "yyyymmddHHMMSS123456789" ) );
    for( const char ch : world->timestamp ) {
        CHECK( ch >= '0' );
        CHECK( ch <= '9' );
    }
}

TEST_CASE( "delete_world_removes_read_only_directory_tree" )
{
    const std::string world_name = "Delete World 测试";
    const std::vector<mod_id> mods;
    REQUIRE_FALSE( world_generator->has_world( world_name ) );

    WORLD *world = world_generator->make_new_world( world_name, mods );
    REQUIRE( world != nullptr );
    const std::filesystem::path world_path = world->folder_path().get_unrelative_path();
    const std::filesystem::path nested_path = world_path / "read_only";
    const std::filesystem::path marker_path = nested_path / "marker.txt";

    on_out_of_scope cleanup( [&]() {
        std::error_code ec;
        std::filesystem::permissions( nested_path, std::filesystem::perms::owner_all,
                                      std::filesystem::perm_options::add, ec );
        std::filesystem::permissions( marker_path, std::filesystem::perms::owner_write,
                                      std::filesystem::perm_options::add, ec );
        if( world_generator->has_world( world_name ) ) {
            world_generator->delete_world( world_name, true );
        } else {
            std::filesystem::remove_all( world_path, ec );
        }
    } );

    REQUIRE( assure_dir_exist( nested_path ) );
    {
        std::ofstream marker( marker_path );
        REQUIRE( marker.is_open() );
        marker << "world deletion regression test";
    }

    std::error_code ec;
    std::filesystem::permissions( marker_path, std::filesystem::perms::owner_read,
                                  std::filesystem::perm_options::replace, ec );
    REQUIRE_FALSE( ec );
    std::filesystem::permissions( nested_path,
                                  std::filesystem::perms::owner_read |
                                  std::filesystem::perms::owner_exec,
                                  std::filesystem::perm_options::replace, ec );
    REQUIRE_FALSE( ec );

    CHECK( world_generator->delete_world( world_name, true ) );
    CHECK_FALSE( std::filesystem::exists( world_path ) );
    CHECK_FALSE( world_generator->has_world( world_name ) );
}
