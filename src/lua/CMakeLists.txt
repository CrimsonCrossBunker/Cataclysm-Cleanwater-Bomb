set(LUA_SOURCE_NAMES
    lapi.c
    lauxlib.c
    lbaselib.c
    lcode.c
    lcorolib.c
    lctype.c
    ldblib.c
    ldebug.c
    ldo.c
    ldump.c
    lfunc.c
    lgc.c
    linit.c
    liolib.c
    llex.c
    lmathlib.c
    lmem.c
    loadlib.c
    lobject.c
    lopcodes.c
    loslib.c
    lparser.c
    lstate.c
    lstring.c
    lstrlib.c
    ltable.c
    ltablib.c
    ltm.c
    lundump.c
    lutf8lib.c
    lvm.c
    lzio.c)
list(TRANSFORM LUA_SOURCE_NAMES
    PREPEND "${CMAKE_CURRENT_SOURCE_DIR}/"
    OUTPUT_VARIABLE LUA_SOURCES)
file(GLOB LUA_HEADERS CONFIGURE_DEPENDS
    ${CMAKE_CURRENT_SOURCE_DIR}/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp)

# Add both sources and headers to the library (headers for IDE visibility)
add_library(liblua ${LUA_SOURCES} ${LUA_HEADERS})
# sol is configured (via src/sol/config.hpp, SOL_USE_CXX_LUA) to reference
# Lua symbols with C++ linkage, so the Lua sources must be compiled as C++
# too, or linking fails with undefined Lua references on CMake builds.
set_source_files_properties(${LUA_SOURCES} PROPERTIES LANGUAGE CXX)
target_include_directories(liblua SYSTEM PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Lua is third-party C code.  Keep its diagnostics isolated from the game's
# warning-as-error policy while still compiling it with the platform C compiler.
if(MSVC)
    target_compile_options(liblua PRIVATE /w)
else()
    target_compile_options(liblua PRIVATE -w)
endif()

install(TARGETS liblua LIBRARY DESTINATION ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
