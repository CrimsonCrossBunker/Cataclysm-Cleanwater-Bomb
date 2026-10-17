#include <algorithm>
#include <vector>

#include "cata_catch.h"
#include "dependency_tree.h"
#include "type_id.h"

static const mod_id MOD_INFORMATION_sync_addon_a( "sync_addon_a" );
static const mod_id MOD_INFORMATION_sync_addon_b( "sync_addon_b" );
static const mod_id MOD_INFORMATION_sync_core( "sync_core" );
static const mod_id MOD_INFORMATION_sync_root( "sync_root" );

TEST_CASE( "shared_mod_dependencies_load_before_each_dependent", "[dependency_order][nogame]" )
{
    dependency_node core( MOD_INFORMATION_sync_core );
    dependency_node first( MOD_INFORMATION_sync_addon_a );
    dependency_node second( MOD_INFORMATION_sync_addon_b );
    dependency_node root( MOD_INFORMATION_sync_root );
    first.add_parent( &core );
    second.add_parent( &core );
    root.add_parent( &core );
    root.add_parent( &first );
    root.add_parent( &second );

    const std::vector<dependency_node *> order = root.get_dependencies_as_nodes();
    REQUIRE( order.size() == 3 );
    const std::vector<dependency_node *> expected{ &core, &first, &second };
    CHECK( order == expected );
    CHECK( std::count( order.begin(), order.end(), &core ) == 1 );
    CHECK( std::find( order.begin(), order.end(), &root ) == order.end() );
}
