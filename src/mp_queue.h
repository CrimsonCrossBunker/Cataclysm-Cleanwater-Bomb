#pragma once
#ifndef CATA_SRC_MP_QUEUE_H
#define CATA_SRC_MP_QUEUE_H

#include <chrono>
#include <condition_variable>
#include <mutex>
#include <queue>
#include <string>
#include <utility>

namespace cata_mp
{

struct mp_event {
    enum class type {
        connect,     // player 2 connected — spawn their character
        disconnect,  // player 2 disconnected — remove their character
        action       // player 2 sent an action command
    };
    type evt_type;
    std::string session_id;
    std::string data;  // JSON action string for type::action
};

class event_queue
{
    public:
        void push( mp_event e ) {
            {
                std::scoped_lock lock( mutex_ );
                queue_.push( std::move( e ) );
            }
            cv_.notify_one();
        }

        bool pop( mp_event &out ) {
            std::scoped_lock lock( mutex_ );
            if( queue_.empty() ) {
                return false;
            }
            out = std::move( queue_.front() );
            queue_.pop();
            return true;
        }

        bool empty() {
            std::scoped_lock lock( mutex_ );
            return queue_.empty();
        }

        // Block until an event is available or timeout expires.
        // Returns true if an event is ready, false on timeout.
        bool wait_for_event( std::chrono::milliseconds timeout ) {
            std::unique_lock<std::mutex> lock( mutex_ );
            return cv_.wait_for( lock, timeout, [this] { return !queue_.empty(); } );
        }

    private:
        std::queue<mp_event> queue_;
        std::mutex mutex_;
        std::condition_variable cv_;
};

// Global queue — Asio thread writes, game thread reads
event_queue &get_mp_queue();

} // namespace cata_mp

#endif // CATA_SRC_MP_QUEUE_H
