#pragma once
#ifndef CATA_SRC_MP_SERVER_H
#define CATA_SRC_MP_SERVER_H

#include <stdint.h>
#include <array>
#include <memory>
#include <optional>
#include <string>
#include <thread>

#include "mp_admission.h"

namespace cata_mp
{
class event_queue;

// Published as one value by the simulation owner. The network worker never
// reads the game, the current world, or another session's metadata.
struct server_welcome {
    std::string world_name;
    std::string player_name;
    unsigned int seed = 0;
    std::optional<std::array<int, 3>> host_omt;
};

class server
{
    public:
        server( uint16_t port, std::string password, std::string version,
                std::shared_ptr<event_queue> events, server_welcome welcome );
        ~server();

        // Start listening. Blocks until stop() is called.
        void run();

        // Signal the server to stop accepting connections and shut down.
        void stop();
        bool running() const;
        void update_welcome( server_welcome welcome );

        // Thread-safe delivery bound to the exact authenticated admission.
        void post_send( const peer_admission &admission, const std::string &msg );
        void broadcast( const std::string &msg );
        void post_broadcast( const std::string &msg );
        // Owner-side admission failed. Queue a reason and close on the worker.
        void post_reject( const peer_admission &admission, const std::string &reason );

        uint16_t port() const {
            return port_;
        }

    private:
        void post( const peer_admission *admission, const std::string &msg, bool close );
        void on_disconnected( uint64_t peer_id );
        void on_message( uint64_t peer_id, const std::string &msg );

        uint16_t port_;
        std::string password_;
        std::string version_;

        struct impl;

        std::unique_ptr<impl> impl_;

};

// The simulation/application owner calls start/stop; only the owned worker
// calls server::run. Destruction joins before any world state is released.
// A stopped server lease may outlive this owner, but cannot enqueue new work.
class host_session
{
    public:
        host_session() = default;
        ~host_session();
        host_session( const host_session & ) = delete;
        host_session &operator=( const host_session & ) = delete;

        bool start( uint16_t port, const std::string &password, const std::string &version,
                    server_welcome welcome = {} );
        void stop();
        bool running() const;
        std::shared_ptr<server> active_server() const;
        event_queue &events();
        void update_welcome( server_welcome welcome );
        const std::string &error() const {
            return error_;
        }

    private:
        std::shared_ptr<server> instance_;
        std::thread worker_;
        std::shared_ptr<event_queue> events_;
        std::string error_;
};

// Current-world owner-thread adapter. Workers keep their explicit session.
std::shared_ptr<server> get_active_server();

} // namespace cata_mp

#endif // CATA_SRC_MP_SERVER_H
