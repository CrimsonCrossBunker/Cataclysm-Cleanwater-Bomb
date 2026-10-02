#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <array>
#include <cmath>
#include <memory>
#include <optional>
#include <string>
#include <string_view>
#include <type_traits>
#include <utility>
#include <variant>
#include <vector>

#include "avatar.h"
#include "bodypart.h"
#include "character.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character_id.h"
#include "condition.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "effect.h"
#include "json_loader.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_runtime_internal.h"
#include "lua_platform_sol.h"
#include "math_parser_diag_value.h"
#include "npc.h"
#include "rng.h"
#include "units.h"

namespace
{

enum class effect_target {
    alpha,
    beta
};

using variable_value = std::variant<std::monostate, double, std::string_view>;

struct effect_case {
    std::string_view name;
    std::string_view input_json;
    effect_target target;
    std::size_t output_index;
    variable_value alpha_duration;
    variable_value beta_duration;
    variable_value alpha_intensity;
    variable_value beta_intensity;
    variable_value alpha_default_duration;
    unsigned int seed;
    std::optional<int> expected_duration_turns;
    std::optional<int> expected_intensity;
    std::optional<std::pair<int, int>> duration_bounds = std::nullopt;
    bool expects_type_diagnostic = false;
    bool expects_negative_duration = false;
    bool expects_effect_maximum_clamp = false;
    bool expects_random_part = false;
};

constexpr std::array effect_cases = {
    effect_case{
        "u math duration and double variable intensity",
        R"({
            "u_add_effect": "bleed",
            "duration": {"math": ["u_math_duration"]},
            "intensity": {"u_val": "intensity_value"},
            "target_part": "arm_l"
        })",
        effect_target::alpha, 0, 6.75, 96.5, 2.75, 8.75, {}, 58131, 6, 2
    },
    effect_case{
        "n math reads the beta character",
        R"({
            "npc_add_effect": "bleed",
            "duration": {"math": ["n_math_duration"]},
            "intensity": 1,
            "target_part": "arm_l"
        })",
        effect_target::beta, 1, 91.5, 5.75, 8.75, 1.0, {}, 58132, 5, 1
    },
    effect_case{
        "duration variable overrides its default",
        R"({
            "u_add_effect": "bleed",
            "duration": {"u_val": "default_duration", "default": 17},
            "intensity": 1,
            "target_part": "arm_l"
        })",
        effect_target::alpha, 2, {}, {}, 2.75, 8.75, 4.75, 58133, 4, 1
    },
    effect_case{
        "missing duration variable uses its default",
        R"({
            "u_add_effect": "bleed",
            "duration": {"u_val": "default_duration", "default": 17},
            "intensity": 1,
            "target_part": "arm_l"
        })",
        effect_target::alpha, 2, {}, {}, 2.75, 8.75, {}, 58134, 17, 1
    },
    effect_case{
        "typed duration mismatch diagnoses and uses zero",
        R"({
            "u_add_effect": "bleed",
            "duration": {"math": ["u_math_duration"]},
            "intensity": {"u_val": "intensity_value"},
            "target_part": "arm_l"
        })",
        effect_target::alpha, 0, "not numeric", 96.5, 2.75, 8.75, {}, 58135, 0, 2,
        std::nullopt, true
    },
    effect_case{
        "negative duration truncates toward zero",
        R"({
            "u_add_effect": "bleed",
            "duration": {"math": ["u_math_duration"]},
            "intensity": {"u_val": "intensity_value"},
            "target_part": "arm_l"
        })",
        effect_target::alpha, 0, -3.75, 96.5, 2.75, 8.75, {}, 58136, -3, 2,
        std::nullopt, false, true
    },
    effect_case{
        "reversed duration range shares Native RNG",
        R"({
            "u_add_effect": "bleed",
            "duration": [9, 3],
            "intensity": 1,
            "target_part": "arm_l"
        })",
        effect_target::alpha, 3, {}, {}, 2.75, 8.75, {}, 58137, std::nullopt, 1,
        std::pair<int, int>{ 3, 9 }
    },
    // The intensity range is the only numeric provider; talker RANDOM selects
    // its body part after all effect arguments are evaluated.
    effect_case{
        "single-point intensity range precedes random body part",
        R"({
            "u_add_effect": "bleed",
            "duration": 12,
            "intensity": [2.5, 2.5],
            "target_part": "RANDOM"
        })",
        effect_target::alpha, 4, {}, {}, 2.75, 8.75, {}, 58138, 12, 2,
        std::nullopt, false, false, false, true
    },
    effect_case{
        "366 day input clamps to bleed effect maximum",
        R"({
            "u_add_effect": "bleed",
            "duration": "366 days",
            "intensity": 1,
            "target_part": "arm_l"
        })",
        effect_target::alpha, 5, {}, {}, 2.75, 8.75, {}, 58139, std::nullopt, 1,
        std::nullopt, false, false, true
    }
};

