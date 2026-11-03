#pragma once
#ifndef CATA_SRC_MONSTER_FRIENDLINESS_H
#define CATA_SRC_MONSTER_FRIENDLINESS_H

#include <cstdint>

// Owner-thread mutation token. No writable int reference escapes this type.
// Only crossing zero changes membership in the ally-target candidate index.
class monster_friendliness
{
    public:
        monster_friendliness( int value = 0 ) : value_( value ) {}
        monster_friendliness( const monster_friendliness & ) = default;
        operator int() const { return value_; }
        monster_friendliness &operator=( int value ) {
            if( ( value_ == 0 ) != ( value == 0 ) ) {
                ++revision_;
            }
            value_ = value;
            return *this;
        }
        monster_friendliness &operator=( const monster_friendliness &other ) {
            // Whole-monster assignment may also replace its position directly.
            ++revision_;
            return *this = other.value_;
        }
        monster_friendliness &operator+=( int value ) { return *this = value_ + value; }
        monster_friendliness &operator-=( int value ) { return *this = value_ - value; }
        monster_friendliness &operator++() { return *this += 1; }
        monster_friendliness &operator--() { return *this -= 1; }
        int operator++( int ) { const int old = value_; ++*this; return old; }
        int operator--( int ) { const int old = value_; --*this; return old; }
        static std::uint64_t revision() { return revision_; }
    private:
        int value_;
        inline static thread_local std::uint64_t revision_ = 0;
};

#endif // CATA_SRC_MONSTER_FRIENDLINESS_H
