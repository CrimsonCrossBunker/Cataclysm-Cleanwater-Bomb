#include "player_identity.h"

#include <algorithm>
#include <array>
#include <fstream>
#include <stdexcept>

#include "mp_player_identity.h"

#if defined(_WIN32)
    #include "platform_win.h"
    #include <bcrypt.h>
#endif

namespace
{
bool hex_string( const std::string &value, size_t length )
{
    return value.size() == length && std::all_of( value.begin(), value.end(), []( char c ) {
        return ( c >= '0' && c <= '9' ) || ( c >= 'a' && c <= 'f' );
    } );
}

std::string identity_material()
{
    std::array<unsigned char, 48> bytes{};
#if defined(_WIN32)
    // Resolve the system provider without adding a new link-time dependency.
    const HMODULE library = LoadLibraryExW( L"bcrypt.dll", nullptr, LOAD_LIBRARY_SEARCH_SYSTEM32 );
    if( !library ) {
        throw std::runtime_error( "Cannot load system entropy provider" );
    }
    const auto generate = reinterpret_cast<decltype( &BCryptGenRandom )>(
                              GetProcAddress( library, "BCryptGenRandom" ) );
    const bool success = generate && generate( nullptr, bytes.data(), bytes.size(),
                         BCRYPT_USE_SYSTEM_PREFERRED_RNG ) == 0;
    FreeLibrary( library );
    if( !success ) {
        throw std::runtime_error( "Cannot obtain system entropy" );
    }
#else
    std::ifstream entropy( "/dev/urandom", std::ios::binary );
    if( !entropy.read( reinterpret_cast<char *>( bytes.data() ), bytes.size() ) ) {
        throw std::runtime_error( "Cannot obtain system entropy" );
    }
#endif
    static constexpr char digits[] = "0123456789abcdef";
    std::string hex;
    for( const unsigned char byte : bytes ) {
        hex += digits[byte >> 4];
        hex += digits[byte & 15];
    }
    return hex;
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
    return player_id( identity_material().substr( 0, 32 ) );
}

namespace cata_mp
{
bool player_credentials::valid() const
{
    return id.valid() && hex_string( resume_secret, 64 );
}

player_credentials create_player_credentials()
{
    const std::string hex = identity_material();
    return { player_id( hex.substr( 0, 32 ) ), hex.substr( 32 ) };
}

} // namespace cata_mp
