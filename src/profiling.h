#pragma once
#ifndef CATA_SRC_PROFILING_H
#define CATA_SRC_PROFILING_H

// Profiling wrapper for Tracy.
//
// Source files include this header and use the ZoneScoped / FrameMark macros
// unconditionally.  When the CMake option TRACY=ON is set, TRACY_ENABLE is
// defined globally and the real Tracy macros are pulled in.  When TRACY=OFF
// (the default, including release builds), every macro expands to nothing, so
// there is zero runtime overhead and no system dependency on the tracy headers.
//
// Usage:
//   #include "profiling.h"
//   void expensive() {
//       ZoneScoped;                 // scopes the function body
//       ...
//       ZoneText( str, len );       // optional annotation
//   }
//   // at the end of a frame / turn:
//   FrameMark;

#if defined( TRACY_ENABLE )

    #include "tracy/Tracy.hpp"
    #include "tracy/TracyC.h"

    // Tracy already defines ZoneScoped, ZoneScopedN, ZoneText, FrameMark, etc.
    // Provide a couple of convenience aliases so call sites read naturally.
    #define CATA_FRAME_MARK FrameMark
    #define CATA_ZONE_TEXT( txt ) ZoneText( txt, static_cast<int>( sizeof( txt ) - 1 ) )

#else // !TRACY_ENABLE

    // No-op stubs.  These must be empty (not do{}while(0)) because ZoneScoped is
    // typically placed as a bare statement and may also be used inside the
    // prologue of an expression-bearing lambda.
    #define ZoneScoped
    #define ZoneScopedN( name )
    #define ZoneText( txt, size )
    #define ZoneTextV( txt, size )
    #define FrameMark
    #define FrameMarkNamed( name )
    #define ZoneName( txt, size )
    #define ZoneTextS( txt, size, depth )
    #define TracyPlot( name, val )
    #define TracyPlotConfig( name, type )

    #define CATA_FRAME_MARK
    #define CATA_ZONE_TEXT( txt )

#endif // TRACY_ENABLE

#endif // CATA_SRC_PROFILING_H
