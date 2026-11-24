#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <algorithm>
#include <calendar.h>
#include <cata_scope_helpers.h>
#include <cctype>
#include <cmath>
#include <cstddef>
#include <cstdint>
#include <filesystem>
#include <functional>
#include <initializer_list>
#include <istream>
#include <limits>
#include <lua_platform_loader.h>
#include <lua_platform_runtime.h>
#include <memory>
#include <npc.h>
#include <optional>
#include <sstream>
#include <stdexcept>
#include <string>
#include <string_view>
#include <type_id.h>
#include <utility>
#include <variant>
#include <vector>

#include "cata_catch.h"
#include "lua_platform_state.h"
#include "messages.h"
#include "debug.h"
#include "lua_platform_runtime_internal.h"
#include "avatar.h"
#include "character_id.h"
#include "lua_platform_handle.h"
#include "lua_platform_test_support.h"
#include "item_group.h"
#include "itype.h"
#include "mounted_charge.h"
#include "flexbuffer_cache.h"
#include "flexbuffer_json.h"
#include "json.h"
#include "json_loader.h"
#include "point.h"
#include "profession.h"
#include "bodypart.h"
#include "flag.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_registry.h"
#include "condition.h"
#include "dialogue.h"
#include "character_martial_arts.h"
#include "martialarts.h"
#include "pimpl.h"
#include "lua_platform_vitamins.h"
#include "vitamin.h"
#include "lua_platform_sol.h"

namespace cata::lua_platform
{
class runtime;
} // namespace cata::lua_platform

namespace merged_lua_platform_bounded_output_test
{

TEST_CASE( "lua_platform_state_output_stops_at_its_byte_limit",
           "[lua][platform][state]" )
{
    cata::lua_platform::detail::bounded_state_output_buffer storage( 4, "bounded output sentinel" );
    std::ostream output( &storage );
    output.exceptions( std::ios::badbit | std::ios::failbit );
    output.write( "ab", 2 );
    output.put( 'c' );
    output.write( "d", 1 );
    CHECK( storage.str() == "abcd" );
    CHECK_THROWS_WITH( output.put( 'e' ), "bounded output sentinel" );
    CHECK( storage.str() == "abcd" );
    output.clear();
    output.write( "", 0 );
    CHECK_THROWS_AS( output.write( "extra", 5 ), std::invalid_argument );
    CHECK( storage.str() == "abcd" );
}

TEST_CASE( "lua_platform_state_output_counts_binary_bytes_and_rejects_whole_chunks",
           "[lua][platform][state]" )
{
    cata::lua_platform::detail::bounded_state_output_buffer storage( 4, "bounded output sentinel" );
    std::ostream output( &storage );
    output.exceptions( std::ios::badbit | std::ios::failbit );
    output.write( "a\0b", 3 );
    CHECK( storage.str() == std::string( "a\0b", 3 ) );
    CHECK_THROWS_AS( output.write( "cd", 2 ), std::invalid_argument );
    CHECK( storage.str().size() == 3 );
    output.clear();
    output.put( 'c' );
    CHECK( storage.str() == std::string( "a\0bc", 4 ) );
}

TEST_CASE( "lua_platform_oversized_encoded_state_does_not_touch_its_destination",
           "[lua][platform][state]" )
{
    namespace platform = cata::lua_platform;
    platform::script_persistent_state state;
    // Raw values fit the 512 KiB state allowance, but JSON escapes exceed the
    // existing 1 MiB codec limit. Only three 64 KiB raw values are needed.
    for( const char *key : {
             "one", "two", "three"
         } ) {
        platform::assign_persistent_value( state, key,
                                           std::string( platform::persistent_state_max_string_bytes, '\x01' ) );
    }
    std::ostringstream destination;
    destination << "previous output";
    CHECK_THROWS_AS( platform::write_persistent_state( destination, state ), std::invalid_argument );
    CHECK( destination.str() == "previous output" );
}

} // namespace merged_lua_platform_bounded_output_test

namespace merged_lua_platform_callback_diagnostic_test
{

TEST_CASE( "lua_platform_callback_errors_name_the_trigger_and_continue_dispatch",
           "[lua][platform][runtime][callbacks]" )
{
    cata::lua_platform::clear_active_runtimes();
    Messages::clear_messages();
    REQUIRE_FALSE( debug_has_error_been_observed() );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "callback-diagnostic-owner", 1902, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
        Messages::clear_messages();
        debug_reset_error_observed();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    lua.set_function( "failing_callback", []() {
        throw std::runtime_error( "callback diagnostic sentinel" );
    } );
    int later_calls = 0;
    lua.set_function( "later_callback", [&later_calls]() {
        ++later_calls;
    } );
    for( const char *handler : {
             "failing_callback", "later_callback"
         } ) {
        const sol::protected_function_result registered =
            ccb["runtime"]["handler"]( handler, lua[handler] );
        REQUIRE( registered.valid() );
        const sol::protected_function_result event_subscription =
            ccb["runtime"]["on"]( "world_ready", handler );
        REQUIRE( event_subscription.valid() );
        const sol::protected_function_result hook_subscription =
            ccb["runtime"]["hook"]( "on_craft_result", handler );
        REQUIRE( hook_subscription.valid() );
    }
    REQUIRE_FALSE( debug_has_error_been_observed() );
    cata::lua_platform::runtime_world_ready( true );
    CHECK( debug_has_error_been_observed() );
    debug_reset_error_observed();
    CHECK( later_calls == 1 );
    REQUIRE_FALSE( debug_has_error_been_observed() );
    cata::lua_platform::dispatch_runtime_hook( "on_craft_result" );
    CHECK( debug_has_error_been_observed() );
    debug_reset_error_observed();
    CHECK( later_calls == 2 );
    const auto messages = Messages::recent_messages( 10 );
    for( const char *context : {
             "event world_ready", "hook on_craft_result"
         } ) {
        const auto error = std::find_if( messages.begin(), messages.end(),
        [context]( const auto & entry ) {
            return entry.second.find( context ) != std::string::npos;
        } );
        REQUIRE( error != messages.end() );
        CHECK( error->second.find( "callback-diagnostic-owner:failing_callback" ) !=
               std::string::npos );
        CHECK( error->second.find( "callback diagnostic sentinel" ) != std::string::npos );
    }
}

} // namespace merged_lua_platform_callback_diagnostic_test

