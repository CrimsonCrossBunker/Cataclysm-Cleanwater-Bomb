#pragma once
#ifndef CATA_SRC_SDLSOUND_H
#define CATA_SRC_SDLSOUND_H

#include <chrono>
#include <cstdint>
#include <optional>
#include <string>
#include <string_view>
#if defined(SDL_SOUND)

/**
 * Attempt to initialize an audio device.  Returns false if initialization fails.
 */
bool init_sound();
void initSDLAudioOnly();
void shutdown_sound();
void play_music( std::string_view playlist );
void set_temporary_music( std::string_view playlist );
void clear_temporary_music();
void stop_music();
void update_music_volume();
void load_soundset();
extern bool sound_init_success;

namespace sfx
{
struct melee_sound_sequence;
struct queued_sound;
void queue_melee_sound( melee_sound_sequence sequence );
void queue_gunshot( queued_sound sound, std::chrono::steady_clock::time_point burst_start,
                    int rpm, int shot_index );
// Main-thread presentation pump and world/audio lifetime cleanup.
void process_queued_sounds();
std::optional<uint32_t> queued_sound_wait_ms();
void clear_queued_sounds();
}

#else

inline bool init_sound()
{
    return false;
}
inline void shutdown_sound() { }
inline void play_music( std::string_view /*playlist*/ )
{
}
inline void set_temporary_music( std::string_view /*playlist*/ )
{
}
inline void clear_temporary_music()
{
}
inline void update_music_volume() { }
inline void load_soundset() { }

#endif

#endif // CATA_SRC_SDLSOUND_H
