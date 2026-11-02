#include "mp_renet_transport.h"
#include "../rust/coop_ecs/include/ccb_coop_ffi.h"

#include <algorithm>
#include <charconv>
#include <filesystem>
#include <limits>
#include <mutex>
#include <utility>

#if defined(_WIN32)
    #include "platform_win.h"
#else
    #include <dlfcn.h>
    #if defined(__linux__)
        #include <unistd.h>
    #elif defined(__APPLE__)
        #include <mach-o/dyld.h>
    #endif
#endif

namespace cata_mp
{

namespace
{

static size_t skip_json_ws( const std::string &json, size_t pos )
{
    while( pos < json.size() && ( json[pos] == ' ' || json[pos] == '\n' ||
                                  json[pos] == '\r' || json[pos] == '\t' ) ) {
        ++pos;
    }
    return pos;
}

static bool read_json_string( const std::string &json, size_t &pos, std::string &out )
{
    out.clear();
    while( pos < json.size() ) {
        const char ch = json[pos++];
        if( ch == '"' ) {
            return true;
        }
        if( ch == '\\' ) {
            if( pos >= json.size() ) {
                return false;
            }
            const char escaped = json[pos++];
            switch( escaped ) {
                case '"':
                case '\\':
                case '/':
                    out.push_back( escaped );
                    break;
                case 'b':
                    out.push_back( '\b' );
                    break;
                case 'f':
                    out.push_back( '\f' );
                    break;
                case 'n':
                    out.push_back( '\n' );
                    break;
                case 'r':
                    out.push_back( '\r' );
                    break;
                case 't':
                    out.push_back( '\t' );
                    break;
                case 'u':
                    // Message type keys are ASCII; skip Unicode escape digits.
                    pos = std::min( json.size(), pos + 4 );
                    break;
                default:
                    out.push_back( escaped );
                    break;
            }
        } else {
            out.push_back( ch );
        }
    }
    return false;
}

static std::string json_get_str( const std::string &json, const std::string &key )
{
    size_t pos = 0;
    int depth = 0;

    while( pos < json.size() ) {
        const char ch = json[pos];
        if( ch == '"' ) {
            ++pos;
            std::string name;
            if( !read_json_string( json, pos, name ) ) {
                return std::string();
            }
            if( depth != 1 || name != key ) {
                continue;
            }
            pos = skip_json_ws( json, pos );
            if( pos >= json.size() || json[pos] != ':' ) {
                continue;
            }
            pos = skip_json_ws( json, pos + 1 );
            if( pos >= json.size() || json[pos] != '"' ) {
                return std::string();
            }
            ++pos;
            std::string value;
            if( !read_json_string( json, pos, value ) ) {
                return std::string();
            }
            return value;
        }
        if( ch == '{' || ch == '[' ) {
            ++depth;
        } else if( ch == '}' || ch == ']' ) {
            --depth;
        }
        ++pos;
    }
    return std::string();
}

using create_fn = CcbCoopTransportRuntime * ( * )();
using destroy_fn = void ( * )( CcbCoopTransportRuntime * );
using start_host_fn = uint8_t ( * )( CcbCoopTransportRuntime *, const char * );
using start_client_fn = uint8_t ( * )( CcbCoopTransportRuntime *, const char *, uint64_t );
using stop_fn = void ( * )( CcbCoopTransportRuntime * );
using pump_fn = void ( * )( CcbCoopTransportRuntime * );
using status_fn = CcbCoopTransportStatus( * )( const CcbCoopTransportRuntime * );
using send_fn = uint8_t ( * )( CcbCoopTransportRuntime *, uint64_t, uint8_t, const uint8_t *,
                               uint32_t );
using mutation_enqueue_batch_fn = CcbCoopMutationQueueStatus( * )( CcbCoopTransportRuntime *,
    uint32_t, uint32_t, const CcbCoopStringSlice *, uint32_t );
using mutation_ack_fn = CcbCoopMutationQueueStatus( * )( CcbCoopTransportRuntime *, uint32_t );
using mutation_status_fn = CcbCoopMutationQueueStatus( * )( const CcbCoopTransportRuntime * );
using drain_fn = CcbCoopIncomingBatch( * )( CcbCoopTransportRuntime *, uint32_t );
using free_batch_fn = void ( * )( CcbCoopIncomingBatch );
using last_error_fn = CcbCoopByteBuffer( * )( const CcbCoopTransportRuntime * );
using stats_json_fn = CcbCoopByteBuffer( * )( const CcbCoopTransportRuntime * );
using delta_packetize_object_array_fn = CcbCoopByteBuffer( * )(
        const uint8_t *, uint32_t, const uint8_t *, uint32_t, const uint8_t *, uint32_t,
        const uint8_t *, uint32_t, const uint8_t *, uint32_t, uint32_t );
using free_bytes_fn = void ( * )( CcbCoopByteBuffer );
using state_reset_fn = void ( * )( CcbCoopTransportRuntime * );
using tile_submit_fn = CcbCoopTileDeltaFlags( * )( CcbCoopTransportRuntime *, int32_t, int32_t,
    int32_t, const uint8_t *, uint32_t, const uint8_t *, uint32_t,
    const uint8_t *, uint32_t, const uint8_t *, uint32_t,
    const uint8_t *, uint32_t, const uint8_t *, uint32_t );
using tile_submit_batch_fn = uint32_t ( * )( CcbCoopTransportRuntime *,
    const CcbCoopTileSnapshotWire *, uint32_t,
    CcbCoopTileDeltaFlags * );
using tile_count_fn = uint32_t ( * )( const CcbCoopTransportRuntime * );
using vehicle_submit_wire_summary_fn = CcbCoopVehicleDeltaFlags( * )(
        CcbCoopTransportRuntime *, uint32_t, int32_t, int32_t, int32_t, int16_t, int16_t,
        int32_t, int32_t, const uint8_t *, uint32_t, uint32_t, uint32_t,
        const uint8_t *, uint32_t, const uint8_t *, uint32_t, const uint8_t *, uint32_t,
        uint32_t );
using vehicle_submit_motion_fn = CcbCoopVehicleDeltaFlags( * )( CcbCoopTransportRuntime *,
    uint32_t, int32_t, int32_t, int32_t, int16_t, int16_t,
    int32_t, int32_t );
using vehicle_submit_part_entries_fn = uint32_t ( * )( CcbCoopTransportRuntime *, uint32_t,
    const CcbCoopStringSlice *, uint32_t, uint8_t,
    uint8_t * );
using vehicle_needs_snapshot_fn = uint8_t ( * )( const CcbCoopTransportRuntime *, uint32_t,
    const uint8_t *, uint32_t );
using vehicle_count_fn = uint32_t ( * )( const CcbCoopTransportRuntime * );
using vehicle_query_json_fn = CcbCoopByteBuffer( * )( const CcbCoopTransportRuntime *, uint32_t );
using actor_submit_basic_fn = CcbCoopActorDeltaFlags( * )( CcbCoopTransportRuntime *, uint64_t,
    const uint8_t *, uint32_t, uint8_t, int32_t, int32_t, int32_t,
    int8_t, uint8_t, uint8_t, uint8_t, int32_t, const uint8_t *,
    uint32_t, int32_t, int32_t, int32_t, const uint8_t *, uint32_t,
    const uint8_t *, uint32_t );
using actor_count_fn = uint32_t ( * )( const CcbCoopTransportRuntime * );
using actor_query_json_fn = CcbCoopByteBuffer( * )( const CcbCoopTransportRuntime *, uint64_t );
using item_submit_location_fn = CcbCoopItemDeltaFlags( * )( CcbCoopTransportRuntime *,
    uint8_t, int32_t, int32_t, int32_t, const uint8_t *, uint32_t,
    uint32_t, uint32_t, const uint8_t *, uint32_t, const uint8_t *,
    uint32_t );
using item_submit_slot_entries_fn = uint32_t ( * )( CcbCoopTransportRuntime *, uint8_t,
    int32_t, int32_t, int32_t, const uint8_t *, uint32_t,
    const CcbCoopStringSlice *, uint32_t, uint8_t,
    uint8_t * );
using item_count_fn = uint32_t ( * )( const CcbCoopTransportRuntime * );
using monster_submit_basic_fn = CcbCoopMonsterDeltaFlags( * )( CcbCoopTransportRuntime *,
    uint32_t, const uint8_t *, uint32_t, int32_t, int32_t, int32_t,
    int8_t, int32_t, int32_t, int8_t, const uint8_t *, uint32_t );
using monster_remove_fn = CcbCoopMonsterDeltaFlags( * )( CcbCoopTransportRuntime *, uint32_t );
using monster_count_fn = uint32_t ( * )( const CcbCoopTransportRuntime * );
using activity_submit_fn = CcbCoopActivityDeltaFlags( * )( CcbCoopTransportRuntime *,
    uint64_t, const uint8_t *, uint32_t, int32_t, int32_t, int32_t,
    int32_t );
using activity_count_fn = uint32_t ( * )( const CcbCoopTransportRuntime * );

static const uint8_t *bytes_or_null( const std::string &text )
{
    return text.empty() ? nullptr : reinterpret_cast<const uint8_t *>( text.data() );
}

static uint32_t size32( const std::string &text )
{
    return static_cast<uint32_t>( text.size() );
}

static CcbCoopByteSlice byte_slice( const std::string &text )
{
    return CcbCoopByteSlice {
        bytes_or_null( text ),
        size32( text )
    };
}

static renet_tile_delta_flags to_tile_flags( const CcbCoopTileDeltaFlags &flags )
{
    return renet_tile_delta_flags {
        flags.terrain != 0,
        flags.furniture != 0,
        flags.items != 0,
        flags.fields != 0,
        flags.trap != 0,
        flags.graffiti != 0
    };
}

static renet_vehicle_delta_flags to_vehicle_flags( const CcbCoopVehicleDeltaFlags &flags )
{
    return renet_vehicle_delta_flags {
        flags.motion != 0,
        flags.identity != 0,
        flags.parts != 0,
        flags.cargo != 0,
        flags.snapshot != 0,
        flags.removed != 0
    };
}

static renet_actor_delta_flags to_actor_flags( const CcbCoopActorDeltaFlags &flags )
{
    return renet_actor_delta_flags {
        flags.identity != 0,
        flags.motion != 0,
        flags.status != 0
    };
}

static renet_item_delta_flags to_item_flags( const CcbCoopItemDeltaFlags &flags )
{
    return renet_item_delta_flags {
        flags.count != 0,
        flags.payload != 0,
        flags.rot != 0,
        flags.removed != 0
    };
}

static renet_mutation_queue_status to_mutation_status(
    const CcbCoopMutationQueueStatus &status )
{
    return renet_mutation_queue_status {
        status.available != 0,
        status.blocked != 0,
        status.pending_packets,
        status.pending_bytes,
        status.inflight_seq,
        status.pending_seq,
        status.sent_chunks,
        status.acked_chunks
    };
}

static renet_monster_delta_flags to_monster_flags( const CcbCoopMonsterDeltaFlags &flags )
{
    return renet_monster_delta_flags {
        flags.identity != 0,
        flags.motion != 0,
        flags.status != 0,
        flags.removed != 0
    };
}

static renet_activity_delta_flags to_activity_flags( const CcbCoopActivityDeltaFlags &flags )
{
    return renet_activity_delta_flags {
        flags.activity != 0,
        flags.progress != 0,
        flags.completed != 0
    };
}

class renet_library
{
    public:
        ~renet_library() {
            if( runtime_ != nullptr && destroy_ != nullptr ) {
                destroy_( runtime_ );
            }
#if defined(_WIN32)
            if( library_ != nullptr ) {
                FreeLibrary( library_ );
            }
#else
            if( library_ != nullptr ) {
                dlclose( library_ );
            }
#endif
        }

