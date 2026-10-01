#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <functional>
#include <initializer_list>
#include <memory>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "activity_type.h"
#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_id.h"
#include "character_martial_arts.h"
#include "condition.h"
#include "debug.h"
#include "dialogue.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "global_vars.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "magic.h"
#include "martialarts.h"
#include "npc.h"
#include "rng.h"
#include "skill.h"
#include "type_id.h"

namespace cata::lua_platform
{
class runtime;
}  // namespace cata::lua_platform

static const itype_id itype_longsword( "longsword" );
static const itype_id itype_test_hazmat_shirt( "test_hazmat_shirt" );
static const matype_id matype_style_judo( "style_judo" );
static const matype_id matype_style_karate( "style_karate" );
static const proficiency_id proficiency_prof_carving( "prof_carving" );
static const skill_id skill_fabrication( "fabrication" );
static const spell_id spell_test_spell_lava( "test_spell_lava" );
static const spell_id spell_test_spell_pew( "test_spell_pew" );

TEST_CASE( "lua_platform_knowledge_semantics_match_both_dialogue_participants",
           "[lua][platform][skills][training][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    avatar player;
    npc partner;
    player.normalize();
    partner.normalize();
    player.setID( character_id( 4301 ), true );
    partner.setID( character_id( 4302 ), true );
    partner.assign_activity( activity_id( "ACT_WAIT" ), 100 );
    partner.omt_path.emplace_back( tripoint_abs_omt{ 4, 5, 0 } );
    cata::lua_platform::register_npc_handle_identity( partner );
    const on_out_of_scope retire( [&]() {
        cata::lua_platform::retire_npc_handle_identity( partner );
    } );
    dialogue conversation( get_talker_for( player ), get_talker_for( partner ) );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = cata::lua_platform::make_runtime( "knowledge_semantics", 4303, lua );
    const on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    bool completed = false;
    lua.set_function( "accept", [&]( const sol::table & ) {
        const auto handle_for = [&]( Character & actor, bool is_npc ) {
            return cata::lua_platform::game_handle::from_creature(
                       actor, { is_npc ? "npc" : "avatar", actor.getID().get_value(), 0, 0, 0, {} },
                       cata::lua_platform::detail::runtime_handle_identity( runtime ),
                       cata::lua_platform::runtime_world_generation() );
        };
        sol::table services = ccb["services"];
        const auto value_of = [&]( const sol::protected_function & function, const auto & ...args ) {
            sol::protected_function_result call = function( args... );
            REQUIRE( call.valid() );
            sol::table result = call;
            REQUIRE( result["ok"].get<bool>() );
            return result["value"].get<sol::object>();
        };
        const cata::lua_platform::game_handle avatar_handle = handle_for( player, false );
        const cata::lua_platform::game_handle beta_handle = handle_for( partner, true );
        const sol::table avatar_snapshot = value_of(
                services["characters"]["snapshot"], avatar_handle ).as<sol::table>();
        const sol::table beta_snapshot = value_of(
                services["characters"]["snapshot"], beta_handle ).as<sol::table>();
        // The Exodii device handoff uses the display name 'social' as a skill
        // ID (the registered ID is 'speech').  Both paths must evaluate that
        // exact native expression; skills.get would reject the invalid ID.
        const skill_id social( "social" );
        const conditional_t below_three( json_loader::from_string(
                                            R"({"math":["u_skill('social') < 3"]})" ).get_object() );
        const conditional_t above_two( json_loader::from_string(
                                           R"({"math":["u_skill('social') > 2"]})" ).get_object() );
        finalize_conditions();
        for( const int level : { 0, 2, 3, 5, 9 } ) {
            player.set_skill_level( social, level );
            const double below_value = value_of(
                                           services["gameplay"]["math"]["evaluate"],
                                           std::string( "u_skill('social') < 3" ), avatar_handle ).as<double>();
            const double above_value = value_of(
                                           services["gameplay"]["math"]["evaluate"],
                                           std::string( "u_skill('social') > 2" ), avatar_handle ).as<double>();
            CAPTURE( level, below_value, above_value );
            CHECK( below_three( conversation ) == ( below_value != 0 ) );
            CHECK( above_two( conversation ) == ( above_value != 0 ) );
        }
        const sol::table avatar_activity = value_of(
                services["activities"]["snapshot"], avatar_handle ).as<sol::table>();
        const sol::table beta_activity = value_of(
                services["activities"]["snapshot"], beta_handle ).as<sol::table>();
        const conditional_t avatar_has_activity_condition( json_loader::from_string(
                    R"({"u_has_activity":"ignored"})" ).get_object() );
        const conditional_t beta_has_activity_condition( json_loader::from_string(
                    R"({"npc_has_activity":"ignored"})" ).get_object() );
        const conditional_t beta_has_activity_simple_condition( "npc_has_activity" );
        const conditional_t avatar_is_travelling_condition( "u_is_travelling" );
        const conditional_t beta_is_travelling_condition( "npc_is_travelling" );
        // The native NPC predicate uses the talker's current player_activity,
        // not npc::has_activity()'s mission/attitude status. Both the simple
        // string and member-object parser read dialogue beta; the object
        // member string does not select an activity id.
        const bool avatar_has_activity = avatar_activity["active"].get<bool>();
        const bool beta_has_activity = beta_activity["active"].get<bool>();
        const bool avatar_is_travelling =
            avatar_snapshot["travel"]["has_path"].get<bool>();
        const bool beta_is_travelling =
            beta_snapshot["travel"]["has_path"].get<bool>();
        CHECK_FALSE( avatar_has_activity );
        CHECK( beta_has_activity );
        CHECK( avatar_has_activity_condition( conversation ) ==
               avatar_has_activity );
        CHECK( beta_has_activity_condition( conversation ) ==
               beta_has_activity );
        CHECK( beta_has_activity_simple_condition( conversation ) ==
               beta_has_activity );
        CHECK_FALSE( avatar_is_travelling );
        CHECK( beta_is_travelling );
        CHECK( avatar_is_travelling_condition( conversation ) ==
               avatar_is_travelling );
        CHECK( beta_is_travelling_condition( conversation ) ==
               beta_is_travelling );
        // This fixture compares each native selector with the snapshot for
        // its intended participant.  Both default actors may share the same
        // safe state, so it does not independently prove role routing when
        // their boolean values coincide.
        const bool avatar_safe_space =
            avatar_snapshot["environment"]["safe_space"].get<bool>();
        const bool beta_safe_space =
            beta_snapshot["environment"]["safe_space"].get<bool>();
        const conditional_t avatar_safe_space_condition( "u_at_safe_space" );
        const conditional_t beta_safe_space_condition( "at_safe_space" );
        const conditional_t npc_beta_safe_space_condition( "npc_at_safe_space" );
        CHECK( avatar_safe_space_condition( conversation ) == avatar_safe_space );
        CHECK( beta_safe_space_condition( conversation ) == beta_safe_space );
        CHECK( npc_beta_safe_space_condition( conversation ) == beta_safe_space );
        for( const bool is_npc : {
                 false, true
             } ) {
            Character &teacher = is_npc ? static_cast<Character &>( partner ) : player;
            Character &student = is_npc ? static_cast<Character &>( player ) : partner;
            const cata::lua_platform::game_handle teacher_handle = handle_for( teacher, is_npc );
            const cata::lua_platform::game_handle student_handle = handle_for( student, !is_npc );
            const std::string prefix = is_npc ? "npc_" : "u_";
            CAPTURE( prefix );
            const auto legacy = [&]( const std::string & selector, const std::string & id ) {
                const conditional_t condition( json_loader::from_string(
                                                   std::string( R"({")" ).append( prefix ).append( selector ).append( R"(":")" ).append( id ).append(
                                                       R"("})" ) ).get_object() );
                return condition( conversation );
            };
            const auto legacy_worn_flag = [&]( const std::string & body_part ) {
                const conditional_t condition( json_loader::from_string(
                                                   std::string( R"({")" ).append( prefix ).append(
                                                       "has_worn_with_flag" ).append(
                                                       R"(": "WATERPROOF", "bodypart": ")" ).append(
                                                           body_part ).append( R"("})" ) ).get_object() );
                return condition( conversation );
            };
            // Teaching depends on student knowledge, not training enabled or practical level.
            for( const Skill &definition : Skill::skills ) {
                teacher.set_skill_level( definition.ident(), 0 );
                student.set_skill_level( definition.ident(), 0 );
            }
            const skill_id &fabrication = skill_fabrication;
            for( const int teacher_level : {
                     0, 3
                 } ) {
                teacher.set_skill_level( fabrication, teacher_level );
                for( const int student_knowledge : {
                         0, 3, 4
                     } ) {
                    student.set_skill_level( fabrication, 0 );
                    student.set_knowledge_level( fabrication, student_knowledge );
                    const conditional_t condition( prefix + "train_skills" );
                    sol::table offered = value_of( services["skills"]["offered"],
                                                   teacher_handle, student_handle );
                    const bool expected = teacher_level > student_knowledge;
                    CHECK( condition( conversation ) == expected );
                    CHECK( ( offered["total"].get<int>() > 0 ) == expected );
                    CHECK( offered["returned"].get<int>() == ( expected ? 1 : 0 ) );
                    CHECK_FALSE( offered["truncated"].get<bool>() );
                    if( expected ) {
                        const cata::lua_platform::script_game_id id = offered["items"][1];
                        CHECK( id.kind() == "skill" );
                        CHECK( id.value() == "fabrication" );
                    }
                }
            }
            player.martial_arts_data->clear_styles();
            partner.martial_arts_data->clear_styles();
            const matype_id &training_style = is_npc ? matype_style_judo :
                                                  matype_style_karate;
            teacher.martial_arts_data->add_martialart( training_style );
            const spell_id &training_spell = is_npc ? spell_test_spell_lava :
                                                spell_test_spell_pew;
            teacher.magic->learn_spell( training_spell, teacher, true );
            const conditional_t styles_condition( prefix + "train_styles" );
            const conditional_t spells_condition( prefix + "train_spells" );
            const auto compare_training_offers = [&]() {
                const bool native_styles = styles_condition( conversation );
                const bool native_spells = spells_condition( conversation );
                const std::vector<matype_id> style_offers =
                    teacher.styles_offered_to( &student );
                const std::vector<spell_id> spell_offers =
                    teacher.spells_offered_to( &student );
                const sol::table offers = value_of(
                                              services["characters"]["training_offers"],
                                              teacher_handle, student_handle ).as<sol::table>();
                const sol::table npc_offers = value_of(
                                                  services["npcs"]["training"]["offerings"],
                                                  teacher_handle, student_handle ).as<sol::table>();
                CHECK( native_styles == !style_offers.empty() );
                CHECK( native_spells == !spell_offers.empty() );
                CHECK( native_styles == ( offers["style_count"].get<int>() > 0 ) );
                CHECK( native_spells == ( offers["spell_count"].get<int>() > 0 ) );
                CHECK( native_styles == ( npc_offers["style_count"].get<int>() > 0 ) );
                CHECK( offers["style_count"].get<int>() ==
                       static_cast<int>( style_offers.size() ) );
                CHECK( offers["spell_count"].get<int>() ==
                       static_cast<int>( spell_offers.size() ) );
                CHECK( npc_offers["style_count"].get<int>() ==
                       static_cast<int>( style_offers.size() ) );
                CHECK( npc_offers["spell_count"].get<int>() ==
                       offers["spell_count"].get<int>() );
            };
            compare_training_offers();
            CHECK( styles_condition( conversation ) );
            CHECK( spells_condition( conversation ) );
            for( const matype_id &offered : teacher.styles_offered_to( &student ) ) {
                student.martial_arts_data->add_martialart( offered );
            }
            for( const spell_id &offered : teacher.spells_offered_to( &student ) ) {
                student.magic->learn_spell( offered, student, true );
            }
            compare_training_offers();
            CHECK_FALSE( styles_condition( conversation ) );
            CHECK_FALSE( spells_condition( conversation ) );
            REQUIRE( teacher.wear_item( item( itype_test_hazmat_shirt ), false ).has_value() );
            for( const auto &part_expected : std::vector<std::pair<std::string, bool>> {
                     { "torso", true }, { "head", false }
                 } ) {
                const std::string &body_part = part_expected.first;
                const bool expected = part_expected.second;
                const bool old_value = legacy_worn_flag( body_part );
                const bool new_value = value_of(
                                           services["inventory"]["has_worn_flag"], teacher_handle,
                                           cata::lua_platform::script_game_id( "json_flag", "WATERPROOF" ),
                                           cata::lua_platform::script_game_id( "body_part", body_part ) ).as<bool>();
                CAPTURE( prefix, body_part );
                CHECK( old_value == new_value );
                CHECK( old_value == expected );
            }
            const proficiency_id &carving = proficiency_prof_carving;
            teacher.lose_proficiency( carving );
            for( const bool known : {
                     false, true
                 } ) {
                if( known ) {
                    teacher.add_proficiency( carving, true );
                }
                sol::table proficiency = value_of( services["proficiencies"]["get"], teacher_handle,
                                                   cata::lua_platform::script_game_id( "proficiency", carving.str() ) );
                const bool native_known = legacy( "has_proficiency", carving.str() );
                const bool platform_known = value_of(
                                                services["proficiencies"]["has_id_text"],
                                                teacher_handle, carving.str() ).as<bool>();
                CHECK( native_known == known );
                CHECK( platform_known == native_known );
                CHECK( proficiency["known"].get<bool>() == known );
            }
            for( const std::string &unknown_id : {
                     std::string(),
                     std::string( "prof_unregistered_condition_test" ),
                     std::string( 257, 'x' ),
                     std::string( 1024, 'x' ),
                     std::string( "无此熟练度" )
                 } ) {
                CAPTURE( prefix, unknown_id );
                REQUIRE_FALSE( proficiency_id( unknown_id ).is_valid() );
                const bool native_known = legacy( "has_proficiency", unknown_id );
                CHECK_FALSE( native_known );
                CHECK( value_of(
                           services["proficiencies"]["has_id_text"],
                           teacher_handle, unknown_id ).as<bool>() == native_known );
            }
            const std::string variable_name = "lua_proficiency_variable_" + prefix;
            REQUIRE( get_globals().maybe_get_global_value( variable_name ) == nullptr );
            on_out_of_scope restore_proficiency_variables( [&]() {
                conversation.remove_value( variable_name );
                get_globals().remove_global_value( variable_name );
            } );
            for( const std::string &scope : {
                     std::string( "global" ), std::string( "context" )
                 } ) {
                std::ostringstream condition_source;
                {
                    JsonOut json( condition_source );
                    json.start_object();
                    json.member( prefix + "has_proficiency" );
                    json.start_object();
                    json.member( scope + "_val", variable_name );
                    json.member( "default", carving.str() );
                    json.end_object();
                    json.end_object();
                }
                const conditional_t native_variable_condition(
                    json_loader::from_string( condition_source.str() ).get_object() );
                sol::table context_values = lua.create_table();
                const auto compare_variable_query = [&]( const bool type_mismatch = false ) {
                    sol::table resolved;
                    const auto read_query = [&]() {
                        resolved = scope == "global" ?
                                   value_of( services["variables"]["get_global_string"],
                                             variable_name ).as<sol::table>() :
                                   value_of( services["variables"]["get_context_string"],
                                             context_values,
                                             variable_name ).as<sol::table>();
                    };
                    if( type_mismatch ) {
                        const std::string diagnostic = capture_debugmsg_during( read_query );
                        CHECK( diagnostic.find( "Type mismatch in diag_value" ) !=
                               std::string::npos );
                    } else {
                        read_query();
                    }
                    const sol::object stored = resolved["value"];
                    const std::string raw_id = !resolved["exists"].get<bool>() ? carving.str() :
                                               stored.is<std::string>() ? stored.as<std::string>() : std::string();
                    bool native_known = false;
                    if( type_mismatch ) {
                        const std::string diagnostic = capture_debugmsg_during( [&]() {
                            native_known = native_variable_condition( conversation );
                        } );
                        CHECK( diagnostic.find( "Type mismatch in diag_value" ) != std::string::npos );
                    } else {
                        native_known = native_variable_condition( conversation );
                    }
                    CHECK( value_of( services["proficiencies"]["has_id_text"],
                                     teacher_handle, raw_id ).as<bool>() == native_known );
                    return native_known;
                };
                // Keep a different value in the other scope to detect accidental
                // owner/scope substitution in the native and Platform readers.
                conversation.set_value( variable_name, "prof_unregistered_condition_test" );
                context_values[variable_name] = "prof_unregistered_condition_test";
                get_globals().set_global_value( variable_name, "prof_unregistered_condition_test" );
                if( scope == "global" ) {
                    get_globals().remove_global_value( variable_name );
                } else {
                    conversation.remove_value( variable_name );
                    context_values[variable_name] = sol::nil;
                }
                CHECK( compare_variable_query() );
                for( const std::string &stored_id : {
                         std::string(), carving.str(), std::string( 10000, 'x' ),
                         std::string( "无此熟练度" ), std::string( "\0" "12", 3 )
                     } ) {
                    if( scope == "global" ) {
                        get_globals().set_global_value( variable_name, stored_id );
                    } else {
                        conversation.set_value( variable_name, stored_id );
                        context_values[variable_name] = stored_id;
                    }
                    CAPTURE( scope, stored_id );
                    CHECK( compare_variable_query() == ( stored_id == carving.str() ) );
                }
                if( scope == "global" ) {
                    get_globals().set_global_value( variable_name, 73 );
                } else {
                    conversation.set_value( variable_name, 73 );
                    context_values[variable_name] = 73;
                }
                CHECK_FALSE( compare_variable_query( true ) );
            }
            teacher.remove_weapon();
            for( const bool wielded : {
                     false, true
                 } ) {
                if( wielded ) {
                    item weapon( itype_longsword );
                    weapon.set_flag( flag_WATERPROOF );
                    teacher.set_wielded_item( std::move( weapon ) );
                }
                const bool old_flag = legacy( "has_wielded_with_flag", "WATERPROOF" );
                const bool new_flag = value_of(
                                          services["inventory"]["wielded_matches"], teacher_handle,
                                          cata::lua_platform::script_game_id( "json_flag", "WATERPROOF" ) ).as<bool>();
                CHECK( old_flag == new_flag );
                CHECK( old_flag == wielded );
                for( const auto &criterion : std::vector<std::pair<std::string, std::string>> {
                { "skill", "cutting" }, { "skill", "pistol" },
                { "weapon_category", "LONG_SWORDS" }, { "weapon_category", "KNIVES" }
            } ) {
                    CAPTURE( wielded, criterion );
                    const bool old_value = legacy( "has_wielded_with_" + criterion.first, criterion.second );
                    const bool new_value = value_of( services["inventory"]["wielded_matches"], teacher_handle,
                                                     cata::lua_platform::script_game_id( criterion.first, criterion.second ) ).as<bool>();
                    CHECK( new_value == old_value );
                    CHECK( new_value == ( wielded && ( criterion.second == "cutting" ||
                                                       criterion.second == "LONG_SWORDS" ) ) );
                }
            }
        }
        completed = true;
    } );
    sol::protected_function_result registered = ccb["runtime"]["handler"]( "accept", lua["accept"] );
    REQUIRE( registered.valid() );
    registered = ccb["runtime"]["on"]( "world_ready", "accept" );
    REQUIRE( registered.valid() );
    cata::lua_platform::runtime_world_ready( true );
    REQUIRE( completed );
}

