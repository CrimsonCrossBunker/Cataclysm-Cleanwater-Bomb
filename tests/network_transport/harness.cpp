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
void mp_log( const std::string &msg )
{
    std::cerr << msg << '\n';
}
unsigned int mp_host_world_seed()
{
    return 12345;
}
std::string mp_get_host_world_name()
{
    return "测试世界\"\\\n";
}
std::string mp_get_host_player_name()
{
    return "主机角色";
}
std::string mp_host_omt_welcome_field()
{
    return ",\"spawn_omt\":[1,2,0]";
}
void mp_set_client_host_world_name( const std::string & ) {}
void mp_set_client_host_player_name( const std::string & ) {}
void mp_store_pending_welcome( const std::string & ) {}
}

using namespace cata_mp;

static void require( bool condition, const char *message )
{
    if( !condition ) {
        throw std::runtime_error( message );
    }
}

static void protocol_tests()
{
    std::map<std::string, std::string> fields;
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
        if( argc == 2 && std::string( argv[1] ) == "unit" ) {
            protocol_tests();
            return 0;
        }
        require( argc >= 3, "mode port required" );
        const std::string mode = argv[1];
        const uint16_t port = std::stoi( argv[2] );
        host_session host;
        if( mode == "host" ) {
            if( !host.start( port, "口令\"\\", "abc" ) ) {
                std::cout << "ERROR " << wire_quote( host.error() ) << std::endl;
                return 0;
            }
        } else if( mode == "client" ) {
            require( argc == 6, "client port name password version required" );
            if( !client_connect( "localhost", port, argv[3], argv[4], argv[5] ) ) {
                std::cout << "ERROR " << wire_quote( client_connect_error() ) << std::endl;
                return 0;
            }
        } else if( mode == "raw" ) {
            require( renet_transport_start_client( "127.0.0.1:" + std::to_string( port ), 991 ), "raw start" );
            const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 5 );
            while( !renet_transport_get_status().connected && std::chrono::steady_clock::now() < deadline ) {
                std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
            }
            require( renet_transport_get_status().connected, "raw connect" );
        } else {
            throw std::runtime_error( "unknown mode" );
        }
        std::cout << "READY" << std::endl;
        std::string command;
        while( std::getline( std::cin, command ) && command != "stop" ) {
            if( command == "stop-session" && mode == "host" ) {
                host.stop();
                require( !host.running() && !get_active_server(), "host fully stopped" );
                require( !renet_transport_get_status().running, "transport fully stopped" );
                require( get_mp_queue().empty(), "old session events discarded" );
                std::cout << "STOPPED" << std::endl;
            } else if( command == "restart" && mode == "host" ) {
                require( host.start( port, "口令\"\\", "abc" ), "same port restart" );
                std::cout << "READY" << std::endl;
            } else if( command == "competing-owner" && mode == "host" ) {
                const auto original = get_active_server();
                host_session other;
                require( !other.start( 0, "", "abc" ), "second owner rejected" );
                other.stop();
                require( host.running() && get_active_server() == original, "first owner preserved" );
                std::cout << "OK" << std::endl;
            } else if( command == "destructor-restart" && mode == "host" ) {
                host.stop();
                std::shared_ptr<server> retained;
                {
                    host_session temporary;
                    require( temporary.start( port, "口令\"\\", "abc" ), "temporary owner start" );
                    retained = get_active_server();
                }
                require( !get_active_server() && !renet_transport_get_status().running,
                         "destruction joins even with retained server lease" );
                require( host.start( port, "口令\"\\", "abc" ), "restart after destructor" );
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
                const bool started = host.start( requested, "口令\"\\", "abc" );
                std::cout << ( started ? "READY" : "ERROR " + wire_quote( host.error() ) ) << std::endl;
            } else if( command == "worker-failure" && mode == "host" ) {
                get_active_server()->post_broadcast( std::string( 8 * 1024 * 1024 + 1, 'x' ) );
                const auto deadline = std::chrono::steady_clock::now() + std::chrono::seconds( 3 );
                while( host.running() && std::chrono::steady_clock::now() < deadline ) {
                    std::this_thread::sleep_for( std::chrono::milliseconds( 5 ) );
                }
                require( !host.running(), "invalid packet ends worker" );
                require( host.start( port, "口令\"\\", "abc" ), "recover after worker exit" );
                std::cout << "READY" << std::endl;
            } else if( command == "join" ) {
                client_send_join();
                std::cout << "OK" << std::endl;
            } else if( command.compare( 0, 5, "send " ) == 0 ) {
                if( mode == "host" ) {
                    get_active_server()->post_broadcast( command.substr( 5 ) );
                } else if( mode == "raw" ) {
                    renet_transport_send( 0, renet_channel::reliable_ordered, command.substr( 5 ) );
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
                            std::cout << "EVENT " << static_cast<int>( event.evt_type ) << ' ' << event.peer_id << ' ' <<
                                      wire_quote( event.session_id ) << ' ' << wire_quote( event.data ) << std::endl;
                            found = true;
                        }
                    } else if( mode == "raw" ) {
                        const auto packets = renet_transport_drain( 1 );
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
            renet_transport_stop();
        }
        return 0;
    } catch( const std::exception &error ) {
        std::cerr << "FAIL: " << error.what() << '\n';
        return 1;
    }
}