// Captured from tools/migrate_lua_first.py::render_dynamic_character_effect.
// read_u=alpha_owner and read_npc=beta_owner are real Character-backed handles.
constexpr std::array<std::string_view, 6> captured_lua_output = {
    // u math duration and direct u_val intensity
    "    do\n        local effect_id = services.types.id(\"effect\", \"bleed\")\n  "
    "      local effect_duration = services.time.duration((function(value) as"
    "sert(value == value and value ~= math.huge and value ~= -math.huge, \"eff"
    "ect duration must be finite\"); local integer = value < 0 and math.ceil(v"
    "alue) or math.floor(value); assert(integer >= -2147483648 and integer <="
    " 2147483647, \"effect duration exceeds the signed engine range\"); return "
    "integer end)((function() local values = {}; local variable_result; varia"
    "ble_result = services.variables.get_number(alpha_owner, \"math_duration\","
    " {strict=true}); if variable_result.ok == false and variable_result.erro"
    "r and variable_result.error.code == \"variable_type_mismatch\" then servic"
    "es.diagnostic(\"Math variable u_math_duration: \" .. variable_result.error"
    ".message); return 0.0 end; values[1] = (function(result) if result.exist"
    "s == false then return 0.0 end; return result.value end)(service_value(v"
    "ariable_result)); return values[1] end)()), \"turn\")\n        local effect"
    "_intensity = (function(value) assert(value == value and value ~= math.hu"
    "ge and value ~= -math.huge, \"effect intensity must be finite\"); local in"
    "teger = value < 0 and math.ceil(value) or math.floor(value); assert(inte"
    "ger >= -2147483648 and integer <= 2147483647, \"effect intensity exceeds "
    "the signed engine range\"); return integer end)((function(result) if resu"
    "lt.exists == false then return 0.0 end; return result.value end)(service"
    "_value(services.variables.get_number(alpha_owner, \"intensity_value\"))))\n"
    "        service_value(services.effects.add(\n            alpha_owner, eff"
    "ect_id, effect_duration, { intensity = effect_intensity, body_part = ser"
    "vices.types.id(\"body_part\", \"arm_l\") }))\n    end",
    // n math duration for the beta talker
    "    do\n        local effect_id = services.types.id(\"effect\", \"bleed\")\n  "
    "      local effect_duration = services.time.duration((function(value) as"
    "sert(value == value and value ~= math.huge and value ~= -math.huge, \"eff"
    "ect duration must be finite\"); local integer = value < 0 and math.ceil(v"
    "alue) or math.floor(value); assert(integer >= -2147483648 and integer <="
    " 2147483647, \"effect duration exceeds the signed engine range\"); return "
    "integer end)((function() local values = {}; local variable_result; varia"
    "ble_result = services.variables.get_number(beta_owner, \"math_duration\", "
    "{strict=true}); if variable_result.ok == false and variable_result.error"
    " and variable_result.error.code == \"variable_type_mismatch\" then service"
    "s.diagnostic(\"Math variable n_math_duration: \" .. variable_result.error."
    "message); return 0.0 end; values[1] = (function(result) if result.exists"
    " == false then return 0.0 end; return result.value end)(service_value(va"
    "riable_result)); return values[1] end)()), \"turn\")\n        local effect_"
    "intensity = (function(value) assert(value == value and value ~= math.hug"
    "e and value ~= -math.huge, \"effect intensity must be finite\"); local int"
    "eger = value < 0 and math.ceil(value) or math.floor(value); assert(integ"
    "er >= -2147483648 and integer <= 2147483647, \"effect intensity exceeds t"
    "he signed engine range\"); return integer end)(1.0)\n        service_value"
    "(services.effects.add(\n            beta_owner, effect_id, effect_duratio"
    "n, { intensity = effect_intensity, body_part = services.types.id(\"body_p"
    "art\", \"arm_l\") }))\n    end",
    // variable duration with a numeric default
    "    do\n        local effect_id = services.types.id(\"effect\", \"bleed\")\n  "
    "      local effect_duration = services.time.duration((function(value) as"
    "sert(value == value and value ~= math.huge and value ~= -math.huge, \"eff"
    "ect duration must be finite\"); local integer = value < 0 and math.ceil(v"
    "alue) or math.floor(value); assert(integer >= -2147483648 and integer <="
    " 2147483647, \"effect duration exceeds the signed engine range\"); return "
    "integer end)((function(result) if result.exists == false then return 17."
    "0 end; return result.value end)(service_value(services.variables.get_num"
    "ber(alpha_owner, \"default_duration\")))), \"turn\")\n        local effect_in"
    "tensity = (function(value) assert(value == value and value ~= math.huge "
    "and value ~= -math.huge, \"effect intensity must be finite\"); local integ"
    "er = value < 0 and math.ceil(value) or math.floor(value); assert(integer"
    " >= -2147483648 and integer <= 2147483647, \"effect intensity exceeds the"
    " signed engine range\"); return integer end)(1.0)\n        service_value(s"
    "ervices.effects.add(\n            alpha_owner, effect_id, effect_duration"
    ", { intensity = effect_intensity, body_part = services.types.id(\"body_pa"
    "rt\", \"arm_l\") }))\n    end",
    // reversed Native duration range
    "    do\n        local effect_id = services.types.id(\"effect\", \"bleed\")\n  "
    "      local effect_duration = services.time.duration((function(value) as"
    "sert(value == value and value ~= math.huge and value ~= -math.huge, \"eff"
    "ect duration must be finite\"); local integer = value < 0 and math.ceil(v"
    "alue) or math.floor(value); assert(integer >= -2147483648 and integer <="
    " 2147483647, \"effect duration exceeds the signed engine range\"); return "
    "integer end)(services.random.native_int(3, 9)), \"turn\")\n        local ef"
    "fect_intensity = (function(value) assert(value == value and value ~= mat"
    "h.huge and value ~= -math.huge, \"effect intensity must be finite\"); loca"
    "l integer = value < 0 and math.ceil(value) or math.floor(value); assert("
    "integer >= -2147483648 and integer <= 2147483647, \"effect intensity exce"
    "eds the signed engine range\"); return integer end)(1.0)\n        service_"
    "value(services.effects.add(\n            alpha_owner, effect_id, effect_d"
    "uration, { intensity = effect_intensity, body_part = services.types.id(\""
    "body_part\", \"arm_l\") }))\n    end",
    // intensity singleton range and Native RANDOM body-part selection
    "    do\n        local effect_id = services.types.id(\"effect\", \"bleed\")\n  "
    "      local effect_duration = services.time.duration(12, \"turn\")\n       "
    " local effect_intensity = (function(value) assert(value == value and val"
    "ue ~= math.huge and value ~= -math.huge, \"effect intensity must be finit"
    "e\"); local integer = value < 0 and math.ceil(value) or math.floor(value)"
    "; assert(integer >= -2147483648 and integer <= 2147483647, \"effect inten"
    "sity exceeds the signed engine range\"); return integer end)(services.ran"
    "dom.native_int(2, 2))\n        service_value(services.effects.add(\n      "
    "      alpha_owner, effect_id, effect_duration, { intensity = effect_inte"
    "nsity, body_part = service_value(services.characters.random_body_part(se"
    "rvices.characters.avatar(), true)) }))\n    end",
    // Native duration literal at 366 days
    "    do\n        local effect_id = services.types.id(\"effect\", \"bleed\")\n  "
    "      local effect_duration = services.time.duration(31622400, \"turn\")\n "
    "       local effect_intensity = (function(value) assert(value == value a"
    "nd value ~= math.huge and value ~= -math.huge, \"effect intensity must be"
    " finite\"); local integer = value < 0 and math.ceil(value) or math.floor("
    "value); assert(integer >= -2147483648 and integer <= 2147483647, \"effect"
    " intensity exceeds the signed engine range\"); return integer end)(1.0)\n "
    "       service_value(services.effects.add(\n            alpha_owner, effe"
    "ct_id, effect_duration, { intensity = effect_intensity, body_part = serv"
    "ices.types.id(\"body_part\", \"arm_l\") }))\n    end",
};