        bool available() {
            std::lock_guard<std::mutex> lock( mutex_ );
            return ensure_loaded_locked();
        }

        bool start_host( const std::string &bind_addr ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( !ensure_loaded_locked() ) {
                return false;
            }
            if( start_host_( runtime_, bind_addr.c_str() ) == 0 ) {
                last_error_cache_ = fetch_last_error_locked();
                return false;
            }
            return true;
        }

        bool start_client( const std::string &server_addr, uint64_t client_id ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( !ensure_loaded_locked() ) {
                return false;
            }
            if( start_client_( runtime_, server_addr.c_str(), client_id ) == 0 ) {
                last_error_cache_ = fetch_last_error_locked();
                return false;
            }
            return true;
        }

        void stop() {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ != nullptr && stop_ != nullptr ) {
                stop_( runtime_ );
            }
        }

        void pump() {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ != nullptr && pump_ != nullptr ) {
                pump_( runtime_ );
            }
        }

        renet_status status() {
            std::lock_guard<std::mutex> lock( mutex_ );
            renet_status out;
            if( runtime_ == nullptr || status_ == nullptr ) {
                return out;
            }
            const CcbCoopTransportStatus raw = status_( runtime_ );
            out.mode = raw.mode;
            out.running = raw.running != 0;
            out.connected = raw.connected != 0;
            out.peer_count = raw.peer_count;
            return out;
        }