namespace merged_lua_platform_due_task_cancel_test
{

TEST_CASE( "lua_platform_due_task_can_be_cancelled_by_an_earlier_callback",
           "[lua][platform][tasks]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime( "due-cancel", 2012, lua );
    const on_out_of_scope cleanup( []() {
        platform::clear_active_runtimes();
    } );
    platform::install_runtime_api( owner, lua, ccb );
    lua["ccb"] = ccb;
    // The first callback cancels a sibling and adds a task for a later pass.
    const sol::protected_function_result setup = lua.safe_script( R"lua(
ran_first = 0
ran_cancelled = 0
ran_last = 0
ran_new = 0
ccb.runtime.handler("first", function()
    ran_first = ran_first + 1
    assert(ccb.tasks.get(cancel_id).handler == "cancelled")
    assert(ccb.tasks.list().total == 2)
    assert(ccb.tasks.cancel(cancel_id))
    assert(ccb.tasks.get(cancel_id) == nil)
    ccb.tasks.after(0, "new")
end)
ccb.runtime.handler("cancelled", function() ran_cancelled = ran_cancelled + 1 end)
ccb.runtime.handler("last", function()
    ran_last = ran_last + 1
    assert(ran_first == 1 and ran_cancelled == 0 and ran_new == 0)
end)
ccb.runtime.handler("new", function() ran_new = ran_new + 1 end)
)lua", sol::script_pass_on_error );
    REQUIRE( setup.valid() );
    platform::set_active_runtimes( { owner } );
    platform::runtime_world_ready( true );
    const sol::protected_function_result scheduled = lua.safe_script( R"lua(
ccb.tasks.after(0, "first")
cancel_id = ccb.tasks.after(0, "cancelled")
ccb.tasks.after(0, "last")
)lua", sol::script_pass_on_error );
    REQUIRE( scheduled.valid() );
    platform::runtime_process_tasks();
    CHECK( lua["ran_first"].get<int>() == 1 );
    CHECK( lua["ran_cancelled"].get<int>() == 0 );
    CHECK( lua["ran_last"].get<int>() == 1 );
    CHECK( lua["ran_new"].get<int>() == 0 );
    REQUIRE( owner->tasks.size() == 1 );
    CHECK( owner->tasks.front().handler_id == "new" );
    platform::runtime_process_tasks();
    CHECK( lua["ran_new"].get<int>() == 1 );
    CHECK( owner->tasks.empty() );
}

} // namespace merged_lua_platform_due_task_cancel_test

namespace merged_lua_platform_gameplay_math_semantics_test
{

TEST_CASE( "lua_platform_gameplay_math_requires_ordinary_lua",
           "[lua][platform][gameplay][numeric_migration]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();

    avatar alpha;
    alpha.normalize();
    alpha.setID( character_id( 6511 ), true );
    alpha.set_value( "lua_math_composition_source", 5.25 );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math, sol::lib::table );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
            "gameplay_math_removed", 6512, lua );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    owner->world_is_ready = true;

    const std::size_t world_generation = platform::detail::runtime_world_generation_storage();
    lua["ccb"] = ccb;
    lua["actor"] = platform::game_handle::from_creature(
                       alpha, { "avatar", 6511, 0, 0, 0, {} },
                       owner->handle_runtime(), world_generation );

    platform::detail::callback_scope active_callback( *owner );
    const sol::protected_function_result result = lua.safe_script( R"(
        local services = ccb.services
        assert(services.gameplay.math == nil)

        local source = services.variables.get_number(
            actor, "lua_math_composition_source", { strict = true })
        assert(source.ok and source.value.exists and source.value.value == 5.25)

        local computed = source.value.value * 2 + math.sqrt(4)
        assert(computed == 12.5)

        local stored = services.variables.set(
            actor, "lua_math_composition_result", computed,
            { include_before = false })
        assert(stored.ok)
        local result = services.variables.get_number(
            actor, "lua_math_composition_result", { strict = true })
        assert(result.ok and result.value.exists and result.value.value == computed)
    )", sol::script_pass_on_error );
    if( !result.valid() ) {
        const sol::error error = result;
        INFO( error.what() );
    }
    REQUIRE( result.valid() );
}

} // namespace merged_lua_platform_gameplay_math_semantics_test

namespace merged_lua_platform_item_group_order_test
{

TEST_CASE( "lua_platform_item_group_native_order", "[lua][items]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    cata::lua_platform::install_item_api(
    services, []() {
        return cata::lua_platform::game_handle_runtime();
    },
    []() {
        return std::size_t( 1 );
    }, []() {}, []() {} );
    const item_group_id group( "forest" );
    std::vector<std::string> native;
    for( const itype *entry : item_group::every_possible_item_from( group ) ) {
        REQUIRE( entry != nullptr );
        native.push_back( entry->get_id().str() );
    }
    REQUIRE( native.size() > 1 );
    std::vector<std::string> sorted = native;
    std::sort( sorted.begin(), sorted.end() );
    sorted.erase( std::unique( sorted.begin(), sorted.end() ), sorted.end() );
    sol::protected_function list = services["items"]["possible_from_group"];
    const cata::lua_platform::script_game_id id( "item_group", group.str() );
    for( const std::string &order : {
             std::string( "native" ), std::string(),
             std::string( "id" )
         } ) {
        sol::table options = lua.create_table();
        if( !order.empty() ) {
            options["order"] = order;
        }
        sol::protected_function_result call = order.empty() ? list( id ) : list( id, options );
        REQUIRE( call.valid() );
        sol::table page = call;
        sol::table items = page["items"];
        const auto &expected = order == "native" ? native : sorted;
        CHECK( page["total"].get<std::size_t>() == expected.size() );
        REQUIRE( items.size() == expected.size() );
        for( std::size_t index = 0; index < expected.size(); ++index ) {
            CHECK( items[index + 1].get<cata::lua_platform::script_game_id>().value() ==
                   expected[index] );
        }
    }
    sol::table invalid = lua.create_table();
    invalid["order"] = "invalid";
    CHECK_FALSE( list( id, invalid ).valid() );
    invalid["order"] = true;
    CHECK_FALSE( list( id, invalid ).valid() );
    invalid["order"] = sol::nil;
    invalid["limit"] = 1;
    CHECK_FALSE( list( id, invalid ).valid() );
}

} // namespace merged_lua_platform_item_group_order_test

