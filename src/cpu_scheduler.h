#pragma once
#ifndef CATA_SRC_CPU_SCHEDULER_H
#define CATA_SRC_CPU_SCHEDULER_H

#include <array>
#include <cstddef>
#include <functional>

enum class cpu_task_kind : std::size_t {
    monster_geometry,
    monster_targets,
    item_history,
    item_rot,
    item_temperature,
    vision,
    render,
    count
};

struct cpu_task_statistics {
    std::size_t batches = 0;
    std::size_t parallel_batches = 0;
    unsigned last_workers = 0;
    double last_ms = 0;
    double serial_ns_per_item = 0;
};

// Value-only feedback policy, also usable with deterministic synthetic costs.
class cpu_task_policy
{
    public:
        unsigned choose( std::size_t count, unsigned available, std::size_t grain ) const;
        void observe( std::size_t count, unsigned workers, double elapsed_ns );
        cpu_task_statistics statistics() const;
    private:
        struct sample {
            double ns_per_item = 0;
            std::size_t observations = 0;
        };
        std::array<sample, 65> samples_{};
        cpu_task_statistics statistics_;
};

bool cpu_parallel_enabled();
cpu_task_statistics cpu_task_stats( cpu_task_kind kind );

// Blocking value-only batches. The caller participates; all accepted jobs are
// joined on every exit. max_workers is a quota, never a private thread pool.
unsigned cpu_parallel_for( cpu_task_kind kind, std::size_t count, std::size_t grain,
                           const std::function<void( std::size_t, std::size_t )> &compute,
                           unsigned max_workers = 64 );

#endif // CATA_SRC_CPU_SCHEDULER_H
