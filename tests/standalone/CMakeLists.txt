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
    "${CCB_ROOT}/src/player_identity.cpp"
    "${CCB_ROOT}/src/identity_random.cpp"
    "${CCB_ROOT}/src/cached_options.cpp")
target_include_directories(input_replay_test PRIVATE "${CCB_ROOT}/src")
target_include_directories(input_replay_test SYSTEM PRIVATE "${CCB_ROOT}/src/third-party")
add_test(NAME input_replay_protocol COMMAND input_replay_test)

find_package(Threads REQUIRED)
add_executable(compute_resources_test
    compute_resources_test.cpp
    "${CCB_ROOT}/src/thread_pool.cpp"
    "${CCB_ROOT}/src/compute_budget.cpp")
target_include_directories(compute_resources_test PRIVATE "${CCB_ROOT}/src")
target_link_libraries(compute_resources_test PRIVATE Threads::Threads)
add_test(NAME compute_resources COMMAND compute_resources_test)
set_tests_properties(compute_resources PROPERTIES TIMEOUT 30)

# The allocation override uses posix_memalign. Keep this fault-injection driver
# separate from native test binaries and from Windows builds.
if(UNIX)
    add_executable(ai_reachability_fault_test
        ai_reachability_fault_test.cpp
        "${CCB_ROOT}/src/ai_reachability.cpp"
        "${CCB_ROOT}/src/thread_pool.cpp"
        "${CCB_ROOT}/src/compute_budget.cpp")
    target_include_directories(ai_reachability_fault_test PRIVATE "${CCB_ROOT}/src")
    target_include_directories(ai_reachability_fault_test SYSTEM PRIVATE
        "${CCB_ROOT}/src/third-party")
    target_compile_options(ai_reachability_fault_test PRIVATE -UNDEBUG)
    target_link_libraries(ai_reachability_fault_test PRIVATE Threads::Threads)
    add_test(NAME ai_reachability_fault COMMAND ai_reachability_fault_test)
    set_tests_properties(ai_reachability_fault PROPERTIES TIMEOUT 30)
endif()
