# Query Git itself: linked worktrees use a .git file and shared refs, which
# cannot be resolved by treating .git as a normal checkout directory.
if (GIT_BINARY)
    set(GIT_EXECUTABLE "${GIT_BINARY}")
else ()
    find_package(Git QUIET)
endif ()

set(DESCRIBE_RESULT "unavailable")
if (GIT_EXECUTABLE)
    execute_process(
        COMMAND "${GIT_EXECUTABLE}" -c core.safecrlf=false
                describe --tags --always --match "cdda-*"
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        RESULT_VARIABLE DESCRIBE_RESULT
        OUTPUT_VARIABLE BUILD_VERSION
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_QUIET)
endif ()

set(VERSION_HEADER "${CMAKE_SOURCE_DIR}/src/version.h")
set(OLD_HEADER "")
if (EXISTS "${VERSION_HEADER}")
    file(READ "${VERSION_HEADER}" OLD_HEADER)
endif ()

if (DESCRIBE_RESULT STREQUAL "0" AND NOT BUILD_VERSION STREQUAL "")
    execute_process(
        COMMAND "${GIT_EXECUTABLE}" -c core.safecrlf=false diff --quiet HEAD
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        RESULT_VARIABLE DIRTY_RESULT)
    if (DIRTY_RESULT STREQUAL "1")
        string(APPEND BUILD_VERSION "-dirty")
    endif ()
    string(TIMESTAMP BUILD_DATE "%Y-%m-%d")
    string(PREPEND BUILD_VERSION "${BUILD_DATE}-")
    string(REPLACE "\\" "\\\\" ESCAPED_VERSION "${BUILD_VERSION}")
    string(REPLACE "\"" "\\\"" ESCAPED_VERSION "${ESCAPED_VERSION}")
    set(NEW_HEADER "// NOLINT(cata-header-guard)\n#define VERSION \"${ESCAPED_VERSION}\"\n")

    execute_process(
        COMMAND "${GIT_EXECUTABLE}" rev-parse HEAD
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
        OUTPUT_VARIABLE COMMIT_SHA
        OUTPUT_STRIP_TRAILING_WHITESPACE)
    string(TIMESTAMP BUILD_TIMESTAMP "%Y-%m-%d-%H%M")
    file(WRITE "${CMAKE_SOURCE_DIR}/VERSION.txt" "\
build type: Release\n\
build number: ${BUILD_TIMESTAMP}\n\
commit sha: ${COMMIT_SHA}\n\
commit url: https://github.com/CleverRaven/Cataclysm-DDA/commit/${COMMIT_SHA}")
else ()
    # Preserve version metadata shipped in a source archive. A fresh export
    # without Git or a generated header must still compile on every platform.
    string(REGEX MATCH "#define VERSION \"([^\"]+)\"" EXISTING_VERSION "${OLD_HEADER}")
    if (EXISTING_VERSION)
        set(BUILD_VERSION "${CMAKE_MATCH_1}")
        set(NEW_HEADER "${OLD_HEADER}")
    else ()
        set(BUILD_VERSION "unknown")
        set(NEW_HEADER "// NOLINT(cata-header-guard)\n#define VERSION \"unknown\"\n")
    endif ()
endif ()

if (NOT NEW_HEADER STREQUAL OLD_HEADER)
    file(WRITE "${VERSION_HEADER}" "${NEW_HEADER}")
endif ()
message(NOTICE "${BUILD_VERSION}")
