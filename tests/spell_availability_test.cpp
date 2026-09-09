#include <map>
#include <memory>

#include "cata_catch.h"
#include "magic.h"
#include "npc.h"
#include "type_id.h"

static const magic_type_id magic_test_magic_available( "test_magic_available" );
static const magic_type_id magic_test_magic_unavailable( "test_magic_unavailable" );
static const spell_id spell_test_spell_lava( "test_spell_lava" );
static const spell_id spell_test_spell_pew( "test_spell_pew" );

TEST_CASE( "spell_menu_availability_tracks_all_known_magic_types", "[magic][spell][availability]" )
{
    npc guy;
    std::map<magic_type_id, bool> tracker;
    CHECK_FALSE( guy.magic->can_cast_any_spell( guy, tracker ) );
    CHECK( tracker.empty() );

    guy.magic->learn_spell( spell_test_spell_pew, guy, true );
    guy.magic->learn_spell( spell_test_spell_lava, guy, true );
    const int mana = GENERATE( 0, 50, 500 );
    CAPTURE( mana );
    guy.magic->set_mana( mana );
    CHECK( guy.magic->can_cast_any_spell( guy, tracker ) == ( mana >= 50 ) );
    REQUIRE( tracker.size() == 2 );
    CHECK( tracker.at( magic_test_magic_available ) == ( mana >= 50 ) );
    CHECK( tracker.at( magic_test_magic_unavailable ) == ( mana >= 500 ) );
}
