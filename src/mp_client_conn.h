#pragma once
#ifndef CATA_SRC_MP_CLIENT_CONN_H
#define CATA_SRC_MP_CLIENT_CONN_H

#include <cstdint>
#include <string>
#include <string_view>

namespace cata_mp
{
struct player_credentials;

bool is_client_mode();
void set_client_mode( bool enabled );

// Connect to server and validate version/password immediately.
// Returns true on success (welcome received).  On false, call
// client_connect_error() to get the human-readable rejection reason.
bool client_connect( const std::string &host, uint16_t port,
                     const std::string &name, const std::string &password = "",
                     const std::string &version = "" );
// Error text from the last failed client_connect() call.
std::string client_connect_error();
// Canonical endpoint derived from the local connection request, not host data.
std::string client_identity_scope();

// Send the deferred join message. No-op if already sent or not connected.
// Called by client_process_incoming() on the first game tick.
void client_send_join( const player_credentials &player );

// Returns true after client_send_join() has fired (i.e. the save is loaded and
// the join handshake has been queued for reliable delivery).
bool client_join_is_sent();

// Queue an action JSON for transmission on the Rust transport worker.
void client_send( const std::string &json );

// Pop one incoming message from the recv queue. Returns false when empty.
// Used by mp_gamestate::client_process_incoming() to apply server state.
bool client_recv_pop( std::string &out );

} // namespace cata_mp

#endif // CATA_SRC_MP_CLIENT_CONN_H
