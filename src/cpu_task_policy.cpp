#include "cpu_scheduler.h"

#include <algorithm>
#include <cmath>

unsigned cpu_task_policy::choose( std::size_t count, unsigned available, std::size_t grain ) const
{
    grain = std::max<std::size_t>( grain, 1 );
    if( count / grain < 2 || available == 0 ) {
        return 0;
    }
    const unsigned limit = static_cast<unsigned>( std::min<std::size_t>(
                               std::min( available, cpu_worker_limit ), count / grain - 1 ) );
    // Learn a serial baseline first, and do not dispatch sub-250us batches.
    const double serial_cost = samples_[0].ns_per_item;
    if( samples_[0].observations < 3 || serial_cost * count < 250000.0 ) {
        return 0;
    }
    unsigned best = 0;
    double cost = serial_cost;
    for( unsigned i = 1; i <= limit; ++i ) {
        if( samples_[i].observations != 0 && samples_[i].ns_per_item < cost * 0.9 ) {
            best = i;
            cost = samples_[i].ns_per_item;
        }
    }
    // Periodic serial samples detect changed workloads. Probe one larger quota
    // at a time, never jump from one worker to the whole CPU on a single sample.
    if( statistics_.batches % 32 == 0 ) {
        return 0;
    }
    if( best != 0 && samples_[best].observations < 3 ) {
        return best;
    }
    const unsigned next = std::min( limit, best == 0 ? 1U : best * 2 );
    if( next > best && ( samples_[next].observations == 0 || statistics_.batches % 16 == 0 ) ) {
        return next;
    }
    return best;
}

void cpu_task_policy::observe( std::size_t count, unsigned workers, double elapsed_ns )
{
    if( count == 0 || workers >= samples_.size() || !std::isfinite( elapsed_ns ) || elapsed_ns <= 0 ) {
        return;
    }
    sample &s = samples_[workers];
    const double cost = elapsed_ns / count;
    s.ns_per_item = s.observations == 0 ? cost : s.ns_per_item * 0.8 + cost * 0.2;
    ++s.observations;
    ++statistics_.batches;
    statistics_.parallel_batches += workers != 0;
    statistics_.last_workers = workers;
    statistics_.last_ms = elapsed_ns / 1000000.0;
    statistics_.serial_ns_per_item = samples_[0].ns_per_item;
}

cpu_task_statistics cpu_task_policy::statistics() const
{
    return statistics_;
}
