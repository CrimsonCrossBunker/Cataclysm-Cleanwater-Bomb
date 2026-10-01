#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include "avatar.h"
#include "dialogue.h"
#include "lua_platform_test_support.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_bindings_coords.h"
#include "lua_platform_interaction.h"
#include "lua_platform_dialogue.h"
#include "npc.h"
#include "npctalk.h"
#include "rng.h"
#include "text_snippets.h"
#include "translation.h"
#include "uilist.h"
#include <memory>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <vector>

TEST_CASE( "lua_platform_translation_fallback_and_lifetime",
           "[lua][platform][runtime][translations]" )
{
    cata::lua_platform::clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_translation_test", 1901, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    lua["ccb"] = ccb;

    const auto run = [&lua]( std::string_view source ) {
        const sol::protected_function_result result = lua.safe_script(
                    source, sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error error = result;
            INFO( error.what() );
            REQUIRE( result.valid() );
        }
    };
    run( R"(
        assert(not pcall(ccb.services.format, "%s", {"before world ready"}))
        assert(not pcall(ccb.services.translate, "before world ready"))
        assert(not pcall(ccb.services.translate_plural, "one", "many", 1))
    )" );
    cata::lua_platform::runtime_world_ready( true );
    // Unique source strings deliberately have no entries in installed catalogs.
    run( R"(
        local one = "ccb translation regression singular 1901"
        local many = "ccb translation regression plural 1901"
        assert(ccb.services.translate(one) == one)
        assert(ccb.services.translate(one, "ccb regression context") == one)
        assert(ccb.services.translate_plural(one, many, 1) == one)
        assert(ccb.services.translate_plural(one, many, 0) == many)
        assert(ccb.services.translate_plural(one, many, 2, "ccb regression context") == many)
        assert(not pcall(ccb.services.translate_plural, one, many, -1))
        assert(not pcall(ccb.services.translate, "a\0b", "ccb regression context"))
        assert(not pcall(ccb.services.translate, one, "a\0b"))
        assert(not pcall(ccb.services.translate_plural, one, "a\0b", 2))
        assert(not pcall(ccb.services.translate_plural, one, many, 2, "a\0b"))
    )" );
    const sol::protected_function translate = ccb["services"]["translate"];
    for( const std::string &text : std::vector<std::string> {
             "", std::string( 1, '\0' ),
             std::string( "ccb translation NUL regression 1901" ) + '\0' + "suffix" + '\0' + "tail",
             std::string( 10000, 'x' ) + '\0' + "tail"
         } ) {
        const sol::protected_function_result result = translate( text );
        REQUIRE( result.valid() );
        CHECK( result.get<std::string>() == to_translation( text ).translated() );
#if defined(LOCALIZE)
        CHECK( result.get<std::string>() == text.substr( 0, text.find( '\0' ) ) );
#else
        CHECK( result.get<std::string>() == text );
#endif
    }
    run( R"(
        local format = ccb.services.format
        assert(format("%2$s -> %1$s", {"NPC", "book"}) == "book -> NPC")
        assert(format("[%2$6s] %1$04d %%", {7, "x"}) == "[     x] 0007 %")
        assert(format("%d %.2f", {3, 1.25}) == "3 1.25")
        assert(format("%d", {true}) == "1")
        assert(format("100%%", {}) == "100%")
        assert(format("", {}) == "")
        assert(format(table.concat({"%2$s", "%1$s"}, " -> "), {"NPC", "book"}) == "book -> NPC")
        assert(not pcall(format, "%s", {}))
        assert(not pcall(format, "%d", {"not a number"}))
        assert(not pcall(format, "%s", {{}}))
        assert(not pcall(format, "%s", {[2] = "hole"}))
        assert(not pcall(format, "%s", {[1] = "value", extra = "field"}))
        assert(not pcall(format, "a\0b", {}))
        assert(not pcall(format, "%s", {"a\0b"}))
    )" );
    lua["native_count_accepts_2_to_32"] = sizeof( std::size_t ) > 4;
    run( R"(
        local success = pcall(ccb.services.translate_plural,
            "ccb translation regression singular 1901", "ccb translation regression plural 1901",
            4294967296)
        assert(success == native_count_accepts_2_to_32)
    )" );
    cata::lua_platform::clear_active_runtimes();
    run( R"(
        assert(not pcall(ccb.services.format, "%s", {"after world unload"}))
        assert(not pcall(ccb.services.translate, "after world unload"))
        assert(not pcall(ccb.services.translate_plural, "one", "many", 2))
    )" );
}
TEST_CASE( "lua_platform_choice_positions_reject_invalid_shapes_before_ui",
           "[lua][platform][runtime][presentation]" )
{
    cata::lua_platform::clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::string );
    sol::table ccb = lua.create_table();
    const auto runtime = cata::lua_platform::make_runtime( "choice_positions", 1902, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    cata::lua_platform::runtime_world_ready( true );
    lua["ccb"] = ccb;
    lua["relative"] = cata::lua_platform::script_tripoint_coord::from_native(
                          coords::origin::relative, coords::scale::map_square, tripoint::zero );
    lua["loaded"] = cata::lua_platform::script_tripoint_coord::from_native(
                        coords::origin::abs, coords::scale::map_square, get_avatar().pos_abs().raw() );
    cata::lua_platform::detail::callback_scope callback( *runtime );
    const auto result = lua.safe_script( R"(
        local function rejected(entries, message)
            local ok, err = pcall(ccb.presentation.choose, "test", entries)
            assert(not ok and string.find(tostring(err), message, 1, true))
        end
        rejected({{id="a",label="A",position={x=1,y=2,z=0}}}, "typed abs_ms")
        rejected({{id="a",label="A",position=relative}}, "abs_ms coordinates")
        -- Reach validation of entry 129, rather than failing the former quota.
        -- The invalid final position keeps this test from opening a modal UI.
        local many = {}
        for i = 1, 129 do many[i] = {id=tostring(i),label="Ally " .. i} end
        many[129].position = relative
        rejected(many, "abs_ms coordinates")
        rejected({{id="a",label="A",position=loaded},{id="b",label="B"}}, "every entry or none")
        rejected({{id="a",label="A"},{id="b",label="B",position=loaded}}, "every entry or none")
    )", sol::script_pass_on_error );
    if( !result.valid() ) {
        const sol::error error = result;
        INFO( error.what() );
    }
    REQUIRE( result.valid() );
}

