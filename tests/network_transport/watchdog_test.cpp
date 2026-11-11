#include "mp_apply_watchdog.h"

#include <chrono>
#include <condition_variable>
#include <future>
#include <iostream>
#include <mutex>
#include <stdexcept>
#include <string>
#include <utility>
#include <vector>

namespace cata_mp
{
void mp_log_client( const std::string &message )
{
    std::cerr << message << '\n';
}
} // namespace cata_mp

using cata_mp::apply_watchdog;
using namespace std::chrono_literals;

static void require( bool condition, const std::string &message )
{
    if( !condition ) {
        throw std::runtime_error( message );
    }
}

struct reports {
    std::mutex mutex;
    std::condition_variable wake;
    std::vector<std::pair<std::string, std::chrono::seconds>> entries;

    void add( const std::string &label, std::chrono::seconds elapsed ) {
        std::lock_guard<std::mutex> lock( mutex );
        entries.emplace_back( label, elapsed );
        wake.notify_all();
    }
    std::pair<std::string, std::chrono::seconds> await( size_t count ) {
        std::unique_lock<std::mutex> lock( mutex );
        require( wake.wait_for( lock, 3s, [&]() {
            return entries.size() >= count;
        } ), "expected watchdog report" );
        return entries[count - 1];
    }
};

static void restart_and_nested_phases()
{
    reports observed;
    apply_watchdog watchdog( [&]( const std::string & label, std::chrono::seconds elapsed ) {
        observed.add( label, elapsed );
    } );
    require( !watchdog.running(), "unused watchdog creates no worker" );
    for( int cycle = 0; cycle < 12; ++cycle ) {
        const auto phase = watchdog.begin( "quiet", apply_watchdog::clock::now() + 1h );
        require( watchdog.running(), "phase starts owned worker" );
        watchdog.end( phase );
        watchdog.stop();
        watchdog.stop();
        require( !watchdog.running(), "stop is complete and idempotent" );
    }
    const auto old = watchdog.begin( "old", apply_watchdog::clock::now() + 1h );
    watchdog.stop();
    const auto outer = watchdog.begin( "outer", apply_watchdog::clock::now() - 10s );
    const auto inner = watchdog.begin( "inner", apply_watchdog::clock::now() + 1h );
    watchdog.end( inner );
    watchdog.end( old );
    const auto report = observed.await( 1 );
    require( report.first == "outer" && report.second >= 10s,
             "nested exit restores parent and stale token cannot close it" );
    watchdog.end( outer );
    watchdog.stop();
}

static void independent_worlds_and_failing_reporter()
{
    reports first_reports;
    reports second_reports;
    apply_watchdog second( [&]( const std::string & label, std::chrono::seconds elapsed ) {
        second_reports.add( label, elapsed );
    } );
    const auto second_phase = second.begin( "second", apply_watchdog::clock::now() - 4s );
    {
        apply_watchdog first( [&]( const std::string & label, std::chrono::seconds elapsed ) {
            first_reports.add( label, elapsed );
            throw std::runtime_error( "diagnostic sink failure" );
        } );
        first.begin( "first", apply_watchdog::clock::now() - 4s );
        require( first_reports.await( 1 ).first == "first", "first world reported" );
        // Destruction must join even after a diagnostic callback throws.
    }
    require( second_reports.await( 1 ).first == "second", "second world independent" );
    second.end( second_phase );
    second.begin( "second again", apply_watchdog::clock::now() - 4s );
    require( second_reports.await( 2 ).first == "second again",
             "destroying first world leaves second worker operational" );
}

static void stop_waits_for_inflight_report()
{
    struct gate {
        std::mutex mutex;
        std::condition_variable wake;
        bool entered = false;
        bool release = false;
        bool exited = false;
        bool stop_started = false;

        void allow_exit() {
            std::lock_guard<std::mutex> lock( mutex );
            release = true;
            wake.notify_all();
        }
    } report_gate;
    apply_watchdog watchdog( [&]( const std::string &, std::chrono::seconds ) {
        std::unique_lock<std::mutex> lock( report_gate.mutex );
        report_gate.entered = true;
        report_gate.wake.notify_all();
        report_gate.wake.wait( lock, [&]() {
            return report_gate.release;
        } );
        report_gate.exited = true;
    } );
    // Release the callback even if a test assertion unwinds this scope.
    struct release_on_exit {
        gate &value;
        ~release_on_exit() {
            value.allow_exit();
        }
    } release_guard{ report_gate };
    watchdog.begin( "blocked reporter", apply_watchdog::clock::now() - 4s );
    {
        std::unique_lock<std::mutex> lock( report_gate.mutex );
        require( report_gate.wake.wait_for( lock, 3s, [&]() {
            return report_gate.entered;
        } ), "callback entered" );
    }
    auto stopped = std::async( std::launch::async, [&]() {
        {
            std::lock_guard<std::mutex> lock( report_gate.mutex );
            report_gate.stop_started = true;
            report_gate.wake.notify_all();
        }
        watchdog.stop();
    } );
    release_on_exit release_before_future_destruction{ report_gate };
    {
        std::unique_lock<std::mutex> lock( report_gate.mutex );
        require( report_gate.wake.wait_for( lock, 3s, [&]() {
            return report_gate.stop_started;
        } ), "stop began" );
    }
    require( stopped.wait_for( 20ms ) == std::future_status::timeout,
             "stop cannot return while report is in flight" );
    report_gate.allow_exit();
    require( stopped.wait_for( 3s ) == std::future_status::ready, "stop joins after callback returns" );
    stopped.get();
    require( report_gate.exited && !watchdog.running(), "no worker or callback survives stop" );
}

int main()
{
    try {
        restart_and_nested_phases();
        independent_worlds_and_failing_reporter();
        stop_waits_for_inflight_report();
        std::cout << "PASS: restart, nesting, stale tokens, isolation, throwing sink, joined callback\n";
        return 0;
    } catch( const std::exception &error ) {
        std::cerr << "FAIL: " << error.what() << '\n';
        return 1;
    }
}
