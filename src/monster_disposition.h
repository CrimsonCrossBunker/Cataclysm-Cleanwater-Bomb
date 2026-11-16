#pragma once
#ifndef CATA_SRC_MONSTER_DISPOSITION_H
#define CATA_SRC_MONSTER_DISPOSITION_H

#include <cstdint>

#include "type_id.h"

// Main-thread writes invalidate candidate membership, including spells, Lua,
// deserialization and whole-monster assignment. Workers only read snapshots.
class monster_friendliness
{
    public:
        monster_friendliness() = default;
        monster_friendliness( const monster_friendliness & ) = default;
        operator int() const {
            return value_;
        }
        monster_friendliness &operator=( int value ) {
            if( ( value_ == 0 ) != ( value == 0 ) ) {
                ++revision_;
            }
            value_ = value;
            return *this;
        }
        monster_friendliness &operator=( const monster_friendliness &other ) {
            return *this = other.value_;
        }
        monster_friendliness &operator+=( int value ) {
            return *this = value_ + value;
        }
        monster_friendliness &operator--() {
            return *this = value_ - 1;
        }
        int operator--( int ) {
            const int previous = value_;
            --*this;
            return previous;
        }
        static std::uint64_t revision() {
            return revision_;
        }
    private:
        int value_ = 0;
        inline static std::uint64_t revision_ = 0;
};

class monster_faction : public mfaction_id
{
    public:
        monster_faction() = default;
        monster_faction( const monster_faction & ) = default;
        monster_faction &operator=( const mfaction_id &value ) {
            if( static_cast<const mfaction_id &>( *this ) != value ) {
                ++revision_;
            }
            mfaction_id::operator=( value );
            return *this;
        }
        monster_faction &operator=( const monster_faction &other ) {
            return *this = static_cast<const mfaction_id &>( other );
        }
        static std::uint64_t revision() {
            return revision_;
        }
    private:
        inline static std::uint64_t revision_ = 0;
};

#endif // CATA_SRC_MONSTER_DISPOSITION_H
