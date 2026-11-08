#include "mp_client_conn.h"
#include "mp_server.h"
#include "mp_queue.h"
#include "mp_protocol.h"
#include "mp_renet_transport.h"

#include <chrono>
#include <iostream>
#include <map>
#include <stdexcept>
#include <thread>

// json.cpp's diagnostic escaping depends on this UI string helper. Keep the
// diagnostic-only shim local to this standalone harness; networking and JSON
// parsing below use the production implementations.
void replace_substring( std::string &text, const std::string &pattern,
                        const std::string &replacement, bool all )
{
    size_t position = 0;
    while( ( position = text.find( pattern, position ) ) != std::string::npos ) {
        text.replace( position, pattern.size(), replacement );
        position += replacement.size();
        if( !all ) {
            break;
        }
    }
}

namespace cata_mp
{
// This standalone application's owner is the local object in main().
client_connection *harness_client = nullptr;
host_session *harness_host = nullptr;
client_connection *current_client_connection()
{
    return harness_client;
}

void mp_log( const std::string &msg )
{
    std::cerr << msg << '\n';
}
void mp_log_host( const std::string &msg )
{
    mp_log( msg );
}

std::shared_ptr<server> get_active_server()
{
    return harness_host ? harness_host->active_server() : nullptr;
}

event_queue &get_mp_queue()
{
    return harness_host->events();
}

server_welcome welcome_data()
{
    return { "测试世界\"\\\n", "主机角色", 12345, std::array<int, 3>{ 1, 2, 0 },
             world_id( std::string( 32, 'a' ) ) };
}
void mp_set_client_host_world_name( const std::string & ) {}
void mp_set_client_host_player_name( const std::string & ) {}
void mp_store_pending_welcome( const std::string & ) {}
}

using namespace cata_mp;

void exercise_context_ownership( uint16_t first_port, uint16_t second_port );
void exercise_queue_limits();
void exercise_inbound_overload( uint16_t port );

static void require( bool condition, const char *message )
{
    if( !condition ) {
        throw std::runtime_error( message );
    }
}

static void protocol_tests()
{
    std::map<std::string, std::string> fields;
    require( read_handshake( R"({"type":"welcome","world_id":"11111111111111111111111111111111"})",
                             fields ) &&
             fields["world_id"] == std::string( 32, '1' ), "world identity survives handshake decoding" );
    require( !read_handshake( R"({"type":"welcome","world_id":42})", fields ),
             "world identity must be a string" );
    require( read_handshake( "{\"type\":\"join\",\"name\":\"\\u4e2d\\u6587😀\"}", fields ),
             "Unicode JSON" );
    require( fields["name"] == "中文😀", "Unicode preserved" );
    require( !read_handshake( "{\"type\":\"join\",\"type\":\"quit\"}", fields ),
             "duplicate keys rejected" );
    require( !read_handshake( "{\"type\":\"join\"} {}", fields ), "trailing JSON rejected" );
    require( !read_handshake( "{\"type\":5}", fields ), "wrong type rejected" );
    const std::string name = "名字\"\\\n\t";
    require( read_handshake( "{\"type\":\"join\",\"name\":" + wire_quote( name ) + "}", fields ) &&
             fields["name"] == name, "escaping roundtrip" );
    require( version_commit_id( "abc-dirty.120000+SDL3" ) == "abc", "build suffix normalization" );
    const std::string large = "{\"type\":\"state\",\"data\":\"" + std::string( 96 * 1024, 'x' ) + "\"}";
    std::string decoded;
    const std::string packet = encode_game_packet( large );
    require( packet.size() < 512, "compression used" );
    require( decode_game_packet( packet, decoded ) && decoded == large, "large roundtrip" );
    require( !decode_game_packet( packet.substr( 0, packet.size() - 1 ), decoded ),
             "truncated frame rejected" );
    require( encode_game_packet( std::string( 8 * 1024 * 1024 + 1, 'x' ) ).empty(), "outgoing limit" );
    require( renet_channel_for_payload( "{\"type\":\"state\"}" ) == renet_channel::reliable_ordered,
             "legacy state ordering" );
    require( renet_channel_for_payload( "{\"type\":\"chat\"}" ) == renet_channel::reliable_unordered,
             "chat channel" );
    std::cout << "PASS protocol\n";
}

