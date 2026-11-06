#include <functional>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "debug.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "item_contents.h"
#include "item_pocket.h"
#include "json.h"
#include "json_loader.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "type_id.h"
#include "units.h"

TEST_CASE( "battery_restore_remaps_pockets_without_losing_state", "[item][pocket][save]" )
{
    const itype_id battery_id( GENERATE( "heavy_battery_cell", "heavy_plus_battery_cell" ) );
    pocket_data heavy( pocket_type::MAGAZINE_WELL );
    heavy.item_id_restriction.insert( battery_id );
    heavy.max_item_length = 1_meter;
    const std::vector<pocket_data> old_pockets = { heavy };
    item_contents original( old_pockets );
    item battery( battery_id );
    battery.ammo_set( itype_id( "battery" ), 123 );
    battery.set_var( "item_label", "saved battery" );
    battery.set_favorite( true );
    REQUIRE( original.insert_item( battery, pocket_type::MAGAZINE_WELL ).success() );
    std::ostringstream stream;
    JsonOut json( stream );
    original.serialize( json );
    item_contents loaded;
    loaded.deserialize( json_loader::from_string( stream.str() ).get_object() );

    pocket_data light( pocket_type::MAGAZINE_WELL );
    light.item_id_restriction.insert( itype_id( "light_battery_cell" ) );
    light.max_item_length = 1_meter;
    std::vector<pocket_data> new_pockets;
    bool compatible = false;
    SECTION( "same_type_pockets_have_changed_order" ) {
        new_pockets = { light, heavy };
        compatible = true;
    }
    SECTION( "removed_battery_well_preserves_the_battery_for_migration" ) {
        new_pockets = { pocket_data( pocket_type::CONTAINER ) };
    }
    new_pockets.emplace_back( pocket_type::MIGRATION );
    item_contents restored( new_pockets );
    const std::string diagnostics = capture_debugmsg_during( [&restored, &loaded]() {
        restored.combine( std::move( loaded ), false, true, false, true );
    } );
    CHECK( diagnostics.empty() );
    const auto batteries = restored.all_items_top( compatible ? pocket_type::MAGAZINE_WELL :
                           pocket_type::MIGRATION );
    REQUIRE( batteries.size() == 1 );
    CHECK( batteries.front()->typeId() == battery_id );
    CHECK( batteries.front()->ammo_remaining() == 123 );
    CHECK( batteries.front()->get_var( "item_label" ) == "saved battery" );
    CHECK( batteries.front()->is_favorite );
    CHECK( batteries.front()->uid() ==
           original.all_items_top( pocket_type::MAGAZINE_WELL ).front()->uid() );
    CHECK( restored.all_items_top( pocket_type::MAGAZINE_WELL ).size() +
           restored.all_items_top( pocket_type::MIGRATION ).size() == 1 );
}

