#include "world_identity.h"

#include <algorithm>
#include <stdexcept>

world_id::world_id( const std::string &value ) : value_( value )
{
    if( value_.size() != 32 || !std::all_of( value_.begin(), value_.end(), []( char c ) {
    return ( c >= '0' && c <= '9' ) || ( c >= 'a' && c <= 'f' );
    } ) ) {
        throw std::invalid_argument( "Invalid persistent world ID" );
    }
}
