#!/bin/bash

# Shell script intended for clang-tidy check

echo "Using bash version $BASH_VERSION"
set -exo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(dirname "$script_dir")"

num_jobs=${num_jobs:-3}
build_dir=${CATA_BUILD_DIR:-build}

# enable all the switches by default
BACKTRACE=${BACKTRACE:-1}
LOCALIZE=${LOCALIZE:-1}
TILES=${TILES:-1}
SOUND=${SOUND:-1}
cmake_sdl3=()
make_sdl3=()
if [ -n "${SDL3+x}" ]; then
    cmake_sdl3=( "-DUSE_SDL3=${SDL3}" )
    make_sdl3=( "SDL3=${SDL3}" )
fi

# create compilation database (compile_commands.json)
mkdir -p "$build_dir"
build_dir="$(cd "$build_dir" && pwd)"
export CATA_BUILD_DIR="$build_dir"
cd "$build_dir"
cmake \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    ${COMPILER:+-DCMAKE_CXX_COMPILER=$COMPILER} \
    -DCMAKE_BUILD_TYPE="Release" \
    -DBACKTRACE="${BACKTRACE}" \
    -DLOCALIZE="${LOCALIZE}" \
    -DTILES="${TILES}" \
    -DSOUND="${SOUND}" \
    "${cmake_sdl3[@]}" \
    "$repo_root"
cd "$repo_root"
ln --force --symbolic "${build_dir}/compile_commands.json" .

if [ ! -f "${build_dir}/tools/clang-tidy-plugin/libCataAnalyzerPlugin.so" ]
then
    echo "Cata plugin not found. Assuming we're in CI and bailing out."
    echo "If you are running clang-tidy locally with no plugin, consider"
    echo "calling it explicitly with the files you care to check."
    echo "e.g. clang-tidy src/item* tests/item*"
    exit 1
fi

# Show compiler C++ header search path
${COMPILER:-clang++} -v -x c++ /dev/null -c
# And the same for clang-tidy
./build-scripts/clang-tidy-wrapper.sh --version
# list of checks
./build-scripts/clang-tidy-wrapper.sh --list-checks

# We want to first analyze all files that changed in this PR, then as
# many others as possible, in a random order.
set +x

# Manual workflow dispatches intentionally omit the PR changed-file index and
# request the full-repository audit.  Pull requests stay bounded to the
# directly/transitively affected source set, including CI/config changes.
if [ ! -f ./files_changed ]
then
    echo "No PR changed-file index; analyzing all files"
    TIDY="all"
fi

bounded_global_changes=""
if [ -f ./files_changed ]
then
    bounded_global_changes="$(grep -Ei \
        '(^|/)(CMakeLists\.txt|Makefile)$|(^|/).*\.cmake$|^\.clang-tidy$|^CMakePresets\.json$|^build-scripts/clang-tidy-(build|run|wrapper)\.sh$|^build-scripts/get_affected_files\.py$|^tools/clang-tidy-plugin/|^\.github/workflows/clang-tidy\.yml$' \
        ./files_changed || true)"
fi

# PR analysis still parses directly/transitively affected translation units,
# but only diagnostics in changed C/C++ files should fail the run.  This keeps
# pre-existing findings in untouched dependents and vendored headers out of an
# otherwise unrelated PR.  Global CI/config changes add a small clean
# cross-section so the analyzer itself is exercised.  Manual dispatches omit
# files_changed and intentionally retain the unfiltered full baseline.
if [ -f ./files_changed ]
then
    line_filter_paths="$(grep -E '\.(c|cc|cpp|h|hh|hpp)$' ./files_changed || true)"
    if [ -n "$bounded_global_changes" ]
    then
        line_filter_paths="$(printf '%s\n' \
            "$line_filter_paths" \
            src/point.cpp \
            src/item_category.cpp \
            tests/point_test.cpp | sed '/^$/d' | sort -u)"
    fi
    if [ -n "$line_filter_paths" ]
    then
        line_filter_file="${build_dir}/clang-tidy-line-filter.json"
        printf '%s\n' "$line_filter_paths" | sed '/^$/d' | sort -u | \
            jq -Rsc 'split("\n") | map(select(length > 0) | {name: ., lines: [[1, 2147483647]]})' \
            > "$line_filter_file"
        export CATA_CLANG_TIDY_LINE_FILTER_FILE="$line_filter_file"
    fi
