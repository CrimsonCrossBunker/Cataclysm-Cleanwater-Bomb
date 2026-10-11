#!/bin/bash

set -e

# The former MXE archive only contained SDL2 and cannot build the SDL3 engine.
if [ -n "${MXE_TARGET}" ]; then
  echo "The legacy MXE SDL2 toolchain is retired; use the SDL3 MSVC or MSYS2 build." >&2
  exit 1
fi

function just_json
{
    for filename in $(./build-scripts/files_changed || echo UNKNOWN)
    do
        if [[ ! "$filename" =~ \.(json|md)$ ]]
        then
            echo "$filename is not json or markdown, triggering full build."
            return 1
        fi
    done
    echo "Only json / markdown files changed, skipping full build."
    return 0
}

# Enable GitHub actions problem matchers
# (See https://github.com/actions/toolkit/blob/master/docs/problem-matchers.md)
echo "::add-matcher::build-scripts/problem-matchers/catch2.json"
echo "::add-matcher::build-scripts/problem-matchers/debugmsg.json"

if which travis_retry &>/dev/null
then
    travis_retry=travis_retry
else
    travis_retry=
fi

if [[ "$TRAVIS_EVENT_TYPE" == "pull_request" ]]; then
    if just_json; then
        export JUST_JSON=true
        export CODE_COVERAGE=""
    fi
fi

set -x
if [[ "$LIBBACKTRACE" == "1" ]]; then
    git clone https://github.com/ianlancetaylor/libbacktrace.git
    (
        cd libbacktrace
        git checkout 4d2dd0b172f2c9192f83ba93425f868f2a13c553
        ./configure
        make -j$(nproc)
        sudo make install
    )
fi

if [ -n "${CODE_COVERAGE}" ]; then
  $travis_retry pip install --user wheel --upgrade
  $travis_retry pip install --user pyyaml cpp-coveralls
  export CXXFLAGS="$CXXFLAGS --coverage"
  export LDFLAGS="$LDFLAGS --coverage"
fi

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  HOMEBREW_NO_AUTO_UPDATE=yes HOMEBREW_NO_INSTALL_CLEANUP=yes brew install sdl3 sdl3_image sdl3_ttf sdl3_mixer gettext ncurses ccache parallel
fi

if [[ "$NATIVE" == "android" ]]; then
  yes | sdkmanager "ndk-bundle"
fi

if [ -n "$WINE" ]
then
    # The build script will try to run things under wine in parallel, and I
    # think there are race conditions that can cause that to break.  So, run
    # something benign under wine in advance to trigger it to configure all the
    # one-time init stuff
    wine hostname
fi

# On GitHub actions environment variables are not saved between steps by
# default, so we need to explicitly save the ones that we care about
if [ -n "$GITHUB_ENV" ]
then
    for v in CROSS_COMPILATION CXX
    do
        if [ -n "${!v}" ]
        then
            printf "%s=%s\n" "$v" "${!v}" >> "$GITHUB_ENV"
        fi
    done
fi

set +x
