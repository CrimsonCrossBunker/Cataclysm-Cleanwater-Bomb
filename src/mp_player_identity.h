#pragma once
#ifndef CATA_SRC_MP_PLAYER_IDENTITY_H
#define CATA_SRC_MP_PLAYER_IDENTITY_H

#include <string>

namespace cata_mp
{
// Persistent identity is neither a display name nor a transport connection ID.
class player_id
{
    public:
        player_id() = default;
        explicit player_id( const std::string &value );
        bool valid() const {
            return !value_.empty();
        }
        const std::string &str() const {
            return value_;
        }
        bool operator==( const player_id &other ) const {
            return value_ == other.value_;
        }
        bool operator<( const player_id &other ) const {
            return value_ < other.value_;
        }
    private:
        std::string value_;
};

// A local profile owns this bearer capability. Never log it or include it in
// replicated character data. The authoritative host stores it privately.
struct player_credentials {
    player_id id;
    std::string resume_secret;
    bool valid() const;
};

// Does not use the simulation RNG. The caller must persist before use.
player_credentials create_player_credentials();
} // namespace cata_mp

#endif // CATA_SRC_MP_PLAYER_IDENTITY_H
