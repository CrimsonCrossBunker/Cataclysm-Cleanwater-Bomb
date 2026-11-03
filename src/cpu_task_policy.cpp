#include "cpu_scheduler.h"

#include <algorithm>
#include <cmath>

unsigned cpu_task_policy::choose( std::size_t count, unsigned available, std::size_t grain,
                                  bool latency_sensitive ) const
{
    grain = std::max<std::size_t>( grain, 1 );
    if( count / grain < 2 || available == 0 ) {
        return 0;
    }
    const unsigned limit = static_cast<unsigned>( std::min<std::size_t>(
                               std::min( available, cpu_worker_limit ), count / grain - 1 ) );
    // Large path batches must not freeze the owner just to learn three serial
    // baselines. Start with useful parallelism, then compare measured quotas.
    double serial_cost = samples_[0].ns_per_item;
    if( latency_sensitive && samples_[0].observations == 0 && count / grain >= 32 ) {
        if( statistics_.batches == 0 ) {
            return std::min( limit, static_cast<unsigned>(
                                 std::min<std::size_t>( cpu_worker_limit, count / grain / 4 ) ) );
        }
        serial_cost = samples_[statistics_.last_workers].ns_per_item *
                      ( statistics_.last_workers + 1 );
    }
    const double estimated_serial = serial_cost * count;
    if( ( !latency_sensitive && samples_[0].observations < 3 ) || estimated_serial < 250000.0 ) {
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
    // Do not periodically reintroduce a multi-second serial stall. A small
    // observed batch can safely refresh the baseline when the workload shrinks.
    const double projected_serial = samples_[statistics_.last_workers].ns_per_item * count *
                                    ( statistics_.last_workers + 1 );
    constexpr double serial_probe_budget = 8000000.0;
    const bool safe_serial_probe = !latency_sensitive || estimated_serial <= serial_probe_budget ||
                                   projected_serial <= serial_probe_budget;
    if( statistics_.batches % 32 == 0 && safe_serial_probe ) {
        return 0;
    }
    if( latency_sensitive && estimated_serial >= serial_probe_budget ) {
        const unsigned next = static_cast<unsigned>( std::min<double>( limit,
                              std::max( 1.0, std::ceil( estimated_serial / 2000000.0 ) - 1 ) ) );
        if( next > best && ( samples_[next].observations == 0 || statistics_.batches % 16 == 0 ) ) {
            return next;
        }
        // Also test lower quotas: more workers need not be faster on hybrid CPUs.
        if( best > 1 && statistics_.batches % 16 == 0 ) {
            return best / 2;
        }
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
