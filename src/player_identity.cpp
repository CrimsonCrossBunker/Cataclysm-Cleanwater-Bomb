#include "player_identity.h"

#include <algorithm>
#include <stdexcept>

#include "mp_player_identity.h"
#include "identity_random.h"



namespace
{
bool hex_string( const std::string &value, size_t length )
{
    return value.size() == length && std::all_of( value.begin(), value.end(), []( char c ) {
        return ( c >= '0' && c <= '9' ) || ( c >= 'a' && c <= 'f' );
    } );
}

} // namespace

player_id::player_id( const std::string &value ) : value_( value )
{
    if( !hex_string( value_, 32 ) ) {
        throw std::invalid_argument( "Invalid persistent player ID" );
    }
}

player_id create_player_id()
{
    return player_id( random_identity_hex( 48 ).substr( 0, 32 ) );
}

namespace cata_mp
{
bool player_credentials::valid() const
{
    return id.valid() && hex_string( resume_secret, 64 );
}

player_credentials create_player_credentials()
{
    const std::string hex = random_identity_hex( 48 );
    return { player_id( hex.substr( 0, 32 ) ), hex.substr( 32 ) };
}

} // namespace cata_mp
