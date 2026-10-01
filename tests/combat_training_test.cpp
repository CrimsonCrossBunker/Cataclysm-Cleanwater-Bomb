#include "avatar.h"
#include "cata_catch.h"
#include "combat_training.h"
#include "player_helpers.h"
#include "skill.h"
#include "type_id.h"

static const skill_id skill_bashing( "bashing" );
static const skill_id skill_dodge( "dodge" );
static const skill_id skill_melee( "melee" );
static const skill_id skill_unarmed( "unarmed" );

TEST_CASE( "combat_training_uses_soft_difficulty_limits", "[skill][combat]" )
{
    CHECK( combat_training_multiplier( 2, 8 ) == 1.0 );
    CHECK( combat_training_multiplier( 8, 8 ) == 1.0 );
    CHECK( combat_training_multiplier( 8, 6 ) == Approx( 1.0 / 3.0 ) );
    CHECK( combat_training_multiplier( 8, 2 ) == Approx( 1.0 / 7.0 ) );
    CHECK( combat_training_multiplier( 20, 0 ) > 0.0 );
    CHECK( combat_training_multiplier( 10, 4 ) < combat_training_multiplier( 8, 4 ) );
}

TEST_CASE( "combat_practice_continues_above_opponent_training_level", "[skill][combat]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    const skill_id id = GENERATE( skill_melee, skill_bashing, skill_unarmed, skill_dodge );
    you.set_skill_level( id, 10 );
    const int before = you.get_skill_level_object( id ).exercise( true );

    you.practice_combat( id, 90, 2 );

    CHECK( you.get_skill_level_object( id ).exercise( true ) > before );
}

TEST_CASE( "strong_opponents_train_faster_without_changing_other_practice_caps", "[skill][combat]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    you.set_skill_level( skill_melee, 10 );
    you.practice_combat( skill_melee, 90, 2 );
    const int weak_experience = you.get_skill_level_object( skill_melee ).exercise( true );
    REQUIRE( weak_experience > 0 );

    clear_avatar();
    you.set_skill_level( skill_melee, 10 );
    you.practice_combat( skill_melee, 90, 10 );
    CHECK( you.get_skill_level_object( skill_melee ).exercise( true ) > weak_experience );

    clear_avatar();
    you.set_skill_level( skill_melee, 10 );
    you.practice( skill_melee, 90, 2, true );
    CHECK( you.get_skill_level_object( skill_melee ).exercise( true ) == 0 );
}
