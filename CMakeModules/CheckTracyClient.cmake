# A discoverable Tracy library may have been built with profiling disabled.
# Validate the same wrapper/definitions used by the game before compiling it.
include(CheckCXXSourceCompiles)
include(CMakePushCheckState)

function(ccb_check_tracy_client)
    cmake_push_check_state(RESET)
    # Match the game target: third-party headers are SYSTEM includes even
    # when project warnings are promoted to errors.
    add_library(cata_tracy_link_probe UNKNOWN IMPORTED)
    set_target_properties(cata_tracy_link_probe PROPERTIES
        IMPORTED_LOCATION "${TRACY_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${TRACY_INCLUDE_DIR}"
        INTERFACE_SYSTEM_INCLUDE_DIRECTORIES "${TRACY_INCLUDE_DIR}")
    set(CMAKE_REQUIRED_INCLUDES "${CMAKE_CURRENT_FUNCTION_LIST_DIR}/../src")
    set(CMAKE_REQUIRED_DEFINITIONS -DTRACY_ENABLE)
    # Cross toolchains can otherwise turn this into a compile-only check.
    set(CMAKE_TRY_COMPILE_TARGET_TYPE EXECUTABLE)
    set(CMAKE_REQUIRED_LIBRARIES cata_tracy_link_probe Threads::Threads ${CMAKE_DL_LIBS})
    # A user can replace the library or header configuration in an existing
    # build tree; a cached successful link must not hide an incompatible client.
    unset(CATA_TRACY_CLIENT_LINKS CACHE)
    check_cxx_source_compiles([=[
        #include "profiling.h"
        int main()
        {
            CATA_PROFILE_SCOPE_NAMED("ccb.cmake.tracy_probe");
            CATA_PROFILE_FRAME();
            CATA_PROFILE_PLOT("ccb.cmake.tracy_probe", 1.0);
            return 0;
        }
    ]=] CATA_TRACY_CLIENT_LINKS)
    cmake_pop_check_state()
    if(NOT CATA_TRACY_CLIENT_LINKS)
        message(FATAL_ERROR
            "TRACY=ON found headers and a client library, but enabled profiling cannot link.\n"
            "Build the Tracy client with TRACY_ENABLE=ON and matching configuration, then set\n"
            "TRACY_INCLUDE_DIR and TRACY_LIBRARY to that client. See the CMake configure log.")
    endif()
endfunction()
