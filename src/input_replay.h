#pragma once
#ifndef CATA_SRC_INPUT_REPLAY_H
#define CATA_SRC_INPUT_REPLAY_H

#include <cstddef>
#include <stdexcept>
#include <string>

#include "input_enums.h" // IWYU pragma: keep  (input_event)

// Deterministic input record/replay harness — phase 0.5 of the sim/render
// decoupling work (a build target that runs the game loop headlessly for tests
// and reproducible replay).
//
// Goal: capture the stream of input_events from an interactive session, then
// feed the exact same stream back during a headless re-run so that, given the
// same RNG seed, the resulting world state is byte-for-byte identical. This is
// the safety net that lets later refactors prove "behaviour unchanged" by
// replaying a recording and diffing the serialized world.
//
// The record/replay decision is driven by the global `replay_mode` flag
// (cached_options.h). The platform get_input_event() implementations call into
// this module: next_event() to source an event without polling the platform,
// and on_record() to log a freshly-polled event.
namespace input_replay
{

// Unwinds a replay out of a nested input loop without polling physical input
// or attempting a re-entrant save. The executable reports a failed run.
class replay_error : public std::runtime_error
{
    public:
        using std::runtime_error::runtime_error;
};

// Begin recording to `path`. Sets replay_mode = record. Returns false (and
// leaves replay_mode unchanged) if the file cannot be opened.
bool begin_record( const std::string &path, std::string *error = nullptr );

// Begin replaying from `path`, which must have been produced by begin_record().
// Sets replay_mode = replay and loads the seed (see recorded_seed()). Returns
// false if the file cannot be opened or parsed, without replacing active input.
// Errors are returned to the caller; these functions never open an input dialog.
bool begin_replay( const std::string &path, std::string *error = nullptr );

// Flush & close any open record/replay stream and reset replay_mode to off.
void finish();

// True while a recording is being written / a replay is being consumed.
bool is_recording();
bool is_replaying();

// Append `ev` to the recording. No-op unless is_recording(). Called by each
// platform get_input_event() after it produces a real event.
void on_record( const input_event &ev );

// If is_replaying() and events remain, fill `out` with the next recorded event
// and return true. Returns false on exhaustion without marking an input failure;
// platform input uses next_event() so exhaustion cannot poll live input.
bool try_replay( input_event &out );

// Return the next recorded event or throw replay_error. Exhaustion inside an
// input loop is a failed recording, not permission to read keyboard/mouse input.
input_event next_event();
bool had_input_failure();
std::size_t total_events();

// True exactly once, on the first query after the replay queue drains. The main
// loop polls this to save-and-quit cleanly when a replay finishes, instead of
// spinning forever feeding timeouts to a game that is waiting for input.
// Returns false when not replaying or when the queue was already empty before
// replay began.
bool replay_just_finished();

// Number of events still queued for replay (0 if not replaying). Non-consuming;
// used for diagnostics and completion validation.
int replay_remaining();

// The RNG seed stored in the replay log header. Valid after begin_replay().
// The harness applies this via rng_set_engine_seed() so the run is reproducible.
unsigned int recorded_seed();

// Seed written into the header by begin_record(). The recorder is responsible
// for having pinned the engine to this seed (see rng.cpp).
void set_record_seed( unsigned int seed );

} // namespace input_replay

#endif // CATA_SRC_INPUT_REPLAY_H