TEST_CASE( "lua_platform_text_expansion_matches_native_dialogue_tags",
           "[lua][platform][runtime][messages][semantic]" )
{
    clear_avatar();
    struct cleanup_avatar {
        ~cleanup_avatar() {
            clear_avatar();
        }
    } cleanup;

    avatar &player = get_avatar();
    player.normalize();
    const_dialogue native_dialogue(
        get_const_talker_for( player ), get_const_talker_for( player ) );
    std::string native_text = "<u_name> / <npc_name>";
    parse_tags( native_text, *native_dialogue.const_actor( false ),
                *native_dialogue.const_actor( true ), native_dialogue );

    cata::lua_platform::clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "lua_platform_message_text_test", 1903, lua );
    on_out_of_scope cleanup_runtime( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    cata::lua_platform::runtime_world_ready( true );
    lua["ccb"] = ccb;

    const sol::protected_function_result result = lua.safe_script( R"(
        local avatar = ccb.services.creatures.avatar()
        local expanded = ccb.services.text.expand_for(
            "<u_name> / <npc_name>", avatar, avatar)
        assert(expanded.ok)
        return expanded.value
    )", sol::script_pass_on_error );
    if( !result.valid() ) {
        const sol::error error = result;
        INFO( error.what() );
    }
    REQUIRE( result.valid() );
    CHECK( result.get<std::string>() == native_text );

    const std::string raw_item_id = std::string( 300, 'i' ) + std::string( "\0tail", 5 );
    const std::vector<std::string> raw_texts = {
        "", "<u_name> / <npc_name>", std::string( 40000, 'x' ) + "<u_name>",
        std::string( "\0prefix", 7 ) + "<u_name> / <npc_name>" + std::string( "\0tail", 5 ),
        "原生文本：<u_name> / <npc_name>"
    };
    for( const std::string &text : raw_texts ) {
        INFO( text.size() );
        std::string expected = text;
        parse_tags( expected, *native_dialogue.const_actor( false ),
                    *native_dialogue.const_actor( true ), native_dialogue, itype_id( raw_item_id ) );
        lua["raw_text"] = text;
        lua["raw_item_id"] = raw_item_id;
        const sol::protected_function_result expanded = lua.safe_script( R"(
            local avatar = ccb.services.creatures.avatar()
            local result = ccb.services.text.expand_for(raw_text, avatar, avatar, raw_item_id)
            assert(result.ok)
            return result.value
        )", sol::script_pass_on_error );
        if( !expanded.valid() ) {
            const sol::error error = expanded;
            INFO( error.what() );
        }
        REQUIRE( expanded.valid() );
        CHECK( expanded.get<std::string>() == expected );
    }
}
TEST_CASE( "lua_platform_dialogue_text_preserves_raw_bytes_context_and_native_rng",
           "[lua][platform][dialogue][messages][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    restore_on_out_of_scope restore_snippets( SNIPPET );
    SNIPPET = snippet_library{};
    SNIPPET.load_snippet( json_loader::from_string( R"({
        "category":"<ccb_text_raw_4851>",
        "text":["<context_val:ctx>","<u_val:label>","<npc_val:label>"]
    })" ).get_object(), "lua_dialogue_text_test" );
    const auto saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    const on_out_of_scope restore_rng( [saved_rng]() {
        rng_get_engine() = saved_rng;
    } );
    avatar alpha;
    npc beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 4851 ), true );
    beta.setID( character_id( 4852 ), true );
    platform::register_npc_handle_identity( beta );
    const on_out_of_scope retire_beta( [&]() {
        platform::retire_npc_handle_identity( beta );
    } );
    alpha.set_value( "label", "alpha label" );
    beta.set_value( "label", "beta label" );
    alpha.set_value( "tag_key", "ctx" );
    ::dialogue conversation( get_talker_for( alpha ), get_talker_for( beta ) );
    const std::string raw_key = std::string( 1000, 'k' ) + '\0' + "tail";
    const std::string raw_value = std::string( 40000, 'v' ) + '\0' + "tail";
    conversation.set_value( "ctx", "context label" );
    conversation.set_value( "number", 42.0 );
    conversation.set_value( "null", diag_value{} );
    conversation.set_value( raw_key, raw_value );
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const auto runtime = platform::make_runtime( "dialogue_text_raw", 4853, lua );
    const on_out_of_scope cleanup_runtime( []() {
        platform::clear_active_runtimes();
    } );
    platform::install_runtime_api( runtime, lua, ccb );
    platform::set_active_runtimes( { runtime } );
    platform::runtime_world_ready( true );
    const auto runtime_identity = platform::detail::runtime_handle_identity( runtime );
    const std::size_t world_generation = platform::runtime_world_generation();
    platform::dialogue::begin_session( conversation, runtime_identity, world_generation );
    const on_out_of_scope retire_session( [&]() {
        platform::dialogue::end_session( conversation );
    } );
    const std::string topic = "TALK_CCB_TEXT_RAW";
    const auto session = platform::dialogue::session_for(
                             conversation, topic, runtime_identity, world_generation );
    platform::dialogue::context context(
        lua.lua_state(), conversation, topic, false,
        "dialogue text context is stale", {}, session, runtime_identity, world_generation );
    REQUIRE( context.valid() );
    const sol::protected_function_result loaded = lua.safe_script(
                "return function(ctx,text,item) return ctx:expand_text(text,item) end",
                sol::script_pass_on_error );
    REQUIRE( loaded.valid() );
    const sol::protected_function expand = loaded.get<sol::protected_function>();
    const std::vector<std::string> texts = {
        "", std::string( 40000, 'x' ),
        std::string( "before\0", 7 ) + "<context_val:ctx>" + '\0' + "after",
        "<u_name> / <npc_name> / <u_val:label> / <npc_val:label>",
        "<context_val:ctx> / <context_val:number> / <context_val:null> / <context_val:missing>",
        "<context_val:<u_val:tag_key>>", "<context_val:" + raw_key + ">",
        "<ccb_text_raw_4851> / <ccb_text_raw_4851>",
        "<color_red><context_val:ctx></color> / <missing_ccb_text_raw_4851>"
    };
    for( const std::string &text : texts ) {
        for( const std::string &item_id : std::vector<std::string> {
                 "", "water", std::string( 300, 'i' ) + '\0' + "tail"
             } ) {
            for( const unsigned int seed : { 4854U, 4855U, 4856U } ) {
                CAPTURE( text.size(), item_id.size(), seed );
                std::string expected = text;
                rng_set_engine_seed( seed );
                const std::string native_diagnostic = capture_debugmsg_during( [&]() {
                    parse_tags( expected, *conversation.const_actor( false ),
                                *conversation.const_actor( true ), conversation,
                                item_id.empty() ? itype_id::NULL_ID() : itype_id( item_id ) );
                } );
                const auto native_rng_after = rng_get_engine(); // NOLINT(cata-determinism)
                rng_set_engine_seed( seed );
                std::string actual;
                const std::string platform_diagnostic = capture_debugmsg_during( [&]() {
                    const sol::protected_function_result result = expand( context, text, item_id );
                    REQUIRE( result.valid() );
                    actual = result.get<std::string>();
                } );
                CHECK( actual == expected );
                CHECK( platform_diagnostic == native_diagnostic );
                CHECK( rng_get_engine() == native_rng_after );
            }
        }
    }
    const sol::protected_function_result context_value = expand( context, "<context_val:ctx>", "" );
    REQUIRE( context_value.valid() );
    CHECK( context_value.get<std::string>() == "context label" );
    CHECK( conversation.get_value( raw_key ).str() == raw_value );
    std::string item_text = "<topic_item>";
    rng_set_engine_seed( 4857 );
    parse_tags( item_text, *conversation.const_actor( false ),
                *conversation.const_actor( true ), conversation, itype_id( "water" ) );
    const auto item_rng_after = rng_get_engine(); // NOLINT(cata-determinism)
    rng_set_engine_seed( 4857 );
    const sol::protected_function_result item_expanded = expand( context, "<topic_item>", "water" );
    REQUIRE( item_expanded.valid() );
    CHECK( item_expanded.get<std::string>() == item_text );
    CHECK( rng_get_engine() == item_rng_after );
    const sol::protected_function_result omitted_item = expand( context, "<context_val:ctx>" );
    REQUIRE( omitted_item.valid() );
    CHECK( omitted_item.get<std::string>() == "context label" );
    context.invalidate();
    const auto before_stale = rng_get_engine(); // NOLINT(cata-determinism)
    CHECK_FALSE( expand( context, "<ccb_text_raw_4851>", "" ).valid() );
    CHECK( rng_get_engine() == before_stale );
}

