#if defined(CATA_ENABLE_LUA_PLATFORM) && CATA_ENABLE_LUA_PLATFORM
#include <ostream>
#include <sstream>
#include <stdexcept>
#include <string>

#include "cata_catch.h"
#include "lua_platform_state.h"

TEST_CASE( "lua_platform_state_output_stops_at_its_byte_limit",
           "[lua][platform][state]" )
{
    cata::lua_platform::detail::bounded_state_output_buffer storage( 4, "bounded output sentinel" );
    std::ostream output( &storage );
    output.exceptions( std::ios::badbit | std::ios::failbit );
    output.write( "ab", 2 );
    output.put( 'c' );
    output.write( "d", 1 );
    CHECK( storage.str() == "abcd" );
    CHECK_THROWS_WITH( output.put( 'e' ), "bounded output sentinel" );
    CHECK( storage.str() == "abcd" );
    output.clear();
    output.write( "", 0 );
    CHECK_THROWS_AS( output.write( "extra", 5 ), std::invalid_argument );
    CHECK( storage.str() == "abcd" );
}

TEST_CASE( "lua_platform_state_output_counts_binary_bytes_and_rejects_whole_chunks",
           "[lua][platform][state]" )
{
    cata::lua_platform::detail::bounded_state_output_buffer storage( 4, "bounded output sentinel" );
    std::ostream output( &storage );
    output.exceptions( std::ios::badbit | std::ios::failbit );
    output.write( "a\0b", 3 );
    CHECK( storage.str() == std::string( "a\0b", 3 ) );
    CHECK_THROWS_AS( output.write( "cd", 2 ), std::invalid_argument );
    CHECK( storage.str().size() == 3 );
    output.clear();
    output.put( 'c' );
    CHECK( storage.str() == std::string( "a\0bc", 4 ) );
}

TEST_CASE( "lua_platform_oversized_encoded_state_does_not_touch_its_destination",
           "[lua][platform][state]" )
{
    namespace platform = cata::lua_platform;
    platform::script_persistent_state state;
    // Raw values fit the 512 KiB state allowance, but JSON escapes exceed the
    // existing 1 MiB codec limit. Only three 64 KiB raw values are needed.
    for( const char *key : {
             "one", "two", "three"
         } ) {
        platform::assign_persistent_value( state, key,
                                           std::string( platform::persistent_state_max_string_bytes, '\x01' ) );
    }
    std::ostringstream destination;
    destination << "previous output";
    CHECK_THROWS_AS( platform::write_persistent_state( destination, state ), std::invalid_argument );
    CHECK( destination.str() == "previous output" );
}
#endif
