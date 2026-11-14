#pragma once
#ifndef CATA_SRC_MP_QUEUE_H
#define CATA_SRC_MP_QUEUE_H

#include <algorithm>
#include <chrono>
#include <cstddef>
#include <cstdint>
#include <condition_variable>
#include <list>
#include <mutex>
#include <optional>
#include <queue>
#include <string>
#include <utility>

#include "mp_admission.h"
#include "mp_player_identity.h"

namespace cata_mp
{

struct mp_event {
    enum class type {
        connect,     // player 2 connected — spawn their character
        disconnect,  // player 2 disconnected — remove their character
        action       // player 2 sent an action command
    };
    type evt_type;
    std::string display_name;
    std::string data;  // JSON action string for type::action
    peer_admission admission; // Exact server admission, not a reusable numeric peer ID.
    player_credentials player{}; // Connect only; never included in gameplay logs.
};

class event_queue
{
    public:
        event_queue() : event_queue( 1024, 64 * 1024 * 1024 ) {}
        event_queue( size_t event_limit, size_t byte_limit ) :
            event_limit_( event_limit ), byte_limit_( byte_limit ) {}

        struct usage {
            size_t queued;
            size_t reserved_disconnects;
            size_t bytes;
        };

        usage current_usage() {
            std::scoped_lock lock( mutex_ );
            return { queue_.size(), disconnects_.size(), bytes_ };
        }

        // Admission is nonblocking and failure leaves the accepted FIFO intact.
        // Every accepted connect reserves its disconnect record, including its
        // strings, so overload cannot strand an already admitted actor.
        [[nodiscard]] bool push( mp_event e ) {
            {
                std::scoped_lock lock( mutex_ );
                const auto reserved = std::find_if( disconnects_.begin(), disconnects_.end(),
                [&]( const mp_event & existing ) {
                    return existing.admission.matches( e.admission );
                } );
                if( e.evt_type == mp_event::type::disconnect && reserved != disconnects_.end() ) {
                    queue_.push( std::move( *reserved ) );
                    disconnects_.erase( reserved );
                } else {
                    const std::optional<size_t> event_bytes = storage_bytes( e );
                    if( !event_bytes ) {
                        return false;
                    }
                    if( e.evt_type == mp_event::type::connect ) {
                        if( !e.admission.active() || reserved != disconnects_.end() ) {
                            return false;
                        }
                        mp_event disconnect{ mp_event::type::disconnect, e.display_name, "", e.admission };
                        const std::optional<size_t> disconnect_bytes = storage_bytes( disconnect );
                        if( !disconnect_bytes || !fits( 2, *event_bytes, *disconnect_bytes ) ) {
                            return false;
                        }
                        disconnects_.push_back( std::move( disconnect ) );
                        bytes_ += *disconnect_bytes;
                    } else if( !fits( 1, *event_bytes ) ) {
                        return false;
                    }
                    queue_.push( std::move( e ) );
                    bytes_ += *event_bytes;
                }
            }
            cv_.notify_one();
            return true;
        }

        bool pop( mp_event &out ) {
            return pop_if( out, []( const mp_event & ) {
                return true;
            } );
        }

        // A rejected front stays ahead of later actions and disconnects.
        // The predicate runs under the queue lock and must not call the queue.
        template<typename Predicate>
        bool pop_if( mp_event &out, Predicate &&accept ) {
            std::scoped_lock lock( mutex_ );
            if( queue_.empty() || !accept( queue_.front() ) ) {
                return false;
            }
            bytes_ -= *storage_bytes( queue_.front() );
            out = std::move( queue_.front() );
            queue_.pop();
            return true;
        }

        bool empty() {
            std::scoped_lock lock( mutex_ );
            return queue_.empty();
        }

        // Called after the producer is stopped/joined at a session boundary.
        void clear() {
            std::scoped_lock lock( mutex_ );
            std::queue<mp_event> empty;
            queue_.swap( empty );
            disconnects_.clear();
            bytes_ = 0;
        }

        // Block until an event is available or timeout expires.
        // Returns true if an event is ready, false on timeout.
        bool wait_for_event( std::chrono::milliseconds timeout ) {
            std::unique_lock<std::mutex> lock( mutex_ );
            return cv_.wait_for( lock, timeout, [this] { return !queue_.empty(); } );
        }

    private:
        // Bound owned event records and string capacities. Allocator/container
        // overhead is additionally bounded by event_limit_, not included here.
        std::optional<size_t> storage_bytes( const mp_event &event ) const {
            size_t result = 0;
            for( const size_t bytes : {
                     sizeof( mp_event ), event.display_name.capacity(),
                     event.data.capacity(), event.player.id.str().capacity(),
                     event.player.resume_secret.capacity()
                 } ) {
                if( bytes > byte_limit_ - result ) {
                    return std::nullopt;
                }
                result += bytes;
            }
            return result;
        }

        bool fits( size_t events, size_t bytes, size_t reserved_bytes = 0 ) const {
            const size_t remaining_bytes = byte_limit_ - bytes_;
            return events <= event_limit_ - queue_.size() - disconnects_.size() &&
                   bytes <= remaining_bytes && reserved_bytes <= remaining_bytes - bytes;
        }

        const size_t event_limit_;
        const size_t byte_limit_;
        size_t bytes_ = 0;
        std::queue<mp_event> queue_;
        std::list<mp_event> disconnects_;
        std::mutex mutex_;
        std::condition_variable cv_;
};

// Current-world owner-thread adapter. Producers retain their session's queue.
event_queue &get_mp_queue();

} // namespace cata_mp

#endif // CATA_SRC_MP_QUEUE_H
