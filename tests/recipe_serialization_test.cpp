#include <array>
#include <sstream>
#include <string>

#include "cata_catch.h"
#include "json.h"
#include "json_loader.h"
#include "recipe.h"
#include "recipe_dictionary.h"
#include "type_id.h"

static std::string saved_recipes( const recipe_subset &value )
{
    std::ostringstream stream;
    JsonOut out( stream );
    serialize( value, out );
    return stream.str();
}

TEST_CASE( "recipe_subset_save_is_independent_of_object_addresses", "[recipe][save][replay]" )
{
    // Arrays give the same IDs two deliberately different address orders.
    // Merely reversing insertion into a pointer-ordered set cannot test this.
    const std::array<recipe, 3> ascending = {
        recipe_id( "bandana" ).obj(), recipe_id( "meat_cooked" ).obj(),
        recipe_id( "water_clean" ).obj()
    };
    const std::array<recipe, 3> descending = { ascending[2], ascending[1], ascending[0] };
    recipe_subset first;
    recipe_subset second;
    for( const recipe &entry : ascending ) {
        first.include( &entry );
    }
    for( const recipe &entry : descending ) {
        second.include( &entry );
    }
    const std::string expected = R"(["bandana","meat_cooked","water_clean"])";
    CHECK( saved_recipes( first ) == expected );
    CHECK( saved_recipes( second ) == expected );
    CHECK( saved_recipes( first ) == saved_recipes( second ) );

    recipe_subset loaded;
    deserialize( loaded, json_loader::from_string( saved_recipes( second ) ).get_array() );
    REQUIRE( loaded.size() == ascending.size() );
    for( const recipe &entry : ascending ) {
        CHECK( loaded.contains( &entry ) );
    }
    CHECK( saved_recipes( loaded ) == expected );
}

TEST_CASE( "recipe_subset_load_accepts_legacy_unsorted_ids", "[recipe][save][replay]" )
{
    recipe_subset loaded;
    deserialize( loaded, json_loader::from_string(
                     R"(["water_clean","bandana","meat_cooked","bandana"])" ).get_array() );
    CHECK( loaded.size() == 3 );
    CHECK( saved_recipes( loaded ) == R"(["bandana","meat_cooked","water_clean"])" );
    loaded.clear();
    CHECK( saved_recipes( loaded ) == "[]" );
    deserialize( loaded, json_loader::from_string( "[]" ).get_array() );
    CHECK( loaded.size() == 0 );
}
