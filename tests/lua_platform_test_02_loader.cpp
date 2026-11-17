// Preserve the established numbered domain test filenames.
// NOLINTBEGIN(cata-test-filename)
#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "lua_platform_test_support.h"
#include <ammo.h>
#include <cata_scope_helpers.h>
#include <cstdlib>
#include <flexbuffer_json.h>
#include <init.h>
#include <json_loader.h>
#include <lua_platform_loader.h>
#include <lua_platform_runtime.h>
#include <options.h>
#include <path_info.h>
#include <requirements.h>
#include <speech.h>
#include <text_snippets.h>
#include <worldfactory.h>
#include <filesystem>
#include <string>
#include <vector>
#include "cata_catch.h"

namespace
{

TEST_CASE( "lua_platform_mod_world_options_keep_native_override_order",
           "[lua][platform][loader][regression]" )
{
    const platform_lua_test_directory files;
    files.write( std::filesystem::u8path( "mod.lua" ), R"lua(
local ccb = require("ccb")
local mod = ccb.ModDefinition { world_options = {
    LUA_TEST_PACK_OPTION = 7,
    LUA_TEST_PRIVATE_OPTION = true,
    LUA_TEST_PACK_FLOAT = 1.25,
    LUA_TEST_PACK_STRING = "custom",
} }
assert(mod.world_options.LUA_TEST_PACK_OPTION == 7)
assert(mod.world_options.LUA_TEST_PRIVATE_OPTION == true)
return mod
)lua" );
    const std::string option = "LUA_TEST_PACK_OPTION";
    options_manager &options = get_options();
    REQUIRE_FALSE( options.has_option( option ) );
    // Register the first value via Lua so the isolated test can remove all
    // temporary options when it exits.
    on_out_of_scope cleanup( [&]() {
        options.restore_mod_world_options();
    } );
    options.apply_mod_world_options( "fixture_defaults", { { option, 2 } } );
    const auto load_json_override = []( const char *json ) {
        const JsonValue data = json_loader::from_string( json );
        load_external_option( data.get_object() );
    };
    load_json_override( R"({"name":"LUA_TEST_PACK_OPTION","stype":"int","value":5})" );
    REQUIRE( get_option<int>( option ) == 5 );

    cata::lua_platform::mod_definition metadata;
    std::string error;
    REQUIRE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
    options.apply_mod_world_options( "lua_pack", metadata.world_options );
    CHECK( get_option<int>( option ) == 7 );
    CHECK( get_option<bool>( "LUA_TEST_PRIVATE_OPTION" ) );
    CHECK( get_option<float>( "LUA_TEST_PACK_FLOAT" ) == 1.25f );
    CHECK( get_option<std::string>( "LUA_TEST_PACK_STRING" ) == "custom" );
    load_json_override( R"({"name":"LUA_TEST_PACK_OPTION","stype":"int","value":9})" );
    CHECK( get_option<int>( option ) == 9 );

    options.restore_mod_world_options();
    CHECK_FALSE( options.has_option( option ) );
    CHECK_FALSE( options.has_option( "LUA_TEST_PRIVATE_OPTION" ) );
}

TEST_CASE( "lua_platform_interaction_options_use_active_companions_in_native_order",
           "[lua][platform][loader][regression]" )
{
    const cata_path user_root = PATH_INFO::user_dir_path();
    const platform_lua_test_directory files( user_root.get_unrelative_path() );
    const mod_id lua_companion( "option_test_first" );
    const mod_id json_companion( "option_test_last" );
    files.write( std::filesystem::u8path( "mod.lua" ), R"lua(
local ccb = require("ccb")
local mod = ccb.ModDefinition { interaction_world_options = {
    option_test_first = { LUA_TEST_INTERACTION = 3 },
} }
assert(mod.interaction_world_options.option_test_first.LUA_TEST_INTERACTION == 3)
return mod
)lua" );
    files.write( std::filesystem::u8path( "mod_interactions/option_test_last/options.json" ),
                 R"([{"type":"EXTERNAL_OPTION","name":"LUA_TEST_INTERACTION","stype":"int","value":5}])" );

    cata::lua_platform::mod_definition metadata;
    std::string error;
    REQUIRE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
    // Only this fixture's data loader should be unfinalized.
    struct interaction_loader : DynamicDataLoader {} loader;
    WORLD world;
    restore_on_out_of_scope restore_world( world_generator->active_world );
    world_generator->active_world = &world;
    options_manager &options = get_options();
    const std::string key = "LUA_TEST_INTERACTION";
    REQUIRE_FALSE( options.has_option( key ) );
    on_out_of_scope cleanup( [&]() {
        options.restore_mod_world_options();
    } );
    const cata_path path = user_root / files.root.filename() / "mod_interactions";
    const auto load_interactions = [&]() {
        options.apply_mod_world_options( "fixture_defaults", { { key, 1 } } );
        loader.load_mod_interaction_files_from_path( path, "interaction_fixture",
                metadata.interaction_world_options );
    };
    load_interactions();
    CHECK( get_option<int>( key ) == 1 );
    world.active_mod_order = { json_companion };
    load_interactions();
    CHECK( get_option<int>( key ) == 5 );
    world.active_mod_order = { lua_companion };
    load_interactions();
    CHECK( get_option<int>( key ) == 3 );
    // The legacy interaction loader traverses interned mod IDs in ascending order.
    REQUIRE( lua_companion < json_companion );
    world.active_mod_order = { json_companion, lua_companion };
    load_interactions();
    CHECK( get_option<int>( key ) == 5 );
}

TEST_CASE( "lua_platform_loader_uses_trusted_environment_for_metadata_and_runtime",
           "[lua][platform][loader]" )
{
    platform_lua_test_directory files;
    files.write( std::filesystem::u8path( "foo.lua" ), R"lua(
local name, path = ... -- NOLINT(cata-text-style)
assert(name == "foo" and path:match("foo%.lua$"))
return { value = "foo" }
)lua" );
    files.write( std::filesystem::u8path( "false_export.lua" ), R"lua(
false_export_loads = (false_export_loads or 0) + 1
return false
)lua" );
    files.write( std::filesystem::u8path( "empty_export.lua" ), R"lua(
empty_export_loads = (empty_export_loads or 0) + 1
)lua" );
    files.write( std::filesystem::u8path( "nested/init.lua" ), "return { value = \"nested\" }\n" );
    files.write( std::filesystem::u8path( "模块.lua" ), "return 23\n" );
    files.write( std::filesystem::u8path( "nested/value.lua" ), "return 29\n" );
    files.write( std::filesystem::u8path( "broken.lua" ), "error(\"broken module\")\n" );
    files.write( std::filesystem::u8path( "mod.lua" ), std::string( platform_loader_policy_probe ) +
                 "\nreturn ccb.ModDefinition { id = \"platform-loader-policy-test\" }\n" );
    files.write( std::filesystem::u8path( "main.lua" ), platform_loader_policy_probe );

    cata::lua_platform::mod_definition metadata;
    std::string error;
    REQUIRE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
    CHECK( error.empty() );
    CHECK( metadata.id == "platform-loader-policy-test" );

    const cata::lua_platform::mod_source source = {
        metadata.id, files.root, files.root / std::filesystem::u8path( "main.lua" )
    };
    REQUIRE( cata::lua_platform::validate_mods( { source }, error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_platform_content_can_use_selected_data_only_mods_during_load_and_reload",
           "[lua][platform][loader]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    const platform_lua_test_directory files;
    files.write( std::filesystem::u8path( "main.lua" ), R"lua(
local content = require("ccb").content
assert(content.is_mod_active("selection_test"))
assert(content.is_mod_active("json_companion"))
assert(not content.is_mod_active("inactive"))
)lua" );
    const platform::mod_source source { "selection_test", files.root, files.root / "main.lua" };
    std::string error;
    CHECK_FALSE( platform::prepare_mods( { source }, error ) );
    REQUIRE( platform::prepare_mods( { source }, error, { "json_companion" } ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    platform::runtime_world_ready( true );
    REQUIRE( platform::reload_active_mods( error ) );
}

TEST_CASE( "lua_platform_static_interactions_keep_order_rollback_and_reload_identity",
           "[lua][platform][loader][regression]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const restore_on_out_of_scope restore_snippets( SNIPPET );
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    const platform_lua_test_directory files;
    files.write( "main.lua", R"lua(
local content = require("ccb").content
content.add(content.SnippetCategory { id = "lua_interaction_notes" }
    :entry { id = "lua_interaction_base_note", text = "base" })
)lua" );
    files.write( "interaction.lua", R"lua(
local content = require("ccb").content
content.replace(content.SnippetCategory { id = "lua_missing_interaction_category" }:text("broken"))
)lua" );

    const std::vector<platform::mod_source> sources = {
        { "interaction_owner", files.root, files.root / "main.lua" },
        { "interaction_owner#data_companion", files.root, files.root / "interaction.lua",
          platform::mod_source_type::interaction_content },
    };
    std::string error;
    REQUIRE( platform::prepare_mods( sources, error, { "data_companion" } ) );
    REQUIRE_FALSE( platform::apply_prepared_content( error ) );
    CHECK( error.find( "lua_missing_interaction_category" ) != std::string::npos );
    CHECK_FALSE( SNIPPET.has_category( "lua_interaction_notes" ) );

    files.write( "interaction.lua", R"lua(
local ccb = require("ccb")
assert(ccb.runtime == nil)
assert(ccb.content.is_mod_active("interaction_owner"))
assert(ccb.content.is_mod_active("data_companion"))
assert(not ccb.content.is_mod_active("interaction_owner#data_companion"))
ccb.content.add(ccb.content.SnippetCategory { id = "lua_interaction_notes" }
    :entry { id = "lua_interaction_late_note", text = "late" })
)lua" );
    REQUIRE( platform::prepare_mods( sources, error, { "data_companion" } ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    const auto notes = SNIPPET.get_snippets_by_category( "lua_interaction_notes" );
    REQUIRE( notes.size() == 2 );
    CHECK( notes[0].first == snippet_id( "lua_interaction_base_note" ) );
    CHECK( notes[1].first == snippet_id( "lua_interaction_late_note" ) );
    CHECK( platform::loaded_mod_ids() == std::vector<std::string>{ "interaction_owner" } );
    std::string output;
    CHECK_FALSE( platform::execute_console( "interaction_owner#data_companion", "return 1",
                                           output, error ) );
    REQUIRE( platform::reload_active_mods( error ) );

    files.write( "interaction.lua", R"lua(
local content = require("ccb").content
content.add(content.SnippetCategory { id = "lua_interaction_notes" }
    :entry { id = "lua_interaction_late_note", text = "changed" })
)lua" );
    CHECK_FALSE( platform::reload_active_mods( error ) );
    CHECK( error.find( "requires_full_data_reload" ) != std::string::npos );
    const auto retained = SNIPPET.get_snippet_by_id( snippet_id( "lua_interaction_late_note" ) );
    REQUIRE( retained );
    CHECK( retained->translated() == "late" );
}

TEST_CASE( "lua_platform_appends_speech_in_mod_load_order",
           "[lua][platform][loader]" )
{
    namespace platform = cata::lua_platform;
    const platform_lua_test_directory first;
    const platform_lua_test_directory second;
    const on_out_of_scope cleanup( []() {
        platform::discard_prepared_mods();
    } );
    first.write( std::filesystem::u8path( "main.lua" ), R"lua(
local content = require("ccb").content
content.append_speech_pool(content.SpeechPool { id = "lua_test_speech_append" }
    :line("first", 4):line("first", 4))
)lua" );
    bool replaces = false;
    SECTION( "a later Mod appends its line" ) {
        second.write( std::filesystem::u8path( "main.lua" ), R"lua(
local content = require("ccb").content
content.append_speech_pool(content.SpeechPool { id = "lua_test_speech_append" }:line("second", 9))
)lua" );
    }
    SECTION( "a later Mod replaces the pool" ) {
        replaces = true;
        second.write( std::filesystem::u8path( "main.lua" ), R"lua(
local content = require("ccb").content
content.replace(content.SpeechPool { id = "lua_test_speech_append" }:line("second", 9))
)lua" );
    }
    const std::string id = "lua_test_speech_append";
    REQUIRE( platform::detail::speech_registry_find( id ) == nullptr );
    std::string error;
    REQUIRE( platform::prepare_mods( {
        { "speech_first", first.root, first.root / "main.lua" },
        { "speech_second", second.root, second.root / "main.lua" },
    }, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    const std::vector<SpeechBubble> *const lines = platform::detail::speech_registry_find( id );
    REQUIRE( lines != nullptr );
    if( replaces ) {
        REQUIRE( lines->size() == 1 );
    } else {
        REQUIRE( lines->size() == 3 );
        CHECK( ( *lines )[0].text.translated() == "first" );
        CHECK( ( *lines )[1].text.translated() == "first" );
    }
    CHECK( lines->back().text.translated() == "second" );
    CHECK( lines->back().volume == 9 );
    platform::discard_prepared_mods();
    CHECK( platform::detail::speech_registry_find( id ) == nullptr );
}

TEST_CASE( "lua_platform_ammunition_types_preserve_mixed_mod_load_order",
           "[lua][platform][loader][regression]" )
{
    namespace platform = cata::lua_platform;
    const platform_lua_test_directory first;
    const platform_lua_test_directory second;
    const on_out_of_scope cleanup( []() {
        platform::discard_prepared_mods();
    } );
    first.write( std::filesystem::u8path( "main.lua" ), R"lua(
local content = require("ccb").content
content.upsert_ammunition_type(content.AmmunitionType {
    id = "lua_test_ammunition_overlay", name = "First ammunition", default_item = "rock",
})
)lua" );
    second.write( std::filesystem::u8path( "main.lua" ), R"lua(
local content = require("ccb").content
content.upsert_ammunition_type(content.AmmunitionType {
    id = "lua_test_ammunition_overlay", name = "Second ammunition", default_item = "rock",
})
)lua" );

    // TEST_DATA supplies only the default item and loads after ccb.
    const ammotype id( "lua_test_ammunition_overlay" );
    REQUIRE( id.is_valid() );
    REQUIRE( id.obj().default_ammotype() == itype_id( "nail" ) );
    auto sources = std::vector<platform::mod_source>{
        { "ccb", first.root, first.root / "main.lua" }
    };
    const bool same_pack_lua_override = GENERATE( false, true );
    if( same_pack_lua_override ) {
        sources.push_back( { "test_data", second.root, second.root / "main.lua" } );
    }

    std::string error;
    REQUIRE( platform::prepare_mods( sources, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    CHECK( id.obj().name() == ( same_pack_lua_override ? "Second ammunition" : "First ammunition" ) );
    CHECK( id.obj().default_ammotype() == itype_id( same_pack_lua_override ? "rock" : "nail" ) );
    platform::discard_prepared_mods();
    CHECK( id.obj().name() == "null" );
    CHECK( id.obj().default_ammotype() == itype_id( "nail" ) );
}

TEST_CASE( "lua_platform_requirements_merge_mixed_mods_in_pack_order",
           "[lua][platform][loader][regression]" )
{
    namespace platform = cata::lua_platform;
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::discard_prepared_mods();
    } );
    const requirement_id id( "lua_test_merged_requirement" );
    REQUIRE( id.is_valid() );
    REQUIRE( id.obj().get_components().empty() );
    REQUIRE( id.obj().get_tools().size() == 1 );
    REQUIRE( id.obj().get_tools().front().front().count == 2 );

    files.write( "main.lua", R"lua(
local content = require("ccb").content
local key = "lua_test_merged_requirement"
local choices = {}
for count = 1, 151 do
    choices[count] = { id = "rock", count = count }
end
content.add(content.Requirement { id = "lua_test_large_requirement_group" }:component_any(choices))
content.merge_requirement(content.Requirement { id = key, name = "Mixed crafting" }
    :component("rock", 1):component("test_rag", 1):tool("hammer", 1),
    content.Requirement {}:component("nail", 2))
content.merge_requirement(content.Requirement { id = key },
    content.Requirement {}:component("scrap", 3))
)lua" );

    std::string error;
    REQUIRE( platform::prepare_mods( { { "ccb", files.root, files.root / "main.lua" } }, error ) );
    const bool applied = platform::apply_prepared_content( error );
    INFO( error );
    REQUIRE( applied );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );

    const auto &components = id.obj().get_components();
    REQUIRE( components.size() == 2 );
    REQUIRE( components[0].size() == 4 );
    CHECK( components[0][0].type == itype_id( "rock" ) );
    CHECK( components[0][1].type == itype_id( "nail" ) );
    CHECK( components[0][2].type == itype_id( "scrap" ) );
    CHECK( components[0][3].type == itype_id( "test_rag" ) );
    CHECK( components[0][3].count == 2 );
    REQUIRE( components[1].size() == 2 );
    CHECK( components[1][1].type == itype_id( "nail" ) );
    CHECK( components[1][1].count == 3 );
    CHECK( id.obj().get_tools().front().front().count == 2 );
    CHECK( id.obj().display_name() == "Mixed crafting" );

    const requirement_id large_group_id( "lua_test_large_requirement_group" );
    REQUIRE( large_group_id.is_valid() );
    const auto &large_groups = large_group_id.obj().get_components();
    REQUIRE( large_groups.size() == 1 );
    REQUIRE( large_groups.front().size() == 151 );
    CHECK( large_groups.front().back().count == 151 );

    platform::discard_prepared_mods();
    CHECK( id.obj().get_components().empty() );
    CHECK( id.obj().get_tools().front().front().count == 2 );
    CHECK_FALSE( id.obj().has_display_name() );
    CHECK_FALSE( large_group_id.is_valid() );
}

TEST_CASE( "lua_platform_requirements_resolve_references_at_content_application",
           "[lua][platform][loader][regression]" )
{
    namespace platform = cata::lua_platform;
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::discard_prepared_mods();
    } );
    files.write( "main.lua", R"lua(
local content = require("ccb").content
content.add(content.Requirement { id = "lua_test_requirement_reference" }
    :tool("lua_test_nonexistent_tool", 1))
)lua" );

    std::string error;
    REQUIRE( platform::prepare_mods( { { "ccb", files.root, files.root / "main.lua" } }, error ) );
    CHECK_FALSE( platform::apply_prepared_content( error ) );
    CHECK( error.find( "references unknown tool 'lua_test_nonexistent_tool'" ) != std::string::npos );
    CHECK_FALSE( requirement_id( "lua_test_requirement_reference" ).is_valid() );
}

TEST_CASE( "lua_platform_loader_preserves_file_preambles_and_error_lines",
           "[lua][platform][loader][regression]" )
{
    platform_lua_test_directory files;
    files.write( std::filesystem::u8path( "module.lua" ),
                 "\xef\xbb\xbf#!/usr/bin/env lua\nreturn 42\n" );
    files.write( std::filesystem::u8path( "mod.lua" ),
                 "\xef\xbb\xbf#!/usr/bin/env lua\n"
                 "local ccb = require('ccb')\n"
                 "assert(require('module') == 42)\n"
                 "return ccb.ModDefinition { id = 'file-preamble-test' }\n" );
    files.write( std::filesystem::u8path( "main.lua" ),
                 "#!/usr/bin/env lua\nassert(require('module') == 42)\n" );
    cata::lua_platform::mod_definition metadata;
    std::string error;
    REQUIRE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
    REQUIRE( metadata.id == "file-preamble-test" );
    const cata::lua_platform::mod_source source = {
        metadata.id, files.root, files.root / std::filesystem::u8path( "main.lua" )
    };
    REQUIRE( cata::lua_platform::validate_mods( { source }, error ) );
    files.write( std::filesystem::u8path( "main.lua" ),
                 "\xef\xbb\xbf#!/usr/bin/env lua\nerror('line preserved')\n" );
    CHECK_FALSE( cata::lua_platform::validate_mods( { source }, error ) );
    CHECK( error.find( "main.lua:2:" ) != std::string::npos );
    CHECK( error.find( "line preserved" ) != std::string::npos );
}

TEST_CASE( "lua_platform_loader_finds_native_modules_beside_the_mod_entry",
           "[lua][platform][loader]" )
{
    platform_lua_test_directory files;
#if defined(_WIN32)
    const std::string library_name = "ccb_native_path_probe.dll";
#else
    const std::string library_name = "ccb_native_path_probe.so";
#endif
    // This checks path resolution only, never loads the placeholder as a DLL/SO.
    files.write( std::filesystem::u8path( library_name ), "native search path placeholder" );
    const std::string expected =
        std::filesystem::canonical( files.root / std::filesystem::u8path( library_name ) ).generic_u8string();
    const std::string probe = "local expected = [=[" + expected + "]=]\n" + R"lua(
local ccb = require("ccb")
local path = assert(package.searchpath("ccb_native_path_probe", package.cpath))
assert(path == expected)
)lua";
    files.write( std::filesystem::u8path( "mod.lua" ), probe +
                 "\nreturn ccb.ModDefinition { id = \"native-path-test\" }\n" );
    files.write( std::filesystem::u8path( "main.lua" ), probe );
    cata::lua_platform::mod_definition metadata;
    std::string error;
    REQUIRE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
    const cata::lua_platform::mod_source source = {
        metadata.id, files.root, files.root / std::filesystem::u8path( "main.lua" )
    };
    REQUIRE( cata::lua_platform::validate_mods( { source }, error ) );
}

TEST_CASE( "lua_platform_loader_supports_external_paths_and_loader_data",
           "[lua][platform][loader]" )
{
    platform_lua_test_directory files;
    platform_lua_test_directory external;
    external.write( std::filesystem::u8path( "dofile_probe.lua" ), "return 42\n" );
    external.write( std::filesystem::u8path( "external_probe.lua" ), R"lua(
local name, path = ... -- NOLINT(cata-text-style)
assert(name == "external_probe")
assert(type(path) == "string")
return { value = 42, path = path }
)lua" );
    // Long Lua brackets preserve Windows path separators without escaping.
    const std::string external_root = external.root.generic_u8string();
    const std::string probe = "local external_root = [=[" + external_root + "]=]\n" + R"lua(
local ccb = require("ccb")
package.path = external_root .. "/?.lua;" .. package.path
local value, loader_data = require("external_probe")
assert(value.value == 42)
assert(loader_data == value.path)
assert(require("external_probe") == value)
assert(dofile(external_root .. "/dofile_probe.lua") == 42)
local chunk = assert(loadfile(external_root .. "/external_probe.lua"))
assert(chunk("external_probe", "loadfile").path == "loadfile")
local marker = external_root .. "/io-probe.txt"
local file = assert(io.open(marker, "w"))
assert(file:write("trusted"))
assert(file:close())
file = assert(io.open(marker, "r"))
assert(file:read("*a") == "trusted")
assert(file:close())
assert(os.remove(marker))
-- A missing native library must return the standard error tuple, not a
-- removed/disabled entry point.  A real shared-library smoke test is separate.
local native, message = package.loadlib(external_root .. "/missing-native-module", "luaopen_probe")
assert(native == nil and type(message) == "string")
)lua";
    files.write( std::filesystem::u8path( "mod.lua" ), probe +
                 "\nreturn ccb.ModDefinition { id = \"external-loader-test\" }\n" );
    files.write( std::filesystem::u8path( "main.lua" ), probe );
    cata::lua_platform::mod_definition metadata;
    std::string error;
    REQUIRE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
    CHECK( error.empty() );
    const cata::lua_platform::mod_source source = {
        metadata.id, files.root, files.root / std::filesystem::u8path( "main.lua" )
    };
    REQUIRE( cata::lua_platform::validate_mods( { source }, error ) );
    CHECK( error.empty() );
}

TEST_CASE( "lua_platform_loader_errors_identify_stage_owner_and_script",
           "[lua][platform][loader]" )
{
    platform_lua_test_directory files;
    std::string error;
    SECTION( "metadata syntax failure identifies its source before an id exists" ) {
        files.write( std::filesystem::u8path( "mod.lua" ), "return function(\n" );
        cata::lua_platform::mod_definition metadata;
        REQUIRE_FALSE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
        CHECK( error.find( "Lua-first Mod metadata" ) != std::string::npos );
        CHECK( error.find( "mod.lua" ) != std::string::npos );
    }
    SECTION( "entry runtime failure identifies the declared owner" ) {
        files.write( std::filesystem::u8path( "main.lua" ), "error('entry diagnostic sentinel')\n" );
        const cata::lua_platform::mod_source source = {
            "diagnostic-owner", files.root, files.root / std::filesystem::u8path( "main.lua" )
        };
        REQUIRE_FALSE( cata::lua_platform::validate_mods( { source }, error ) );
        CHECK( error.find( "Lua-first Mod 'diagnostic-owner' entry" ) != std::string::npos );
        CHECK( error.find( "main.lua" ) != std::string::npos );
        CHECK( error.find( "entry diagnostic sentinel" ) != std::string::npos );
    }
    SECTION( "required module keeps its own source in the entry error" ) {
        files.write( std::filesystem::u8path( "main.lua" ), "require('nested_failure')\n" );
        files.write( std::filesystem::u8path( "nested_failure.lua" ), "error('nested diagnostic sentinel')\n" );
        const cata::lua_platform::mod_source source = {
            "diagnostic-owner", files.root, files.root / std::filesystem::u8path( "main.lua" )
        };
        REQUIRE_FALSE( cata::lua_platform::validate_mods( { source }, error ) );
        CHECK( error.find( "Lua-first Mod 'diagnostic-owner' entry" ) != std::string::npos );
        CHECK( error.find( "nested_failure.lua" ) != std::string::npos );
        CHECK( error.find( "nested diagnostic sentinel" ) != std::string::npos );
    }
}

TEST_CASE( "lua_platform_native_module_uses_host_lua_abi",
           "[.][native_module]" )
{
    // This explicit acceptance case needs the separately compiled probe.
    const char *directory = std::getenv( "CCB_NATIVE_PROBE_DIR" );
    REQUIRE( directory != nullptr );
    REQUIRE( directory[0] != '\0' );
    const std::filesystem::path root = std::filesystem::u8path( directory );
    const cata::lua_platform::mod_source source = {
        "native-abi-probe", root, root / std::filesystem::u8path( "main.lua" )
    };
    std::string error;
    const bool valid = cata::lua_platform::validate_mods( { source }, error );
    INFO( error );
    REQUIRE( valid );
}

TEST_CASE( "lua_platform_metadata_forwarding_uses_one_explicit_module_result",
           "[lua][platform][loader]" )
{
    platform_lua_test_directory files;
    files.write( std::filesystem::u8path( "metadata.lua" ), R"lua(
local ccb = require("ccb")
return ccb.ModDefinition { id = "forwarded-metadata" }
)lua" );
    files.write( std::filesystem::u8path( "mod.lua" ), "return require('metadata')\n" );
    cata::lua_platform::mod_definition metadata;
    std::string error;
    // Lua 5.4 require forwards loader data on the first load. The metadata
    // contract still requires precisely one typed result.
    REQUIRE_FALSE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
    // Literal Lua vararg syntax, not prose punctuation.
    // NOLINTNEXTLINE(cata-text-style)
    CHECK( error.find( "return (require(...))" ) != std::string::npos );
    files.write( std::filesystem::u8path( "mod.lua" ), "return (require('metadata'))\n" );
    REQUIRE( cata::lua_platform::read_mod_definition( files.root, metadata, error ) );
    CHECK( metadata.id == "forwarded-metadata" );
    CHECK( error.empty() );
}

} // namespace

#endif // CATA_ENABLE_LUA_PLATFORM

// NOLINTEND(cata-test-filename)
