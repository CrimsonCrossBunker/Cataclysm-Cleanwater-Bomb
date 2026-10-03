#pragma once
#ifndef CATA_SRC_MOD_ID_COMPAT_H
#define CATA_SRC_MOD_ID_COMPAT_H

#include <algorithm>
#include <string>
#include <string_view>
#include <utility>
#include <vector>

#include "type_id.h"

// Keep the former core ID readable without registering a second core pack.
inline mod_id canonical_mod_id( const mod_id &id )
{
    return id.str() == "dda" ? mod_id( "ccb" ) : id;
}

inline bool mod_id_is_in_active_order( const mod_id &requested,
                                       const std::vector<mod_id> &active_mod_order )
{
    const mod_id canonical_requested = canonical_mod_id( requested );
    return std::any_of( active_mod_order.begin(), active_mod_order.end(),
    [&canonical_requested]( const mod_id & active ) {
        return canonical_mod_id( active ) == canonical_requested;
    } );
}

inline bool is_core_data_source( std::string_view id )
{
    return id == "ccb" || id == "dda";
}

// Canonicalize before deduplicating so worlds containing both IDs load core once.
inline void canonicalize_mod_list( std::vector<mod_id> &mods )
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

#endif // CATA_SRC_MOD_ID_COMPAT_H