        bool send( uint64_t peer_id, renet_channel channel, const std::string &payload ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( payload.size() > std::numeric_limits<uint32_t>::max() || !ensure_loaded_locked() ) {
                return false;
            }
            const auto *data = reinterpret_cast<const uint8_t *>( payload.data() );
            const uint8_t ok = send_( runtime_, peer_id, static_cast<uint8_t>( channel ), data,
                                      static_cast<uint32_t>( payload.size() ) );
            if( ok == 0 ) {
                last_error_cache_ = fetch_last_error_locked();
            }
            return ok != 0;
        }

        renet_mutation_queue_status mutation_enqueue_batch( uint32_t seq, uint32_t grant_seq,
                const std::vector<std::string> &packets ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( packets.empty() || !ensure_loaded_locked() || mutation_enqueue_batch_ == nullptr ) {
                return {};
            }
            std::vector<CcbCoopStringSlice> slices;
            slices.reserve( packets.size() );
            for( const std::string &packet : packets ) {
                slices.push_back( CcbCoopStringSlice {
                    bytes_or_null( packet ),
                    size32( packet )
                } );
            }
            return to_mutation_status( mutation_enqueue_batch_(
                                           runtime_, seq, grant_seq, slices.data(),
                                           static_cast<uint32_t>( slices.size() ) ) );
        }

        renet_mutation_queue_status mutation_ack( uint32_t seq ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( !ensure_loaded_locked() || mutation_ack_ == nullptr ) {
                return {};
            }
            return to_mutation_status( mutation_ack_( runtime_, seq ) );
        }

