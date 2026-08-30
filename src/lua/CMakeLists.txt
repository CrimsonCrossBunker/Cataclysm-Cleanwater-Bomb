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

# Keep the bundled runtime on Lua's standard C ABI.  Make also compiles these
# files as C, while C++ callers and sol2 include the Lua headers with C linkage.
set_source_files_properties(${LUA_SOURCES}
    PROPERTIES LANGUAGE C)

file(GLOB LUA_HEADERS CONFIGURE_DEPENDS
    ${CMAKE_CURRENT_SOURCE_DIR}/*.h
    ${CMAKE_CURRENT_SOURCE_DIR}/*.hpp)

# Add both sources and headers to the library (headers for IDE visibility)
add_library(liblua ${LUA_SOURCES} ${LUA_HEADERS})
target_include_directories(liblua SYSTEM PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Lua is third-party code.  Keep its diagnostics isolated from the game's
# warning-as-error policy while preserving its standard C ABI.
if(MSVC)
    target_compile_options(liblua PRIVATE /w)
else()
    target_compile_options(liblua PRIVATE -w)
endif()

install(TARGETS liblua LIBRARY DESTINATION ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