TEST_CASE( "lua_platform_roll_contested_matches_native_rng_semantics",
           "[lua][platform][random][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    avatar player;
    player.normalize();
    player.setID( character_id( 4311 ), true );
    dialogue conversation( get_talker_for( player ), get_talker_for( player ) );
    const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
    const on_out_of_scope restore_rng( [saved_rng]() {
        rng_get_engine() = saved_rng;
    } );

    sol::state lua;
    lua.open_libraries( sol::lib::base, sol::lib::math );
    sol::table ccb = lua.create_table();
    const auto runtime = cata::lua_platform::make_runtime( "roll_contested_semantics", 4304, lua );
    const on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    lua["ccb"] = ccb;

    const std::vector<std::string> native_conditions = {
        R"({"roll_contested":2,"difficulty":5})",
        R"({"roll_contested":2.5,"difficulty":5.5,"die_size":8.9})",
        R"({"roll_contested":2,"difficulty":5,"die_size":0})",
        R"({"roll_contested":2,"difficulty":5,"die_size":-3.9})",
    };
    cata_default_random_engine expected_native_engine;
    lua.set_function( "native_roll_contested", [&native_conditions, &conversation,
    &expected_native_engine](
    const int index, const unsigned int seed ) {
        rng_set_engine_seed( seed );
        const conditional_t condition( json_loader::from_string(
                                          native_conditions.at( index - 1 ) ).get_object() );
        const bool result = condition( conversation );
        expected_native_engine = rng_get_engine();
        // Let the following Platform native_int call draw from the same seed.
        rng_set_engine_seed( seed );
        return result;
    } );
    lua.set_function( "check_roll_contested", [&expected_native_engine]( const bool same ) {
        CHECK( same );
        CHECK( rng_get_engine() == expected_native_engine );
    } );
    const sol::protected_function_result installed = lua.safe_script( R"(
local cases = {
    { 1, 10, 2.0, 5.0 },
    { 1, 8, 2.5, 5.5 },
    { 0, 1, 2.0, 5.0 },
    { -3, 1, 2.0, 5.0 },
}
ccb.runtime.handler("compare_rolls", function()
    local random = ccb.services.random
    for index, case in ipairs(cases) do
        for _, seed in ipairs({ 4911, 4912, 4913, 4914 }) do
            local native_result = native_roll_contested(index, seed)
            local migrated_result = random.native_int(case[1], case[2]) +
                (0.0 + case[3]) > (0.0 + case[4])
            check_roll_contested(native_result == migrated_result)
        end
    end
    done = true
end)
ccb.runtime.on("world_ready", "compare_rolls")
)" );
    REQUIRE( installed.valid() );
    cata::lua_platform::runtime_world_ready( true );
    CHECK( lua["done"].get_or( false ) );
}
#endif
