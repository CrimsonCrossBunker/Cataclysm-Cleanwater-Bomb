#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include <coordinates.h>
#include <math_parser_diag_value.h>
#include <pimpl.h>
#include <point.h>
#include <talker.h>
#include <cstddef>
#include <optional>
#include <random>
#include <unordered_map>
#include <functional>
#include <initializer_list>
#include <memory>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "activity_type.h"
#include "activity_actor_definitions.h"
#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_id.h"
#include "character_martial_arts.h"
#include "condition.h"
#include "debug.h"
#include "dialogue.h"
#include "dialogue_helpers.h"
#include "effect_on_condition.h"
#include "flag.h"
#include "flexbuffer_json.h"
#include "global_vars.h"
#include "item.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_dialogue.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "magic.h"
#include "martialarts.h"
#include "messages.h"
#include "mtype.h"
#include "npc.h"
#include "options.h"
#include "rng.h"
#include "skill.h"
#include "talker_topic.h"
#include "translation.h"
#include "type_id.h"

static const itype_id itype_longsword( "longsword" );
static const itype_id itype_test_hazmat_shirt( "test_hazmat_shirt" );

static const matec_id tech_base_headbutt( "tech_base_headbutt" );

static const matype_id style_judo( "style_judo" );
static const matype_id style_karate( "style_karate" );

static const mtype_id mon_null( "mon_null" );
static const mtype_id mon_zombie( "mon_zombie" );

static const proficiency_id proficiency_prof_carving( "prof_carving" );

static const skill_id skill_fabrication( "fabrication" );
static const skill_id skill_social( "social" );
static const skill_id skill_unarmed( "unarmed" );

static const spell_id spell_test_spell_lava( "test_spell_lava" );
static const spell_id spell_test_spell_pew( "test_spell_pew" );

namespace cata::lua_platform
{
class runtime;
}  // namespace cata::lua_platform


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
    partner.assign_activity( wait_activity_actor( 100_turns ) );
    partner.omt_path.emplace_back( 4, 5, 0 );
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
        // native ID fallback through skills.level; skills.get rejects the invalid ID.
        const conditional_t below_three( json_loader::from_string(
                                             R"({"math":["u_skill('social') < 3"]})" ).get_object() );
        const conditional_t above_two( json_loader::from_string(
                                           R"({"math":["u_skill('social') > 2"]})" ).get_object() );
        finalize_conditions();
        for( const int level : {
                 0, 2, 3, 5, 9
             } ) {
            player.set_skill_level( skill_social, level );
            const double native_level = value_of(
                                            services["skills"]["level"], avatar_handle,
                                            skill_social.str() ).as<double>();
            const bool below_value = native_level < 3;
            const bool above_value = native_level > 2;
            CAPTURE( level, below_value, above_value );
            CHECK( below_three( conversation ) == ( below_value != 0 ) );
            CHECK( above_two( conversation ) == ( above_value != 0 ) );
        }
        const sol::table avatar_activity = value_of(
                                               services["activities"]["snapshot"], avatar_handle ).as<sol::table>();
        const sol::table beta_activity = value_of(
                                             services["activities"]["snapshot"], beta_handle ).as<sol::table>();
        const conditional_t avatar_has_activity_condition( "u_has_activity" );
        const conditional_t beta_has_activity_condition( "npc_has_activity" );
        const conditional_t beta_has_activity_simple_condition( "npc_has_activity" );
        const conditional_t avatar_is_travelling_condition( "u_is_travelling" );
        const conditional_t beta_is_travelling_condition( "npc_is_travelling" );
        // The native NPC predicate uses the talker's current player_activity,
        // not npc::has_activity()'s mission/attitude status. Both the simple
        // string selectors read each dialogue participant.
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
                teacher.set_knowledge_level( definition.ident(), 0 );
                student.set_knowledge_level( definition.ident(), 0 );
            }
            // The invalid native ID above is stored outside Skill::skills.
            teacher.set_skill_level( skill_social, 0 );
            student.set_skill_level( skill_social, 0 );
            teacher.set_knowledge_level( skill_social, 0 );
            student.set_knowledge_level( skill_social, 0 );
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
            const matype_id &training_style = is_npc ? style_judo :
                                              style_karate;
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
                    teacher.set_wielded_item( weapon );
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
    if( !completed ) {
        for( const auto &message : Messages::recent_messages_with_formatting( 10 ) ) {
            UNSCOPED_INFO( message.second );
        }
    }
    REQUIRE( completed );
}

