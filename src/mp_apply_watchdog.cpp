#include "mp_apply_watchdog.h"
#include "mp_log.h"

#include <algorithm>
#include <condition_variable>
#include <limits>
#include <mutex>
#include <stdexcept>
#include <thread>
#include <utility>
#include <vector>

namespace cata_mp
{
struct apply_watchdog::state {
    struct phase {
        token id;
        std::string label;
        clock::time_point started;
        clock::time_point next_warning;
    };
    std::mutex mutex;
    std::condition_variable wake;
    bool stopping = false;
    std::vector<phase> phases;
    std::thread worker;

    void run( const report_fn &report ) {
        std::unique_lock<std::mutex> lock( mutex );
        while( !wake.wait_for( lock, std::chrono::seconds( 1 ), [&]() {
        return stopping;
    } ) ) {
            const clock::time_point now = clock::now();
            if( phases.empty() || now < phases.back().next_warning ) {
                continue;
            }
            phase &current = phases.back();
            const std::string label = current.label;
            const auto elapsed = std::chrono::duration_cast<std::chrono::seconds>( now - current.started );
            current.next_warning = now + std::chrono::seconds( 5 );
            lock.unlock();
            // A failing diagnostic sink must not terminate the simulation.
            // Keep the reporting cadence and permit a later report to recover.
            try {
                report( label, elapsed );
            } catch( ... ) {
            }
            lock.lock();
        }
    }
};

apply_watchdog::apply_watchdog( report_fn report ) : report_( std::move( report ) )
{
    if( !report_ ) {
        report_ = []( const std::string & label, std::chrono::seconds elapsed ) {
            mp_log_client( "[cdda-mp] WATCHDOG: main thread stalled " +
                           std::to_string( elapsed.count() ) + "s in apply-step=" + label +
                           " (client likely hung — Windows 'not responding')" );
        };
    }
}

apply_watchdog::~apply_watchdog()
{
    stop();
}

apply_watchdog::token apply_watchdog::begin( std::string label, clock::time_point started )
{
    if( next_token_ == std::numeric_limits<token>::max() ) {
        throw std::overflow_error( "Multiplayer diagnostic phase IDs exhausted" );
    }
    if( !state_ ) {
        state_ = std::make_unique<state>();
    }
    std::scoped_lock lock( state_->mutex );
    const token id = ++next_token_;
    state_->phases.push_back( { id, std::move( label ), started, started + std::chrono::seconds( 3 ) } );
    try {
        if( !state_->worker.joinable() ) {
            state_->worker = std::thread( [this]() {
                state_->run( report_ );
            } );
        }
    } catch( ... ) {
        state_->phases.pop_back();
        throw;
    }
    return id;
}

void apply_watchdog::end( token phase )
{
    if( !state_ ) {
        return;
    }
    std::scoped_lock lock( state_->mutex );
    const auto found = std::find_if( state_->phases.begin(), state_->phases.end(),
    [phase]( const state::phase & entry ) {
        return entry.id == phase;
    } );
    if( found != state_->phases.end() ) {
        state_->phases.erase( found );
    }
}

void apply_watchdog::stop()
{
    if( !state_ ) {
        return;
    }
    {
        std::scoped_lock lock( state_->mutex );
        state_->stopping = true;
    }
    state_->wake.notify_all();
    if( state_->worker.joinable() ) {
        state_->worker.join();
    }
    state_.reset();
}

bool apply_watchdog::running() const
{
    return state_ && state_->worker.joinable();
}
} // namespace cata_mp
