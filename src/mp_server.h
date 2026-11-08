#pragma once
#ifndef CATA_SRC_MP_SERVER_H
#define CATA_SRC_MP_SERVER_H

#include <stdint.h>
#include <memory>
#include <string>
#include <thread>

namespace cata_mp
{

class server
{
    public:
        server( uint16_t port, std::string password, std::string version = "" );
        ~server();

        // Start listening. Blocks until stop() is called.
        void run();

        // Signal the server to stop accepting connections and shut down.
        void stop();

        // Thread-safe delivery to authenticated peers only (zero means broadcast).
        void post_send( uint64_t peer_id, const std::string &msg );
        void broadcast( const std::string &msg );
        void post_broadcast( const std::string &msg );

        uint16_t port() const {
            return port_;
        }

    private:
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

        bool start( uint16_t port, const std::string &password, const std::string &version );
        void stop();
        bool running() const;
        const std::string &error() const {
            return error_;
        }

    private:
        std::shared_ptr<server> instance_;
        std::thread worker_;
        bool owns_transport_ = false;
        std::string error_;
};

// Returns the active server instance, or nullptr if not running.
// Shared ownership keeps concurrent game-loop calls valid during shutdown.
std::shared_ptr<server> get_active_server();

} // namespace cata_mp

#endif // CATA_SRC_MP_SERVER_H
