#include "compute_budget.h"

#include <cassert>

bool byte_budget::acquire( std::size_t bytes ) noexcept
{
    std::size_t current = used_.load( std::memory_order_relaxed );
    do {
        if( bytes > limit_ - current ) {
            return false;
        }
    } while( !used_.compare_exchange_weak( current, current + bytes, std::memory_order_relaxed ) );
    return true;
}

void byte_budget::release( std::size_t bytes ) noexcept
{
    const std::size_t previous = used_.fetch_sub( bytes, std::memory_order_relaxed );
    assert( previous >= bytes );
    static_cast<void>( previous );
}

std::size_t byte_budget::used() const noexcept
{
    return used_.load( std::memory_order_relaxed );
}

byte_budget &compute_byte_budget()
{
    static byte_budget budget( 64U * 1024U * 1024U );
    return budget;
}
