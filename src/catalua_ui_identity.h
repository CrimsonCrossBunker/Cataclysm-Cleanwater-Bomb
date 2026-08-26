#pragma once
#ifndef CATA_SRC_CATALUA_UI_IDENTITY_H
#define CATA_SRC_CATALUA_UI_IDENTITY_H

#include <atomic>
#include <cstdint>
#include <exception>
#include <limits>

namespace cata::lua
{

// Gives native objects a process-local identity that cannot be reused after
// allocator address reuse.  Copying creates a distinct logical object, while
// moving preserves the identity of the object being relocated.
class native_object_identity
{
    public:
        native_object_identity() noexcept
            : value_( next_value() ) {}

        native_object_identity( const native_object_identity & ) noexcept
            : native_object_identity() {}

        native_object_identity &operator=( const native_object_identity &other ) noexcept {
            if( this != &other ) {
                value_ = next_value();
            }
            return *this;
        }

        native_object_identity( native_object_identity &&other ) noexcept
            : value_( other.value_ ) {
            other.value_ = next_value();
        }

        native_object_identity &operator=( native_object_identity &&other ) noexcept {
            if( this != &other ) {
                value_ = other.value_;
                other.value_ = next_value();
            }
            return *this;
        }

        std::uint64_t value() const noexcept {
            return value_;
        }

    private:
        static std::uint64_t next_value() noexcept {
            const std::uint64_t result =
                next_.fetch_add( 1, std::memory_order_relaxed );
            if( result == 0 ||
                result == std::numeric_limits<std::uint64_t>::max() ) {
                std::terminate();
            }
            return result;
        }

        inline static std::atomic<std::uint64_t> next_{ 1 };
        std::uint64_t value_;
};

} // namespace cata::lua

#endif // CATA_SRC_CATALUA_UI_IDENTITY_H
