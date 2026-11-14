#pragma once
#ifndef CATA_SRC_MP_APPLY_WATCHDOG_H
#define CATA_SRC_MP_APPLY_WATCHDOG_H

#include <chrono>
#include <cstdint>
#include <functional>
#include <memory>
#include <string>

namespace cata_mp
{
// Diagnostics owned by a world session. The simulation thread opens/closes
// phases and stops the worker; the worker only receives labels and timestamps.
// The report callback must not call back into this object or the game world.
class apply_watchdog
{
    public:
        using clock = std::chrono::steady_clock;
        using token = uint64_t;
        using report_fn = std::function<void( const std::string &, std::chrono::seconds )>;

        explicit apply_watchdog( report_fn report = {} );
        ~apply_watchdog();
        apply_watchdog( const apply_watchdog & ) = delete;
        apply_watchdog &operator=( const apply_watchdog & ) = delete;

        token begin( std::string label, clock::time_point started = clock::now() );
        void end( token phase );
        // Joins any in-flight report before returning. May be restarted later;
        // tokens from before stop cannot close phases in the replacement run.
        void stop();
        bool running() const;

    private:
        struct state;
        std::unique_ptr<state> state_;
        report_fn report_;
        token next_token_ = 0;
};
} // namespace cata_mp

#endif // CATA_SRC_MP_APPLY_WATCHDOG_H
