#include <string>

#include "avatar.h"
#include "cata_catch.h"
#include "combat_training.h"
#include "coordinates.h"
#include "map_helpers.h"
#include "map_helpers_tests.h"
#include "monster.h"
#include "player_helpers.h"
#include "point.h"
#include "skill.h"
#include "type_id.h"

static const skill_id skill_bashing( "bashing" );
static const skill_id skill_cutting( "cutting" );
static const skill_id skill_dodge( "dodge" );
static const skill_id skill_melee( "melee" );
static const skill_id skill_stabbing( "stabbing" );
static const skill_id skill_unarmed( "unarmed" );

TEST_CASE( "combat_training_respects_opponent_limits", "[skill][combat]" )
{
    CHECK( combat_training_multiplier( 2, 8 ) == 1.0 );
    CHECK( combat_training_multiplier( 8, 8 ) == 1.0 );
    CHECK( combat_training_multiplier( 8, 6 ) == 0.0 );
    CHECK( combat_training_multiplier( 8, 2 ) == 0.0 );
    CHECK( combat_training_multiplier( 20, 0 ) == 0.0 );
}

TEST_CASE( "combat_practice_stops_above_opponent_training_level", "[skill][combat]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    const skill_id id = GENERATE( skill_melee, skill_bashing, skill_cutting,
                                  skill_stabbing, skill_unarmed, skill_dodge );
    const int cap = GENERATE( 0, 2, 6 );
    you.set_skill_level( id, cap + 1 );
    you.set_knowledge_level( id, cap + 1 );
    const SkillLevel &level = you.get_skill_level_object( id );
    const int practical_before = level.exercise( true );
    const int knowledge_before = level.knowledgeExperience( true );
    const int focus_before = you.get_focus();

    for( int i = 0; i < 100; ++i ) {
        CHECK_FALSE( you.practice_combat( id, 90, cap ) );
    }

    CHECK( level.exercise( true ) == practical_before );
    CHECK( level.knowledgeExperience( true ) == knowledge_before );
    CHECK( you.get_focus() == focus_before );
}

TEST_CASE( "combat_practice_preserves_training_at_and_below_cap", "[skill][combat]" )
{
    clear_avatar();
    avatar &you = get_avatar();
    const int skill = GENERATE( 1, 2 );
    you.set_skill_level( skill_melee, skill );
    you.set_knowledge_level( skill_melee, skill );
    you.practice_combat( skill_melee, 90, 2 );
    CHECK( you.get_skill_level_object( skill_melee ).exercise( true ) > 0 );

    you.set_skill_level( skill_melee, 10 );
    const int before = you.get_skill_level_object( skill_melee ).exercise( true );
    you.practice( skill_melee, 90, 2, true );
    CHECK( you.get_skill_level_object( skill_melee ).exercise( true ) == before );
}

TEST_CASE( "ordinary_zombies_cannot_train_high_level_dodging", "[skill][combat][dodge]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    you.set_skill_level( skill_dodge, 9 );
    you.set_knowledge_level( skill_dodge, 9 );
    const SkillLevel &level = you.get_skill_level_object( skill_dodge );
    const int before = level.exercise( true );
    const int knowledge_before = level.knowledgeExperience( true );
    // Keep the source non-adjacent so the training callback does not counterattack.
    monster &zombie = spawn_test_monster( "mon_zombie", you.pos_bub() + tripoint( 3, 0, 0 ) );
    const float difficulty = zombie.get_melee();
    REQUIRE( difficulty > 0 );
    REQUIRE( difficulty < 9 );
    for( int i = 0; i < 50; ++i ) {
        you.on_dodge( &zombie, difficulty );
    }
    CHECK( zombie.times_combatted_player == 50 );
    CHECK( level.exercise( true ) == before );
    CHECK( level.knowledgeExperience( true ) == knowledge_before );
}
