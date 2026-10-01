#include <sstream>
#include <vector>

#include "cata_catch.h"
#include "coordinates.h"
#include "flexbuffer_json.h"
#include "inventory_ui.h"
#include "item.h"
#include "item_contents.h"
#include "item_location.h"
#include "item_pocket.h"
#include "json.h"
#include "json_loader.h"
#include "map.h"
#include "map_helpers.h"
#include "map_selector.h"
#include "pocket_type.h"
#include "ret_val.h"
#include "type_id.h"

static const itype_id itype_magazine_battery_mod( "magazine_battery_mod" );
static const itype_id itype_small_storage_battery( "small_storage_battery" );
static const itype_id itype_wearable_light( "wearable_light" );

TEST_CASE( "toolmod_pocket_visibility_survives_save_load", "[item][pocket][toolmod][save]" )
{
    clear_map();
    map &here = get_map();
    const tripoint_bub_ms pos( 60, 60, 0 );
    item &lamp = here.add_item( pos, item( itype_wearable_light ) );
    REQUIRE( lamp.put_in( item( itype_magazine_battery_mod ), pocket_type::MOD ).success() );
    if( GENERATE( false, true ) ) {
        REQUIRE( lamp.put_in( item( itype_small_storage_battery ),
                              pocket_type::MAGAZINE_WELL ).success() );
    }
    const bool collapsed = GENERATE( false, true );
    inventory_selector_preset preset;
    inventory_column column( preset );
    inventory_entry entry( std::vector<item_location> {item_location( map_cursor( pos ), &lamp )} );
    column.set_collapsed( entry, collapsed );
    REQUIRE( lamp.is_collapsed() == collapsed );

    std::ostringstream stream;
    JsonOut json( stream );
    lamp.serialize( json );
    item restored;
    restored.deserialize( json_loader::from_string( stream.str() ).get_object() );

    REQUIRE( restored.all_items_top( pocket_type::MOD ).size() == 1 );
    CHECK( restored.all_items_top( pocket_type::MOD ).front()->typeId() ==
           itype_magazine_battery_mod );
    CHECK( restored.is_collapsed() == collapsed );
    for( const item_pocket *pocket : restored.get_pockets( []( const item_pocket & pocket ) {
    return pocket.is_standard_type() || pocket.is_type( pocket_type::MOD );
    } ) ) {
        CHECK( pocket->settings.is_collapsed() == collapsed );
    }
}