TEST_CASE( "lua_platform_interaction_menu_preserves_native_rows_and_text",
           "[lua][platform][interaction]" )
{
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    const std::string long_text = std::string( 5000, 'x' ) + std::string( "\0tail", 5 );
    const std::vector<std::string> keys = {
        "a", "!", " ", std::string( 1, '\0' ), std::string( 1, static_cast<char>( 255 ) )
    };
    sol::table entries = lua.create_table();
    std::vector<std::string> expected_ids;
    uilist native_menu;
    for( int index = 0; index < 300; ++index ) {
        const std::string id = index == 0 ? "" : long_text + std::to_string( index );
        const std::string label = index % 2 == 0 ? "" : long_text;
        const std::string description = index % 3 == 0 ? long_text : "";
        const bool enabled = index % 4 != 0;
        sol::table row = lua.create_table();
        row["id"] = id;
        row["label"] = label;
        row["description"] = description;
        row["enabled"] = enabled;
        int native_key = MENU_AUTOASSIGN;
        if( index < static_cast<int>( keys.size() ) ) {
            row["hotkey"] = keys[index];
            native_key = static_cast<int>( keys[index].front() );
        }
        entries[index + 1] = row;
        expected_ids.push_back( id );
        native_menu.entries.emplace_back( index, enabled, native_key, label, description );
    }
    sol::table options = lua.create_table();
    options["title"] = long_text;
    options["allow_cancel"] = false;
    options["highlight_disabled"] = true;
    options["show_descriptions"] = true;
    native_menu.text = long_text;
    native_menu.allow_cancel = false;
    native_menu.hilight_disabled = true;
    native_menu.desc_enabled = true;

    uilist platform_menu;
    const std::vector<std::string> ids = cata::lua_platform::prepare_game_interaction_menu(
                                           platform_menu, entries, options );
    CHECK( ids == expected_ids );
    REQUIRE( platform_menu.entries.size() == native_menu.entries.size() );
    CHECK( platform_menu.text == native_menu.text );
    CHECK( platform_menu.allow_cancel == native_menu.allow_cancel );
    CHECK( platform_menu.hilight_disabled == native_menu.hilight_disabled );
    CHECK( platform_menu.desc_enabled == native_menu.desc_enabled );
    for( std::size_t index = 0; index < native_menu.entries.size(); ++index ) {
        INFO( index );
        const uilist_entry &actual = platform_menu.entries[index];
        const uilist_entry &expected = native_menu.entries[index];
        CHECK( actual.retval == expected.retval );
        CHECK( actual.enabled == expected.enabled );
        CHECK( actual.hotkey == expected.hotkey );
        CHECK( actual.txt == expected.txt );
        CHECK( actual.desc == expected.desc );
    }

    sol::table empty_descriptions = lua.create_table();
    sol::table empty_row = lua.create_table();
    empty_row["id"] = "";
    empty_row["label"] = "";
    empty_row["description"] = "";
    empty_descriptions[1] = empty_row;
    options["title"] = "";
    for( const bool show : { false, true } ) {
        options["show_descriptions"] = show;
        uilist menu;
        cata::lua_platform::prepare_game_interaction_menu( menu, empty_descriptions, options );
        CHECK( menu.text.empty() );
        CHECK( menu.desc_enabled == show );
    }
    uilist default_menu;
    cata::lua_platform::prepare_game_interaction_menu(
        default_menu, empty_descriptions, sol::nullopt );
    CHECK_FALSE( default_menu.desc_enabled );
    CHECK( default_menu.entries.front().hotkey == uilist_entry( "" ).hotkey );
}

