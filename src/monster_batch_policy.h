#pragma once
#ifndef CATA_SRC_MONSTER_BATCH_POLICY_H
#define CATA_SRC_MONSTER_BATCH_POLICY_H

#include <algorithm>
#include <array>
#include <chrono>
#include <cstddef>

// Owner-thread observations only. No world pointers or worker-written state.
class monster_batch_policy
{
    public:
        bool should_observe( std::size_t kind ) {
            auto &sample = serial_[kind];
            if( sample.count < 8 ) {
                return true;
            }
            if( ++sample.skipped < 16 ) {
                return false;
            }
            sample.skipped = 0;
            return true;
        }

        void observe( std::size_t kind, double microseconds ) {
            auto &sample = serial_[kind];
            sample.cost = sample.count == 0 ? microseconds :
                          sample.cost * 0.875 + microseconds * 0.125;
            sample.count = std::min( sample.count + 1, 8u );
        }

        double estimate( std::size_t kind ) const {
            return serial_[kind].count >= 8 ? serial_[kind].cost : 0.0;
        }

        bool worth_collecting( std::size_t kind, std::size_t tasks,
                               std::size_t minimum_tasks, double minimum_cost ) const {
            // Cheap individual tasks can still amortize dispatch as a batch.
            return tasks >= minimum_tasks && estimate( kind ) > 0 &&
                   estimate( kind ) * tasks >= std::max( 2000.0, minimum_cost * minimum_tasks );
        }

        bool begin( std::size_t kind, std::size_t tasks, std::size_t minimum_tasks,
                    double minimum_cost ) {
            if( !worth_collecting( kind, tasks, minimum_tasks, minimum_cost ) ) {
                return false;
            }
            auto &state = batches_[kind][size_class( tasks )];
            if( state.cooldown > 0 ) {
                --state.cooldown;
                return false;
            }
            // Refresh successful workloads too; otherwise a costly old map can
            // keep a now-cheap workload parallel forever.
            if( ++state.batches_since_probe == 16 ) {
                state.batches_since_probe = 0;
                return false;
            }
            return true;
        }

        void finish( std::size_t kind, std::size_t tasks, double overhead,
                     double avoided_serial ) {
            auto &state = batches_[kind][size_class( tasks )];
            if( avoided_serial <= 0 || overhead >= avoided_serial * 0.8 ) {
                state.failures = std::min( state.failures + 1, 4u );
                state.cooldown = 8u << state.failures;
            } else {
                state.failures = 0;
                state.cooldown = 0;
            }
        }

        static std::size_t chunks( std::size_t tasks, std::size_t workers,
                                   std::size_t grain, double cost ) {
            return std::min( { workers, tasks / grain,
                               static_cast<std::size_t>( tasks * cost / 500.0 ) } );
        }

        static std::size_t size_class( std::size_t tasks ) {
            return tasks < 64 ? 0 : tasks < 256 ? 1 : tasks < 1024 ? 2 : 3;
        }

    private:
        struct observation {
            double cost = 0;
            unsigned count = 0;
            unsigned skipped = 0;
        };
        struct batch_state {
            unsigned failures = 0;
            unsigned cooldown = 0;
            unsigned batches_since_probe = 0;
        };
        std::array<observation, 4> serial_{};
        std::array<std::array<batch_state, 4>, 4> batches_{};
};

class monster_batch_timer
{
    public:
        explicit monster_batch_timer( double &elapsed ) : elapsed_( elapsed ) {}
        ~monster_batch_timer() {
            elapsed_ += std::chrono::duration<double, std::micro>(
                            std::chrono::steady_clock::now() - start_ ).count();
        }
    private:
        double &elapsed_;
        std::chrono::steady_clock::time_point start_ = std::chrono::steady_clock::now();
};

#endif // CATA_SRC_MONSTER_BATCH_POLICY_H
