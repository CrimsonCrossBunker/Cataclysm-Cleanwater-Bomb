#pragma once
#ifndef CATA_SRC_PROFILING_H
#define CATA_SRC_PROFILING_H

// Profiling wrapper for Tracy.
//
// Source files include this header and use only the CATA_PROFILE_* macros.
// When the CMake option TRACY=ON is set, TRACY_ENABLE is defined globally and
// the macros forward to Tracy.  When TRACY=OFF (the default, including release
// builds), every macro expands to nothing, so there is zero runtime overhead
// and no system dependency on the Tracy headers.
//
// Usage:
//   #include "profiling.h"
//   void expensive() {
//       CATA_PROFILE_SCOPE();       // scopes the function body
//       ...
//       CATA_PROFILE_TEXT( str, len ); // optional annotation
//   }
//   // at the end of a frame / turn:
//   CATA_PROFILE_FRAME();

#if defined( TRACY_ENABLE )

    #include "tracy/Tracy.hpp"
    #include "tracy/TracyC.h"

    #define CATA_PROFILE_SCOPE() ZoneScoped
    #define CATA_PROFILE_SCOPE_NAMED( name ) ZoneScopedN( name )
    #define CATA_PROFILE_TEXT( txt, size ) ZoneText( txt, size )
    #define CATA_PROFILE_LITERAL( txt ) ZoneText( txt, static_cast<int>( sizeof( txt ) - 1 ) )
    #define CATA_PROFILE_FRAME() FrameMark
    #define CATA_PROFILE_FRAME_NAMED( name ) FrameMarkNamed( name )
    #define CATA_PROFILE_PLOT( name, value ) TracyPlot( name, value )

#else // !TRACY_ENABLE

    #define CATA_PROFILE_SCOPE() do { } while( false )
    #define CATA_PROFILE_SCOPE_NAMED( name ) do { } while( false )
    #define CATA_PROFILE_TEXT( txt, size ) do { } while( false )
    #define CATA_PROFILE_LITERAL( txt ) do { } while( false )
    #define CATA_PROFILE_FRAME() do { } while( false )
    #define CATA_PROFILE_FRAME_NAMED( name ) do { } while( false )
    #define CATA_PROFILE_PLOT( name, value ) do { } while( false )

#endif // TRACY_ENABLE

#endif // CATA_SRC_PROFILING_H
