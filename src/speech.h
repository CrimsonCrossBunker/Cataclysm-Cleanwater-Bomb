#pragma once
#ifndef CATA_SRC_SPEECH_H
#define CATA_SRC_SPEECH_H

#include <string>
#include <string_view>
#include <vector>

#include "translation.h"

class JsonObject;

struct SpeechBubble {
    translation text;
    int volume = 0;
};

void load_speech( const JsonObject &jo );
void reset_speech();
const SpeechBubble &get_speech( const std::string &label );

namespace cata::lua_platform::detail
{
const std::vector<SpeechBubble> *speech_registry_find( std::string_view label );
void speech_registry_set( const std::string &label, std::vector<SpeechBubble> lines );
void speech_registry_erase( std::string_view label );
} // namespace cata::lua_platform::detail

#endif // CATA_SRC_SPEECH_H
