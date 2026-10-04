#include <string>

#include "avatar.h"
#include "butchery.h"
#include "calendar.h"
#include "cata_catch.h"
#include "flag.h"
#include "item.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "type_id.h"

static const itype_id itype_knife_combat( "knife_combat" );
static const mtype_id mon_deer( "mon_deer" );

TEST_CASE( "batch_butchery_skips_processed_corpses", "[butchery][batch]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    item knife( itype_knife_combat );
    you.wield( knife );
    item fresh = item::make_corpse( mon_deer, calendar::turn );
    item dressed = fresh;
    dressed.set_flag( flag_FIELD_DRESS );
    item skinned = fresh;
    skinned.set_flag( flag_SKINNED );

    CHECK( butcher_action_applicable( you, fresh, butcher_type::FIELD_DRESS ) );
    CHECK( butcher_action_applicable( you, fresh, butcher_type::SKIN ) );
    CHECK_FALSE( butcher_action_applicable( you, dressed, butcher_type::FIELD_DRESS ) );
    CHECK( butcher_action_applicable( you, dressed, butcher_type::SKIN ) );
    CHECK_FALSE( butcher_action_applicable( you, skinned, butcher_type::SKIN ) );
    CHECK( butcher_action_applicable( you, skinned, butcher_type::FIELD_DRESS ) );
}

TEST_CASE( "coarse_butchery_progress_only_blocks_its_own_corpse", "[butchery][batch]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    item knife( itype_knife_combat );
    you.wield( knife );
    item fresh = item::make_corpse( mon_deer, calendar::turn );
    item started = fresh;
    started.set_var( butcher_progress_var( butcher_type::QUICK ), 0.5 );

    CHECK_FALSE( butcher_action_applicable( you, started, butcher_type::FULL ) );
    CHECK( butcher_action_applicable( you, fresh, butcher_type::FULL ) );
    CHECK( butcher_action_applicable( you, started, butcher_type::QUICK ) );
    CHECK( butcher_action_applicable( you, started, butcher_type::DISMEMBER ) );
}