fi

all_cpp_files="$(jq -r '.[].file | select(contains("third-party") | not)' "${build_dir}/compile_commands.json")"
if [ "$TIDY" == "all" ]
then
    echo "Analyzing all files"
    tidyable_cpp_files=$all_cpp_files
else
    make \
        --silent \
        -j "$num_jobs" \
        ${COMPILER:+COMPILER="$COMPILER"} \
        BACKTRACE="${BACKTRACE}" \
        LOCALIZE="${LOCALIZE}" \
        TILES="${TILES}" \
        SOUND="${SOUND}" \
        "${make_sdl3[@]}" \
        includes

    tidyable_cpp_files="$( \
        ( test -f ./files_changed && ( build-scripts/get_affected_files.py --changed-files-list ./files_changed ) ) || \
        echo unknown )"

    tidyable_cpp_files="$(echo -n "$tidyable_cpp_files" | grep -v third-party || true)"
    if [ "$tidyable_cpp_files" == "unknown" ]
    then
        echo "Unable to determine affected files, tidying all files"
        tidyable_cpp_files=$all_cpp_files
    elif [ -n "$bounded_global_changes" ]
    then
        echo "Global clang-tidy configuration changed; adding bounded representative TUs"
        tidyable_cpp_files="$(printf '%s\n' \
            "$tidyable_cpp_files" \
            src/point.cpp \
            src/item_category.cpp \
            tests/point_test.cpp | sed '/^$/d' | sort -u)"
    fi
    if [ -z "$tidyable_cpp_files" ]
    then
	echo "No files to tidy, exiting";
	set -x
	exit 0
    fi
fi

printf "Subset to analyze: '%s'\n" "$CATA_CLANG_TIDY_SUBSET"

# (temporary create ./files_changed and then clean up it later. This is a terrible hack, and I'm not proud)
if [ ! -f ./files_changed ] ; then touch ./files_changed ; CLEANUP_FILES_CHANGED="yes" ; fi

# We might need to analyze only a subset of the files if they have been split
# into multiple jobs for efficiency. The paths from `compile_commands.json` can
# be absolute but the paths from `get_affected_files.py` are relative, so both
# formats are matched. Exit code 1 from grep (meaning no match) is ignored in
# case one subset contains no file to analyze.
case "$CATA_CLANG_TIDY_SUBSET" in
    ( directly-changed )
        tidyable_cpp_files=$(printf '%s\n' "$tidyable_cpp_files" | grep -f ./files_changed || [[ $? == 1 ]])
        ;;
    ( indirectly-changed-src )
        tidyable_cpp_files=$(printf '%s\n' "$tidyable_cpp_files" | grep -E '(^|/)src/' | grep -vf ./files_changed || [[ $? == 1 ]])
        ;;
    ( indirectly-changed-other )
        tidyable_cpp_files=$(printf '%s\n' "$tidyable_cpp_files" | grep -Ev '(^|/)src/' | grep -vf ./files_changed || [[ $? == 1 ]])
        ;;
esac
if [ "${CLEANUP_FILES_CHANGED}" == "yes" ] ; then rm -f ./files_changed ; fi

printf "full list of files to analyze (they might get shuffled around in practice):\n%s\n" "$tidyable_cpp_files"

function analyze_files_in_random_order
{
    if [ -n "$1" ]
    then
        echo "$1" | shuf | \
            xargs -P "$num_jobs" -n 1 ./build-scripts/clang-tidy-wrapper.sh -quiet
    else
        echo "No files to analyze"
    fi
}

echo "Analyzing affected files"
analyze_files_in_random_order "$tidyable_cpp_files"
set -x
