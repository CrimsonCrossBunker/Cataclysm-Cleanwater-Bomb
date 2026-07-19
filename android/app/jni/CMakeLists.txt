cmake_minimum_required(VERSION 3.22)

# Output libmain.so; SDL3 dlsym's SDL_main from it
# (CataclysmDDA.java::getMainSharedObject).
project(cataclysm-android LANGUAGES C CXX)

set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

get_filename_component(CATA_REPO_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/../../.."
                       ABSOLUTE)

set(TILES ON)
set(USE_SDL3 ON)
set(DYNAMIC_LINKING ON)

find_package(SDL3 CONFIG REQUIRED)
find_package(SDL3_image CONFIG REQUIRED)
find_package(SDL3_ttf CONFIG REQUIRED)
find_package(SDL3_mixer CONFIG REQUIRED)

# Prefab AARs expose <SDL3/SDL.h> only; CDDA legacy bare <SDL_*.h> matches the
# pkg-config sdl3 desktop layout, so also add each SDL3 subdir to -I.
set(_sdl3_subdir_inc "")
foreach(lib SDL3 SDL3_image SDL3_ttf SDL3_mixer)
  foreach(tgt ${lib}::${lib} ${lib}::${lib}-shared
                  ${lib}::${lib}-Headers ${lib}::Headers)
    if(TARGET ${tgt})
      get_target_property(inc ${tgt} INTERFACE_INCLUDE_DIRECTORIES)
      if(inc)
        foreach(dir IN LISTS inc)
          if(IS_DIRECTORY "${dir}/SDL3")
            list(APPEND _sdl3_subdir_inc "${dir}/SDL3")
          endif()
        endforeach()
      endif()
    endif()
  endforeach()
endforeach()
list(REMOVE_DUPLICATES _sdl3_subdir_inc)

add_subdirectory(${CATA_REPO_ROOT}/src/third-party third-party)

file(GLOB CATA_SOURCES ${CATA_REPO_ROOT}/src/*.cpp
     ${CATA_REPO_ROOT}/src/cata_allocator_c.c)

add_library(main SHARED ${CATA_SOURCES})

# Android always uses SDL3's Vulkan GPU backend when available, so every APK
# needs SPIR-V shader artifacts. Release CI downloads and validates prebuilt
# files; local builds generate them as part of the native build by default.
option(CATA_ANDROID_PREBUILT_SHADERS
       "Use precompiled Android SPIR-V shader artifacts" OFF)
set(CATA_SHADERS_DIR ${CATA_REPO_ROOT}/data/shaders)
set(CATA_ANDROID_SHADER_STAMP ${CATA_SHADERS_DIR}/build-spv.stamp)
file(GLOB CATA_SHADER_SOURCES ${CATA_SHADERS_DIR}/*.frag
     ${CATA_SHADERS_DIR}/*.vert)
if(CATA_ANDROID_PREBUILT_SHADERS)
  foreach(shader ${CATA_SHADER_SOURCES})
    set(shader_spv "${shader}.spv")
    if(NOT EXISTS "${shader_spv}")
      message(FATAL_ERROR "Precompiled Android shader is missing: ${shader_spv}")
    endif()
    file(SIZE "${shader_spv}" shader_spv_size)
    if(shader_spv_size EQUAL 0)
      message(FATAL_ERROR "Precompiled Android shader is empty: ${shader_spv}")
    endif()
  endforeach()
  message(STATUS "Using precompiled Android SPIR-V shader artifacts")
else()
  find_package(Python3 COMPONENTS Interpreter REQUIRED)
  add_custom_command(
    OUTPUT ${CATA_ANDROID_SHADER_STAMP}
    COMMAND
      ${Python3_EXECUTABLE} ${CATA_REPO_ROOT}/tools/build_shaders.py --shader-dir
      ${CATA_SHADERS_DIR} --formats spv --stamp ${CATA_ANDROID_SHADER_STAMP}
    WORKING_DIRECTORY ${CATA_REPO_ROOT}
    DEPENDS ${CATA_SHADER_SOURCES} ${CATA_REPO_ROOT}/tools/build_shaders.py
    COMMENT "Compiling Android SPIR-V shader artifacts")
  add_custom_target(compile_android_shaders ALL
                    DEPENDS ${CATA_ANDROID_SHADER_STAMP})
  add_dependencies(main compile_android_shaders)
endif()

target_include_directories(
  main PRIVATE ${CATA_REPO_ROOT}/src ${CATA_REPO_ROOT}/src/third-party
               ${_sdl3_subdir_inc})

target_compile_definitions(
  main
  PRIVATE TILES
          SDL_SOUND
          USE_SDL3
          BACKTRACE
          LOCALIZE
          ZSTD_STATIC_LINKING_ONLY
          ZSTD_DISABLE_ASM)

target_compile_options(main PRIVATE -fsigned-char -Wall -Wextra)

target_link_libraries(
  main
  PRIVATE third-party
          SDL3::SDL3
          SDL3_image::SDL3_image
          SDL3_ttf::SDL3_ttf
          SDL3_mixer::SDL3_mixer
          log
          GLESv2
          GLESv1_CM
          z)