TEST_CASE( "lua_platform_interaction_menu_rejects_invalid_shapes_before_query",
           "[lua][platform][interaction]" )
{
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    const std::vector<std::string_view> invalid_entries = {
        "return {}", "return {{id = 'x'}}", "return {{id = 1, label = 'x'}}",
        "return {{id = 'x', label = 'x', hotkey = ''}}",
        "return {{id = 'x', label = 'x', hotkey = 'ab'}}",
        "return {{id = 'x', label = 'x', description = 1}}",
        "return {{id = 'x', label = 'x', enabled = 1}}",
        "return {{id = 'x', label = 'x'}, {id = 'x', label = 'y'}}"
    };
    for( const std::string_view invalid : invalid_entries ) {
        INFO( invalid );
        const sol::protected_function_result result = lua.safe_script(
                    invalid, sol::script_pass_on_error );
        REQUIRE( result.valid() );
        const sol::table entries = result.get<sol::table>();
        uilist menu;
        CHECK_THROWS_AS( cata::lua_platform::prepare_game_interaction_menu(
                            menu, entries, sol::nullopt ), std::invalid_argument );
    }
    sol::table entries = lua.create_table();
    sol::table row = lua.create_table();
    row["id"] = "x";
    row["label"] = "x";
    entries[1] = row;
    const std::vector<std::string_view> invalid_options = {
        "return {title = 1}", "return {show_descriptions = 1}", "return {unknown = true}"
    };
    for( const std::string_view invalid : invalid_options ) {
        INFO( invalid );
        const sol::protected_function_result result = lua.safe_script(
                    invalid, sol::script_pass_on_error );
        REQUIRE( result.valid() );
        const sol::table options = result.get<sol::table>();
        uilist menu;
        CHECK_THROWS_AS( cata::lua_platform::prepare_game_interaction_menu(
                            menu, entries, options ), std::invalid_argument );
    }
    sol::table services = lua.create_table();
    bool actions_requested = false;
    cata::lua_platform::install_game_interaction_api(
        services, [&actions_requested]() { actions_requested = true; }, []() { return false; } );
    lua["services"] = services;
    const sol::protected_function_result outside_callback = lua.safe_script( R"(
        local ok, err = pcall(services.interaction.choose, {{id = 'x', label = 'x'}})
        assert(not ok and string.find(err, 'only available from an active callback'))
    )", sol::script_pass_on_error );
    REQUIRE( outside_callback.valid() );
    CHECK( actions_requested );
}
#endif
