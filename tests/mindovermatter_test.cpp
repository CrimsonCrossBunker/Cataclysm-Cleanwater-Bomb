#include "avatar.h"
#include "bodypart.h"
#include "calendar.h"
#include "cata_catch.h"
#include "dialogue.h"
#include "effect.h"
#include "effect_on_condition.h"
#include "json.h"
#include "json_loader.h"
#include "magic.h"
#include "magic_enchantment.h"
#include "monster.h"
#include "npc.h"
#include "talker.h"
#include "type_id.h"

TEST_CASE( "mindovermatter_fire_conditions_handle_local_and_global_effects",
           "[.][mods][mindovermatter][fire_conditions]" )
{
    INFO( "Requires --mods mindovermatter" );
    const spell_id intensify_id( "pyrokinetic_intensify_flames_target_creature" );
    const effect_on_condition_id blocked( "EOC_CONDITION_MOM_BANNED_EFFECTS_TO_PRACTICE_CONCENTRATION" );
    REQUIRE( intensify_id.is_valid() );
    REQUIRE( blocked.is_valid() );
    const spell intensify( intensify_id );
    const efftype_id onfire( "onfire" );
    avatar u;
    u.set_body();
    npc caster;
    const const_dialogue concentration( get_const_talker_for( u ), nullptr );
    CHECK_FALSE( blocked->test_condition( concentration ) );
    CHECK_FALSE( intensify.valid_target_condition( caster, u ) );

    SECTION( "fire on a replacement torso satisfies both conditions" ) {
        enchantment replacement;
        replacement.load( json_loader::from_string( R"({
            "modified_bodyparts": [ { "lose": "torso" }, { "gain": "torso_slime" } ]
        })" ).get_object() );
        u.enchantment_cache->force_add( replacement, u );
        u.recalculate_bodyparts();
        const bodypart_id actual_torso( "torso_slime" );
        u.add_effect( onfire, 5_turns, actual_torso, false, 1, false, true );
        REQUIRE_FALSE( u.get_effect( onfire, actual_torso ).is_null() );
        CHECK( u.get_effect( onfire, body_part_torso ).is_null() );
        CHECK( u.get_effect( onfire ).is_null() );
        CHECK( blocked->test_condition( concentration ) );
        CHECK( intensify.valid_target_condition( caster, u ) );
    }

    SECTION( "global character fire also satisfies both conditions" ) {
        u.add_effect( onfire, 5_turns, false, 1, false, true );
        REQUIRE_FALSE( u.get_effect( onfire ).is_null() );
        CHECK( blocked->test_condition( concentration ) );
        CHECK( intensify.valid_target_condition( caster, u ) );
    }

    SECTION( "Intensify Flames accepts either kind of monster fire record" ) {
        const bodypart_id part = GENERATE( body_part_hand_l.id(), bodypart_str_id::NULL_ID().id() );
        CAPTURE( part );
        monster target( mtype_id( "mon_zombie" ) );
        CHECK_FALSE( intensify.valid_target_condition( u, target ) );
        target.add_effect( onfire, 5_turns, part, false, 1, false, true );
        REQUIRE_FALSE( target.get_effect( onfire, part ).is_null() );
        CHECK( intensify.valid_target_condition( u, target ) );
    }
}