namespace merged_lua_platform_item_patch_fingerprint_test
{

TEST_CASE( "lua_platform_item_patch_fingerprint_distinguishes_omitted_fields",
           "[lua][platform][content][reload]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory files;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    const platform::mod_source source {
        "item-patch-fingerprint", files.root, files.root / std::filesystem::u8path( "main.lua" )
    };
    const auto fingerprint = [&]( const std::string & field ) {
        files.write( std::filesystem::u8path( "main.lua" ), "local ccb = require('ccb')\n"
                                              "ccb.content.add(ccb.content.Item { id = 'lua_patch_fingerprint_item', "
                                              "copy_from = 'rock', " + field + " })\n" );
        std::string error;
        const bool prepared = platform::prepare_mods( { source }, error );
        INFO( error );
        REQUIRE( prepared );
        const std::string result = platform::prepared_content_fingerprint();
        platform::discard_prepared_mods();
        return result;
    };
    const std::string inherited = fingerprint( "" );
    REQUIRE_FALSE( inherited.empty() );
    CHECK( fingerprint( "" ) == inherited );
    // These explicit values equal the C++ defaults of omitted fields, but
    // applying them replaces rather than inherits the source item's values.
    for( const char *field : {
             "name = ''", "description = ''", "symbol = '?'", "mass_grams = 0",
             "volume_ml = 0", "price_cents = 0", "price_postapoc_cents = 0",
             "color = 'white'"
         } ) {
        INFO( field );
        const std::string overridden = fingerprint( field );
        CHECK( overridden != inherited );
        CHECK( fingerprint( field ) == overridden );
    }
}

} // namespace merged_lua_platform_item_patch_fingerprint_test

namespace merged_lua_platform_mounted_charge_test
{

TEST_CASE( "lua_platform_mounted_charge_damage_validates_results_and_snapshots",
           "[lua][platform][mounted][charge]" )
{
    namespace platform = cata::lua_platform;
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math );
    sol::table ccb = lua.create_table();
    const auto owner = platform::make_runtime( "charge-damage-test", 4301, lua );
    const auto previous = platform::detail::active_runtimes;
    const on_out_of_scope cleanup( [previous]() {
        platform::set_active_runtimes( previous );
        debug_reset_error_observed();
    } );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    owner->world_is_ready = true;
    lua["ccb"] = ccb;

    const std::string body = GENERATE(
                                 std::string( "return 1.25" ), std::string( "return -10" ),
                                 std::string( "return 10" ), std::string( "return 'invalid'" ),
                                 std::string( "return 0/0" ), std::string( "return math.huge" ),
                                 std::string( "return 1.1, 1.2" ), std::string( "return" ),
                                 std::string( "error('charge damage sentinel')" ) );
    CAPTURE( body );
    const sol::protected_function_result registration = lua.safe_script( R"lua(
ccb.runtime.handler("damage", function(context)
    assert(context.technique_id == "MOUNTED_CHARGE")
    assert(context.character ~= nil)
    assert(type(context.weapon_id) == "string")
    assert(context.completed_steps == 3)
    assert(context.mount_speed == 123.5)
    assert(type(context.running) == "boolean")
    assert(context.damage_type == "stab")
    assert(math.abs(context.multiplier_per_step - 0.1) < 0.00001)
    assert(context.max_multiplier == 1.5)
)lua" + body + "\nend, 1)", sol::script_pass_on_error );
    REQUIRE( registration.valid() );
    mounted_charge_profile profile;
    profile.max_steps = 15;
    const std::optional<double> multiplier = platform::invoke_mounted_charge_damage_handler(
            "MOUNTED_CHARGE", "charge-damage-test", "damage", get_avatar(), profile, 3, 123.5 );
    if( body == "return 1.25" ) {
        REQUIRE( multiplier.has_value() );
        CHECK( *multiplier == Approx( 1.25 ) );
    } else if( body == "return -10" ) {
        REQUIRE( multiplier.has_value() );
        CHECK( *multiplier == 1.0 );
    } else if( body == "return 10" ) {
        REQUIRE( multiplier.has_value() );
        CHECK( *multiplier == 1.5 );
    } else {
        CHECK_FALSE( multiplier.has_value() );
        CHECK( debug_has_error_been_observed() );
    }
    CHECK( owner->callback_depth == 0 );
    CHECK_FALSE( platform::invoke_mounted_charge_damage_handler(
                     "MOUNTED_CHARGE", "charge-damage-test", "missing", get_avatar(), profile, 3,
                     123.5 ).has_value() );
    owner->world_is_ready = false;
    CHECK_FALSE( platform::invoke_mounted_charge_damage_handler(
                     "MOUNTED_CHARGE", "charge-damage-test", "damage", get_avatar(), profile, 3,
                     123.5 ).has_value() );
}

} // namespace merged_lua_platform_mounted_charge_test

namespace merged_lua_platform_persistent_integer_test
{

namespace
{
class source_less_flexbuffer : public parsed_flexbuffer
{
    public:
        explicit source_less_flexbuffer( const std::shared_ptr<flexbuffer_storage> &storage ) :
            parsed_flexbuffer( storage ) {}

