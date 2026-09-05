#include <optional>
#include <unordered_set>

#include "activity_actor_definitions.h"
#include "activity_item_handling.h"
#include "avatar.h"
#include "calendar.h"
#include "cata_catch.h"
#include "cata_scope_helpers.h"
#include "clone_ptr.h"
#include "clzones.h"
#include "item.h"
#include "item_location.h"
#include "map.h"
#include "map_helpers.h"
#include "player_helpers.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "type_id.h"
#include "units.h"
#include "veh_type.h"
#include "vehicle.h"
#include "vpart_position.h"
#include "vpart_range.h"

static const activity_id ACT_GUNMOD_REMOVE( "ACT_GUNMOD_REMOVE" );
static const activity_id ACT_MOVE_LOOT( "ACT_MOVE_LOOT" );

TEST_CASE( "zone_gunmod_removal_preserves_location_and_resumes_sorting",
           "[zones][activities][gunmod]" )
{
    clear_avatar();
    clear_map_without_vision();
    avatar &you = get_avatar();
    map &here = get_map();
    zone_manager &zones = zone_manager::get_manager();
    zones.clear();
    on_out_of_scope cleanup( [&]() {
        you.cancel_activity();
        you.backlog.clear();
        zones.clear();
    } );
    const tripoint_bub_ms pos( 60, 60, 0 );
    you.setpos( here, pos );
    const tripoint_abs_ms abs = here.get_abs( pos );
    zones.add( "Unload", zone_type_id( "UNLOAD_ALL" ), faction_id( "your_followers" ),
               false, true, abs, abs );
    zones.cache_data();
    item gun( itype_id( "win70" ) );
    REQUIRE( gun.put_in( item( itype_id( "shoulder_strap" ) ), pocket_type::MOD ).success() );
    item *stored = nullptr;
    std::optional<vpart_reference> cargo;
    if( GENERATE( false, true ) ) {
        vehicle *cart = here.add_vehicle( vproto_id( "test_shopping_cart" ), pos,
                                          0_degrees, 0, veh_spawn_status::UNDAMAGED );
        REQUIRE( cart );
        cargo = here.veh_at( pos ).cargo();
        REQUIRE( cargo );
        const auto added = cart->add_item( here, cargo->part(), gun );
        REQUIRE( added );
        stored = & **added;
    } else {
        stored = &here.add_item_or_charges( pos, gun );
    }
    REQUIRE( stored );
    you.assign_activity( zone_sort_activity_actor() );
    you.set_moves( 1000 );
    zone_sorting::unload_sort_options options;
    options.unload_mods = true;
    int processed = 0;
    CHECK_FALSE( zone_sorting::unload_item( you, abs, options, cargo, stored, {}, processed ) );
    REQUIRE( you.activity.id() == ACT_GUNMOD_REMOVE );
    REQUIRE_FALSE( you.backlog.empty() );
    CHECK( you.backlog.front().id() == ACT_MOVE_LOOT );
    CHECK( you.backlog.front().auto_resume );
    you.activity.actor->finish( you.activity, you );
    CHECK( stored->gunmods().empty() );
    you.resume_backlog_activity();
    REQUIRE( you.activity.id() == ACT_MOVE_LOOT );
    // With no remaining sortable items, the resumed parent restores the view.
    you.zone_sort_viewport.active = true;
    process_activity( you );
    CHECK_FALSE( you.activity );
    CHECK_FALSE( you.zone_sort_viewport.active );
}
