// Links the real replay implementation and cached options; no game-code stubs.
// Checks remain enabled in Release. Run through tests/standalone/CMakeLists.txt.
#include <chrono>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <iterator>
#include <limits>
#include <locale>
#include <stdexcept>
#include <string>
#include <vector>

#include "input_replay.h"

namespace
{
std::size_t checks = 0;

void check( bool value, const std::string &message )
{
    ++checks;
    if( !value ) {
        throw std::runtime_error( message );
    }
}

void write( const std::filesystem::path &path, const std::string &text )
{
    std::ofstream output( path, std::ios::binary | std::ios::trunc );
    output << text;
    output.close();
    check( output.good(), "writing fixture" );
}

std::string read( const std::filesystem::path &path )
{
    std::ifstream input( path, std::ios::binary );
    return std::string( std::istreambuf_iterator<char>( input ), {} );
}

struct grouped_numbers : std::numpunct<char> {
    char do_thousands_sep() const override {
        return ',';
    }
    std::string do_grouping() const override {
        return "\3";
    }
};

void profile_identity_round_trip( const std::filesystem::path &path )
{
    input_replay::finish();
    check( !input_replay::next_profile_identity( "slot" ), "inactive identity stream" );
    check( input_replay::begin_record( path.string() ), "record identity seed" );
    const auto first = input_replay::next_profile_identity( "first slot" );
    const auto second = input_replay::next_profile_identity( "second slot" );
    check( first && second && *first != *second && first->size() == 32, "distinct profile IDs" );
    input_replay::on_record( input_event( 46, input_event_t::keyboard_code ) );
    input_replay::finish();
    check( read( path ).find( "CATA_REPLAY 3\n" ) == 0, "new recordings use v3" );
    check( input_replay::begin_replay( path.string() ), "load recorded identity seed" );
    check( input_replay::next_profile_identity( "renamed slot" ) == first,
           "v2 identity is independent of a legacy filename" );
    const std::string valid_recording = read( path );
    write( path, "CATA_REPLAY 2\nSEED 19\nPROFILE_SEED invalid\nEV 2 0 1 46 0 0 - -\n" );
    check( !input_replay::begin_replay( path.string() ), "reject invalid identity seed" );
    check( input_replay::next_profile_identity( "another slot" ) == second,
           "failed replacement retains identity stream position" );
    write( path, valid_recording );
    check( input_replay::begin_replay( path.string() ), "restart valid recording" );
    check( input_replay::next_profile_identity( "slot" ) == first, "replay resets identity stream" );
    check( input_replay::replay_remaining() == 1, "identities do not consume input events" );
    input_replay::finish();

    const std::string legacy = "CATA_REPLAY 1\nSEED 19\nEV 2 0 1 46 0 0 - -\n";
    write( path, legacy );
    check( input_replay::begin_replay( path.string() ), "old recordings still load" );
    const auto old_first = input_replay::next_profile_identity( "first saved player" );
    const auto old_second = input_replay::next_profile_identity( "first saved player" );
    check( old_first && old_second && old_first != old_second, "legacy allocation sequence" );
    check( *old_first == "92ea3d5fa8f28457ed8e015444f25335" &&
           *old_second == "92ea3d5fa8f28457ed8e015444f25336", "legacy identity protocol golden values" );
    check( input_replay::begin_replay( path.string() ), "restart old recording" );
    check( input_replay::next_profile_identity( "first saved player" ) == old_first,
           "legacy migration is reproducible" );
    check( input_replay::begin_replay( path.string() ), "restart with another save" );
    check( input_replay::next_profile_identity( "second saved player" ) != old_first,
           "legacy recording disambiguates distinct save slots" );
    write( path, legacy + "EV 2 0 1 119 0 0 - -\n" );
    check( input_replay::begin_replay( path.string() ), "different old recording" );
    check( input_replay::next_profile_identity( "first saved player" ) != old_first,
           "legacy recording identity includes the input stream" );
    input_replay::finish();
    check( !input_replay::next_profile_identity( "slot" ), "finish clears identity state" );
    write( path,
           "CATA_REPLAY 2\nSEED 19\nPROFILE_SEED 0000000000000001ffffffffffffffff\nEV 2 0 1 46 0 0 - -\n" );
    check( input_replay::begin_replay( path.string() ), "load identity carry boundary" );
    check( input_replay::next_profile_identity( "slot" ) == "0000000000000001ffffffffffffffff",
           "v2 first identity equals recorded public seed" );
    check( input_replay::next_profile_identity( "slot" ) == "00000000000000020000000000000000",
           "v2 identity sequence carries into the high half" );
    input_replay::finish();
}

void round_trip( const std::filesystem::path &path )
{
    input_replay::finish();
    const std::locale original;
    std::locale::global( std::locale( original, new grouped_numbers ) );
    input_replay::set_record_seed( std::numeric_limits<unsigned int>::max() );
    std::string error;
    check( input_replay::begin_record( path.string(), &error ), "start recording" );
    input_event event( MouseInput::LeftButtonPressed, input_event_t::mouse );
    event.modifiers = { keymod_t::ctrl, keymod_t::alt, keymod_t::shift };
    event.mouse_pos = point( -2, 37 );
    event.text = "汉字 % -\n\t";
    event.edit = "-";
    event.camera = camera_input{ 2, point( 127, 9 ) };
    event.map_click = tripoint( -12, 35, -1 );
    input_replay::on_record( input_event() );
    input_replay::on_record( input_event( 0, input_event_t::timeout ) );
    input_replay::on_record( input_event( MouseInput::Move, input_event_t::mouse ) );
    input_replay::on_record( event );
    check( !input_replay::begin_replay( path.string(), &error ), "cannot replay a live recording" );
    check( input_replay::is_recording(), "failed replay keeps recorder" );
    input_replay::finish();
    check( read( path ).find( "SEED 4294967295\n" ) != std::string::npos,
           "recording is locale neutral" );
    check( input_replay::begin_replay( path.string(), &error ), "round-trip load" );
    check( error.empty(), "success clears old error" );
    check( input_replay::recorded_seed() == std::numeric_limits<unsigned int>::max(), "seed" );
    check( input_replay::total_events() == 1, "poll artifacts are not recorded" );
    const input_event decoded = input_replay::next_event();
    check( decoded.type == event.type && decoded.sequence == event.sequence, "keys and type" );
    check( decoded.modifiers == event.modifiers &&
           decoded.mouse_pos == event.mouse_pos, "modifiers/mouse" );
    check( decoded.text == event.text && decoded.edit == event.edit, "escaped Unicode text" );
    check( decoded.camera && decoded.camera->octant == 2 &&
           decoded.camera->forward == point( 127, 9 ) &&
           decoded.camera->map_direction( point::north ) == point::east, "spatial camera" );
    check( decoded.map_click == event.map_click, "absolute map click" );
    check( input_replay::replay_remaining() == 0, "queue drained" );
    check( input_replay::replay_just_finished(), "completion only after final event" );
    check( !input_replay::replay_just_finished(), "completion is one-shot" );
    std::locale::global( original );
    input_replay::finish();
}

void malformed_logs( const std::filesystem::path &path )
{
    const std::string valid = "CATA_REPLAY 1\nSEED 19\nEV 2 0 1 46 0 0 - -\n";
    const std::string spatial_header =
        "CATA_REPLAY 3\nSEED 19\nPROFILE_SEED 0123456789abcdef0123456789abcdef\n";
    const std::vector<std::string> invalid = {
        "", "CATA_REPLAY 2\nSEED 19\nEV 2 0 1 46 0 0 - -\n",
        "CATA_REPLAY 3\nSEED 19\nEV 2 0 1 46 0 0 - -\n",
        "CATA_REPLAY 2\nSEED 19\nPROFILE_SEED AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\nEV 2 0 1 46 0 0 - -\n",
        "CATA_REPLAY 2\nSEED 19\nPROFILE_SEED 0123456789abcdef0123456789abcdef extra\nEV 2 0 1 46 0 0 - -\n",
        "CATA_REPLAY 2\nSEED 19\nPROFILE_SEED 0123456789abcdef0123456789abcde\nEV 2 0 1 46 0 0 - -\n",
        "CATA_REPLAY 1 extra\nSEED 19\nEV 2 0 1 46 0 0 - -\n",
        "CATA_REPLAY 1\nSEED\n", "CATA_REPLAY 1\nSEED -1\n",
        "CATA_REPLAY 1\nSEED 4294967296\n",
        "CATA_REPLAY 1\nSEED 19 extra\nEV 2 0 1 46 0 0 - -\n",
        "CATA_REPLAY 1\nSEED 19\n", "CATA_REPLAY 1\nSEED 19\nUNKNOWN 1\n",
        "CATA_REPLAY 1\nSEED 19\nEV 2 0 1\n",
        "CATA_REPLAY 1\nSEED 19\nEV -1 0 1 46 0 0 - -\n",
        "CATA_REPLAY 1\nSEED 19\nEV 6 0 1 46 0 0 - -\n",
        "CATA_REPLAY 1\nSEED 19\nEV 2 8 1 46 0 0 - -\n",
        "CATA_REPLAY 1\nSEED 19\nEV 2 -1 1 46 0 0 - -\n",
        "CATA_REPLAY 1\nSEED 19\nEV 2 0 -1 0 0 - -\n",
        "CATA_REPLAY 1\nSEED 19\nEV 2 0 2147483647 46\n",
        "CATA_REPLAY 1\nSEED 19\nEV 2 0 1 99999999999999999 0 0 - -\n",
        "CATA_REPLAY 1\nSEED 19\nEV 2 0 1 46 99999999999999999 0 - -\n",
        "CATA_REPLAY 1\nSEED 19\nEV 2 0 1 46 0 0 -\n",
        "CATA_REPLAY 1\nSEED 19\nEV 2 0 1 46 0 0 % -\n",
        "CATA_REPLAY 1\nSEED 19\nEV 2 0 1 46 0 0 %G0 -\n",
        "CATA_REPLAY 1\nSEED 19\nEV 2 0 1 46 0 0 - %0\n",
        "CATA_REPLAY 1\nSEED 19\nEV 2 0 1 46 0 0 - - extra\n",
        spatial_header + "EV 2 0 1 46 0 0 - - 1 8 127 9\n",
        spatial_header + "EV 2 0 1 46 0 0 - - 1 2 128 128\n",
        spatial_header + "EV 2 0 1 46 0 0 - - 2 -12 35 -1\n",
        spatial_header + "EV 5 0 1 1 0 0 - - 3 2 127 9 -12 35\n",
        valid + "EV 2 0 1 46 0 0 -\n"
    };
    for( const std::string &text : invalid ) {
        input_replay::finish();
        write( path, valid );
        check( input_replay::begin_replay( path.string() ), "prior valid replay" );
        write( path, text );
        std::string error;
        check( !input_replay::begin_replay( path.string(), &error ), "reject: " + text );
        check( !error.empty(), "non-interactive error detail" );
        check( input_replay::is_replaying(), "failed parse preserves active replay" );
        check( input_replay::recorded_seed() == 19, "failed parse preserves seed" );
        check( input_replay::replay_remaining() == 1 && input_replay::total_events() == 1,
               "failed parse cannot publish a partial queue" );
        check( input_replay::next_event().sequence.front() == 46, "prior input preserved" );
    }
    input_replay::finish();
}

void lifecycle( const std::filesystem::path &path )
{
    write( path, "CATA_REPLAY 1\r\nSEED 0\r\n \t\r\nEV 2 0 1 46 0 0 - -\r\n" );
    check( input_replay::begin_replay( path.string() ), "CRLF and blank lines" );
    check( !input_replay::replay_just_finished(), "not finished before input" );
    const std::string original = read( path );
    check( !input_replay::begin_record( path.string() ), "cannot record during replay" );
    check( read( path ) == original, "failed recording cannot truncate active input" );
    input_replay::next_event();
    input_event ignored;
    check( !input_replay::try_replay( ignored ), "nonthrowing inspection" );
    check( !input_replay::had_input_failure(), "inspection is not an input failure" );
    bool unwound = false;
    bool caught = false;
    try {
        struct guard {
            bool &value;
            ~guard() {
                value = true;
            }
        } scope{ unwound };
        input_replay::next_event();
    } catch( const input_replay::replay_error & ) {
        caught = true;
    }
    check( caught && unwound, "exhausted input unwinds nested scope" );
    check( input_replay::had_input_failure(), "caught exhaustion still marks failed replay" );
    input_replay::finish();
    check( !input_replay::is_replaying() && !input_replay::had_input_failure(), "finish resets state" );
    check( input_replay::total_events() == 0, "finish clears counters" );
    std::string error;
    check( !input_replay::begin_replay( ( path / "missing" ).string(), &error ), "missing recording" );
    check( !error.empty() && !input_replay::is_replaying(), "failed open stays inactive" );
}
} // namespace

int main()
{
    const auto stamp = std::chrono::steady_clock::now().time_since_epoch().count();
    const std::filesystem::path scratch = std::filesystem::temp_directory_path() /
                                          ( "ccb-input-replay-" + std::to_string( stamp ) );
    if( !std::filesystem::create_directory( scratch ) ) {
        return 2;
    }
    try {
        const auto path = scratch / "recording.txt";
        profile_identity_round_trip( path );
        round_trip( path );
        malformed_logs( path );
        lifecycle( path );
        std::filesystem::remove_all( scratch );
        std::cout << checks << " replay protocol checks passed\n";
        return 0;
    } catch( const std::exception &error ) {
        input_replay::finish();
        std::cerr << error.what() << "\nFixtures retained: " << scratch << '\n';
        return 1;
    }
}
