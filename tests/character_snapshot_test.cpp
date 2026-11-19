#include <sstream>
#include <string>

#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "creature.h"
#include "effect.h"
#include "flexbuffer_json.h"
#include "game.h"
#include "json.h"
#include "json_loader.h"
#include "lua_platform_content.h"
#include "mp_combat_result.h"
#include "mp_pickup.h"
#include "type_id.h"
#include "vehicle.h"
#include "wound.h"

namespace
{
const bodypart_str_id arm_l( "arm_l" );
const bodypart_str_id arm_r( "arm_r" );
const efftype_id retired_effect( "blisters" );
const efftype_id wet( "wet" );
const efftype_id stunned( "stunned" );
const wound_type_id blister_wound( "thermal_blister" );
const std::string retired_record =
    R"({"eff_type":"blisters","duration":1800,"bp":"arm_l","permanent":false,"intensity":1})";
const std::string null_record =
    R"({"eff_type":"","duration":0,"bp":"bp_null","permanent":false,"intensity":1})";

class scoped_effect_migration
{
    public:
        scoped_effect_migration( const efftype_id &from, const std::string &to )
            : migration{ "effect", from.str(), to } {
            REQUIRE_FALSE( effect_migration::find_migration( from ) );
            cata::lua_platform::detail::insert_platform_effect_migration( migration );
        }

        ~scoped_effect_migration() {
            cata::lua_platform::detail::erase_platform_effect_migration( migration );
        }

    private:
        cata::lua_platform::detail::platform_migration_data migration;
};

std::string replace_field( std::string wire, const std::string &field,
                           const std::string &replacement )
{
    const auto pos = wire.find( field );
    REQUIRE( pos != std::string::npos );
    wire.replace( pos, field.size(), replacement );
    return wire;
}

std::string turn_state( const Character &actor )
{
    std::ostringstream text;
    JsonOut out( text );
    actor.store_turn_state( out );
    return text.str();
}

std::string player_state( const Character &actor )
{
    std::ostringstream text;
    JsonOut out( text );
    actor.store_player_state( out );
    return text.str();
}

std::string effect_map( bool legacy )
{
    const std::string left = legacy ? std::to_string( bp_arm_l ) : "arm_l";
    const std::string right = legacy ? std::to_string( bp_arm_r ) : "arm_r";
    const std::string retired_part = "\"" + left + "\":" + retired_record;
    std::string result = "{\"blisters\":{" + retired_part + "},\"stunned\":{" + retired_part +
                         "},\"wet\":{" + retired_part + ",\"" + right +
                         R"(":{"eff_type":"wet","duration":1800,"bp":"arm_r","permanent":false,"intensity":1}})";
    result += ",\"winded_arm\":{\"" + left + "\":" + null_record + "}";
    if( !legacy ) {
        result += ",\"winded_arm_l\":{" + retired_part + "}";
    }
    return result + "}";
}
} // namespace

TEST_CASE( "turn_state_keeps_raw_pain_separate_from_wounds", "[character_snapshot][multiplayer]" )
{
    avatar owner;
    owner.set_body();
    owner.Creature::set_pain( 7 );
    owner.get_part( arm_l )->add_wound( blister_wound );
    const int expected_pain = owner.get_pain();
    REQUIRE( expected_pain > 7 );

    avatar replica;
    replica.set_body();
    replica.load_turn_state( json_loader::from_string( turn_state( owner ) ).get_object() );
    CHECK( replica.Creature::get_pain() == 7 );
    CHECK( replica.get_pain() == expected_pain );
    REQUIRE( replica.get_part( arm_l )->has_wound( blister_wound ) );

    // Fail after the new body and pain have already been read.
    owner.get_part( arm_l )->remove_all_wounds_of_type( blister_wound );
    owner.Creature::set_pain( 17 );
    const std::string malformed = replace_field( turn_state( owner ), "\"mana\":", "\"missing_mana\":" );
    CHECK_THROWS_AS( replica.load_turn_state( json_loader::from_string( malformed ).get_object() ),
                     JsonError );
    CHECK( replica.Creature::get_pain() == 7 );
    CHECK( replica.get_pain() == expected_pain );
    CHECK( replica.get_part( arm_l )->has_wound( blister_wound ) );
}

