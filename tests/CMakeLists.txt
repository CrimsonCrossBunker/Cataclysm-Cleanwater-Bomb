cmake_minimum_required(VERSION 3.20)

if (BUILD_TESTING)
    file(GLOB CATACLYSM_DDA_TEST_SOURCES CONFIGURE_DEPENDS
            ${CMAKE_SOURCE_DIR}/tests/*.cpp)
    if (CATA_TEST_SUITE STREQUAL "lua")
        if (NOT CATA_ENABLE_LUA_PLATFORM)
            message(FATAL_ERROR "CATA_TEST_SUITE=lua requires CATA_ENABLE_LUA_PLATFORM=ON")
        endif ()
        list(FILTER CATACLYSM_DDA_TEST_SOURCES INCLUDE REGEX "/lua_platform[^/]*\\.cpp$")
        set_property(DIRECTORY APPEND PROPERTY CMAKE_CONFIGURE_DEPENDS
                ${CMAKE_CURRENT_SOURCE_DIR}/test_support_sources.txt)
        file(STRINGS ${CMAKE_CURRENT_SOURCE_DIR}/test_support_sources.txt TEST_SUPPORT_SOURCES)
        list(TRANSFORM TEST_SUPPORT_SOURCES PREPEND "${CMAKE_CURRENT_SOURCE_DIR}/")
        list(APPEND CATACLYSM_DDA_TEST_SOURCES ${TEST_SUPPORT_SOURCES})
        set(_test_filter "[lua][platform]")
    elseif (NOT CATA_TEST_SUITE STREQUAL "all")
        message(FATAL_ERROR "CATA_TEST_SUITE must be all or lua")
    endif ()

    # Enabling benchmarks
    add_definitions(-DCATCH_CONFIG_ENABLE_BENCHMARKING)

    # Workaround clang>=22 flagging __COUNTER__ as c2y-extension
    # (llvm/llvm-project#189645). Mirrors tests/Makefile.
    if (CMAKE_CXX_COMPILER_ID MATCHES "Clang"
            AND CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 22)
        add_definitions(-DCATCH_CONFIG_NO_COUNTER)
    endif ()

    if(LOCALIZE)
        # Need to build the test .mo file for the tests to pass.
        # Unfortunately we currently need to put this in the source dir, not the
        # build dir
        set(TEST_LANG ${CMAKE_SOURCE_DIR}/data/mods/TEST_DATA/lang)
        set(TEST_MO ${TEST_LANG}/mo/ru/LC_MESSAGES/TEST_DATA.mo)
        add_custom_command(
            OUTPUT ${TEST_MO}
            MAIN_DEPENDENCY ${TEST_LANG}/po/ru.po
            COMMAND ${GETTEXT_MSGFMT_EXECUTABLE} -f -o ${TEST_MO} ${TEST_LANG}/po/ru.po)

        add_custom_target(test_mo DEPENDS ${TEST_MO})
    endif()

    if (TILES)
        add_executable(cata_test-tiles ${CATACLYSM_DDA_TEST_SOURCES})
        if (LOCALIZE)
            add_dependencies(cata_test-tiles test_mo)
        endif()
        target_link_libraries(cata_test-tiles PRIVATE cataclysm-tiles-common)
	target_compile_definitions(cata_test-tiles PUBLIC SDL_MAIN_HANDLED)
        add_test(NAME cata.tiles.default
                COMMAND cata_test-tiles ${_test_filter} --rng-seed time --warn NoTests
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
        # ctest -C RelWithDebInfo -j 2 -V -L ^gha$
        if (CATA_TEST_SUITE STREQUAL "all")
            list(APPEND _n 1 2)
            list(APPEND _args "[slow] ~starting_items" "~[slow] ~[.],starting_items")
            foreach(n args IN ZIP_LISTS _n _args)
                add_test(NAME cata.tiles.gha-${n}
                        COMMAND cata_test-tiles --min-duration 20 --use-colour yes --rng-seed time
                        --order lex --user-dir=test_user_dir_${n} ${args}
                        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
                set_tests_properties(cata.tiles.gha-${n} PROPERTIES LABELS "gha")
            endforeach()
            catch_discover_tests(cata_test-tiles
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
        endif ()
    endif ()

    if (CURSES)
        add_executable(cata_test ${CATACLYSM_DDA_TEST_SOURCES})
        if (LOCALIZE)
            add_dependencies(cata_test test_mo)
        endif()
        target_link_libraries(cata_test PRIVATE cataclysm-common)
        add_test(NAME test
                COMMAND cata_test ${_test_filter} --rng-seed time --warn NoTests
                WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
    endif ()
endif ()
