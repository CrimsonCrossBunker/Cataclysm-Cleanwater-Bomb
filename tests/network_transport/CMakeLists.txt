cmake_minimum_required(VERSION 3.20)
project(ccb_network_transport_tests LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
get_filename_component(CCB_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../.." ABSOLUTE)
find_package(Threads REQUIRED)
find_library(ZSTD_LIBRARY zstd REQUIRED)
add_executable(network_harness harness.cpp
    ${CCB_ROOT}/src/mp_server.cpp ${CCB_ROOT}/src/mp_client_conn.cpp
    ${CCB_ROOT}/src/mp_renet_transport.cpp ${CCB_ROOT}/src/mp_protocol.cpp
    ${CCB_ROOT}/src/mp_queue.cpp ${CCB_ROOT}/src/json.cpp ${CCB_ROOT}/src/wcwidth.cpp)
target_compile_definitions(network_harness PRIVATE CATA_IN_TOOL)
target_include_directories(network_harness PRIVATE ${CCB_ROOT}/src)
target_include_directories(network_harness SYSTEM PRIVATE ${CCB_ROOT}/src/third-party
    ${CCB_ROOT}/src/third-party/asio/asio/include)
target_link_libraries(network_harness PRIVATE Threads::Threads ${CMAKE_DL_LIBS} ${ZSTD_LIBRARY})
enable_testing()
add_test(NAME protocol COMMAND network_harness unit)
add_library(incompatible_runtime SHARED incompatible_runtime.cpp)
set_target_properties(incompatible_runtime PROPERTIES OUTPUT_NAME ccb_bevy_ecs_coop
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bad-abi"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bad-abi")
find_package(Python3 REQUIRED COMPONENTS Interpreter)
add_test(NAME integration COMMAND ${Python3_EXECUTABLE}
    ${CMAKE_CURRENT_SOURCE_DIR}/run_integration.py $<TARGET_FILE:network_harness>
    --logs ${CMAKE_BINARY_DIR}/integration-logs
    --incompatible-library $<TARGET_FILE:incompatible_runtime>)
