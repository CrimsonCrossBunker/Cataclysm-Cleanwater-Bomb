#pragma once
#ifndef CATA_SRC_MP_SERVER_H
#define CATA_SRC_MP_SERVER_H

#include <stdint.h>
#include <memory>
#include <string>

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

// Start the server on the given port. Called from main() when --server flag is set.
// Does not return until the server shuts down.
void run_server( uint16_t port, const std::string &password,
                 const std::string &version = "" );

// Returns the active server instance, or nullptr if not running.
// Shared ownership keeps concurrent game-loop calls valid during shutdown.
std::shared_ptr<server> get_active_server();

// True from the moment the (detached) listen thread enters run_server() until
// it fully returns — i.e. until the server object has destructed and its
// listen socket (the port) is released. Session-end waits on this going false
// before allowing a re-host to re-bind the same port, so a second host session
// in one launch can't race the first session's socket teardown.
bool is_server_thread_running();

} // namespace cata_mp

#endif // CATA_SRC_MP_SERVER_H