int main( int argc, char **argv )
{
    try {
        client_connection owned_client;
        harness_client = &owned_client;
        if( argc == 2 && std::string( argv[1] ) == "unit" ) {
            protocol_tests();
            exercise_queue_limits();
            return 0;
        }
        require( argc >= 3, "mode port required" );
        const std::string mode = argv[1];
        const uint16_t port = std::stoi( argv[2] );
        if( mode == "contexts" ) {
            require( argc == 4, "two context ports required" );
            exercise_context_ownership( port, static_cast<uint16_t>( std::stoi( argv[3] ) ) );
            exercise_inbound_overload( port );
            std::cout << "PASS contexts" << std::endl;
            return 0;
        }
        host_session host;
        std::map<uint64_t, peer_admission> admissions;
        harness_host = &host;
        renet_context raw;
        if( mode == "host" ) {
            if( !host.start( port, "口令\"\\", "abc", welcome_data() ) ) {
                std::cout << "ERROR " << wire_quote( host.error() ) << std::endl;
                return 0;
            }
        } else if( mode == "client" ) {
            require( argc == 6, "client port name password version required" );
            set_client_mode( true );
            if( !client_connect( "localhost", port, argv[3], argv[4], argv[5] ) ) {
                std::cout << "ERROR " << wire_quote( client_connect_error() ) << std::endl;
                return 0;
            }
            require( client_identity_scope() == "127.0.0.1:" + std::to_string( port ),
                     "identity scope comes from the resolved local request" );
        } else if( mode == "raw" ) {
            require( raw.start_client( "127.0.0.1:" + std::to_string( port ), 991 ), "raw start" );
            const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 5 );
            while( !raw.status().connected && std::chrono::steady_clock::now() < deadline ) {
                std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
            }
            require( raw.status().connected, "raw connect" );
        } else {
            throw std::runtime_error( "unknown mode" );
        }
        std::cout << "READY" << std::endl;
        std::string command;
        while( std::getline( std::cin, command ) && command != "stop" ) {
            if( command == "stop-session" && mode == "host" ) {
                host.stop();
                require( !host.running() && !get_active_server(), "host fully stopped" );
                require( get_mp_queue().empty(), "old session events discarded" );
                std::cout << "STOPPED" << std::endl;
            } else if( command == "restart" && mode == "host" ) {
                require( host.start( port, "口令\"\\", "abc", welcome_data() ), "same port restart" );
                std::cout << "READY" << std::endl;
            } else if( command == "competing-owner" && mode == "host" ) {
                const auto original = get_active_server();
                host_session other;
                require( other.start( 0, "", "abc", welcome_data() ), "independent host owns another context" );
                other.stop();
                require( host.running() && get_active_server() == original, "first owner preserved" );
                std::cout << "OK" << std::endl;
            } else if( command == "destructor-restart" && mode == "host" ) {
                host.stop();
                std::shared_ptr<server> retained;
                {
                    host_session temporary;
                    require( temporary.start( port, "口令\"\\", "abc", welcome_data() ), "temporary owner start" );
                    retained = temporary.active_server();
                    require( retained != nullptr, "temporary owner's server lease" );
                }
                require( !get_active_server() && !retained->running(),
                         "destruction joins even with retained server lease" );
                require( host.start( port, "口令\"\\", "abc", welcome_data() ), "restart after destructor" );
                retained->post_broadcast( "{\"type\":\"old_session\"}" );
                require( host.running(), "old server lease cannot stop replacement" );
                std::cout << "READY" << std::endl;
            } else if( command == "await-queued" && mode == "host" ) {
                const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 3 );
                while( get_mp_queue().empty() && std::chrono::steady_clock::now() < deadline ) {
                    std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
                }
                require( !get_mp_queue().empty(), "actual transport event queued" );
                std::cout << "QUEUED" << std::endl;
            } else if( command.compare( 0, 11, "start-port " ) == 0 && mode == "host" ) {
                const auto requested = static_cast<uint16_t>( std::stoi( command.substr( 11 ) ) );
                const bool started = host.start( requested, "口令\"\\", "abc", welcome_data() );
                std::cout << ( started ? "READY" : "ERROR " + wire_quote( host.error() ) ) << std::endl;
            } else if( command == "worker-failure" && mode == "host" ) {
                get_active_server()->post_broadcast( std::string( 8 * 1024 * 1024 + 1, 'x' ) );
                const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 3 );
                while( host.running() && std::chrono::steady_clock::now() < deadline ) {
                    std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
                }
                require( !host.running(), "invalid packet ends worker" );
                require( host.start( port, "口令\"\\", "abc", welcome_data() ), "recover after worker exit" );
                std::cout << "READY" << std::endl;
            } else if( command.compare( 0, 7, "reject " ) == 0 && mode == "host" ) {
                get_active_server()->post_reject( admissions.at( std::stoull( command.substr( 7 ) ) ),
                                                  "Owner rejected player identity" );
                std::cout << "OK" << std::endl;
            } else if( command == "competing-client" ) {
                const std::string scope = owned_client.identity_scope();
                const std::string error = owned_client.error();
                {
                    client_connection other;
                    other.set_enabled( true );
                    require( other.connect( "127.0.0.1", port, "other", "口令\"\\", "abc" ),
                             "independent connection owns its own transport" );
                    require( other.pending_admission() && other.connected(), "independent probe succeeds" );
                }
                require( mode == "host" ? host.running() : owned_client.connected(),
                         "destroying another connection preserves original transport" );
                require( owned_client.identity_scope() == scope && owned_client.error() == error,
                         "other connection state stays private" );
                std::cout << "OK" << std::endl;
            } else if( command == "pending-setup" && mode == "client" ) {
                const std::string welcome = owned_client.welcome();
                const std::string scope = owned_client.identity_scope();
                require( owned_client.pending_admission(), "menu probe is pending admission" );
                owned_client.prepare_for_world_load();
                require( owned_client.pending_admission() && owned_client.connected(),
                         "initial setup preserves the pending probe" );
                require( owned_client.welcome() == welcome && owned_client.identity_scope() == scope,
                         "pending metadata survives initial setup" );
                std::cout << "OK" << std::endl;
            } else if( command == "world-reset" && mode == "client" ) {
                require( owned_client.join_is_sent(), "live client before world replacement" );
                owned_client.prepare_for_world_load();
                std::string message;
                require( !is_client_mode() && !owned_client.join_is_sent() &&
                         !owned_client.pending_admission() && !owned_client.recv_pop( message ),
                         "world replacement retires joined state and queues" );
                require( owned_client.identity_scope().empty() && owned_client.welcome().empty() &&
                         owned_client.error().empty() && !owned_client.transport_running(),
                         "world replacement releases transport and private metadata" );
                std::cout << "STOPPED" << std::endl;
            } else if( command == "reconnect-client" && mode == "client" ) {
                set_client_mode( true );
                require( client_connect( "localhost", port, argv[3], argv[4], argv[5] ),
                         "same process starts a fresh client attempt" );
                require( !client_join_is_sent(), "new connection cannot inherit old join" );
                std::cout << "READY" << std::endl;
            } else if( command == "destructor-client" && mode == "client" ) {
                require( !owned_client.transport_running(), "no live owner before destructor case" );
                {
                    client_connection temporary;
                    temporary.set_enabled( true );
                    require( temporary.connect( "localhost", port, argv[3], argv[4], argv[5] ),
                             "temporary client probes host" );
                    require( temporary.pending_admission(), "temporary pending admission" );
                }
                require( !owned_client.transport_running() && !owned_client.pending_admission(),
                         "client destruction releases pending transport" );
                std::cout << "OK" << std::endl;
            } else if( command == "join-invalid" ) {
                client_send_join( {} );
                require( !client_join_is_sent(), "invalid profile must not join" );
                std::cout << "OK" << std::endl;
            } else if( command == "join" ) {
                client_send_join( { player_id( std::string( 32, '1' ) ), std::string( 64, 'a' ) } );
                std::cout << "OK" << std::endl;
            } else if( command.compare( 0, 5, "send " ) == 0 ) {
                if( mode == "host" ) {
                    get_active_server()->post_broadcast( command.substr( 5 ) );
                } else if( mode == "raw" ) {
                    raw.send( 0, renet_channel::reliable_ordered, command.substr( 5 ) );
                } else {
                    client_send( command.substr( 5 ) );
                }
                std::cout << "OK" << std::endl;
            } else if( command == "next" ) {
                const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 3 );
                bool found = false;
                do {
                    if( mode == "host" ) {
                        mp_event event;
                        if( get_mp_queue().pop( event ) ) {
                            require( event.evt_type != mp_event::type::connect || event.player.valid(),
                                     "connect event owns validated credentials" );
                            admissions[event.admission.peer_id()] = event.admission;
                            std::cout << "EVENT " << static_cast<int>( event.evt_type ) << ' ' << event.admission.peer_id() <<
                            ' ' <<
                                      wire_quote( event.display_name ) << ' ' << wire_quote( event.data ) << std::endl;
                            found = true;
                        }
                    } else if( mode == "raw" ) {
                        const auto packets = raw.drain( 1 );
                        if( !packets.empty() ) {
                            std::string message;
                            require( decode_game_packet( packets[0].payload, message ), "raw decode" );
                            std::cout << "MESSAGE " << message << std::endl;
                            found = true;
                        }
                    } else {
                        std::string message;
                        if( client_recv_pop( message ) ) {
                            std::cout << "MESSAGE " << message << std::endl;
                            found = true;
                        }
                    }
                    if( !found ) {
                        std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
                    }
                } while( !found && std::chrono::steady_clock::now() < deadline );
                if( !found ) {
                    std::cout << "EMPTY" << std::endl;
                }
            }
        }
        if( mode == "host" ) {
            host.stop();
        } else {
            set_client_mode( false );
            raw.reset();
        }
        return 0;
    } catch( const std::exception &error ) {
        std::cerr << "FAIL: " << error.what() << '\n';
        return 1;
    }
}
