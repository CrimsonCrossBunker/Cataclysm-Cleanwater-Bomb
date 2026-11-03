#pragma once
#ifndef CATA_SRC_MP_PROTOCOL_H
#define CATA_SRC_MP_PROTOCOL_H

#include <map>
#include <string>

namespace cata_mp
{
// Handshakes are bounded separately from world snapshots.  Parse using CCB's
// JSON reader, including escaped Unicode and duplicate-key rejection.
bool read_handshake( const std::string &wire, std::map<std::string, std::string> &fields );
// Only a recognized top-level bookkeeping message bypasses the turn budget.
// Attached world deltas and nested discriminator-looking fields do not qualify.
bool is_state_sync_message( const std::string &wire );
std::string wire_quote( const std::string &text );
std::string version_commit_id( const std::string &version );
std::string encode_game_packet( const std::string &json );
bool decode_game_packet( const std::string &packet, std::string &json );
} // namespace cata_mp
#endif
