#include "identity_random.h"

#include <fstream>
#include <stdexcept>
#include <vector>

#if defined(_WIN32)
    #include "platform_win.h"
    #include <bcrypt.h>
#endif

std::string random_identity_hex( size_t byte_count )
{
    // Keep allocations and native-provider length conversions bounded.
    if( byte_count == 0 || byte_count > 1024 ) {
        throw std::invalid_argument( "Invalid identity material size" );
    }
    std::vector<unsigned char> bytes( byte_count );
#if defined(_WIN32)
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
    hex.reserve( bytes.size() * 2 );
    for( const unsigned char byte : bytes ) {
        hex += digits[byte >> 4];
        hex += digits[byte & 15];
    }
    return hex;
}