        renet_mutation_queue_status mutation_status() {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ == nullptr || mutation_status_ == nullptr ) {
                return {};
            }
            return to_mutation_status( mutation_status_( runtime_ ) );
        }

        std::vector<renet_packet> drain( uint32_t max_packets ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            std::vector<renet_packet> out;
            if( runtime_ == nullptr || drain_ == nullptr || free_batch_ == nullptr ) {
                return out;
            }
            CcbCoopIncomingBatch batch = drain_( runtime_, max_packets );
            out.reserve( batch.count );
            for( uint32_t i = 0; i < batch.count; ++i ) {
                const CcbCoopIncomingPacket &packet = batch.packets[i];
                renet_packet converted;
                converted.peer_id = packet.peer_id;
                converted.channel = to_channel( packet.channel );
                if( packet.data != nullptr && packet.len != 0 ) {
                    converted.payload.assign( reinterpret_cast<const char *>( packet.data ),
                                              packet.len );
                }
                out.push_back( std::move( converted ) );
            }
            free_batch_( batch );
            return out;
        }

        std::string last_error() {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ == nullptr || last_error_ == nullptr || free_bytes_ == nullptr ) {
                return last_error_cache_;
            }
            last_error_cache_ = fetch_last_error_locked();
            return last_error_cache_;
        }

        std::vector<uint64_t> connected_peers() {
            std::lock_guard<std::mutex> lock( mutex_ );
            std::vector<uint64_t> peers;
            if( runtime_ == nullptr ) {
                return peers;
            }
            const std::string json = consume_bytes_locked( peers_json_( runtime_ ) );
            const char *pos = json.data();
            const char *end = pos + json.size();
            while( pos < end ) {
                uint64_t peer = 0;
                const auto result = std::from_chars( pos, end, peer );
                if( result.ec == std::errc() ) {
                    peers.push_back( peer );
                    pos = result.ptr;
                } else {
                    ++pos;
                }
            }
            return peers;
        }

        void disconnect_peer( uint64_t peer ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ != nullptr ) {
                disconnect_peer_( runtime_, peer );
            }
        }

        std::string stats_json() {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ == nullptr || stats_json_ == nullptr || free_bytes_ == nullptr ) {
                return std::string();
            }
            CcbCoopByteBuffer bytes = stats_json_( runtime_ );
            std::string out;
            if( bytes.data != nullptr && bytes.len != 0 ) {
                out.assign( reinterpret_cast<const char *>( bytes.data ), bytes.len );
            }
            free_bytes_( bytes );
            return out;
        }

        std::vector<std::string> delta_packetize_object_array(
            const std::string &type, const std::string &array_member,
            const std::string &array_json, const std::string &common_fields,
            const std::string &extra_fields, uint32_t max_packet_bytes ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            std::vector<std::string> out;
            if( !ensure_loaded_locked() || delta_packetize_object_array_ == nullptr ||
                free_bytes_ == nullptr ) {
                return out;
            }
            CcbCoopByteBuffer bytes = delta_packetize_object_array_(
                                          bytes_or_null( type ), size32( type ),
                                          bytes_or_null( array_member ), size32( array_member ),
                                          bytes_or_null( array_json ), size32( array_json ),
                                          bytes_or_null( common_fields ), size32( common_fields ),
                                          bytes_or_null( extra_fields ), size32( extra_fields ),
                                          max_packet_bytes );
            const std::string joined = consume_bytes_locked( bytes );
            size_t start = 0;
            while( start < joined.size() ) {
                const size_t end = joined.find( '\n', start );
                std::string packet = joined.substr(
                                         start, end == std::string::npos ? std::string::npos : end - start );
                if( !packet.empty() ) {
                    out.push_back( std::move( packet ) );
                }
                if( end == std::string::npos ) {
                    break;
                }
                start = end + 1;
            }
            return out;
        }

        void state_reset() {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( ensure_loaded_locked() && state_reset_ != nullptr ) {
                state_reset_( runtime_ );
            }
        }

        renet_tile_delta_flags tile_submit( int32_t x, int32_t y, int32_t z,
                                            const std::string &terrain,
                                            const std::string &furniture,
                                            const std::string &items_sig,
                                            const std::string &fields_sig,
                                            const std::string &trap_sig,
                                            const std::string &graffiti_sig ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( !ensure_loaded_locked() || tile_submit_ == nullptr ) {
                return {};
            }
            return to_tile_flags( tile_submit_( runtime_, x, y, z,
                                                bytes_or_null( terrain ), size32( terrain ),
                                                bytes_or_null( furniture ), size32( furniture ),
                                                bytes_or_null( items_sig ), size32( items_sig ),
                                                bytes_or_null( fields_sig ), size32( fields_sig ),
                                                bytes_or_null( trap_sig ), size32( trap_sig ),
                                                bytes_or_null( graffiti_sig ), size32( graffiti_sig ) ) );
        }

        std::vector<renet_tile_delta_flags> tile_submit_batch(
            const std::vector<renet_tile_snapshot> &tiles ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            std::vector<renet_tile_delta_flags> out;
            if( tiles.empty() ) {
                return out;
            }
            if( !ensure_loaded_locked() || tile_submit_batch_ == nullptr ) {
                return out;
            }
            std::vector<CcbCoopTileSnapshotWire> wire;
            wire.reserve( tiles.size() );
            for( const renet_tile_snapshot &tile : tiles ) {
                wire.push_back( CcbCoopTileSnapshotWire {
                    tile.x,
                    tile.y,
                    tile.z,
                    byte_slice( tile.terrain ),
                    byte_slice( tile.furniture ),
                    byte_slice( tile.items_sig ),
                    byte_slice( tile.fields_sig ),
                    byte_slice( tile.trap_sig ),
                    byte_slice( tile.graffiti_sig )
                } );
            }
            std::vector<CcbCoopTileDeltaFlags> raw( tiles.size() );
            const uint32_t written = tile_submit_batch_( runtime_, wire.data(),
                static_cast<uint32_t>( wire.size() ), raw.data() );
            if( written != tiles.size() ) {
                return {};
            }
            out.reserve( raw.size() );
            for( const CcbCoopTileDeltaFlags &flags : raw ) {
                out.push_back( to_tile_flags( flags ) );
            }
            return out;
        }

        uint32_t tile_count() {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ == nullptr || tile_count_ == nullptr ) {
                return 0;
            }
            return tile_count_( runtime_ );
        }

        renet_vehicle_delta_flags vehicle_submit_wire_summary( uint32_t nid,
                int32_t x, int32_t y, int32_t z, int16_t face_deg, int16_t turn_dir_deg,
                int32_t velocity, int32_t cruise_velocity, const std::string &name,
                uint32_t parts_count, uint32_t snapshot_generation,
                const std::string &parts_sig, const std::string &cargo_sig,
                const std::string &snapshot_sig, uint32_t snapshot_bytes ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( !ensure_loaded_locked() || vehicle_submit_wire_summary_ == nullptr ) {
                return {};
            }
            return to_vehicle_flags( vehicle_submit_wire_summary_(
                                         runtime_, nid, x, y, z, face_deg, turn_dir_deg,
                                         velocity, cruise_velocity, bytes_or_null( name ), size32( name ),
                                         parts_count, snapshot_generation,
                                         bytes_or_null( parts_sig ), size32( parts_sig ),
                                         bytes_or_null( cargo_sig ), size32( cargo_sig ),
                                         bytes_or_null( snapshot_sig ), size32( snapshot_sig ),
                                         snapshot_bytes ) );
        }

        renet_vehicle_delta_flags vehicle_submit_motion( uint32_t nid,
                int32_t x, int32_t y, int32_t z, int16_t face_deg, int16_t turn_dir_deg,
                int32_t velocity, int32_t cruise_velocity ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( !ensure_loaded_locked() || vehicle_submit_motion_ == nullptr ) {
                return {};
            }
            return to_vehicle_flags( vehicle_submit_motion_( runtime_, nid, x, y, z, face_deg,
                    turn_dir_deg, velocity, cruise_velocity ) );
        }

        std::vector<bool> vehicle_submit_part_entries( uint32_t nid,
                const std::vector<std::string> &part_entries, bool force_full ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            std::vector<bool> out;
            if( part_entries.empty() ) {
                return out;
            }
            if( !ensure_loaded_locked() || vehicle_submit_part_entries_ == nullptr ) {
                return out;
            }
            std::vector<CcbCoopStringSlice> slices;
            slices.reserve( part_entries.size() );
            for( const std::string &entry : part_entries ) {
                slices.push_back( CcbCoopStringSlice {
                    bytes_or_null( entry ),
                    size32( entry )
                } );
            }
            std::vector<uint8_t> changed( part_entries.size(), 0 );
            const uint32_t written = vehicle_submit_part_entries_(
                                         runtime_, nid, slices.data(),
                                         static_cast<uint32_t>( slices.size() ),
                                         force_full ? 1 : 0, changed.data() );
            if( written != part_entries.size() ) {
                return {};
            }
            out.reserve( changed.size() );
            for( const uint8_t value : changed ) {
                out.push_back( value != 0 );
            }
            return out;
        }

        bool vehicle_needs_snapshot( uint32_t nid, const std::string &snapshot_sig,
                                     bool *available ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( !ensure_loaded_locked() || vehicle_needs_snapshot_ == nullptr ) {
                if( available != nullptr ) {
                    *available = false;
                }
                return true;
            }
            if( available != nullptr ) {
                *available = true;
            }
            return vehicle_needs_snapshot_( runtime_, nid, bytes_or_null( snapshot_sig ),
                                            size32( snapshot_sig ) ) != 0;
        }

        uint32_t vehicle_count() {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ == nullptr || vehicle_count_ == nullptr ) {
                return 0;
            }
            return vehicle_count_( runtime_ );
        }

        std::string vehicle_query_json( uint32_t nid ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ == nullptr || vehicle_query_json_ == nullptr || free_bytes_ == nullptr ) {
                return std::string();
            }
            CcbCoopByteBuffer bytes = vehicle_query_json_( runtime_, nid );
            return consume_bytes_locked( bytes );
        }

        renet_actor_delta_flags actor_submit_basic( uint64_t nid, const std::string &name,
                bool is_host, int32_t x, int32_t y, int32_t z, int8_t facing, uint8_t move_mode,
                bool in_vehicle, bool controlling_vehicle, int32_t moves,
                const std::string &activity, int32_t activity_pct, int32_t activity_moves_total,
                int32_t light_milli, const std::string &bodyparts_json,
                const std::string &effects_json ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( !ensure_loaded_locked() || actor_submit_basic_ == nullptr ) {
                return {};
            }
            return to_actor_flags( actor_submit_basic_(
                                       runtime_, nid, bytes_or_null( name ), size32( name ),
                                       is_host ? 1 : 0, x, y, z, facing, move_mode,
                                       in_vehicle ? 1 : 0, controlling_vehicle ? 1 : 0, moves,
                                       bytes_or_null( activity ), size32( activity ), activity_pct,
                                       activity_moves_total, light_milli,
                                       bytes_or_null( bodyparts_json ), size32( bodyparts_json ),
                                       bytes_or_null( effects_json ), size32( effects_json ) ) );
        }

        uint32_t actor_count() {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ == nullptr || actor_count_ == nullptr ) {
                return 0;
            }
            return actor_count_( runtime_ );
        }

        std::string actor_query_json( uint64_t nid ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ == nullptr || actor_query_json_ == nullptr || free_bytes_ == nullptr ) {
                return std::string();
            }
            CcbCoopByteBuffer bytes = actor_query_json_( runtime_, nid );
            return consume_bytes_locked( bytes );
        }

        renet_item_delta_flags item_submit_location( uint8_t location_kind,
                int32_t x, int32_t y, int32_t z, const std::string &slot,
                uint32_t item_count, uint32_t encoded_bytes, const std::string &items_sig,
                const std::string &rot_sig ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( !ensure_loaded_locked() || item_submit_location_ == nullptr ) {
                return {};
            }
            return to_item_flags( item_submit_location_(
                                      runtime_, location_kind, x, y, z,
                                      bytes_or_null( slot ), size32( slot ),
                                      item_count, encoded_bytes,
                                      bytes_or_null( items_sig ), size32( items_sig ),
                                      bytes_or_null( rot_sig ), size32( rot_sig ) ) );
        }

        std::vector<bool> item_submit_slot_entries( uint8_t location_kind,
                int32_t x, int32_t y, int32_t z, const std::string &slot,
                const std::vector<std::string> &entries, bool force_full ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            std::vector<bool> out;
            if( entries.empty() ) {
                return out;
            }
            if( !ensure_loaded_locked() || item_submit_slot_entries_ == nullptr ) {
                return out;
            }
            std::vector<CcbCoopStringSlice> slices;
            slices.reserve( entries.size() );
            for( const std::string &entry : entries ) {
                slices.push_back( CcbCoopStringSlice {
                    bytes_or_null( entry ),
                    size32( entry )
                } );
            }
            std::vector<uint8_t> changed( entries.size(), 0 );
            const uint32_t written = item_submit_slot_entries_(
                                         runtime_, location_kind, x, y, z,
                                         bytes_or_null( slot ), size32( slot ),
                                         slices.data(), static_cast<uint32_t>( slices.size() ),
                                         force_full ? 1 : 0, changed.data() );
            if( written != entries.size() ) {
                return {};
            }
            out.reserve( changed.size() );
            for( const uint8_t value : changed ) {
                out.push_back( value != 0 );
            }
            return out;
        }

        uint32_t item_count() {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ == nullptr || item_count_ == nullptr ) {
                return 0;
            }
            return item_count_( runtime_ );
        }

        renet_monster_delta_flags monster_submit_basic( uint32_t nid,
                const std::string &species, int32_t x, int32_t y, int32_t z, int8_t facing,
                int32_t hp, int32_t speed, int8_t attitude, const std::string &effects_sig ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( !ensure_loaded_locked() || monster_submit_basic_ == nullptr ) {
                return {};
            }
            return to_monster_flags( monster_submit_basic_(
                                         runtime_, nid, bytes_or_null( species ), size32( species ),
                                         x, y, z, facing, hp, speed, attitude,
                                         bytes_or_null( effects_sig ), size32( effects_sig ) ) );
        }

        uint32_t monster_count() {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ == nullptr || monster_count_ == nullptr ) {
                return 0;
            }
            return monster_count_( runtime_ );
        }

        renet_monster_delta_flags monster_remove( uint32_t nid ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( !ensure_loaded_locked() || monster_remove_ == nullptr ) {
                return {};
            }
            return to_monster_flags( monster_remove_( runtime_, nid ) );
        }

        renet_activity_delta_flags activity_submit( uint64_t actor_id,
                const std::string &activity, int32_t pct, int32_t moves_left,
                int32_t moves_total, int32_t calendar_turn ) {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( !ensure_loaded_locked() || activity_submit_ == nullptr ) {
                return {};
            }
            return to_activity_flags( activity_submit_(
                                          runtime_, actor_id, bytes_or_null( activity ),
                                          size32( activity ), pct, moves_left, moves_total,
                                          calendar_turn ) );
        }

        uint32_t activity_count() {
            std::lock_guard<std::mutex> lock( mutex_ );
            if( runtime_ == nullptr || activity_count_ == nullptr ) {
                return 0;
            }
            return activity_count_( runtime_ );
        }

    private:
