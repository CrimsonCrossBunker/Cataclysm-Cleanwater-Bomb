#pragma once
#ifndef CATA_SRC_ANDROID_NATIVE_UI_H
#define CATA_SRC_ANDROID_NATIVE_UI_H

#if defined(__ANDROID__)

#include <optional>
#include <string>

namespace android_native_ui
{
std::optional<std::string> text_input( const std::string &title,
                                       const std::string &initial_value,
                                       int max_length = 0 );
} // namespace android_native_ui

#endif

#endif // CATA_SRC_ANDROID_NATIVE_UI_H
