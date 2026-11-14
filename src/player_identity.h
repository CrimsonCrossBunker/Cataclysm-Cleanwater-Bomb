#pragma once
#ifndef CATA_SRC_PLAYER_IDENTITY_H
#define CATA_SRC_PLAYER_IDENTITY_H

#include <string>

// A persistent player/profile identity, independent of the current character,
// display name, save filename or transport connection. It grants no authority.
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

// System entropy only: does not consume simulation or replay randomness.
// The owning profile must persist the result before using it across sessions.
player_id create_player_id();

#endif // CATA_SRC_PLAYER_IDENTITY_H