        bool is_stale() const override {
            return false;
        }
        std::unique_ptr<std::istream> get_source_stream() const override {
            return nullptr;
        }
        std::filesystem::path get_source_path() const noexcept override {
            return {};
        }
};

JsonValue parse_without_source( const std::string &input )
{
    const std::shared_ptr<parsed_flexbuffer> parsed = flexbuffer_cache::parse_buffer( input );
    const std::shared_ptr<parsed_flexbuffer> source_less =
        std::make_shared<source_less_flexbuffer>( parsed->get_storage() );
    return JsonValue( source_less, flexbuffer_root_from_storage( source_less->get_storage() ),
                      nullptr, 0 );
}
} // namespace

TEST_CASE( "lua_platform_persistent_coordinates_preserve_integer_bounds",
           "[lua][platform][semantic][state]" )
{
    const cata::lua_platform::script_persistent_value value =
        cata::lua_platform::detail::read_persistent_value( json_loader::from_string(
                R"({"type":"tripoint_abs_ms","value":[2147483647,-2147483648,0]})" ).get_object() );
    const cata::lua_platform::script_persistent_tripoint &coordinate =
        std::get<cata::lua_platform::script_persistent_tripoint>( value );
    CHECK( coordinate.value.x == std::numeric_limits<int>::max() );
    CHECK( coordinate.value.y == std::numeric_limits<int>::min() );
    CHECK( coordinate.value.z == 0 );
}

TEST_CASE( "lua_platform_persistent_coordinates_preserve_codec",
           "[lua][platform][semantic][state][persistence]" )
{
    namespace platform = cata::lua_platform;
    const platform::script_persistent_value value = platform::script_persistent_tripoint{
        tripoint( std::numeric_limits<int>::max(), std::numeric_limits<int>::min(), 0 )
    };
    std::ostringstream output;
    JsonOut json( output );
    json.start_object();
    platform::detail::write_persistent_value( json, value );
    json.end_object();
    CHECK( output.str() == R"({"type":"tripoint_abs_ms","value":[2147483647,-2147483648,0]})" );
    const platform::script_persistent_value restored = platform::detail::read_persistent_value(
            json_loader::from_string( output.str() ).get_object() );
    CHECK( restored == value );
}

TEST_CASE( "lua_platform_persistent_coordinates_reject_integer_overflow",
           "[lua][platform][semantic][state]" )
{
    const std::string component = GENERATE( "2147483648", "-2147483649",
                                            "18446744073709551615" );
    const std::string input = R"({"type":"tripoint_abs_ms","value":[)" + component + ",0,0]}";
    CHECK_THROWS( cata::lua_platform::detail::read_persistent_value(
                      json_loader::from_string( input ).get_object() ) );
}

TEST_CASE( "lua_platform_persistent_coordinates_read_source_less_flexbuffers",
           "[lua][platform][semantic][state]" )
{
    const JsonValue root = parse_without_source(
                               R"({"type":"tripoint_abs_ms","value":[2147483647,-2147483648,0]})" );
    const cata::lua_platform::script_persistent_value value =
        cata::lua_platform::detail::read_persistent_value( root.get_object() );
    const cata::lua_platform::script_persistent_tripoint &coordinate =
        std::get<cata::lua_platform::script_persistent_tripoint>( value );
    CHECK( coordinate.value.x == std::numeric_limits<int>::max() );
    CHECK( coordinate.value.y == std::numeric_limits<int>::min() );
    CHECK( coordinate.value.z == 0 );
}

TEST_CASE( "lua_platform_persistent_coordinates_reject_source_less_overflow",
           "[lua][platform][semantic][state]" )
{
    const std::string component = GENERATE( "2147483648", "-2147483649" );
    const JsonValue root = parse_without_source(
                               R"({"type":"tripoint_abs_ms","value":[)" + component + ",0,0]}" );
    CHECK_THROWS( cata::lua_platform::detail::read_persistent_value( root.get_object() ) );
}

} // namespace merged_lua_platform_persistent_integer_test