#if defined(_WIN32)
        using library_handle = HMODULE;
#else
        using library_handle = void *;
#endif

        bool ensure_loaded_locked() {
            if( runtime_ != nullptr ) {
                return true;
            }
            if( library_ == nullptr && !load_library_locked() ) {
                return false;
            }
            if( !bind( abi_version_, "ccb_coop_abi_version" ) ) {
                return false;
            }
            if( abi_version_() != 1 ) {
                last_error_cache_ = "incompatible CCB co-op ABI (expected 1)";
                return false;
            }
            if( !load_symbols_locked() ) {
                return false;
            }
            runtime_ = create_();
            if( runtime_ == nullptr ) {
                last_error_cache_ = "ccb_coop_transport_create returned null";
                return false;
            }
            return true;
        }

        bool load_library_locked() {
#if defined(_WIN32)
            wchar_t path[32768];
            const DWORD size = GetModuleFileNameW( nullptr, path, 32768 );
            if( size == 0 || size >= 32768 ) {
                last_error_cache_ = "could not locate executable for co-op runtime";
                return false;
            }
            const auto library_path = std::filesystem::path( path ).parent_path() /
                                      L"ccb_bevy_ecs_coop.dll";
            library_ = LoadLibraryW( library_path.c_str() );
            if( library_ == nullptr ) {
                last_error_cache_ = "failed to load adjacent ccb_bevy_ecs_coop.dll";
                return false;
            }
#else
            std::filesystem::path executable;
#if defined(__linux__) && !defined(__ANDROID__)
            char path[4096];
            const ssize_t size = readlink( "/proc/self/exe", path, sizeof( path ) );
            if( size > 0 && static_cast<size_t>( size ) < sizeof( path ) ) {
                executable = std::string( path, size );
            }
#elif defined(__APPLE__)
            uint32_t size = 0;
            _NSGetExecutablePath( nullptr, &size );
            std::vector<char> path( size );
            if( _NSGetExecutablePath( path.data(), &size ) == 0 ) {
                executable = path.data();
            }
#endif
#if defined(__APPLE__)
            const char *name = "libccb_bevy_ecs_coop.dylib";
#else
            const char *name = "libccb_bevy_ecs_coop.so";
#endif
            const std::string library_path = executable.empty() ? name :
                                             ( executable.parent_path() / name ).string();
            library_ = dlopen( library_path.c_str(), RTLD_NOW | RTLD_LOCAL );
            if( library_ == nullptr ) {
                const char *err = dlerror();
                last_error_cache_ = err != nullptr ? err : "failed to load co-op runtime";
                return false;
            }
#endif
            return true;
        }

        bool load_symbols_locked() {
            return bind( peers_json_, "ccb_coop_transport_peers_json" ) &&
                   bind( disconnect_peer_, "ccb_coop_transport_disconnect_peer" ) &&
                   bind( create_, "ccb_coop_transport_create" ) &&
                   bind( destroy_, "ccb_coop_transport_destroy" ) &&
                   bind( start_host_, "ccb_coop_transport_start_host" ) &&
                   bind( start_client_, "ccb_coop_transport_start_client" ) &&
                   bind( stop_, "ccb_coop_transport_stop" ) &&
                   bind( pump_, "ccb_coop_transport_pump" ) &&
                   bind( status_, "ccb_coop_transport_status" ) &&
                   bind( send_, "ccb_coop_transport_send" ) &&
                   bind_optional( mutation_enqueue_batch_,
                                  "ccb_coop_mutation_enqueue_batch" ) &&
                   bind_optional( mutation_ack_, "ccb_coop_mutation_ack" ) &&
                   bind_optional( mutation_status_, "ccb_coop_mutation_status" ) &&
                   bind( drain_, "ccb_coop_transport_drain" ) &&
                   bind( free_batch_, "ccb_coop_transport_free_batch" ) &&
                   bind( last_error_, "ccb_coop_transport_last_error" ) &&
                   bind( stats_json_, "ccb_coop_transport_stats_json" ) &&
                   bind( free_bytes_, "ccb_coop_transport_free_bytes" ) &&
                   bind_optional( delta_packetize_object_array_,
                                  "ccb_coop_delta_packetize_object_array" ) &&
                   bind_optional( state_reset_, "ccb_coop_state_reset" ) &&
                   bind_optional( tile_submit_, "ccb_coop_tile_submit" ) &&
                   bind_optional( tile_submit_batch_, "ccb_coop_tile_submit_batch" ) &&
                   bind_optional( tile_count_, "ccb_coop_tile_count" ) &&
                   bind_optional( vehicle_submit_wire_summary_,
                                  "ccb_coop_vehicle_submit_wire_summary" ) &&
                   bind_optional( vehicle_submit_motion_, "ccb_coop_vehicle_submit_motion" ) &&
                   bind_optional( vehicle_submit_part_entries_,
                                  "ccb_coop_vehicle_submit_part_entries" ) &&
                   bind_optional( vehicle_needs_snapshot_,
                                  "ccb_coop_vehicle_needs_snapshot" ) &&
                   bind_optional( vehicle_count_, "ccb_coop_vehicle_count" ) &&
                   bind_optional( vehicle_query_json_, "ccb_coop_vehicle_query_json" ) &&
                   bind_optional( actor_submit_basic_, "ccb_coop_actor_submit_basic" ) &&
                   bind_optional( actor_count_, "ccb_coop_actor_count" ) &&
                   bind_optional( actor_query_json_, "ccb_coop_actor_query_json" ) &&
                   bind_optional( item_submit_location_, "ccb_coop_item_submit_location" ) &&
                   bind_optional( item_submit_slot_entries_,
                                  "ccb_coop_item_submit_slot_entries" ) &&
                   bind_optional( item_count_, "ccb_coop_item_count" ) &&
                   bind_optional( monster_submit_basic_, "ccb_coop_monster_submit_basic" ) &&
                   bind_optional( monster_remove_, "ccb_coop_monster_remove" ) &&
                   bind_optional( monster_count_, "ccb_coop_monster_count" ) &&
                   bind_optional( activity_submit_, "ccb_coop_activity_submit" ) &&
                   bind_optional( activity_count_, "ccb_coop_activity_count" );
        }

        template<typename Fn>
        bool bind( Fn &fn, const char *name ) {
#if defined(_WIN32)
            fn = reinterpret_cast<Fn>( GetProcAddress( library_, name ) );
#else
            fn = reinterpret_cast<Fn>( dlsym( library_, name ) );
#endif
            if( fn == nullptr ) {
                last_error_cache_ = std::string( "missing Rust transport symbol: " ) + name;
                return false;
            }
            return true;
        }

        template<typename Fn>
        bool bind_optional( Fn &fn, const char *name ) {
#if defined(_WIN32)
            fn = reinterpret_cast<Fn>( GetProcAddress( library_, name ) );
#else
            fn = reinterpret_cast<Fn>( dlsym( library_, name ) );
#endif
            return true;
        }

        std::string consume_bytes_locked( CcbCoopByteBuffer bytes ) {
            std::string out;
            if( bytes.data != nullptr && bytes.len != 0 ) {
                out.assign( reinterpret_cast<const char *>( bytes.data ), bytes.len );
            }
            free_bytes_( bytes );
            return out;
        }

        std::string fetch_last_error_locked() {
            if( runtime_ == nullptr || last_error_ == nullptr || free_bytes_ == nullptr ) {
                return last_error_cache_;
            }
            CcbCoopByteBuffer bytes = last_error_( runtime_ );
            std::string out = consume_bytes_locked( bytes );
            return out.empty() ? last_error_cache_ : out;
        }

        static renet_channel to_channel( uint8_t channel ) {
            switch( channel ) {
                case 0:
                    return renet_channel::unreliable;
                case 1:
                    return renet_channel::reliable_unordered;
                case 3:
                    return renet_channel::reliable_bulk;
                case 2:
                default:
                    return renet_channel::reliable_ordered;
            }
        }

        std::mutex mutex_;
        library_handle library_ = nullptr;
        CcbCoopTransportRuntime *runtime_ = nullptr;
        std::string last_error_cache_;

        decltype( &ccb_coop_abi_version ) abi_version_ = nullptr;
        decltype( &ccb_coop_transport_peers_json ) peers_json_ = nullptr;
        decltype( &ccb_coop_transport_disconnect_peer ) disconnect_peer_ = nullptr;
        create_fn create_ = nullptr;
        destroy_fn destroy_ = nullptr;
        start_host_fn start_host_ = nullptr;
        start_client_fn start_client_ = nullptr;
        stop_fn stop_ = nullptr;
        pump_fn pump_ = nullptr;
        status_fn status_ = nullptr;
        send_fn send_ = nullptr;
        mutation_enqueue_batch_fn mutation_enqueue_batch_ = nullptr;
        mutation_ack_fn mutation_ack_ = nullptr;
        mutation_status_fn mutation_status_ = nullptr;
        drain_fn drain_ = nullptr;
        free_batch_fn free_batch_ = nullptr;
        last_error_fn last_error_ = nullptr;
        stats_json_fn stats_json_ = nullptr;
        delta_packetize_object_array_fn delta_packetize_object_array_ = nullptr;
        free_bytes_fn free_bytes_ = nullptr;
        state_reset_fn state_reset_ = nullptr;
        tile_submit_fn tile_submit_ = nullptr;
        tile_submit_batch_fn tile_submit_batch_ = nullptr;
        tile_count_fn tile_count_ = nullptr;
        vehicle_submit_wire_summary_fn vehicle_submit_wire_summary_ = nullptr;
        vehicle_submit_motion_fn vehicle_submit_motion_ = nullptr;
        vehicle_submit_part_entries_fn vehicle_submit_part_entries_ = nullptr;
        vehicle_needs_snapshot_fn vehicle_needs_snapshot_ = nullptr;
        vehicle_count_fn vehicle_count_ = nullptr;
        vehicle_query_json_fn vehicle_query_json_ = nullptr;
        actor_submit_basic_fn actor_submit_basic_ = nullptr;
        actor_count_fn actor_count_ = nullptr;
        actor_query_json_fn actor_query_json_ = nullptr;
        item_submit_location_fn item_submit_location_ = nullptr;
        item_submit_slot_entries_fn item_submit_slot_entries_ = nullptr;
        item_count_fn item_count_ = nullptr;
        monster_submit_basic_fn monster_submit_basic_ = nullptr;
        monster_remove_fn monster_remove_ = nullptr;
        monster_count_fn monster_count_ = nullptr;
        activity_submit_fn activity_submit_ = nullptr;
        activity_count_fn activity_count_ = nullptr;
};