TEST_CASE( "character_snapshots_keep_damage_undo_with_restored_wounds",
           "[character_snapshot][multiplayer][save]" )
{
    const bool full_snapshot = GENERATE( false, true );
    CAPTURE( full_snapshot );
    const auto store = full_snapshot ? player_state : turn_state;
    const auto load = full_snapshot ? &Character::load_player_state : &Character::load_turn_state;

    // Seed a save midway through healing a contact burn that masks an environmental blister.
    struct save_test_avatar : avatar {
        using Character::load;
    };
    const restore_on_out_of_scope restore_version( savegame_loading_version );
    savegame_loading_version = savegame_version;
    save_test_avatar owner;
    owner.set_body();
    const wound_type_id burn_wound( "thermal_burn" );
    wound contact;
    contact.deserialize( json_loader::from_string( R"({
        "type":"thermal_burn","healing_time":100,"healing_progress":20,"pain":7,
        "reversible_contact":true
    })" ).get_object() );
    owner.get_part( arm_l )->add_wound( contact );

    std::ostringstream saved;
    JsonOut out( saved );
    owner.serialize( out );
    const std::string disk = replace_field( saved.str(), "\"body\":", R"(
        "last_damage_record":{
            "part":"arm_l","amount":16,"pain":4,"burn_part":"arm_l","burn_type":"thermal_burn",
            "prior_blister":{"type":"thermal_blister","healing_time":100,"healing_progress":30,"pain":4},
            "prior_blister_burn_progress":8
        },"body":)" );
    owner.load( json_loader::from_string( disk ).get_object() );

    avatar replica;
    replica.set_body();
    Character *restored = &replica;
    time_duration expected_progress = 42_turns;
    SECTION( "complete record restores the damage and wound history" ) {
        ( replica.*load )( json_loader::from_string( store( owner ) ).get_object() );
    }
    SECTION( "old record defaults the missing baseline to zero" ) {
        const std::string wire = replace_field( store( owner ),
                                                ",\"prior_blister_burn_progress\":8", "" );
        ( replica.*load )( json_loader::from_string( wire ).get_object() );
        expected_progress = 50_turns;
    }
    SECTION( "a frame with no record clears the destination's old record" ) {
        replica.get_part( arm_l )->add_wound( blister_wound );
        ( owner.*load )( json_loader::from_string( store( replica ) ).get_object() );
        CHECK( owner.get_part( arm_l )->has_wound( blister_wound ) );
        CHECK_FALSE( owner.get_part( arm_l )->has_wound( burn_wound ) );
        CHECK_FALSE( owner.take_recent_damage() );
        return;
    }
    SECTION( "a late failure restores the original record and body" ) {
        const char *missing = full_snapshot ? "\"magic\":" : "\"mana\":";
        const std::string wire = replace_field( store( replica ), missing, "\"missing_late\":" );
        REQUIRE_THROWS_AS( ( owner.*load )( json_loader::from_string( wire ).get_object() ), JsonError );
        restored = &owner;
    }

    bodypart &arm = *restored->get_part( arm_l );
    REQUIRE( arm.has_wound( burn_wound ) );
    CHECK( arm.get_wound( burn_wound )->get_healing_progress() == 20_turns );
    const auto hit = restored->take_recent_damage();
    REQUIRE( hit );
    CHECK( hit->part == arm_l );
    CHECK( hit->amount == 16 );
    CHECK( hit->pain == 4 );
    CHECK_FALSE( arm.has_wound( burn_wound ) );
    REQUIRE( arm.has_wound( blister_wound ) );
    CHECK( arm.get_wound( blister_wound )->get_healing_progress() == expected_progress );
}

