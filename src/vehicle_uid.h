#pragma once
#ifndef CATA_SRC_VEHICLE_UID_H
#define CATA_SRC_VEHICLE_UID_H

#include <cstdint>
#include <iosfwd>

class JsonOut;

// Generate a fresh UID from the global counter.
// Returns 0 if the game state is not yet initialized or the UID space is exhausted.
int64_t generate_next_vehicle_uid();

class vehicle_uid
{
    public:
        vehicle_uid() : value( 0 ) {}

        explicit vehicle_uid( int64_t i ) : value( i ) {}

        // Copy: generate fresh UID (like safe_reference_anchor)
        vehicle_uid( const vehicle_uid & ) : value( generate_next_vehicle_uid() ) {}

        // Move: transfer value, zero source
        vehicle_uid( vehicle_uid &&other ) noexcept : value( other.value ) {
            other.value = 0;
        }

        // Copy assignment: generate fresh UID
        vehicle_uid &operator=( const vehicle_uid & ) {
            value = generate_next_vehicle_uid();
            return *this;
        }

        // Move assignment: transfer value, zero source
        vehicle_uid &operator=( vehicle_uid &&other ) noexcept {
            value = other.value;
            other.value = 0;
            return *this;
        }

        bool is_valid() const {
            return value > 0;
        }

        int64_t get_value() const {
            return value;
        }

        void serialize( JsonOut & ) const;
        void deserialize( int64_t );

    private:
        int64_t value;
};

inline bool operator==( const vehicle_uid &l, const vehicle_uid &r )
{
    return l.get_value() == r.get_value();
}

inline bool operator!=( const vehicle_uid &l, const vehicle_uid &r )
{
    return l.get_value() != r.get_value();
}

std::ostream &operator<<( std::ostream &o, const vehicle_uid &id );

#endif // CATA_SRC_VEHICLE_UID_H