void set_character_value( Character &character, const std::string_view key,
                          const variable_value &value )
{
    if( std::holds_alternative<std::monostate>( value ) ) {
        character.remove_value( std::string( key ) );
    } else if( const double *number = std::get_if<double>( &value ) ) {
        character.set_value( std::string( key ), diag_value( *number ) );
    } else {
        character.set_value( std::string( key ),
                             diag_value( std::string( std::get<std::string_view>( value ) ) ) );
    }
}

void initialize_case_values( const effect_case &test_case, avatar &alpha, npc &beta )
{
    alpha.clear_effects();
    beta.clear_effects();
    for( Character *character : {
             static_cast<Character *>( &alpha ),
             static_cast<Character *>( &beta )
         } ) {
        character->remove_value( "math_duration" );
        character->remove_value( "intensity_value" );
        character->remove_value( "default_duration" );
    }
    set_character_value( alpha, "math_duration", test_case.alpha_duration );
    set_character_value( beta, "math_duration", test_case.beta_duration );
    set_character_value( alpha, "intensity_value", test_case.alpha_intensity );
    set_character_value( beta, "intensity_value", test_case.beta_intensity );
    set_character_value( alpha, "default_duration", test_case.alpha_default_duration );
}

Character &target_character( const effect_case &test_case, avatar &alpha, npc &beta )
{
    return test_case.target == effect_target::alpha ? static_cast<Character &>( alpha ) : beta;
}