renet_library &library()
{
    static renet_library instance;
    return instance;
}

} // namespace

bool renet_transport_available()
{
    return library().available();
}

std::vector<uint64_t> renet_transport_connected_peers()
{
    return library().connected_peers();
}

void renet_transport_disconnect_peer( uint64_t peer )
{
    library().disconnect_peer( peer );
}

bool renet_transport_start_host( const std::string &bind_addr )
{
    return library().start_host( bind_addr );
}

bool renet_transport_start_client( const std::string &server_addr, uint64_t client_id )
{
    return library().start_client( server_addr, client_id );
}

void renet_transport_stop()
{
    library().stop();
}

void renet_transport_pump()
{
    library().pump();
}

renet_status renet_transport_get_status()
{
    return library().status();
}

bool renet_transport_send( uint64_t peer_id, renet_channel channel, const std::string &payload )
{
    return library().send( peer_id, channel, payload );
}

renet_mutation_queue_status renet_mutation_enqueue_batch( uint32_t seq, uint32_t grant_seq,
        const std::vector<std::string> &packets )
{
    return library().mutation_enqueue_batch( seq, grant_seq, packets );
}

renet_mutation_queue_status renet_mutation_ack( uint32_t seq )
{
    return library().mutation_ack( seq );
}

renet_mutation_queue_status renet_mutation_status()
{
    return library().mutation_status();
}