namespace merged_lua_platform_profession_test
{

namespace
{
struct profession_test_mod : platform_lua_test_directory {
    ~profession_test_mod() {
        cata::lua_platform::shutdown();
    }
    cata::lua_platform::mod_source source( const std::string &id ) const {
        return { id, root, root / "main.lua" };
    }
};
} // namespace

TEST_CASE( "lua_platform_profession_resolves_staged_traits",
           "[lua][platform][content][profession]" )
{
    cata::lua_platform::shutdown();
    profession_test_mod files;
    const bool invalid_variant = GENERATE( false, true );
    files.write( "main.lua", std::string( R"lua(
local ccb = require("ccb")
local profession = ccb.content.Profession {
    id = "platform_staged_trait_profession", name = "Staged trait profession",
    description = "Exercises same-transaction trait references.", points = 0,
}
profession:trait("platform_staged_trait", ")lua" ) +
                 ( invalid_variant ? "missing" : "golden" ) + R"lua(")
profession:forbid_trait("platform_staged_forbidden")
ccb.content.add(profession)
-- Deliberately declare the referenced mutations after the profession.
local mutation = ccb.content.Mutation {
    id = "platform_staged_trait", name = "Staged trait",
    description = "A mutation declared in the same transaction.",
}
mutation:variant { id = "golden", name = "Golden", description = "Golden fur.", weight = 1 }
ccb.content.add(mutation)
ccb.content.add(ccb.content.Mutation {
    id = "platform_staged_forbidden", name = "Forbidden staged trait",
    description = "A forbidden mutation declared in the same transaction.",
})
)lua" );
    std::string error;
    REQUIRE( cata::lua_platform::prepare_mods( { files.source( "profession_staged_traits" ) },
            error ) );
    CAPTURE( error );
    REQUIRE( cata::lua_platform::apply_prepared_content( error ) );
    const profession_id id( "platform_staged_trait_profession" );
    REQUIRE( id.is_valid() );
    if( invalid_variant ) {
        CHECK_FALSE( cata::lua_platform::validate_finalized_prepared_content( error ) );
        CHECK( error.find( "invalid finalized trait" ) != std::string::npos );
    } else {
        REQUIRE( cata::lua_platform::validate_finalized_prepared_content( error ) );
        const auto traits = id->get_locked_traits();
        REQUIRE( traits.size() == 1 );
        CHECK( traits.front().trait == trait_id( "platform_staged_trait" ) );
        CHECK( traits.front().variant == "golden" );
        CHECK( id->get_forbidden_traits().count( trait_id( "platform_staged_forbidden" ) ) == 1 );
    }
    cata::lua_platform::discard_prepared_mods();
    CHECK_FALSE( id.is_valid() );
    CHECK_FALSE( trait_id( "platform_staged_trait" ).is_valid() );
    CHECK_FALSE( trait_id( "platform_staged_forbidden" ).is_valid() );
}

TEST_CASE( "lua_platform_profession_rejects_invalid_trait_references",
           "[lua][platform][content][profession]" )
{
    cata::lua_platform::shutdown();
    profession_test_mod files;
    std::string references;
    SECTION( "unknown starting trait" ) {
        references = "profession:trait('platform_missing_trait', '')";
    }
    SECTION( "unknown forbidden trait" ) {
        references = "profession:forbid_trait('platform_missing_trait')";
    }
    SECTION( "duplicate staged trait" ) {
        references = "profession:trait('platform_staged_trait', '')\n"
                     "profession:trait('platform_staged_trait', '')";
    }
    SECTION( "contradictory staged trait" ) {
        references = "profession:trait('platform_staged_trait', '')\n"
                     "profession:forbid_trait('platform_staged_trait')";
    }
    files.write( "main.lua", std::string( R"lua(
local ccb = require("ccb")
ccb.content.add(ccb.content.Mutation {
    id = "platform_staged_trait", name = "Staged trait", description = "Test trait.",
})
local profession = ccb.content.Profession {
    id = "platform_invalid_trait_profession", name = "Invalid trait profession",
    description = "Must be rejected without publishing content.", points = 0,
}
)lua" ) + references + "\nccb.content.add(profession)\n" );
    std::string error;
    const bool prepared = cata::lua_platform::prepare_mods(
    { files.source( "profession_invalid_traits" ) }, error );
    const bool applied = prepared && cata::lua_platform::apply_prepared_content( error );
    CHECK_FALSE( applied );
    CHECK( error.find( "trait" ) != std::string::npos );
    cata::lua_platform::discard_prepared_mods();
    CHECK_FALSE( profession_id( "platform_invalid_trait_profession" ).is_valid() );
    CHECK_FALSE( trait_id( "platform_staged_trait" ).is_valid() );
}

} // namespace merged_lua_platform_profession_test

namespace merged_lua_platform_recurring_turn_range_test
{

TEST_CASE( "lua_platform_character_recurrence_rejects_unrepresentable_saved_turns",
           "[lua][platform][runtime][recurring]" )
{
    cata::lua_platform::clear_active_runtimes();
    sol::state lua;
    sol::table ccb = lua.create_table();
    const std::shared_ptr<cata::lua_platform::runtime> runtime =
        cata::lua_platform::make_runtime( "recurring-turn-range", 1903, lua );
    on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    int effect_calls = 0;
    int interval_calls = 0;
    bool first_schedule = false;
    lua.set_function( "effect", [&effect_calls]() {
        ++effect_calls;
    } );
    lua.set_function( "interval", [&interval_calls, &first_schedule]( const sol::table & payload ) {
        ++interval_calls;
        first_schedule = payload["first_schedule"].get<bool>();
        return 10;
    } );
    for( const char *handler : {
             "effect", "interval"
         } ) {
        const sol::protected_function_result registered =
            ccb["runtime"]["handler"]( handler, lua[handler] );
        REQUIRE( registered.valid() );
    }
    const sol::protected_function_result policy =
        ccb["runtime"]["character_recurring"]( "effect", "interval" );
    REQUIRE( policy.valid() );
    REQUIRE( runtime->character_recurring_handlers.size() == 1 );
    const std::string due_variable = runtime->character_recurring_handlers.front().due_variable;
    cata::lua_platform::runtime_world_ready( true );
    npc actor;
    actor.normalize();
    actor.setID( character_id( 1903 ), true );

    const double upper_bound =
        -static_cast<double>( std::numeric_limits<std::int64_t>::min() );
    SECTION( "rounded maximum does not become a negative due turn" ) {
        actor.set_value( due_variable, upper_bound );
        cata::lua_platform::runtime_process_character_recurring( actor );
        CHECK( effect_calls == 0 );
        CHECK( interval_calls == 1 );
        CHECK( first_schedule );
    }
    SECTION( "largest representable in-range double remains a future due turn" ) {
        actor.set_value( due_variable, std::nextafter( upper_bound, 0.0 ) );
        cata::lua_platform::runtime_process_character_recurring( actor );
        CHECK( effect_calls == 0 );
        CHECK( interval_calls == 0 );
    }
    SECTION( "fractional due state is rescheduled without invoking the effect" ) {
        actor.set_value( due_variable, 0.5 );
        cata::lua_platform::runtime_process_character_recurring( actor );
        CHECK( effect_calls == 0 );
        CHECK( interval_calls == 1 );
        CHECK( first_schedule );
    }
}

} // namespace merged_lua_platform_recurring_turn_range_test

namespace merged_lua_platform_registry_order_test
{

TEST_CASE( "lua_platform_registry_native_order_pages", "[lua][registry]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    cata::lua_platform::install_registry_api( lua, services, []() {}, []() {} );
    for( const std::string &kind : {
             std::string( "body_part" ), std::string( "json_flag" )
         } ) {
        std::vector<std::string> native;
        if( kind == "body_part" ) {
            for( const body_part_type &entry : body_part_type::get_all() ) {
                native.push_back( entry.id.str() );
            }
        } else {
            for( const json_flag &entry : json_flag::get_all() ) {
                native.push_back( entry.id.str() );
            }
        }
        REQUIRE_FALSE( native.empty() );
        std::vector<std::string> sorted = native;
        std::sort( sorted.begin(), sorted.end() );
        for( const bool typed : {
                 false, true
             } ) {
            sol::table api = typed ? services["registry"]["definitions"].get<sol::table>() :
                             services["registry"].get<sol::table>();
            sol::protected_function list = api["list"];
            // Alternate orders against the same catalog to exercise cached indexes.
            for( const std::string &order : {
                     std::string( "native" ), std::string(), std::string( "id" ), std::string( "native" )
                 } ) {
                const auto &expected = order == "native" ? native : sorted;
                for( std::size_t offset = 0; offset < expected.size(); offset += 17 ) {
                    sol::table options = lua.create_table();
                    if( !order.empty() ) {
                        options["order"] = order;
                    }
                    options["offset"] = offset;
                    options["limit"] = 17;
                    sol::protected_function_result call = list( kind, options );
                    REQUIRE( call.valid() );
                    sol::table page = call;
                    sol::table entries = page["entries"];
                    REQUIRE( entries.size() == std::min<std::size_t>( 17, expected.size() - offset ) );
                    for( std::size_t index = 1; index <= entries.size(); ++index ) {
                        sol::table entry = entries[index];
                        const std::string id = typed ? entry["id"].get<cata::lua_platform::script_game_id>().value() :
                                               entry["id"].get<std::string>();
                        CHECK( id == expected[offset + index - 1] );
                    }
                }
            }
            sol::table invalid = lua.create_table();
            invalid["order"] = "invalid";
            CHECK_FALSE( list( kind, invalid ).valid() );
            invalid["order"] = 1;
            CHECK_FALSE( list( kind, invalid ).valid() );
        }
    }
}

} // namespace merged_lua_platform_registry_order_test

namespace merged_lua_platform_sound_test
{

static const efftype_id effect_sleep( "sleep" );

TEST_CASE( "lua_platform_audible_sound_reports_the_native_hearing_gate",
           "[lua][platform][sound][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    sol::state lua;
    lua.open_libraries( sol::lib::base );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
            "lua_platform_sound_test", 6107, lua );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    owner->world_is_ready = true;
    lua["ccb"] = ccb;