struct effect_snapshot {
    time_duration duration;
    time_duration maximum_duration;
    int intensity;
    std::string body_part;
};

std::optional<effect_snapshot> find_effect( Character &target, const bool random_part )
{
    static const efftype_id bleeding( "bleed" );
    if( !random_part ) {
        const bodypart_id part( "arm_l" );
        const effect &found = target.get_effect( bleeding, part );
        if( found.is_null() ) {
            return std::nullopt;
        }
        return effect_snapshot{ found.get_duration(), found.get_max_duration(),
                                found.get_intensity(),
                                std::string( part.id().str() ) };
    }

    for( const bodypart_id &part : target.get_all_body_parts( get_body_part_flags::none ) ) {
        const effect &found = target.get_effect( bleeding, part );
        if( !found.is_null() ) {
            return effect_snapshot{ found.get_duration(), found.get_max_duration(),
                                    found.get_intensity(),
                                    std::string( part.id().str() ) };
        }
    }
    return std::nullopt;
}

std::string lua_diagnostic_script( const std::string_view output )
{
    return R"lua(
local services = ccb.services
local function service_value(result)
    if not result.ok then
        error(result.error and result.error.message or "native operation failed", 0)
    end
    return result.value
end
)lua" + std::string( output );
}

} // namespace

TEST_CASE( "lua_platform_dynamic_effect_numeric_matches_native_talk_effect",
           "[lua][platform][effect_numeric_migration][semantic]" )
{
    namespace platform = cata::lua_platform;
    platform::clear_active_runtimes();
    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    const on_out_of_scope restore_rng( [saved_rng]() {
        rng_get_engine() = saved_rng;
    } );

    avatar alpha;
    npc beta;
    alpha.normalize();
    beta.normalize();
    alpha.setID( character_id( 7931 ), true );
    beta.setID( character_id( 7932 ), true );
    platform::register_npc_handle_identity( beta );
    const on_out_of_scope retire_beta( [&]() {
        platform::retire_npc_handle_identity( beta );
    } );
    dialogue conversation( get_talker_for( alpha ), get_talker_for( beta ) );

    std::vector<talk_effect_t> native_effects;
    native_effects.reserve( effect_cases.size() );
    for( const effect_case &test_case : effect_cases ) {
        talk_effect_t effect;
        effect.parse_sub_effect(
            json_loader::from_string( std::string( test_case.input_json ) ).get_object(),
            "lua_platform_effect_numeric_migration" );
        native_effects.push_back( std::move( effect ) );
    }
    finalize_conditions();

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::table, sol::lib::math, sol::lib::string );
    sol::table ccb = lua.create_table();
    const std::shared_ptr<platform::runtime> owner = platform::make_runtime(
            "effect_numeric_migration", 7933, lua );
    platform::install_runtime_api( owner, lua, ccb );
    platform::set_active_runtimes( { owner } );
    const on_out_of_scope clear_runtimes( []() {
        platform::clear_active_runtimes();
    } );
    owner->world_is_ready = true;
    lua["ccb"] = ccb;
    const std::size_t world_generation = platform::detail::runtime_world_generation_storage();
    lua["alpha_owner"] = platform::game_handle::from_creature(
                             alpha, { "avatar", 7931, 0, 0, 0, {} },
                             owner->handle_runtime(), world_generation );
    lua["beta_owner"] = platform::game_handle::from_creature(
                            beta, { "npc", 7932, 0, 0, 0, {} },
                            owner->handle_runtime(), world_generation );

    for( std::size_t index = 0; index < effect_cases.size(); ++index ) {
        const effect_case &test_case = effect_cases[index];
        CAPTURE( test_case.name );
        initialize_case_values( test_case, alpha, beta );

        rng_set_engine_seed( test_case.seed );
        const std::string native_diagnostic = capture_debugmsg_during( [&]() {
            native_effects[index].apply( conversation );
        } );
        const std::optional<effect_snapshot> expected = find_effect(
                target_character( test_case, alpha, beta ), test_case.expects_random_part );
        REQUIRE( expected.has_value() );
        if( test_case.expected_duration_turns ) {
            CHECK( expected->duration == time_duration::from_turns(
                       *test_case.expected_duration_turns ) );
        }
        if( test_case.expected_intensity ) {
            CHECK( expected->intensity == *test_case.expected_intensity );
        }
        if( test_case.duration_bounds ) {
            CHECK( expected->duration >= time_duration::from_turns(
                       test_case.duration_bounds->first ) );
            CHECK( expected->duration <= time_duration::from_turns(
                       test_case.duration_bounds->second ) );
        }
        if( test_case.expects_negative_duration ) {
            CHECK( expected->duration < time_duration() );
        }
        if( test_case.expects_effect_maximum_clamp ) {
            // data/json/effects.json sets bleed's max_duration to 2400 turns.
            CHECK( expected->maximum_duration == time_duration::from_turns( 2400 ) );
            CHECK( expected->duration == expected->maximum_duration );
            CHECK( expected->duration < time_duration::from_days( 365 ) );
        }
        if( test_case.expects_type_diagnostic ) {
            CHECK( native_diagnostic.find( "Type mismatch" ) != std::string::npos );
        } else {
            CHECK( native_diagnostic.empty() );
        }
        const int native_next_draw = rng( -100, 100 );
        const cata_default_random_engine expected_rng =
            rng_get_engine(); // NOLINT(cata-determinism)

        alpha.clear_effects();
        beta.clear_effects();
        rng_set_engine_seed( test_case.seed );
        const std::string lua_script = lua_diagnostic_script(
                                           captured_lua_output[test_case.output_index] );
        sol::protected_function_result lua_result;
        const std::string lua_diagnostic = capture_debugmsg_during( [&]() {
            platform::detail::callback_scope active_callback( *owner );
            lua_result = lua.safe_script( lua_script, sol::script_pass_on_error );
        } );
        if( !lua_result.valid() ) {
            const sol::error error = lua_result;
            INFO( error.what() );
        }
        REQUIRE( lua_result.valid() );
        const std::optional<effect_snapshot> actual = find_effect(
                target_character( test_case, alpha, beta ), test_case.expects_random_part );
        REQUIRE( actual.has_value() );
        CHECK( actual->duration == expected->duration );
        CHECK( actual->maximum_duration == expected->maximum_duration );
        CHECK( actual->intensity == expected->intensity );
        CHECK( actual->body_part == expected->body_part );
        if( test_case.expects_type_diagnostic ) {
            CHECK( lua_diagnostic.find( "Math variable u_math_duration" ) != std::string::npos );
            CHECK( lua_diagnostic.find( "Type mismatch" ) != std::string::npos );
        } else {
            CHECK( lua_diagnostic.empty() );
        }
        CHECK( rng( -100, 100 ) == native_next_draw );
        CHECK( rng_get_engine() == expected_rng );
    }
}

#endif // CATA_ENABLE_LUA_PLATFORM