std::vector<renet_packet> renet_transport_drain( uint32_t max_packets )
{
    return library().drain( max_packets );
}

std::string renet_transport_last_error()
{
    return library().last_error();
}

std::string renet_transport_stats_json()
{
    return library().stats_json();
}

std::vector<std::string> renet_delta_packetize_object_array( const std::string &type,
        const std::string &array_member, const std::string &array_json,
        const std::string &common_fields, const std::string &extra_fields,
        uint32_t max_packet_bytes )
{
    return library().delta_packetize_object_array( type, array_member, array_json,
            common_fields, extra_fields, max_packet_bytes );
}

void renet_state_reset()
{
    library().state_reset();
}

renet_tile_delta_flags renet_tile_submit( int32_t x, int32_t y, int32_t z,
        const std::string &terrain, const std::string &furniture,
        const std::string &items_sig, const std::string &fields_sig,
        const std::string &trap_sig, const std::string &graffiti_sig )
{
    return library().tile_submit( x, y, z, terrain, furniture, items_sig, fields_sig,
                                  trap_sig, graffiti_sig );
}

std::vector<renet_tile_delta_flags> renet_tile_submit_batch(
    const std::vector<renet_tile_snapshot> &tiles )
{
    return library().tile_submit_batch( tiles );
}

uint32_t renet_tile_count()
{
    return library().tile_count();
}

