# Keep the native C++ ABI adapter available in single-player-only builds too.
set(_COOP_RUNTIME_DEFAULT ON)
if(ANDROID OR EMSCRIPTEN OR CMAKE_CROSSCOMPILING)
    set(_COOP_RUNTIME_DEFAULT OFF)
endif()
option(CATA_BUILD_COOP_RUNTIME "Build and package the Rust multiplayer runtime" ${_COOP_RUNTIME_DEFAULT})
set(CATA_COOP_RUST_TARGET "" CACHE STRING "Rust target triple (required for cross compilation)")
set(CATA_COOP_PROFILE "release" CACHE STRING "Cargo profile: dev or release")
set_property(CACHE CATA_COOP_PROFILE PROPERTY STRINGS dev release)
set(CATA_COOP_BUILD_FLAGS "" CACHE STRING "Extra build-coop-runtime.py arguments, as a CMake list")
set(CATA_COOP_TARGET_DIR "${CMAKE_BINARY_DIR}/coop-rust" CACHE PATH "Cargo artifact directory")
set(CATA_COOP_JOBS "2" CACHE STRING "Parallel Cargo jobs")
if(CATA_BUILD_COOP_RUNTIME)
    if(CMAKE_CROSSCOMPILING AND NOT CATA_COOP_RUST_TARGET)
        message(FATAL_ERROR "Set CATA_COOP_RUST_TARGET for cross compilation, or disable CATA_BUILD_COOP_RUNTIME for single-player")
    endif()
    find_program(CATA_CARGO cargo REQUIRED)
    find_package(Python3 REQUIRED COMPONENTS Interpreter)
    set(CATA_COOP_LIBRARY "${CMAKE_BINARY_DIR}/coop-runtime/${CMAKE_SHARED_LIBRARY_PREFIX}ccb_bevy_ecs_coop${CMAKE_SHARED_LIBRARY_SUFFIX}")
    add_custom_target(ccb_coop_runtime
        COMMAND ${Python3_EXECUTABLE} ${CMAKE_SOURCE_DIR}/build-scripts/build-coop-runtime.py
            --cargo "${CATA_CARGO}" --target "${CATA_COOP_RUST_TARGET}"
            --profile "${CATA_COOP_PROFILE}" --jobs "${CATA_COOP_JOBS}"
            --target-dir "${CATA_COOP_TARGET_DIR}"
            --library-dir "${CMAKE_BINARY_DIR}/coop-runtime" ${CATA_COOP_BUILD_FLAGS}
        BYPRODUCTS "${CATA_COOP_LIBRARY}"
        VERBATIM)
    include(GNUInstallDirs)
    install(FILES "${CATA_COOP_LIBRARY}" DESTINATION "${CMAKE_INSTALL_BINDIR}")
endif()

function(configure_coop_runtime EXECUTABLE COMMON)
    target_link_libraries(${COMMON} PUBLIC ${CMAKE_DL_LIBS})
    if(CATA_BUILD_COOP_RUNTIME)
        add_custom_target(${EXECUTABLE}-coop-runtime
            COMMAND ${CMAKE_COMMAND} -E make_directory "$<TARGET_FILE_DIR:${EXECUTABLE}>"
            COMMAND ${CMAKE_COMMAND} -E copy_if_different "${CATA_COOP_LIBRARY}" "$<TARGET_FILE_DIR:${EXECUTABLE}>"
            DEPENDS ccb_coop_runtime
            VERBATIM)
        add_dependencies(${EXECUTABLE} ${EXECUTABLE}-coop-runtime)
    endif()
endfunction()
