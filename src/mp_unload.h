#pragma once
#ifndef CATA_SRC_MP_UNLOAD_H
#define CATA_SRC_MP_UNLOAD_H

#include "item_unload.h"
#include "mp_item_source.h"

namespace cata_mp
{
struct unload_intent {
    item_source root;
    item_source target;
    std::vector<int64_t> sources;
    std::vector<unload_liquid_choice> liquids;
    void serialize( JsonOut &out ) const;
    void deserialize( const JsonObject &object );
};

unload_intent make_unload_intent( const Character &who, const item_location &root,
                                  const unload_selection &selection,
                                  const std::vector<unload_liquid_choice> &liquids );
bool start_owned_unload( Character &who, map &here, const JsonObject &request );
void client_select_unload( const item_location &root,
                           const item_location &new_container = item_location::nowhere );
} // namespace cata_mp
#endif // CATA_SRC_MP_UNLOAD_H
