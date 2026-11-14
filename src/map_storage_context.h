#pragma once
#ifndef CATA_SRC_MAP_STORAGE_CONTEXT_H
#define CATA_SRC_MAP_STORAGE_CONTEXT_H

#include "cata_path.h"
#include "type_id.h"
#include "world_identity.h"

// A storage namespace is not a live game/renderer context. Paths are resolved
// once on the owner thread and remain valid when the active world changes.
class map_storage_context
{
    public:
        map_storage_context( world_id world, dimension_id dimension,
                             const cata_path &world_directory, bool compressed );
        const world_id &world() const {
            return world_;
        }
        const dimension_id &dimension() const {
            return dimension_;
        }
        const cata_path &directory() const {
            return directory_;
        }
        const cata_path &dictionary() const {
            return dictionary_;
        }
        bool compressed() const {
            return compressed_;
        }

    private:
        world_id world_;
        dimension_id dimension_;
        cata_path directory_;
        cata_path dictionary_;
        bool compressed_;
};

#endif // CATA_SRC_MAP_STORAGE_CONTEXT_H