renet_vehicle_delta_flags renet_vehicle_submit_wire_summary( uint32_t nid,
        int32_t x, int32_t y, int32_t z, int16_t face_deg, int16_t turn_dir_deg,
        int32_t velocity, int32_t cruise_velocity, const std::string &name,
        uint32_t parts_count, uint32_t snapshot_generation,
        const std::string &parts_sig, const std::string &cargo_sig,
        const std::string &snapshot_sig, uint32_t snapshot_bytes )
{
    return library().vehicle_submit_wire_summary( nid, x, y, z, face_deg, turn_dir_deg,
            velocity, cruise_velocity, name, parts_count, snapshot_generation,
            parts_sig, cargo_sig, snapshot_sig, snapshot_bytes );
}

renet_vehicle_delta_flags renet_vehicle_submit_motion( uint32_t nid,
        int32_t x, int32_t y, int32_t z, int16_t face_deg, int16_t turn_dir_deg,
        int32_t velocity, int32_t cruise_velocity )
{
    return library().vehicle_submit_motion( nid, x, y, z, face_deg, turn_dir_deg,
                                            velocity, cruise_velocity );
}

std::vector<bool> renet_vehicle_submit_part_entries( uint32_t nid,
        const std::vector<std::string> &part_entries, bool force_full )
{
    return library().vehicle_submit_part_entries( nid, part_entries, force_full );
}

bool renet_vehicle_needs_snapshot( uint32_t nid, const std::string &snapshot_sig,
                                   bool *available )
{
    return library().vehicle_needs_snapshot( nid, snapshot_sig, available );
}

uint32_t renet_vehicle_count()
{
    return library().vehicle_count();
}

std::string renet_vehicle_query_json( uint32_t nid )
{
    return library().vehicle_query_json( nid );
}

renet_actor_delta_flags renet_actor_submit_basic( uint64_t nid,
        const std::string &name, bool is_host, int32_t x, int32_t y, int32_t z,
        int8_t facing, uint8_t move_mode, bool in_vehicle, bool controlling_vehicle,
        int32_t moves, const std::string &activity, int32_t activity_pct,
        int32_t activity_moves_total, int32_t light_milli,
        const std::string &bodyparts_json, const std::string &effects_json )
{
    return library().actor_submit_basic( nid, name, is_host, x, y, z, facing, move_mode,
                                         in_vehicle, controlling_vehicle, moves, activity,
                                         activity_pct, activity_moves_total, light_milli,
                                         bodyparts_json, effects_json );
}

uint32_t renet_actor_count()
{
    return library().actor_count();
}

std::string renet_actor_query_json( uint64_t nid )
{
    return library().actor_query_json( nid );
}

renet_item_delta_flags renet_item_submit_location( uint8_t location_kind,
        int32_t x, int32_t y, int32_t z, const std::string &slot,
        uint32_t item_count, uint32_t encoded_bytes, const std::string &items_sig,
        const std::string &rot_sig )
{
    return library().item_submit_location( location_kind, x, y, z, slot, item_count,
                                           encoded_bytes, items_sig, rot_sig );
}

std::vector<bool> renet_item_submit_slot_entries( uint8_t location_kind,
        int32_t x, int32_t y, int32_t z, const std::string &slot,
        const std::vector<std::string> &entries, bool force_full )
{
    return library().item_submit_slot_entries( location_kind, x, y, z, slot, entries,
            force_full );
}

uint32_t renet_item_count()
{
    return library().item_count();
}

renet_monster_delta_flags renet_monster_submit_basic( uint32_t nid,
        const std::string &species, int32_t x, int32_t y, int32_t z, int8_t facing,
        int32_t hp, int32_t speed, int8_t attitude, const std::string &effects_sig )
{
    return library().monster_submit_basic( nid, species, x, y, z, facing, hp, speed,
                                           attitude, effects_sig );
}

renet_monster_delta_flags renet_monster_remove( uint32_t nid )
{
    return library().monster_remove( nid );
}

uint32_t renet_monster_count()
{
    return library().monster_count();
}

renet_activity_delta_flags renet_activity_submit( uint64_t actor_id,
        const std::string &activity, int32_t pct, int32_t moves_left,
        int32_t moves_total, int32_t calendar_turn )
{
    return library().activity_submit( actor_id, activity, pct, moves_left, moves_total,
                                      calendar_turn );
}

uint32_t renet_activity_count()
{
    return library().activity_count();
}

renet_channel renet_channel_for_payload( const std::string &payload )
{
    const std::string type = json_get_str( payload, "type" );
    const std::string action = json_get_str( payload, "action" );
    if( type == "chat" ||
        type == "visual_event" ||
        type == "sfx" ||
        type == "activity_progress" ||
        type == "debug" ||
        type == "stats" ||
        action == "chat" ||
        action == "visual_event" ||
        action == "sfx" ||
        action == "shout" ||
        action == "high_five" ) {
        return renet_channel::reliable_unordered;
    }

    // Conservative default. Most current co-op JSON affects world, actor,
    // map, inventory, or lockstep ordering, so it must not cross channels.
    return renet_channel::reliable_ordered;
}

const char *renet_channel_name( renet_channel channel )
{
    switch( channel ) {
        case renet_channel::unreliable:
            return "Unreliable";
        case renet_channel::reliable_unordered:
            return "ReliableUnordered";
        case renet_channel::reliable_bulk:
            return "ReliableBulk";
        case renet_channel::reliable_ordered:
        default:
            return "ReliableOrdered";
    }
}

std::string renet_payload_route_label( const std::string &payload )
{
    const std::string type = json_get_str( payload, "type" );
    const std::string action = json_get_str( payload, "action" );
    std::string label;
    if( !type.empty() ) {
        label = "type=" + type;
    } else if( !action.empty() ) {
        label = "action=" + action;
    } else {
        return "type=(unknown)";
    }
    if( type == "action" ) {
        if( !action.empty() ) {
            label += " action=" + action;
        }
    }
    return label;
}

} // namespace cata_mp