TEST_CASE( "lua_platform_proficiency_query_matches_native_id_sources",
           "[lua][platform][proficiencies][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    avatar player;
    npc partner;
    player.normalize();
    partner.normalize();
    player.setID( character_id( 4321 ), true );
    partner.setID( character_id( 4322 ), true );
    cata::lua_platform::register_npc_handle_identity( partner );
    const on_out_of_scope retire( [&]() {
        cata::lua_platform::retire_npc_handle_identity( partner );
    } );
    dialogue conversation( get_talker_for( player ), get_talker_for( partner ) );
    sol::state lua;
    sol::table ccb = lua.create_table();
    const auto runtime = cata::lua_platform::make_runtime( "proficiency_id_sources", 4323, lua );
    const on_out_of_scope cleanup( []() {
        cata::lua_platform::clear_active_runtimes();
    } );
    cata::lua_platform::install_runtime_api( runtime, lua, ccb );
    cata::lua_platform::set_active_runtimes( { runtime } );
    const proficiency_id &carving = proficiency_prof_carving;
    player.add_proficiency( carving, true );
    partner.add_proficiency( carving, true );
    bool completed = false;
    lua.set_function( "accept", [&]( const sol::table & ) {
        const auto handle_for = [&]( Character & actor, bool is_npc ) {
            return cata::lua_platform::game_handle::from_creature(
                       actor, { is_npc ? "npc" : "avatar", actor.getID().get_value(), 0, 0, 0, {} },
                       cata::lua_platform::detail::runtime_handle_identity( runtime ),
                       cata::lua_platform::runtime_world_generation() );
        };
        const cata::lua_platform::game_handle alpha_handle = handle_for( player, false );
        const cata::lua_platform::game_handle beta_handle = handle_for( partner, true );
        sol::table services = ccb["services"];
        const auto value_of = [&]( const sol::protected_function & function, const auto & ...args ) {
            sol::protected_function_result result = function( args... );
            REQUIRE( result.valid() );
            sol::table wrapper = result;
            REQUIRE( wrapper["ok"].get<bool>() );
            return wrapper["value"].get<sol::object>();
        };
        const auto handle_for_selector = [&]( const std::string & selector )
        -> const cata::lua_platform::game_handle & {
            return selector == "npc" ? beta_handle : alpha_handle;
        };
        const auto make_literal_condition = [&]( const std::string & selector,
        const std::string & id_text ) {
            std::ostringstream source;
            {
                JsonOut json( source );
                json.start_object();
                json.member( selector + "_has_proficiency", id_text );
                json.end_object();
            }
            return conditional_t( json_loader::from_string( source.str() ).get_object() );
        };
        const auto make_i18n_condition = [&]( const std::string & selector,
        const std::string & text ) {
            std::ostringstream source;
            {
                JsonOut json( source );
                json.start_object();
                json.member( selector + "_has_proficiency" );
                json.start_object();
                json.member( "i18n", true );
                json.member( "str", text );
                json.end_object();
                json.end_object();
            }
            return conditional_t( json_loader::from_string( source.str() ).get_object() );
        };
        const auto make_game_option_condition = [&]( const std::string & selector,
        const std::string & option_id ) {
            std::ostringstream source;
            {
                JsonOut json( source );
                json.start_object();
                json.member( selector + "_has_proficiency" );
                json.start_object();
                json.member( "mutator", "game_option" );
                json.member( "option", option_id );
                json.end_object();
                json.end_object();
            }
            return conditional_t( json_loader::from_string( source.str() ).get_object() );
        };
        const auto make_variable_condition = [&]( const std::string & selector,
                                             const std::string & scope, const std::string & key, const std::string & default_id,
        const bool with_default ) {
            std::ostringstream source;
            {
                JsonOut json( source );
                json.start_object();
                json.member( selector + "_has_proficiency" );
                json.start_object();
                json.member( scope, key );
                if( with_default ) {
                    json.member( "default", default_id );
                }
                json.end_object();
                json.end_object();
            }
            return conditional_t( json_loader::from_string( source.str() ).get_object() );
        };
        const auto compare_id = [&]( const std::string & selector, const conditional_t &condition,
        const std::string & id_text ) {
            const bool native = condition( conversation );
            const bool platform = value_of( services["proficiencies"]["has_id_text"],
                                            handle_for_selector( selector ), id_text ).as<bool>();
            CAPTURE( selector, id_text );
            CHECK( native == platform );
            return native;
        };
        const sol::protected_function translate = services["translate"];
        const auto translated_text = [&]( const std::string & text ) {
            const sol::protected_function_result result = translate( text );
            REQUIRE( result.valid() );
            return result.get<std::string>();
        };
        sol::table gameplay_options = services["gameplay"]["options"];
        const sol::protected_function get_option_string = gameplay_options["get_string"];
        REQUIRE( get_option_string.valid() );
        const std::vector<std::string> selectors = { "u", "npc" };
        const std::string nul_id( "unknown\0proficiency", sizeof( "unknown\0proficiency" ) - 1 );
        const std::vector<std::string> literal_ids = {
            carving.str(), std::string(), std::string( "prof_unregistered_raw_test" ),
            std::string( 10000, 'x' ), std::string( "无此熟练度" ), nul_id
        };
        for( const std::string &selector : selectors ) {
            for( const std::string &id_text : literal_ids ) {
                CAPTURE( selector, id_text );
                const conditional_t condition = make_literal_condition( selector, id_text );
                CHECK( compare_id( selector, condition, id_text ) == ( id_text == carving.str() ) );
            }
        }

        // Native str_or_var accepts translation objects. Compare with the
        // actual service output; services.translate returns a bare string,
        // including NUL's native LOCALIZE-on/off behaviour. Native translation
        // returns an empty source unchanged without consulting catalogs.
        const std::vector<std::string> i18n_texts = {
            std::string(), carving.str(), "prof_unregistered_i18n_test", "无此熟练度",
            std::string( 9000, 'x' ), std::string( 1, '\0' ),
            carving.str() + '\0' + "suffix", nul_id
        };
        for( const std::string &selector : selectors ) {
            for( const std::string &text : i18n_texts ) {
                const std::string translated_id = text.empty() ? std::string() :
                                                  translated_text( text );
                CHECK( translated_id == to_translation( text ).translated() );
                const conditional_t condition = make_i18n_condition( selector, text );
                CAPTURE( selector, text, translated_id );
                CHECK( compare_id( selector, condition, translated_id ) ==
                       ( translated_id == carving.str() ) );
            }
        }

        const auto compare_game_option = [&]( const std::string & selector,
        const std::string & option_id ) {
            std::string native_value;
            const std::string native_diagnostic = capture_debugmsg_during( [&]() {
                native_value = ::get_option<std::string>( option_id );
            } );
            std::string platform_value;
            const std::string platform_diagnostic = capture_debugmsg_during( [&]() {
                const sol::protected_function_result result = get_option_string( option_id );
                REQUIRE( result.valid() );
                platform_value = result.get<std::string>();
            } );
            CHECK( platform_value == native_value );
            CHECK( platform_diagnostic == native_diagnostic );
            bool expects_diagnostic = true;
            if( get_options().has_option( option_id ) ) {
                const std::string type = get_options().get_option( option_id ).getType();
                expects_diagnostic = type != "string_select" && type != "string_input";
            }
            if( expects_diagnostic ) {
                CHECK_FALSE( native_diagnostic.empty() );
            } else {
                CHECK( native_diagnostic.empty() );
            }

            const conditional_t condition = make_game_option_condition( selector, option_id );
            bool native_match = false;
            const std::string condition_diagnostic = capture_debugmsg_during( [&]() {
                native_match = condition( conversation );
            } );
            const bool platform_match = value_of( services["proficiencies"]["has_id_text"],
                                                  handle_for_selector( selector ),
                                                  platform_value ).as<bool>();
            CAPTURE( selector, option_id, native_value, platform_value, native_diagnostic,
                     platform_diagnostic, condition_diagnostic );
            CHECK( condition_diagnostic == native_diagnostic );
            CHECK( native_match == platform_match );
        };

        const options_manager::options_container raw_options = get_options().get_raw_options();
        const std::vector<std::string> required_option_types = {
            "string_select", "string_input", "bool", "int", "float"
        };
        std::vector<std::pair<std::string, std::string>> typed_option_ids;
        for( const std::string &type : required_option_types ) {
            std::string option_id;
            for( const auto &entry : raw_options ) {
                // Choose a stable option ID; this is independent of display collation.
                if( entry.second.getType() == type &&
                    // NOLINTNEXTLINE(cata-use-localized-sorting)
                    ( option_id.empty() || entry.first < option_id ) ) {
                    option_id = entry.first;
                }
            }
            CAPTURE( type, option_id );
            REQUIRE_FALSE( option_id.empty() );
            CHECK( get_options().has_option( option_id ) );
            CHECK( raw_options.at( option_id ).getType() == type );
            typed_option_ids.emplace_back( type, option_id );
        }
        for( const std::pair<std::string, std::string> &typed_option : typed_option_ids ) {
            for( const std::string &selector : selectors ) {
                compare_game_option( selector, typed_option.second );
            }
        }

        const std::string nul_option_id( "CCB_LUA_OPTION\0missing",
                                         sizeof( "CCB_LUA_OPTION\0missing" ) - 1 );
        const std::vector<std::string> unknown_option_ids = {
            std::string(), "CCB_LUA_PLATFORM_UNKNOWN_OPTION_83D2A1", nul_option_id,
            std::string( 300, 'x' )
        };
        for( const std::string &option_id : unknown_option_ids ) {
            CAPTURE( option_id );
            CHECK_FALSE( get_options().has_option( option_id ) );
            for( const std::string &selector : selectors ) {
                compare_game_option( selector, option_id );
            }
        }

        // Compare the raw faction text and diagnostic, not just the final
        // proficiency predicate: most faction IDs are not proficiencies.
        const sol::protected_function monster_faction = services["registry"]["monster_default_faction"];
        REQUIRE( monster_faction.valid() );
        const auto make_monster_condition = [&]( const std::string & selector,
        const std::string & id_text ) {
            std::ostringstream source;
            {
                JsonOut json( source );
                json.start_object();
                json.member( selector + "_has_proficiency" );
                json.start_object();
                json.member( "mutator", "mon_faction" );
                json.member( "mtype_id", id_text );
                json.end_object();
                json.end_object();
            }
            return conditional_t( json_loader::from_string( source.str() ).get_object() );
        };
        const std::string nul_monster_id( "mon_zombie\0missing",
                                          sizeof( "mon_zombie\0missing" ) - 1 );
        const std::vector<std::string> monster_ids = {
            "mon_zombie", "mon_null", std::string(), "mon_lua_unregistered_faction_test",
            nul_monster_id, "无此怪物", std::string( 10000, 'x' )
        };
        REQUIRE( mon_zombie.is_valid() );
        REQUIRE( mon_null.is_valid() );
        for( const std::string &id_text : monster_ids ) {
            std::string native_faction;
            const std::string native_diagnostic = capture_debugmsg_during( [&]() {
                native_faction = mtype_id( id_text )->default_faction.str();
            } );
            std::string platform_faction;
            const std::string platform_diagnostic = capture_debugmsg_during( [&]() {
                const sol::protected_function_result result = monster_faction( id_text );
                REQUIRE( result.valid() );
                platform_faction = result.get<std::string>();
            } );
            CAPTURE( id_text, native_faction, platform_faction );
            CHECK( native_faction == platform_faction );
            CHECK( native_diagnostic == platform_diagnostic );
            CHECK( native_diagnostic.empty() == mtype_id( id_text ).is_valid() );
            for( const std::string &selector : selectors ) {
                CAPTURE( selector );
                const conditional_t condition = make_monster_condition( selector, id_text );
                bool native_match = false;
                const std::string condition_diagnostic = capture_debugmsg_during( [&]() {
                    native_match = condition( conversation );
                } );
                CHECK( condition_diagnostic == native_diagnostic );
                CHECK( native_match == value_of( services["proficiencies"]["has_id_text"],
                                                 handle_for_selector( selector ), platform_faction ).as<bool>() );
            }
        }

        // A technique's localized authored text is not its formatted rule
        // description, nor a typed-ID snapshot that rejects unknown IDs.
        const auto make_technique_condition = [&]( const std::string & selector,
        const std::string & mutator, const std::string & id_text ) {
            std::ostringstream source;
            {
                JsonOut json( source );
                json.start_object();
                json.member( selector + "_has_proficiency" );
                json.start_object();
                json.member( "mutator", mutator );
                json.member( "matec_id", id_text );
                json.end_object();
                json.end_object();
            }
            return conditional_t( json_loader::from_string( source.str() ).get_object() );
        };
        const std::string nul_technique_id( "tec_none\0missing", sizeof( "tec_none\0missing" ) - 1 );
        const std::vector<std::string> technique_ids = {
            "tec_none", "tech_base_headbutt", std::string(), "tec_lua_unregistered_text_test",
            nul_technique_id, "无此招式", std::string( 10000, 'x' )
        };
        REQUIRE( tec_none.is_valid() );
        REQUIRE( tech_base_headbutt.is_valid() );
        CHECK( tec_none->description.translated().empty() );
        CHECK_FALSE( tech_base_headbutt->description.translated().empty() );
        for( const bool use_name : {
                 true, false
             } ) {
            const std::string mutator = use_name ? "ma_technique_name" : "ma_technique_description";
            const std::string method = use_name ? "technique_name" : "technique_description";
            const sol::protected_function read_text = services["martial_arts"][method];
            REQUIRE( read_text.valid() );
            for( const std::string &id_text : technique_ids ) {
                std::string native_text;
                const std::string native_diagnostic = capture_debugmsg_during( [&]() {
                    const ma_technique &definition = matec_id( id_text ).obj();
                    native_text = ( use_name ? definition.name : definition.description ).translated();
                } );
                std::string platform_text;
                const std::string platform_diagnostic = capture_debugmsg_during( [&]() {
                    const sol::protected_function_result result = read_text( id_text );
                    REQUIRE( result.valid() );
                    platform_text = result.get<std::string>();
                } );
                CAPTURE( id_text, mutator, native_text, platform_text );
                CHECK( platform_text == native_text );
                CHECK( platform_diagnostic == native_diagnostic );
                CHECK( native_diagnostic.empty() == matec_id( id_text ).is_valid() );
                for( const std::string &selector : selectors ) {
                    CAPTURE( selector );
                    const conditional_t condition = make_technique_condition( selector, mutator, id_text );
                    bool native_match = false;
                    const std::string condition_diagnostic = capture_debugmsg_during( [&]() {
                        native_match = condition( conversation );
                    } );
                    CHECK( condition_diagnostic == native_diagnostic );
                    CHECK( native_match == value_of( services["proficiencies"]["has_id_text"],
                                                     handle_for_selector( selector ), platform_text ).as<bool>() );
                }
            }
        }

        const cata::lua_platform::game_handle_runtime runtime_identity =
            cata::lua_platform::detail::runtime_handle_identity( runtime );
        const std::size_t world_generation = cata::lua_platform::runtime_world_generation();
        cata::lua_platform::dialogue::begin_session( conversation, runtime_identity, world_generation );
        const cata::lua_platform::dialogue::dialogue_session_ptr topic_session =
            cata::lua_platform::dialogue::session_for(
                conversation, "TALK_PROFICIENCY_TOPIC", runtime_identity, world_generation );
        cata::lua_platform::dialogue::context topic_context(
            lua.lua_state(), conversation, "TALK_PROFICIENCY_TOPIC", false,
            "proficiency topic context is stale", {}, topic_session, runtime_identity, world_generation );
        REQUIRE( topic_context.valid() );
        sol::protected_function_result loaded = lua.safe_script(
                "return function(context) return context:topic_item() end", sol::script_pass_on_error );
        REQUIRE( loaded.valid() );
        const sol::protected_function read_topic_item = loaded.get<sol::protected_function>();
        const auto make_topic_condition = [&]( const std::string & selector ) {
            return conditional_t( json_loader::from_string(
                                      "{\"" + selector + R"(_has_proficiency":{"mutator":"topic_item"}})" ).get_object() );
        };
        // The topic-item text need not be a registered item. The direct
        // callback reads live changes; activated EOCs observe a fresh copy.
        partner.lose_proficiency( carving );
        for( const std::string &id_text : literal_ids ) {
            conversation.cur_item = itype_id( id_text );
            const sol::protected_function_result topic_result = read_topic_item( topic_context );
            REQUIRE( topic_result.valid() );
            const std::string platform_item = topic_result.get<std::string>();
            CAPTURE( id_text, platform_item );
            CHECK( platform_item == id_text );
            for( const std::string &selector : selectors ) {
                CAPTURE( selector );
                const conditional_t condition = make_topic_condition( selector );
                CHECK( compare_id( selector, condition, platform_item ) ==
                       ( selector == "u" && id_text == carving.str() ) );
                effect_on_condition activated;
                activated.has_condition = true;
                std::string observed_item = "not_evaluated";
                activated.condition = [&]( const const_dialogue & frame ) {
                    observed_item = frame.cur_item.str();
                    return condition( frame );
                };
                const bool empty_match = value_of( services["proficiencies"]["has_id_text"],
                                                   handle_for_selector( selector ), std::string() ).as<bool>();
                CHECK( activated.activate( conversation, false ) == empty_match );
                CHECK( observed_item.empty() );
                CHECK( conversation.cur_item.str() == id_text );
            }
        }
        partner.add_proficiency( carving, true );
        conversation.cur_item = itype_id();
        loaded = lua.safe_script(
                     "return function(context, method, key) return context[method](context, key) end",
                     sol::script_pass_on_error );
        REQUIRE( loaded.valid() );
        const sol::protected_function read_dialogue_string = loaded.get<sol::protected_function>();
        const std::vector<std::string> dialogue_string_methods = {
            "get_string", "speaker_variable_string", "interlocutor_variable_string"
        };
        const std::string nul_key( "dialogue\0string", sizeof( "dialogue\0string" ) - 1 );
        const std::vector<std::string> dialogue_keys = { "", "live_string", nul_key, std::string( 10000, 'k' ) };
        const std::vector<diag_value> dialogue_values = {
            diag_value(), diag_value( std::string() ), diag_value( carving.str() ), diag_value( nul_id ),
            diag_value( std::string( 10000, 'v' ) ), diag_value( 73 ), diag_value( diag_array( 5000, diag_value( 1 ) ) )
        };
        for( const std::string &method : dialogue_string_methods ) {
            talker *const variable_actor = method == "get_string" ? nullptr :
                                           conversation.actor( method == "interlocutor_variable_string" );
            for( const std::string &key : dialogue_keys ) {
                CAPTURE( method, key );
                if( variable_actor ) {
                    variable_actor->remove_value( key );
                } else {
                    conversation.remove_value( key );
                }
                const sol::protected_function_result missing = read_dialogue_string( topic_context, method, key );
                REQUIRE( missing.valid() );
                CHECK( missing.get<sol::object>().get_type() == sol::type::nil );
                for( const diag_value &value : dialogue_values ) {
                    if( variable_actor ) {
                        variable_actor->set_value( key, value );
                    } else {
                        conversation.set_value( key, value );
                    }
                    std::string native_text;
                    const std::string native_diagnostic = capture_debugmsg_during( [&]() {
                        const diag_value *stored = variable_actor ? variable_actor->maybe_get_value( key ) :
                                                   conversation.maybe_get_value( key );
                        REQUIRE( stored != nullptr );
                        native_text = stored->str();
                    } );
                    std::string platform_text;
                    const std::string platform_diagnostic = capture_debugmsg_during( [&]() {
                        const sol::protected_function_result result = read_dialogue_string( topic_context, method, key );
                        REQUIRE( result.valid() );
                        REQUIRE( result.get<sol::object>().get_type() == sol::type::string );
                        platform_text = result.get<std::string>();
                    } );
                    CHECK( platform_text == native_text );
                    CHECK( platform_diagnostic == native_diagnostic );
                }
                if( variable_actor ) {
                    variable_actor->remove_value( key );
                } else {
                    conversation.remove_value( key );
                }
            }
        }
        cata::lua_platform::dialogue::end_session( conversation );
        CHECK_FALSE( topic_context.valid() );
        const sol::protected_function_result stale_topic = read_topic_item( topic_context );
        CHECK_FALSE( stale_topic.valid() );
        for( const std::string &method : dialogue_string_methods ) {
            const sol::protected_function_result stale_string = read_dialogue_string( topic_context, method,
                    "" );
            CHECK_FALSE( stale_string.valid() );
        }

        {
            const cata_default_random_engine saved_rng = rng_get_engine(); // NOLINT(cata-determinism)
            const on_out_of_scope restore_rng( [&saved_rng]() {
                rng_get_engine() = saved_rng;
            } );
            cata::lua_platform::dialogue::begin_session( conversation, runtime_identity, world_generation );
            const on_out_of_scope retire_selection( [&]() {
                cata::lua_platform::dialogue::end_session( conversation );
            } );
            const cata::lua_platform::dialogue::dialogue_session_ptr selection_session =
                cata::lua_platform::dialogue::session_for(
                    conversation, "TALK_PROFICIENCY_SELECTION", runtime_identity, world_generation );
            cata::lua_platform::dialogue::context selection_context(
                lua.lua_state(), conversation, "TALK_PROFICIENCY_SELECTION", false,
                "proficiency selection context is stale", {}, selection_session,
                runtime_identity, world_generation );
            REQUIRE( selection_context.valid() );
            const sol::protected_function_result sampler_loaded = lua.safe_script(
                        "return function(ctx, c, d, b, blacklist) "
                        "return ctx:sample_technique(c, d, b, blacklist) end", sol::script_pass_on_error );
            REQUIRE( sampler_loaded.valid() );
            const sol::protected_function sample_technique = sampler_loaded.get<sol::protected_function>();
            player.set_skill_level( skill_unarmed, 10 );
            player.martial_arts_data->add_martialart( style_karate );
            player.martial_arts_data->set_style( style_karate );
            const std::string nul_blacklist_id( "tec_karate_rapid\0missing",
                                                sizeof( "tec_karate_rapid\0missing" ) - 1 );
            const std::vector<std::vector<std::string>> blacklists = {
                {}, { "", "tec_unknown_raw", nul_blacklist_id, "无此招式", std::string( 10000, 'x' ) },
                {
                    "tec_karate_rapid", "tec_karate_precise", "tec_karate_roundhouse",
                    "tec_karate_staff", "tec_karate_staff_crit"
                },
                std::vector<std::string>( 300, nul_blacklist_id )
            };
            bool saw_selected_technique = false;
            for( const auto &blacklist : blacklists ) {
                std::vector<matec_id> native_blacklist;
                sol::table raw_blacklist = lua.create_table();
                for( std::size_t index = 0; index < blacklist.size(); ++index ) {
                    native_blacklist.emplace_back( blacklist[index] );
                    raw_blacklist[index + 1] = blacklist[index];
                }
                for( int flags = 0; flags < 8; ++flags ) {
                    const bool critical = flags & 1;
                    const bool dodge_counter = flags & 2;
                    const bool block_counter = flags & 4;
                    sol::table options = lua.create_table();
                    options["critical"] = critical;
                    options["dodge_counter"] = dodge_counter;
                    options["block_counter"] = block_counter;
                    options["blacklist"] = raw_blacklist;
                    for( const unsigned int seed : {
                             4911U, 4912U
                         } ) {
                        rng_set_engine_seed( seed );
                        const std::string native_id = conversation.const_actor( false )->get_random_technique(
                                                          partner, critical, dodge_counter, block_counter, native_blacklist ).str();
                        const cata_default_random_engine native_rng_after = rng_get_engine(); // NOLINT(cata-determinism)
                        rng_set_engine_seed( seed );
                        const sol::table selected = value_of( services["characters"]["choose_technique"],
                                                              alpha_handle, beta_handle, options ).as<sol::table>();
                        const std::string platform_id =
                            selected["technique"].get<cata::lua_platform::script_game_id>().value();
                        CAPTURE( flags, seed, blacklist.size(), native_id, platform_id );
                        CHECK( platform_id == native_id );
                        CHECK( selected["found"].get<bool>() == ( native_id != tec_none.str() ) );
                        CHECK( selected["accepted"].get<bool>() == ( native_id != tec_none.str() ) );
                        CHECK( rng_get_engine() == native_rng_after );
                        // Actual read-phase Lua binding uses the live native
                        // pair and consumes exactly the same shared RNG state.
                        rng_set_engine_seed( seed );
                        const sol::protected_function_result sampled = sample_technique(
                                    selection_context, critical, dodge_counter, block_counter, raw_blacklist );
                        REQUIRE( sampled.valid() );
                        CHECK( sampled.get<std::string>() == native_id );
                        CHECK( rng_get_engine() == native_rng_after );
                        saw_selected_technique = saw_selected_technique || native_id != tec_none.str();
                        for( const std::string &selector : selectors ) {
                            std::ostringstream source;
                            {
                                JsonOut json( source );
                                json.start_object();
                                json.member( selector + "_has_proficiency" );
                                json.start_object();
                                json.member( "mutator", "valid_technique" );
                                json.member( "crit", critical );
                                json.member( "dodge_counter", dodge_counter );
                                json.member( "block_counter", block_counter );
                                json.member( "blacklist", blacklist );
                                json.end_object();
                                json.end_object();
                            }
                            const conditional_t condition( json_loader::from_string( source.str() ).get_object() );
                            rng_set_engine_seed( seed );
                            CHECK( compare_id( selector, condition, platform_id ) ==
                                   ( selector == "npc" ? partner.has_proficiency( proficiency_id( native_id ) ) :
                                     player.has_proficiency( proficiency_id( native_id ) ) ) );
                            CHECK( rng_get_engine() == native_rng_after );
                        }
                    }
                }
            }
            CHECK( saw_selected_technique );
            // Native has_array does not evaluate non-array blacklist values.
            // They have the same result and RNG state as no blacklist.
            for( const std::string &ignored : std::vector<std::string> {
            "null", "false", "42", "\"ignored\"", R"({"npc_val":"not_read"})"
        } ) {
                rng_set_engine_seed( 4911 );
                const sol::table selected = value_of( services["characters"]["choose_technique"],
                                                      alpha_handle, beta_handle ).as<sol::table>();
                const std::string platform_id =
                    selected["technique"].get<cata::lua_platform::script_game_id>().value();
                const cata_default_random_engine platform_rng_after = rng_get_engine(); // NOLINT(cata-determinism)
                for( const std::string &selector : selectors ) {
                    CAPTURE( ignored, selector );
                    const conditional_t condition( json_loader::from_string(
                                                       std::string( "{\"" ).append( selector ).append(
                                                           R"(_has_proficiency":{"mutator":"valid_technique","blacklist":)" ).append(
                                                           ignored ).append( "}}" ) ).get_object() );
                    rng_set_engine_seed( 4911 );
                    compare_id( selector, condition, platform_id );
                    CHECK( rng_get_engine() == platform_rng_after );
                }
            }
            cata::lua_platform::dialogue::end_session( conversation );
            CHECK_FALSE( selection_context.valid() );
            const cata_default_random_engine rng_before_stale = rng_get_engine(); // NOLINT(cata-determinism)
            const sol::protected_function_result stale_sample = sample_technique(
                        selection_context, false, false, false, sol::nil );
            CHECK_FALSE( stale_sample.valid() );
            CHECK( rng_get_engine() == rng_before_stale );

            // A non-Character speaker inherits the native empty-ID fallback,
            // rather than being converted into a fictitious Character handle.
            dialogue topic_speaker( std::make_unique<talker_topic>(), get_talker_for( partner ) );
            cata::lua_platform::dialogue::begin_session( topic_speaker, runtime_identity, world_generation );
            const on_out_of_scope retire_topic_speaker( [&]() {
                cata::lua_platform::dialogue::end_session( topic_speaker );
            } );
            const cata::lua_platform::dialogue::dialogue_session_ptr fallback_session =
                cata::lua_platform::dialogue::session_for(
                    topic_speaker, "TALK_PROFICIENCY_FALLBACK", runtime_identity, world_generation );
            cata::lua_platform::dialogue::context fallback_context(
                lua.lua_state(), topic_speaker, "TALK_PROFICIENCY_FALLBACK", false,
                "proficiency fallback context is stale", {}, fallback_session,
                runtime_identity, world_generation );
            const cata_default_random_engine rng_before_fallback = rng_get_engine(); // NOLINT(cata-determinism)
            const std::string native_fallback = topic_speaker.const_actor( false )->get_random_technique(
                                                    partner, false, false, false ).str();
            REQUIRE( native_fallback.empty() );
            const sol::protected_function_result sampled_fallback = sample_technique(
                        fallback_context, false, false, false, sol::nil );
            REQUIRE( sampled_fallback.valid() );
            CHECK( sampled_fallback.get<std::string>() == native_fallback );
            CHECK( rng_get_engine() == rng_before_fallback );

            // Native callers must supply a Creature target. An invalid pair
            // fails before selection instead of dereferencing a null target.
            dialogue topic_target( get_talker_for( player ), std::make_unique<talker_topic>() );
            cata::lua_platform::dialogue::begin_session( topic_target, runtime_identity, world_generation );
            const on_out_of_scope retire_topic_target( [&]() {
                cata::lua_platform::dialogue::end_session( topic_target );
            } );
            const cata::lua_platform::dialogue::dialogue_session_ptr invalid_session =
                cata::lua_platform::dialogue::session_for(
                    topic_target, "TALK_PROFICIENCY_INVALID_TARGET", runtime_identity, world_generation );
            cata::lua_platform::dialogue::context invalid_context(
                lua.lua_state(), topic_target, "TALK_PROFICIENCY_INVALID_TARGET", false,
                "proficiency invalid target context is stale", {}, invalid_session,
                runtime_identity, world_generation );
            const sol::protected_function_result invalid_target = sample_technique(
                        invalid_context, false, false, false, sol::nil );
            CHECK_FALSE( invalid_target.valid() );
            CHECK( rng_get_engine() == rng_before_fallback );
        }

        // The native selectors query dialogue alpha for u_* and beta for
        // npc_*; prove the two participants have distinct learned sets.
        partner.lose_proficiency( carving );
        CHECK( compare_id( "u", make_literal_condition( "u", carving.str() ), carving.str() ) );
        CHECK_FALSE( compare_id( "npc", make_literal_condition( "npc", carving.str() ),
                                 carving.str() ) );
        player.lose_proficiency( carving );
        partner.add_proficiency( carving, true );
        CHECK_FALSE( compare_id( "u", make_literal_condition( "u", carving.str() ), carving.str() ) );
        CHECK( compare_id( "npc", make_literal_condition( "npc", carving.str() ), carving.str() ) );
        player.add_proficiency( carving, true );
        partner.add_proficiency( carving, true );

        sol::table context_values = lua.create_table();
        const sol::object null_value = services["types"]["null"].get<sol::object>();
        const std::vector<std::string> scopes = { "u_val", "npc_val", "global_val", "context_val" };
        const auto set_scope_value = [&]( const std::string & scope, const std::string & key,
        const diag_value & value, const sol::object & lua_value ) {
            if( scope == "u_val" ) {
                conversation.actor( false )->set_value( key, value );
            } else if( scope == "npc_val" ) {
                conversation.actor( true )->set_value( key, value );
            } else if( scope == "global_val" ) {
                get_globals().set_global_value( key, value );
            } else {
                conversation.set_value( key, value );
                context_values.raw_set( key, lua_value );
            }
        };
        const auto remove_scope_value = [&]( const std::string & scope, const std::string & key ) {
            if( scope == "u_val" ) {
                conversation.actor( false )->remove_value( key );
            } else if( scope == "npc_val" ) {
                conversation.actor( true )->remove_value( key );
            } else if( scope == "global_val" ) {
                get_globals().remove_global_value( key );
            } else {
                conversation.remove_value( key );
                context_values[key] = sol::nil;
            }
        };
        const auto read_scope = [&]( const std::string & scope, const std::string & key ) {
            if( scope == "u_val" ) {
                return value_of( services["variables"]["get_string"], alpha_handle, key ).as<sol::table>();
            }
            if( scope == "npc_val" ) {
                return value_of( services["variables"]["get_string"], beta_handle, key ).as<sol::table>();
            }
            if( scope == "global_val" ) {
                return value_of( services["variables"]["get_global_string"], key ).as<sol::table>();
            }
            return value_of( services["variables"]["get_context_string"], context_values,
                             key ).as<sol::table>();
        };
        const auto compare_scope = [&]( const std::string & selector, const std::string & scope,
                                        const std::string & key, const std::string & default_id, const bool with_default,
        const bool expect_type_diagnostic = false ) {
            const conditional_t condition = make_variable_condition( selector, scope, key,
                                            default_id, with_default );
            bool native = false;
            std::string native_diagnostic;
            if( expect_type_diagnostic ) {
                native_diagnostic = capture_debugmsg_during( [&]() {
                    native = condition( conversation );
                } );
                CHECK( native_diagnostic.find( "Type mismatch in diag_value" ) != std::string::npos );
            } else {
                native = condition( conversation );
            }
            sol::table stored;
            std::string platform_diagnostic;
            const auto read = [&]() {
                stored = read_scope( scope, key );
            };
            if( expect_type_diagnostic ) {
                platform_diagnostic = capture_debugmsg_during( read );
                CHECK( platform_diagnostic.find( "Type mismatch in diag_value" ) != std::string::npos );
            } else {
                read();
            }
            const std::string id_text = stored["exists"].get<bool>() ?
                                        stored["value"].get<std::string>() :
                                        ( with_default ? default_id : std::string() );
            const bool platform = value_of( services["proficiencies"]["has_id_text"],
                                            handle_for_selector( selector ), id_text ).as<bool>();
            CAPTURE( selector, scope, key, id_text );
            CHECK( native == platform );
            return native;
        };

        const auto direct_source_key = []( const std::string & selector,
        const std::string & scope ) {
            std::string key = "lua_prof_" + selector + "_" + scope;
            key.push_back( '\0' );
            key += "raw_key";
            return key;
        };
        std::vector<std::pair<std::string, std::string>> direct_source_keys;
        for( const std::string &selector : selectors ) {
            for( const std::string &scope : scopes ) {
                direct_source_keys.emplace_back( scope, direct_source_key( selector, scope ) );
            }
        }
        const on_out_of_scope restore_direct_sources( [&]() {
            for( const std::pair<std::string, std::string> &source : direct_source_keys ) {
                remove_scope_value( source.first, source.second );
            }
        } );

        // Direct native var_info sources are alpha/u, beta/npc, global and
        // dialogue context. Missing reads use default; stored empty/null and
        // wrong-type values remain present and therefore suppress default.
        for( const std::string &selector : selectors ) {
            for( const std::string &scope : scopes ) {
                const std::string key = direct_source_key( selector, scope );
                remove_scope_value( scope, key );
                CHECK( compare_scope( selector, scope, key, carving.str(), true ) );
                CHECK_FALSE( compare_scope( selector, scope, key, carving.str(), false ) );
                set_scope_value( scope, key, diag_value( carving.str() ),
                                 sol::make_object( lua, carving.str() ) );
                CHECK( compare_scope( selector, scope, key, carving.str(), true ) );
                for( const std::string &raw_id : {
                         std::string(), std::string( "raw\0id", sizeof( "raw\0id" ) - 1 ),
                         std::string( 10000, 'x' ), std::string( "无此熟练度" )
                     } ) {
                    set_scope_value( scope, key, diag_value( raw_id ), sol::make_object( lua, raw_id ) );
                    CHECK_FALSE( compare_scope( selector, scope, key, carving.str(), true ) );
                }
                set_scope_value( scope, key, diag_value( 73 ), sol::make_object( lua, 73 ) );
                CHECK_FALSE( compare_scope( selector, scope, key, carving.str(), true, true ) );
                set_scope_value( scope, key, diag_value{}, null_value );
                // monostate returns empty text without a type diagnostic.
                CHECK_FALSE( compare_scope( selector, scope, key, carving.str(), true ) );
                remove_scope_value( scope, key );
            }
        }

        // var_info is attempted before string_mutator and chooses the first
        // present source in fixed native order. Shadowed malformed sources,
        // translation and technique selection must never be evaluated.
        const std::vector<std::string> provider_scopes = {
            "u_val", "npc_val", "global_val", "var_val", "context_val"
        };
        const std::vector<std::string> default_fragments = {
            "null", "false", "42", "[]", "{}", "\"\"", "\"prof_carving\""
        };
        for( std::size_t index = 0; index < provider_scopes.size(); ++index ) {
            const std::string &scope = provider_scopes[index];
            const std::string key = "lua_prof_provider_priority_" + scope;
            const bool indirect = scope == "var_val";
            const std::string source_scope = indirect ? "u_val" : scope;
            const std::string source_key = indirect ? key + "_target" : key;
            const on_out_of_scope retire_provider_sources( [&]() {
                remove_scope_value( source_scope, source_key );
                if( indirect ) {
                    conversation.remove_value( key );
                }
            } );
            if( indirect ) {
                conversation.set_value( key, diag_value( "u_" + source_key ) );
            }
            for( const std::string &default_fragment : default_fragments ) {
                std::string descriptor = std::string( "{\"" ).append( scope ).append(
                                             "\":\"" ).append( key ).append( "\"" );
                for( std::size_t lower = index + 1; lower < provider_scopes.size(); ++lower ) {
                    descriptor.append( ",\"" ).append( provider_scopes[lower] ).append( "\":false" );
                }
                descriptor += ",\"default\":" + default_fragment +
                              ",\"mutator\":\"valid_technique\",\"blacklist\":[42],"
                              "\"i18n\":true,\"str\":\"not_translated\",\"type\":\"ignored_prefix\"}";
                str_or_var provider;
                const std::string parse_diagnostic = capture_debugmsg_during( [&]() {
                    provider.deserialize( json_loader::from_string(
                                              "{\"source\":" + descriptor + "}" ).get_object().get_member( "source" ) );
                } );
                CHECK( parse_diagnostic.empty() );
                for( const std::string &selector : selectors ) {
                    const conditional_t condition( json_loader::from_string(
                                                       std::string( "{\"" ).append( selector ).append(
                                                           "_has_proficiency\":" ).append( descriptor ).append( "}" ) ).get_object() );
                    for( int state = 0; state < 3; ++state ) {
                        if( state == 0 ) {
                            remove_scope_value( source_scope, source_key );
                        } else {
                            const std::string text = state == 1 ? std::string() : carving.str();
                            set_scope_value( source_scope, source_key, diag_value( text ),
                                             sol::make_object( lua, text ) );
                        }
                        const sol::table stored = read_scope( source_scope, source_key );
                        const std::string expected = stored["exists"].get<bool>() ?
                                                     stored["value"].get<std::string>() :
                                                     ( default_fragment == "\"prof_carving\"" ? carving.str() : std::string() );
                        const cata_default_random_engine rng_before = rng_get_engine(); // NOLINT(cata-determinism)
                        CAPTURE( scope, default_fragment, selector, state );
                        CHECK( provider.evaluate( conversation ) == expected );
                        compare_id( selector, condition, expected );
                        CHECK( rng_get_engine() == rng_before );
                    }
                }
            }
        }

        const std::string pointer_key( "lua_prof_pointer\0raw", sizeof( "lua_prof_pointer\0raw" ) - 1 );
        const std::string alpha_target_key( "lua_prof_alpha\0target",
                                            sizeof( "lua_prof_alpha\0target" ) - 1 );
        const std::string beta_target_key( "lua_prof_beta\0target", sizeof( "lua_prof_beta\0target" ) - 1 );
        const std::string context_target_key( "lua_prof_context\0target",
                                              sizeof( "lua_prof_context\0target" ) - 1 );
        const std::string global_target_key( "lua_prof_global\0target",
                                             sizeof( "lua_prof_global\0target" ) - 1 );
        const std::string missing_target_key( "lua_prof_missing\0target",
                                              sizeof( "lua_prof_missing\0target" ) - 1 );
        const std::string var_prefixed_key = std::string( "var_" ) + global_target_key;
        const diag_value *previous_empty_global = get_globals().maybe_get_global_value( "" );
        const bool had_empty_global = previous_empty_global != nullptr;
        const diag_value saved_empty_global = had_empty_global ? *previous_empty_global : diag_value{};
        const on_out_of_scope restore_variables( [&]() {
            remove_scope_value( "u_val", alpha_target_key );
            remove_scope_value( "npc_val", beta_target_key );
            remove_scope_value( "context_val", context_target_key );
            remove_scope_value( "global_val", global_target_key );
            get_globals().remove_global_value( var_prefixed_key );
            conversation.remove_value( pointer_key );
            context_values[pointer_key] = sol::nil;
            if( had_empty_global ) {
                get_globals().set_global_value( "", saved_empty_global );
            } else {
                get_globals().remove_global_value( "" );
            }
            get_globals().remove_global_value( missing_target_key );
        } );
        const auto set_pointer = [&]( const diag_value & value, const sol::object & lua_value ) {
            conversation.set_value( pointer_key, value );
            context_values.raw_set( pointer_key, lua_value );
        };
        const auto remove_pointer = [&]() {
            conversation.remove_value( pointer_key );
            context_values[pointer_key] = sol::nil;
        };
        const auto compare_var_val = [&]( const std::string & selector,
                                          const std::string & default_id, const bool expect_pointer_type_diagnostic,
        const bool expect_target_type_diagnostic ) {
            const conditional_t condition = make_variable_condition( selector, "var_val",
                                            pointer_key, default_id, true );
            bool native = false;
            if( expect_pointer_type_diagnostic || expect_target_type_diagnostic ) {
                const std::string diagnostic = capture_debugmsg_during( [&]() {
                    native = condition( conversation );
                } );
                CHECK( diagnostic.find( "Type mismatch in diag_value" ) != std::string::npos );
            } else {
                native = condition( conversation );
            }
            sol::table pointer;
            const auto read_pointer = [&]() {
                pointer = value_of( services["variables"]["get_context_string"], context_values,
                                    pointer_key ).as<sol::table>();
            };
            if( expect_pointer_type_diagnostic ) {
                const std::string diagnostic = capture_debugmsg_during( read_pointer );
                CHECK( diagnostic.find( "Type mismatch in diag_value" ) != std::string::npos );
            } else {
                read_pointer();
            }
            std::string id_text;
            if( !pointer["exists"].get<bool>() ) {
                id_text = default_id;
            } else {
                const std::string pointer_text = pointer["value"].get<std::string>();
                std::string target_scope = "global_val";
                std::string target_key = pointer_text;
                if( pointer_text.compare( 0, 2, "u_" ) == 0 ) {
                    target_scope = "u_val";
                    target_key = pointer_text.substr( 2 );
                } else if( pointer_text.compare( 0, 2, "n_" ) == 0 ) {
                    target_scope = "npc_val";
                    target_key = pointer_text.substr( 2 );
                } else if( pointer_text.compare( 0, 1, "_" ) == 0 ) {
                    target_scope = "context_val";
                    target_key = pointer_text.substr( 1 );
                }
                sol::table target;
                const auto read_target = [&]() {
                    target = read_scope( target_scope, target_key );
                };
                if( expect_target_type_diagnostic ) {
                    const std::string diagnostic = capture_debugmsg_during( read_target );
                    CHECK( diagnostic.find( "Type mismatch in diag_value" ) != std::string::npos );
                } else {
                    read_target();
                }
                id_text = target["exists"].get<bool>() ?
                          target["value"].get<std::string>() : default_id;
            }
            const bool platform = value_of( services["proficiencies"]["has_id_text"],
                                            handle_for_selector( selector ), id_text ).as<bool>();
            CAPTURE( selector, id_text );
            CHECK( native == platform );
            return native;
        };

        remove_pointer();
        for( const std::string &selector : selectors ) {
            CHECK( compare_var_val( selector, carving.str(), false, false ) ); // missing pointer uses default
        }
        set_pointer( diag_value( std::string( "u_" ) + missing_target_key ),
                     sol::make_object( lua, std::string( "u_" ) + missing_target_key ) );
        for( const std::string &selector : selectors ) {
            CHECK( compare_var_val( selector, carving.str(), false, false ) ); // missing target uses default
        }
        get_globals().set_global_value( "", diag_value( std::string( "prof_unregistered_empty_global" ) ) );
        set_pointer( diag_value( std::string() ), sol::make_object( lua, std::string() ) );
        for( const std::string &selector : selectors ) {
            CHECK_FALSE( compare_var_val( selector, carving.str(), false,
                                          false ) ); // present empty pointer reads global[""]
        }
        set_pointer( diag_value{}, null_value );
        for( const std::string &selector : selectors ) {
            CHECK_FALSE( compare_var_val( selector, carving.str(), false,
                                          false ) ); // null pointer reads empty key without diagnostics
        }
        set_pointer( diag_value( 73 ), sol::make_object( lua, 73 ) );
        for( const std::string &selector : selectors ) {
            CHECK_FALSE( compare_var_val( selector, carving.str(), true,
                                          false ) ); // wrong-type pointer also reads global[""]
        }
        // Each indirection target gets a different value and all other targets
        // are absent. With a known default, a wrong scope/key would incorrectly
        // succeed instead of returning the source-specific false result.
        const auto clear_indirect_targets = [&]() {
            remove_scope_value( "u_val", alpha_target_key );
            remove_scope_value( "npc_val", beta_target_key );
            remove_scope_value( "context_val", context_target_key );
            remove_scope_value( "global_val", global_target_key );
            get_globals().remove_global_value( var_prefixed_key );
        };
        const auto compare_indirect_source = [&]( const std::string & pointer_text,
                                             const std::string & scope, const std::string & key, const std::string & stored_id,
        const std::string & default_id, const bool expected ) {
            clear_indirect_targets();
            set_scope_value( scope, key, diag_value( stored_id ), sol::make_object( lua, stored_id ) );
            set_pointer( diag_value( pointer_text ), sol::make_object( lua, pointer_text ) );
            for( const std::string &selector : selectors ) {
                CHECK( compare_var_val( selector, default_id, false, false ) == expected );
            }
        };
        compare_indirect_source( std::string( "u_" ) + alpha_target_key, "u_val",
                                 alpha_target_key, "prof_unregistered_alpha_target",
                                 carving.str(), false );
        compare_indirect_source( std::string( "n_" ) + beta_target_key, "npc_val",
                                 beta_target_key, "prof_unregistered_beta_target",
                                 carving.str(), false );
        compare_indirect_source( std::string( "_" ) + context_target_key, "context_val",
                                 context_target_key, std::string(), carving.str(), false );
        compare_indirect_source( global_target_key, "global_val", global_target_key,
                                 "prof_unregistered_global_target", carving.str(), false );
        compare_indirect_source( std::string( "u_" ) + alpha_target_key, "u_val",
                                 alpha_target_key, carving.str(), "prof_unregistered_default", true );

        // Native process_variable recognizes u_, n_ and _ prefixes exactly
        // once; every other string, including var_, remains a global key.
        clear_indirect_targets();
        get_globals().set_global_value( global_target_key, diag_value( carving.str() ) );
        get_globals().set_global_value( var_prefixed_key,
                                        diag_value( std::string( "prof_unregistered_var_prefix" ) ) );
        const std::string &var_pointer = var_prefixed_key;
        set_pointer( diag_value( var_pointer ), sol::make_object( lua, var_pointer ) );
        for( const std::string &selector : selectors ) {
            CHECK_FALSE( compare_var_val( selector, carving.str(), false, false ) );
        }

        clear_indirect_targets();
        const std::string numeric_target_pointer = std::string( "u_" ) + alpha_target_key;
        set_pointer( diag_value( numeric_target_pointer ), sol::make_object( lua,
                     numeric_target_pointer ) );
        set_scope_value( "u_val", alpha_target_key, diag_value( 73 ), sol::make_object( lua, 73 ) );
        for( const std::string &selector : selectors ) {
            CHECK_FALSE( compare_var_val( selector, carving.str(), false, true ) );
        }
        clear_indirect_targets();
        set_pointer( diag_value( numeric_target_pointer ), sol::make_object( lua,
                     numeric_target_pointer ) );
        set_scope_value( "u_val", alpha_target_key, diag_value{}, null_value );
        for( const std::string &selector : selectors ) {
            CHECK_FALSE( compare_var_val( selector, carving.str(), false, false ) );
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
    const on_out_of_scope restore_rng( [&saved_rng]() {
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
    // The native oracle overwrites this with the explicitly seeded engine before comparison.
    // NOLINTNEXTLINE(bugprone-random-generator-seed,cert-msc32-c,cert-msc51-cpp,cata-determinism)
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