    avatar &player = get_avatar();
    const bool already_sleeping = player.has_effect( effect_sleep );
    if( !already_sleeping ) {
        player.add_effect( effect_sleep, 10_turns );
    }
    const on_out_of_scope restore_sleep( [&player, already_sleeping]() {
        if( !already_sleeping ) {
            player.remove_effect( effect_sleep );
        }
    } );

    platform::detail::callback_scope active_callback( *owner );
    const sol::protected_function_result result = lua.safe_script( R"(
        local played = ccb.services.sound.play_if_audible(
            "bionics", "sound_test", 20)
        assert(played == false)
        assert(not pcall(ccb.services.sound.play_if_audible,
            "bionics", "sound_test", 129))
    )", sol::script_pass_on_error );
    if( !result.valid() ) {
        const sol::error error = result;
        INFO( error.what() );
    }
    REQUIRE( result.valid() );

    const sol::protected_function_result emit_result = lua.safe_script( R"(
        local snapshot = ccb.services.characters.snapshot(
            ccb.services.characters.avatar())
        assert(snapshot.ok)
        ccb.services.sound.emit(
            snapshot.value.creature.position, 0, "background",
            ccb.services.translate("A faint sound."), false)
        assert(not pcall(ccb.services.sound.emit,
            snapshot.value.creature.position, 1001, "background", "too loud", false))
    )", sol::script_pass_on_error );
    if( !emit_result.valid() ) {
        const sol::error error = emit_result;
        INFO( error.what() );
    }
    REQUIRE( emit_result.valid() );
}

} // namespace merged_lua_platform_sound_test

