cmake_minimum_required(VERSION 3.20)
project(CCBStandaloneTests LANGUAGES CXX)

# These targets link actual production sources without initializing game data
# or building the full engine. They supplement native integration acceptance.
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
find_program(CCB_TEST_CCACHE ccache)
if(CCB_TEST_CCACHE)
    set(CMAKE_CXX_COMPILER_LAUNCHER "${CCB_TEST_CCACHE}")
endif()
enable_testing()

get_filename_component(CCB_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../.." ABSOLUTE)
add_executable(input_replay_test
    input_replay_test.cpp
    "${CCB_ROOT}/src/input_replay.cpp"
    "${CCB_ROOT}/src/cached_options.cpp")
target_include_directories(input_replay_test PRIVATE "${CCB_ROOT}/src")
target_include_directories(input_replay_test SYSTEM PRIVATE "${CCB_ROOT}/src/third-party")
add_test(NAME input_replay_protocol COMMAND input_replay_test)
