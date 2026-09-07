#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM

#include "avatar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "character.h"
#include "character_id.h"
#include "dialogue.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "json_loader.h"
#include "lua_platform_bindings_values.h"
#include "lua_platform_handle.h"
#include "lua_platform_runtime.h"
#include "lua_platform_sol.h"
#include "npc.h"
#include "type_id.h"
#include <functional>
#include <initializer_list>
#include <memory>
#include <string>
#include <utility>
#include <vector>
#include "lua_platform_test_support.h"
#include "condition.h"
#include "skill.h"

static const itype_id itype_longsword( "longsword" );
static const proficiency_id proficiency_prof_carving( "prof_carving" );
static const skill_id skill_fabrication( "fabrication" );

TEST_CASE( "lua_platform_knowledge_semantics_match_both_dialogue_participants",
           "[lua][platform][skills][semantic]" )
{
    cata::lua_platform::clear_active_runtimes();
    avatar player;
    npc partner;
    player.normalize();
    partner.normalize();
    player.setID( character_id( 4301 ), true );
    partner.setID( character_id( 4302 ), true );
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
                CHECK( legacy( "has_proficiency", carving.str() ) == known );
                CHECK( proficiency["known"].get<bool>() == known );
            }
            teacher.remove_weapon();
            for( const bool wielded : {
                     false, true
                 } ) {
                if( wielded ) {
                    teacher.set_wielded_item( item( itype_longsword ) );
                }
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
#endif
