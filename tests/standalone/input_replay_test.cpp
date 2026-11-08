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

void round_trip( const std::filesystem::path &path )
{
    input_replay::finish();
    const std::locale original;
    std::locale::global( std::locale( original, new grouped_numbers ) );
    input_replay::set_record_seed( std::numeric_limits<unsigned int>::max() );
    std::string error;
    check( input_replay::begin_record( path.string(), &error ), "start recording" );
    input_event event( 119, input_event_t::keyboard_code );
    event.modifiers = { keymod_t::ctrl, keymod_t::alt, keymod_t::shift };
    event.mouse_pos = point( -2, 37 );
    event.text = "汉字 % -\n\t";
    event.edit = "-";
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
    check( input_replay::replay_remaining() == 0, "queue drained" );
    check( input_replay::replay_just_finished(), "completion only after final event" );
    check( !input_replay::replay_just_finished(), "completion is one-shot" );
    std::locale::global( original );
    input_replay::finish();
}

void malformed_logs( const std::filesystem::path &path )
{
    const std::string valid = "CATA_REPLAY 1\nSEED 19\nEV 2 0 1 46 0 0 - -\n";
    const std::vector<std::string> invalid = {
        "", "CATA_REPLAY 2\nSEED 19\nEV 2 0 1 46 0 0 - -\n",
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