namespace merged_lua_platform_state_keys_test
{

TEST_CASE( "lua_platform_state_keys_are_paged_and_owner_scoped",
           "[lua][platform][state]" )
{
    namespace platform = cata::lua_platform;
    platform::shutdown();
    const platform_lua_test_directory first;
    const platform_lua_test_directory second;
    const on_out_of_scope cleanup( []() {
        platform::shutdown();
    } );
    first.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
assert(not pcall(ccb.state.world.keys))
ccb.runtime.handler("initialize", function()
    ccb.state.world.set("zeta", 3)
    ccb.state.world.set("alpha", "kept private")
    ccb.state.world.set("middle", true)
    ccb.state.character.set("character_only", 1)
end)
ccb.runtime.on("world_ready", "initialize")
)lua" );
    second.write( std::filesystem::u8path( "main.lua" ), R"lua(
local ccb = require("ccb")
ccb.runtime.handler("initialize", function()
    ccb.state.world.set("other_mod_only", 99)
end)
ccb.runtime.on("world_ready", "initialize")
)lua" );
    std::string error;
    REQUIRE( platform::prepare_mods( {
        { "state-keys-first", first.root, first.root / std::filesystem::u8path( "main.lua" ) },
        { "state-keys-second", second.root, second.root / std::filesystem::u8path( "main.lua" ) }
    }, error ) );
    REQUIRE( platform::apply_prepared_content( error ) );
    REQUIRE( platform::validate_finalized_prepared_content( error ) );
    platform::commit_prepared_mods();
    platform::runtime_world_ready( true );
    const std::shared_ptr<platform::runtime> owner = platform::detail::find_active_runtime(
            "state-keys-first" );
    REQUIRE( owner );
    const auto run = [&owner]( const std::string_view source ) {
        const sol::protected_function_result result = owner->lua->safe_script(
                source, sol::script_pass_on_error );
        if( !result.valid() ) {
            const sol::error failure = result;
            INFO( failure.what() );
            REQUIRE( result.valid() );
        }
    };
    run( R"lua(
local ccb = require("ccb")
local page = ccb.state.world.keys(nil, 2)
assert(page.total == 3 and page.matched == 3 and page.returned == 2 and page.limit == 2)
assert(page.items[1] == "alpha" and page.items[2] == "middle")
assert(page.truncated and page.next_after == "middle")
assert(page.values == nil)
local tail = ccb.state.world.keys(page.next_after, 2)
assert(tail.total == 3 and tail.matched == 1 and tail.returned == 1)
assert(tail.items[1] == "zeta" and not tail.truncated and tail.next_after == nil)
assert(ccb.state.world.keys("nonexistent").items[1] == "zeta")
assert(ccb.state.world.keys("zzzz").returned == 0)
assert(ccb.state.world.keys().limit == 20)
assert(ccb.state.character.keys().items[1] == "character_only")
page.items[1] = "modified snapshot"
assert(ccb.state.world.get("alpha") == "kept private")
assert(ccb.state.world.keys(nil, 1).items[1] == "alpha")
assert(not pcall(ccb.state.world.keys, nil, 0))
assert(not pcall(ccb.state.world.keys, nil, 201))
ccb.state.world.set("binary\0key", 1)
local binary_page = ccb.state.world.keys("alpha", 1)
assert(binary_page.items[1] == "binary\0key")
assert(ccb.state.world.keys(binary_page.next_after, 1).items[1] == "middle")
ccb.state.world.set("middle", nil)
assert(ccb.state.world.keys().total == 3)
ccb.state.world.set("中文", 1)
assert(ccb.state.world.keys("zeta", 1).items[1] == "中文")
saved_keys = ccb.state.world.keys
)lua" );
    platform::clear_active_runtimes();
    run( "assert(not pcall(saved_keys))" );
}

} // namespace merged_lua_platform_state_keys_test

namespace merged_lua_platform_string_comparison_test
{

TEST_CASE( "lua_platform_string_comparison_native_short_circuit_contract",
           "[lua][platform][string_comparison][semantic]" )
{
    avatar player;
    npc partner;
    player.normalize();
    partner.normalize();
    player.set_value( "comparison", "alpha" );
    partner.set_value( "comparison", "alpha" );
    dialogue context( get_talker_for( player ), get_talker_for( partner ) );
    const auto evaluate = [&context]( const std::string & input ) {
        const conditional_t condition( json_loader::from_string( input ).get_object() );
        return condition( context );
    };
    // Evaluating the final mutator would request an invalid game option.
    // A decisive pair must prevent that evaluation entirely.
    CHECK( evaluate(
               R"({"compare_string":[{"u_val":"comparison"},{"npc_val":"comparison"},{"mutator":"game_option","option":"INVALID_UNREACHED_OPTION"}]})" ) );
    partner.set_value( "comparison", "beta" );
    CHECK_FALSE( evaluate(
                     R"({"compare_string_match_all":[{"u_val":"comparison"},{"npc_val":"comparison"},{"mutator":"game_option","option":"INVALID_UNREACHED_OPTION"}]})" ) );
    CHECK_FALSE( evaluate( R"({"compare_string":[]})" ) );
    CHECK_FALSE( evaluate( R"({"compare_string":["only"]})" ) );
    CHECK( evaluate( R"({"compare_string_match_all":["only"]})" ) );
    CHECK_FALSE( evaluate( R"({"compare_string":["a","b","c"]})" ) );
    CHECK( evaluate( R"({"compare_string_match_all":["a","a","a"]})" ) );
}

} // namespace merged_lua_platform_string_comparison_test

namespace merged_lua_platform_technique_cooldown_test
{

static const matec_id test_active_cooldown_strike( "test_active_cooldown_strike" );

TEST_CASE( "lua_platform_technique_cooldown_validates_results_and_preserves_native_fallback",
           "[lua][platform][active_technique][cooldown]" )
{
    namespace platform = cata::lua_platform;
    const auto previous = platform::detail::active_runtimes;
    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math );
    const auto owner = platform::make_runtime( "cooldown-test", 9011, lua );
    sol::table ccb = lua.create_table();
    platform::install_runtime_api( owner, lua, ccb );
    lua["ccb"] = ccb;
    platform::set_active_runtimes( { owner } );
    owner->world_is_ready = true;
    const on_out_of_scope cleanup( [&previous]() {
        platform::set_active_runtimes( previous );
        debug_reset_error_observed();
    } );
    avatar character;
    character.normalize();
    character.setID( character_id( 9012 ), true );
    ma_technique technique;
    technique.id = test_active_cooldown_strike;
    technique.cooldown = 8_seconds;
    technique.lua_platform_mod = "cooldown-test";
    technique.lua_platform_cooldown_handler = "unavailable";
    CHECK( technique.activation_cooldown( character ) == 8_seconds );

    const std::vector<std::string> results = {
        "context.base_cooldown_seconds / 2", "0.1", "0", "86400",
        "nil", "true", "'4'", "-1", "86401", "0/0", "math.huge", "2, 3", "error('test failure')"
    };
    for( std::size_t index = 0; index < results.size(); ++index ) {
        INFO( results[index] );
        const std::string handler = "duration_" + std::to_string( index );
        const sol::protected_function_result registered = lua.safe_script(
                "ccb.runtime.handler('" + handler + "', function(context) "
                "assert(context.technique_id == 'test_active_cooldown_strike') "
                "assert(context.character ~= nil) "
                "assert(context.weapon_id == '') "
                "assert(context.base_cooldown_seconds == 8) "
                "return " + results[index] + " end)", sol::script_pass_on_error );
        REQUIRE( registered.valid() );
        technique.lua_platform_cooldown_handler = handler;
        const std::vector<time_duration> expected = { 4_seconds, 1_seconds, 0_seconds, 1_days };
        CHECK( technique.activation_cooldown( character ) ==
               ( index < expected.size() ? expected[index] : 8_seconds ) );
        CHECK( owner->callback_depth == 0 );
    }
    owner->world_is_ready = false;
    CHECK( technique.activation_cooldown( character ) == 8_seconds );
}

