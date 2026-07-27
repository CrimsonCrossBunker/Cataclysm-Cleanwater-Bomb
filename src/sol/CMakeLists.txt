file(GLOB SOL_SOURCES config.hpp forward.hpp sol.hpp)

add_library(libsol INTERFACE ${SOL_SOURCES})
# HACK: "/.." here keeps the generated path layout compatible with existing includes.
#       Get rid of it once we get rid of Make, and move sol sources into subdirectory.
target_include_directories(libsol SYSTEM INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/..)
target_link_libraries(libsol INTERFACE liblua)
# src/lua/CMakeLists.txt deliberately builds the bundled C sources as C++.
# Keep sol2's declarations on the same linkage mode for every CMake consumer,
# including Android (whose top-level project does not define the legacy CMAKE
# preprocessor symbol used by CBN's desktop build).
target_compile_definitions(libsol INTERFACE SOL_USE_CXX_LUA=1)
