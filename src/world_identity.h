#pragma once
#ifndef CATA_SRC_WORLD_IDENTITY_H
#define CATA_SRC_WORLD_IDENTITY_H

#include <string>

// Persistent world lineage, independent of its display name, folder, seed,
// local client cache and current network session. This is not authentication.
class world_id
{
    public:
        world_id() = default;
        explicit world_id( const std::string &value );
        bool valid() const {
            return !value_.empty();
        }
        const std::string &str() const {
            return value_;
        }
        bool operator==( const world_id &other ) const {
            return value_ == other.value_;
        }
        bool operator!=( const world_id &other ) const {
            return !( *this == other );
        }
    private:
        std::string value_;
};

#endif // CATA_SRC_WORLD_IDENTITY_H