TEST_CASE( "lua_platform_technique_state_is_a_detached_read_only_cooldown_snapshot",
           "[lua][platform][active_technique][cooldown]" )
{
    namespace platform = cata::lua_platform;
    const auto previous = platform::detail::active_runtimes;
    sol::state lua;
    const auto owner = platform::make_runtime( "cooldown-state", 9013, lua );
    sol::table ccb = lua.create_table();
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    owner->world_is_ready = true;
    const on_out_of_scope cleanup( [&previous]() {
        platform::set_active_runtimes( previous );
    } );
    avatar character;
    character.normalize();
    character.setID( character_id( 9014 ), true );
    const matec_id &technique = test_active_cooldown_strike;
    character.martial_arts_data->start_technique_cooldown( technique, 8_seconds );
    const platform::game_handle handle = platform::game_handle::from_creature(
            character, { "avatar", character.getID().get_value(), 0, 0, 0, {} },
            platform::detail::runtime_handle_identity( owner ), platform::runtime_world_generation() );
    sol::protected_function get_state = ccb["services"]["martial_arts"]["technique_state"];
    const platform::script_game_id id( "martial_art_technique", technique.str() );
    sol::protected_function_result call = get_state( handle, id );
    REQUIRE( call.valid() );
    sol::table result = call;
    REQUIRE( result["ok"].get<bool>() );
    sol::table snapshot = result["value"];
    CHECK( snapshot["remaining_seconds"].get<double>() == 8.0 );
    CHECK( snapshot["base_cooldown_seconds"].get<double>() == 8.0 );
    snapshot["remaining_seconds"] = 0;
    CHECK( character.martial_arts_data->technique_cooldown_remaining( technique ) == 8_seconds );
    call = get_state( handle, platform::script_game_id( "item", "rock" ) );
    CHECK_FALSE( call.valid() );
}

} // namespace merged_lua_platform_technique_cooldown_test

namespace merged_lua_platform_vitamin_definitions_test
{

TEST_CASE( "lua_platform_vitamin_definition_order", "[lua][vitamins]" )
{
    sol::state lua;
    sol::table services = lua.create_table();
    auto owner = cata::lua_platform::make_game_handle_runtime_owner();
    cata::lua_platform::game_handle_runtime runtime{ owner, 1 };
    cata::lua_platform::install_value_type_api( lua, services, []() {} );
    cata::lua_platform::install_vitamin_api( services, [runtime]() {
        return runtime;
    }, []() {
        return std::size_t{ 1 };
    }, []() {}, []() {} );
    sol::protected_function definitions = services["vitamins"]["definitions"];
    CHECK( vitamin_id( "blood" )->rate() == -6_seconds );
    CHECK( vitamin_id( "redcells" )->rate() == -12_seconds );
    const auto chelator = vitamin_id( "mutagen_chelator" )->decays_into();
    REQUIRE_FALSE( chelator.empty() );
    CHECK( chelator.front().first == vitamin_id( "mutagen" ) );
    CHECK( chelator.front().second == -2 );
    const auto &native = vitamin::all();
    REQUIRE( native.size() > 2 );
    std::vector<std::string> sorted;
    for( const vitamin &definition : native ) {
        sorted.push_back( definition.get_id().str() );
    }
    std::sort( sorted.begin(), sorted.end() );
    for( const std::string &order : {
             std::string( "native" ), std::string( "id" ), std::string()
         } ) {
        sol::table options = lua.create_table();
        if( !order.empty() ) {
            options["order"] = order;
        }
        options["offset"] = 1;
        options["limit"] = 2;
        sol::protected_function_result call = definitions( options );
        REQUIRE( call.valid() );
        sol::table page = call;
        sol::table items = page["items"];
        REQUIRE( items.size() == 2 );
        for( std::size_t index = 1; index <= 2; ++index ) {
            sol::table item = items[index];
            const std::string expected = order == "native" ? native[index].get_id().str() : sorted[index];
            CHECK( item["id"].get<cata::lua_platform::script_game_id>().value() == expected );
        }
    }
    const auto lower = []( std::string text ) {
        std::transform( text.begin(), text.end(), text.begin(), []( unsigned char ch ) {
            return static_cast<char>( std::tolower( ch ) );
        } );
        return text;
    };
    const std::string query = "a";
    std::vector<std::string> expected_filtered;
    for( const vitamin &definition : native ) {
        if( lower( definition.get_id().str() ).find( query ) != std::string::npos ||
            lower( definition.name() ).find( query ) != std::string::npos ) {
            expected_filtered.push_back( definition.get_id().str() );
        }
    }
    REQUIRE_FALSE( expected_filtered.empty() );
    for( std::size_t offset = 0; offset < expected_filtered.size(); ++offset ) {
        sol::table options = lua.create_table();
        options["order"] = "native";
        options["query"] = query;
        options["offset"] = offset;
        options["limit"] = 1;
        sol::protected_function_result call = definitions( options );
        REQUIRE( call.valid() );
        sol::table page = call;
        CHECK( page["total"].get<std::size_t>() == expected_filtered.size() );
        sol::table item = page["items"][1];
        CHECK( item["id"].get<cata::lua_platform::script_game_id>().value() == expected_filtered[offset] );
    }
    sol::table invalid = lua.create_table();
    invalid["order"] = "invalid";
    CHECK_FALSE( definitions( invalid ).valid() );
    invalid["order"] = false;
    CHECK_FALSE( definitions( invalid ).valid() );
}

} // namespace merged_lua_platform_vitamin_definitions_test

#endif // CATA_ENABLE_LUA_PLATFORM
