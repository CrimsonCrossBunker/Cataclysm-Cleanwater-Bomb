#include <string>
#include <utility>

#include "activity_actor_definitions.h"
#include "avatar.h"
#include "butchery.h"
#include "calendar.h"
#include "cata_catch.h"
#include "coordinates.h"
#include "event.h"
#include "event_bus.h"
#include "event_subscriber.h"
#include "flag.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "monster.h"
#include "player_activity.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "recipe_dictionary.h"
#include "ret_val.h"
#include "type_id.h"

static const itype_id itype_knife_combat( "knife_combat" );
static const itype_id itype_test_rag_bundle( "test_rag_bundle" );

static const mtype_id mon_chicken( "mon_chicken" );
static const mtype_id mon_deer( "mon_deer" );
static const mtype_id mon_zombie( "mon_zombie" );

static const skill_id skill_survival( "survival" );

TEST_CASE( "completed_butchery_delivers_products_and_consumes_the_corpse",
           "[butchery][activity_completion]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    item knife( itype_knife_combat );
    you.wield( knife );
    you.set_skill_level( skill_survival, 10 );
    you.set_dex_base( 12 );
    const mtype_id type = GENERATE( mon_deer, mon_chicken, mon_zombie );
    CAPTURE( type );
    const tripoint_bub_ms position = you.pos_bub();
    monster victim( type, position );
    victim.die( &here, nullptr );
    item_location corpse;
    for( item &value : here.i_at( position ) ) {
        if( value.is_corpse() ) {
            corpse = item_location( map_cursor( position ), &value );
            break;
        }
    }
    REQUIRE( corpse );
    SECTION( "ordinary_corpse" ) {}
    SECTION( "corpse_with_an_unfinished_workpiece" ) {
        item component( itype_test_rag_bundle );
        item unfinished( &recipe_dictionary::get_uncraft( component.typeId() ), 1, component );
        REQUIRE( corpse->put_in( unfinished, pocket_type::CONTAINER ).success() );
    }
    const item snapshot( *corpse );
    INFO( "Corpse stacks with its untouched copy: " <<
          static_cast<bool>( corpse->stacks_with( snapshot, true, false, false, 0, 999, true ) ) );
    butchery_data work( corpse, butcher_type::QUICK );
    work.time_to_butcher = 1_seconds;
    work.progress = work.time_to_butcher;
    you.assign_activity( butchery_activity_actor( work ) );
    REQUIRE( you.activity );
    you.activity.do_turn( you );
    CHECK_FALSE( corpse );
    bool produced_material = false;
    for( const item &value : here.i_at( position ) ) {
        produced_material |= value.is_comestible();
    }
    CHECK( produced_material );
}

TEST_CASE( "butchery_rechecks_the_corpse_after_training_callbacks",
           "[butchery][activity_completion]" )
{
    clear_avatar();
    clear_map();
    avatar &you = get_avatar();
    map &here = get_map();
    item knife( itype_knife_combat );
    you.wield( knife );
    you.set_skill_level( skill_survival, 10 );
    item_location corpse = here.add_item_or_charges_ret_loc( you.pos_bub(),
                           item::make_corpse( mon_deer, calendar::turn ) );
    REQUIRE( corpse );
    class change_corpse_on_training : public event_subscriber
    {
        public:
            item_location corpse;
            bool fired = false;
            explicit change_corpse_on_training( item_location corpse ) : corpse( std::move( corpse ) ) {
                get_event_bus().subscribe( this );
            }
            void notify( const cata::event &event ) override {
                if( !fired && event.type() == event_type::gains_proficiency ) {
                    fired = true;
                    corpse->set_damage( 1000 );
                }
            }
    } callback( corpse );
    butchery_data work( corpse, butcher_type::QUICK );
    // Ensure proficiency training emits its synchronous callback during harvest.
    work.time_to_butcher = 30_days;
    destroy_the_carcass( work, you );
    REQUIRE( callback.fired );
    REQUIRE( corpse );
    CHECK( corpse->damage() == 1000 );
    CHECK( here.i_at( you.pos_bub() ).size() == 1 );
}

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
