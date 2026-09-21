#include <algorithm>
#include <array>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "cata_catch.h"
#include "flexbuffer_json.h"
#include "item.h"
#include "itype.h"
#include "json.h"
#include "json_loader.h"
#include "text_snippets.h"
#include "type_id.h"
#include "worldfactory.h"

static const itype_id itype_menstrual_pad( "menstrual_pad" );
static const mod_id MOD_INFORMATION_pride_items( "pride_items" );
static const snippet_id snippet_menstrual_pad6( "menstrual_pad6" );

namespace
{

bool pride_items_enabled()
{
    const std::vector<mod_id> &mods = world_generator->active_world->active_mod_order;
    return std::find( mods.begin(), mods.end(), MOD_INFORMATION_pride_items ) != mods.end();
}

item load_saved_item( const std::string &saved )
{
    item result;
    JsonValue value = json_loader::from_string( saved );
    result.deserialize( value.get_object() );
    return result;
}

std::string save_item( const item &value )
{
    std::ostringstream stream;
    JsonOut json( stream );
    value.serialize( json );
    return stream.str();
}

} // namespace

// Run both with the default core/test data and with --mods=pride_items.
TEST_CASE( "legacy_pride_pad_snippets_load_with_and_without_pride_items",
           "[pride_items][item][savegame][text_snippets]" )
{
    REQUIRE( world_generator->active_world != nullptr );
    REQUIRE( itype_menstrual_pad.is_valid() );
    const bool with_pride_items = pride_items_enabled();
    CAPTURE( with_pride_items );

    CHECK( itype_menstrual_pad->snippet_category == "auto:menstrual_pad" );
    const std::vector<std::pair<snippet_id, std::string>> snippets =
                SNIPPET.get_snippets_by_category( itype_menstrual_pad->snippet_category );
    const bool can_spawn_pride_snippet = std::any_of( snippets.begin(), snippets.end(),
    []( const std::pair<snippet_id, std::string> &entry ) {
        return entry.first == snippet_menstrual_pad6;
    } );
    CHECK( can_spawn_pride_snippet == with_pride_items );
    CHECK( snippet_menstrual_pad6.is_valid() == with_pride_items );

    // Both persisted spellings of the snippet key must survive even when the
    // optional snippet is absent.  Its missing text uses the base description.
    const std::array<std::string, 2> snippet_keys = { "snip_id", "snippet_id" };
    for( const std::string &key : snippet_keys ) {
        CAPTURE( key );
        const std::string legacy = R"({"typeid":"menstrual_pad",")" + key +
                                   R"(":"menstrual_pad6","damaged":1000,"bday":0})";
        const item loaded = load_saved_item( legacy );
        CHECK( loaded.typeId().str() == "menstrual_pad" );
        CHECK( loaded.damage() == 1000 );
        CHECK( loaded.snip_id.str() == "menstrual_pad6" );
        CHECK( SNIPPET.get_snippet_by_id( loaded.snip_id ).has_value() == with_pride_items );

        const item reloaded = load_saved_item( save_item( loaded ) );
        CHECK( reloaded.typeId().str() == "menstrual_pad" );
        CHECK( reloaded.damage() == loaded.damage() );
        CHECK( reloaded.snip_id.str() == "menstrual_pad6" );
        CHECK( SNIPPET.get_snippet_by_id( reloaded.snip_id ).has_value() == with_pride_items );
    }
}
