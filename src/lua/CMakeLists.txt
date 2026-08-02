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

# Make compiles the bundled Lua .c sources as C++.  sol2 and the native Lua
# bridge therefore reference C++-mangled lua_* symbols; keep CMake on the same
# ABI so every generator links the same runtime contract.
set_source_files_properties(${LUA_SOURCES}
    PROPERTIES LANGUAGE CXX)

file(GLOB LUA_HEADERS CONFIGURE_DEPENDS
    ${CMAKE_CURRENT_SOURCE_DIR}/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp)

# Add both sources and headers to the library (headers for IDE visibility)
add_library(liblua ${LUA_SOURCES} ${LUA_HEADERS})
target_include_directories(liblua SYSTEM PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Lua is third-party code.  Keep its diagnostics isolated from the game's
# warning-as-error policy while compiling it with the required C++ ABI.
if(MSVC)
    target_compile_options(liblua PRIVATE /w)
else()
    target_compile_options(liblua PRIVATE -w)
endif()

install(TARGETS liblua LIBRARY DESTINATION ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