TEST_CASE( "thermal_snapshot_does_not_retarget_damage_from_a_missing_hp_recipient",
           "[character_snapshot][save]" )
{
    struct anatomy_test_avatar : avatar {
        using Creature::body;
    };
    anatomy_test_avatar owner;
    owner.set_body();
    owner.record_scripted_damage( arm_l, 8, 3 );
    owner.save_thermal_wounds( "before_limb_loss" );
    owner.body.erase( arm_l );
    REQUIRE( owner.get_part_id( arm_l ) == arm_r );

    SECTION( "the live record no longer offers HP or pain reversal" ) {
        // No snapshot restoration.
    }
    SECTION( "restoring a baseline does not retarget the record to the surviving arm" ) {
        REQUIRE( owner.restore_thermal_wounds( "before_limb_loss" ) );
        owner.body.emplace( arm_l, bodypart( arm_l ) );
    }
    SECTION( "replacing the lost limb with the same ID does not revive the live record" ) {
        owner.body.emplace( arm_l, bodypart( arm_l ) );
    }

    const auto hit = owner.take_recent_damage();
    REQUIRE( hit );
    CHECK( hit->amount == 0 );
    CHECK( hit->pain == 0 );
    CHECK_FALSE( hit->burn_reverted );
}

TEST_CASE( "named_rewind_does_not_restore_a_hit_or_burn_to_a_recreated_limb",
           "[character_snapshot][save]" )
{
    struct anatomy_test_avatar : avatar {
        using Character::load;
        using Creature::body;
    };
    const restore_on_out_of_scope restore_version( savegame_loading_version );
    savegame_loading_version = savegame_version;
    anatomy_test_avatar owner;
    owner.set_body();
    owner.recalc_hp();
    const wound_type_id burn_wound( "thermal_burn" );
    wound contact( burn_wound );
    contact.deserialize( json_loader::from_string( R"({"reversible_contact":true})" ).get_object() );
    owner.get_part( arm_l )->add_wound( contact );
    owner.set_part_hp_cur( arm_l, 30 );
    owner.set_part_hp_cur( arm_r, 42 );

    std::ostringstream saved;
    JsonOut out( saved );
    owner.serialize( out );
    owner.load( json_loader::from_string( replace_field( saved.str(), "\"body\":", R"(
        "last_damage_record":{
            "part":"arm_l","amount":16,"pain":4,"burn_part":"arm_l","burn_type":"thermal_burn"
        },"body":)" ) ).get_object() );
    owner.save_thermal_wounds( "before_replacement", true );

    owner.body.erase( arm_l );
    owner.body.emplace( arm_l, bodypart( arm_l ) );
    owner.recalc_hp();
    owner.set_part_hp_cur( arm_l, 51 );
    owner.set_part_hp_cur( arm_r, 28 );
    owner.get_part( arm_l )->add_wound( blister_wound );
    // Another rewind can capture this replacement under the same body-part ID.
    owner.save_thermal_wounds( "after_replacement" );

    const bool through_save = GENERATE( false, true );
    anatomy_test_avatar replica;
    Character *rewound = &owner;
    if( through_save ) {
        std::ostringstream wire;
        JsonOut saved_owner( wire );
        owner.serialize( saved_owner );
        replica.load( json_loader::from_string( wire.str() ).get_object() );
        rewound = &replica;
    }

    REQUIRE( rewound->restore_thermal_wounds( "before_replacement" ) );
    CHECK( rewound->get_part_hp_cur( arm_l ) == 51 );
    CHECK( rewound->get_part_hp_cur( arm_r ) == 42 );
    CHECK_FALSE( rewound->get_part( arm_l )->has_wound( burn_wound ) );
    CHECK( rewound->get_part( arm_l )->has_wound( blister_wound ) );
    const auto hit = rewound->take_recent_damage();
    REQUIRE( hit );
    CHECK( hit->amount == 0 );
    CHECK( hit->pain == 0 );
    CHECK_FALSE( hit->burn_reverted );
}

TEST_CASE( "combat_result_keeps_raw_pain_and_skips_retired_effects",
           "[character_snapshot][multiplayer]" )
{
    avatar owner;
    owner.set_body();
    owner.Creature::set_pain( 7 );
    owner.get_part( arm_l )->add_wound( blister_wound );
    REQUIRE( owner.get_pain() > 7 );

    avatar replica;
    replica.set_body();
    replica.get_part( arm_l )->add_wound( blister_wound );
    const int wound_pain = replica.get_pain();
    REQUIRE( wound_pain > 0 );
    cata_mp::pickup_host_state host;
    cata_mp::pickup_client_state client;
    const std::string wire = replace_field( cata_mp::make_combat_result( owner, host ),
                                           "\"effects\":[]", "\"effects\":[" + retired_record + "]" );
    const JsonObject result = json_loader::from_string( wire ).get_object();
    result.allow_omitted_members();
    CHECK( result.get_int( "pain" ) == 7 );
    REQUIRE( cata_mp::apply_combat_result( replica, result, client ) );
    CHECK( replica.Creature::get_pain() == 7 );
    CHECK( replica.get_pain() == 7 + wound_pain );
    CHECK( replica.get_effects().empty() );
}

TEST_CASE( "retired_effect_payloads_are_discarded_regardless_of_map_key",
           "[character_snapshot][save]" )
{
    struct save_test_avatar : avatar {
        using Creature::load;
    };
    const std::string mode = GENERATE( "legacy_save", "save", "turn_state", "player_state" );
    CAPTURE( mode );
    REQUIRE_FALSE( retired_effect.is_valid() );
    save_test_avatar actor;
    actor.set_body();
    const int hp_before = actor.get_part_hp_cur( arm_l );
    const bool legacy = mode == "legacy_save";
    const std::string effects_field = "\"effects\":" + effect_map( legacy );
    if( legacy || mode == "save" ) {
        const restore_on_out_of_scope restore_version( savegame_loading_version );
        savegame_loading_version = legacy ? 30 : savegame_version;
        actor.load( json_loader::from_string( "{" + effects_field + "}" ).get_object() );
    } else if( mode == "turn_state" ) {
        const std::string wire = replace_field( turn_state( actor ), "\"effects\":{}", effects_field );
        actor.load_turn_state( json_loader::from_string( wire ).get_object() );
    } else {
        const std::string wire = replace_field( player_state( actor ), "\"effects\":{}", effects_field );
        actor.load_player_state( json_loader::from_string( wire ).get_object() );
    }

    CHECK_FALSE( actor.has_effect( retired_effect ) );
    CHECK_FALSE( actor.has_effect( stunned ) );
    CHECK_FALSE( actor.has_effect( efftype_id( "winded_arm" ) ) );
    CHECK_FALSE( actor.has_effect( wet, arm_l ) );
    CHECK( actor.get_effect_dur( wet, arm_r ) == 30_minutes );
    CHECK( actor.get_effects().size() == 1 );
    CHECK( actor.get_part_hp_cur( arm_l ) == hp_before );
    CHECK( actor.get_part( arm_l )->get_wounds().empty() );
}

TEST_CASE( "character_snapshots_keep_live_effect_ids_with_save_migrations",
           "[character_snapshot][multiplayer]" )
{
    const bool full_snapshot = GENERATE( false, true );
    const std::string replacement = GENERATE( "stunned", "" );
    CAPTURE( full_snapshot, replacement );
    REQUIRE( wet.is_valid() );
    REQUIRE( stunned.is_valid() );
    const scoped_effect_migration migration( wet, replacement );

    const auto store = full_snapshot ? player_state : turn_state;
    const auto load = full_snapshot ? &Character::load_player_state : &Character::load_turn_state;
    avatar owner;
    owner.set_body();
    owner.add_effect( wet, 30_minutes, arm_r.id(), true, 2 );
    REQUIRE( owner.has_effect( wet, arm_r ) );

    avatar replica;
    replica.set_body();
    SECTION( "successful load" ) {
        ( replica.*load )( json_loader::from_string( store( owner ) ).get_object() );
    }
    SECTION( "rollback after replacing effects" ) {
        replica.add_effect( wet, 30_minutes, arm_r.id(), true, 2 );
        REQUIRE( replica.has_effect( wet, arm_r ) );
        owner.clear_effects();
        owner.add_effect( stunned, 5_turns );
        // Both loaders read this required field immediately after replacing effects.
        const char *missing = full_snapshot ? "\"damage_over_time_map\":" : "\"damage_over_time\":";
        const std::string wire = replace_field( store( owner ), missing, "\"missing_dot\":" );
        CHECK_THROWS_AS( ( replica.*load )( json_loader::from_string( wire ).get_object() ), JsonError );
    }
    REQUIRE( replica.get_effects().size() == 1 );
    REQUIRE( replica.has_effect( wet, arm_r ) );
    const effect &restored_effect = replica.get_effect( wet, arm_r );
    CHECK( restored_effect.get_id() == wet );
    CHECK( restored_effect.get_duration() == 30_minutes );
    CHECK( restored_effect.get_intensity() == 2 );
    CHECK( restored_effect.is_permanent() );
    CHECK_FALSE( replica.has_effect( stunned ) );
}

TEST_CASE( "vehicle_load_drops_null_effects_without_migrating_live_effects",
           "[character_snapshot][vehicle][save]" )
{
    const efftype_id grabbed( "grabbed" );
    REQUIRE( wet.is_valid() );
    REQUIRE( stunned.is_valid() );
    REQUIRE( grabbed.is_valid() );
    REQUIRE_FALSE( retired_effect.is_valid() );
    const scoped_effect_migration migration( wet, stunned.str() );
    vehicle original( vproto_id( "test_shopping_cart" ) );
    std::ostringstream text;
    JsonOut out( text );
    original.serialize( out );
    const std::string records = "{\"blisters\":" + retired_record + ",\"stunned\":" +
                                retired_record + ",\"winded_arm\":" + null_record + "," +
                                R"("grabbed":{"eff_type":"grabbed","duration":1,"bp":"bp_null",)"
                                R"("permanent":false,"intensity":1},)"
                                R"("wet":{"eff_type":"wet","duration":1800,"bp":"bp_null",)"
                                R"("permanent":true,"intensity":2}})";
    const std::string wire = replace_field( text.str(), "\"effects\":{}", "\"effects\":" + records );

    vehicle restored{ vproto_id() };
    restored.deserialize( json_loader::from_string( wire ).get_object() );
    CHECK_FALSE( restored.has_effect( retired_effect ) );
    CHECK_FALSE( restored.has_effect( stunned ) );
    CHECK_FALSE( restored.has_effect( efftype_id( "winded_arm" ) ) );
    REQUIRE( restored.get_effects().size() == 2 );
    REQUIRE( restored.has_effect( grabbed ) );
    REQUIRE( restored.has_effect( wet ) );

    restored.process_effects();
    CHECK( restored.has_effect( grabbed ) );
    restored.process_effects();
    CHECK_FALSE( restored.has_effect( grabbed ) );
    REQUIRE( restored.get_effects().size() == 1 );
    REQUIRE( restored.has_effect( wet ) );
    const effect &remaining = restored.get_effects().front().get();
    REQUIRE_FALSE( remaining.is_null() );
    CHECK( remaining.get_id() == wet );
    CHECK( remaining.get_duration() == 30_minutes );
    CHECK( remaining.get_intensity() == 2 );
    CHECK( remaining.is_permanent() );
}
