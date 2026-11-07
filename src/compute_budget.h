#pragma once
#ifndef CATA_SRC_COMPUTE_BUDGET_H
#define CATA_SRC_COMPUTE_BUDGET_H

#include <atomic>
#include <cstddef>
#include <limits>
#include <memory>
#include <new>
#include <type_traits>
#include <utility>

// Accounts retained speculative allocations, including old and replacement
// buffers during growth. Never use this to cap authoritative world contents.
// A budget must outlive its allocations. Exhaustion follows the same owner
// fallback as allocation failure; no worker result may be partially published.
class byte_budget
{
    public:
        explicit byte_budget( std::size_t limit ) : limit_( limit ) {}
        bool acquire( std::size_t bytes ) noexcept;
        void release( std::size_t bytes ) noexcept;
        std::size_t used() const noexcept;
        std::size_t limit() const noexcept {
            return limit_;
        }
    private:
        const std::size_t limit_;
        std::atomic<std::size_t> used_{ 0 };
};

// Shared by all AI, visibility and tile-preparation owners, including inactive
// maps whose reusable buffers remain allocated. Separate from GPU/world memory.
byte_budget &compute_byte_budget();

template<typename T>
class compute_allocator
{
    public:
        using value_type = T;
        using propagate_on_container_move_assignment = std::true_type;
        using propagate_on_container_swap = std::true_type;
        using is_always_equal = std::false_type;

        compute_allocator() noexcept : budget( &compute_byte_budget() ) {}
        explicit compute_allocator( byte_budget &owner ) noexcept : budget( &owner ) {}
        template<typename U>
        compute_allocator( const compute_allocator<U> &other ) noexcept : budget( other.budget ) {}

        T *allocate( std::size_t count ) {
            if( count > std::numeric_limits<std::size_t>::max() / sizeof( T ) ||
                !budget->acquire( count * sizeof( T ) ) ) {
                throw std::bad_alloc();
            }
            try {
                return std::allocator<T> {}.allocate( count );
            } catch( ... ) {
                budget->release( count * sizeof( T ) );
                throw;
            }
        }
        void deallocate( T *data, std::size_t count ) noexcept {
            std::allocator<T> {}.deallocate( data, count );
            budget->release( count * sizeof( T ) );
        }
        template<typename U>
        bool operator==( const compute_allocator<U> &other ) const noexcept {
            return budget == other.budget;
        }
        template<typename U>
        bool operator!=( const compute_allocator<U> &other ) const noexcept {
            return !( *this == other );
        }

        byte_budget *budget;
};

template<typename T>
struct compute_deleter {
    byte_budget *budget = nullptr;
    void operator()( T *data ) const noexcept {
        delete data;
        budget->release( sizeof( T ) );
    }
};

template<typename T>
using compute_ptr = std::unique_ptr<T, compute_deleter<T>>;

template<typename T, typename... Args>
compute_ptr<T> make_compute_in( byte_budget &budget, Args &&...args )
{
    if( !budget.acquire( sizeof( T ) ) ) {
        throw std::bad_alloc();
    }
    try {
        return compute_ptr<T>( new T( std::forward<Args>( args )... ), compute_deleter<T> { &budget } );
    } catch( ... ) {
        budget.release( sizeof( T ) );
        throw;
    }
}

template<typename T, typename... Args>
compute_ptr<T> make_compute( Args &&...args )
{
    return make_compute_in<T>( compute_byte_budget(), std::forward<Args>( args )... );
}

#endif // CATA_SRC_COMPUTE_BUDGET_H
