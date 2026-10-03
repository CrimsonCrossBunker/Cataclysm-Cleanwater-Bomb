#include "mod_id_compat.h"

#include <algorithm>
#include <utility>
#include <vector>

void canonicalize_mod_list( std::vector<mod_id> &mods )
{
    std::vector<mod_id> canonical;
    canonical.reserve( mods.size() );
    for( const mod_id &id : mods ) {
        const mod_id resolved = canonical_mod_id( id );
        if( std::find( canonical.begin(), canonical.end(), resolved ) == canonical.end() ) {
            canonical.push_back( resolved );
        }
    }
    mods = std::move( canonical );
}
