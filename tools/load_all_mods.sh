#!/bin/bash

# A helper script to load the game data with all mods

set -ue

# Figure out which test executable to use
test_exe=

for potential_test_exe in ./tests/cata_test ./cata_test ./cata_test-tiles
do
    if [ -x "$potential_test_exe" ]
    then
        if [ -z "$test_exe" -o "$potential_test_exe" -nt "$test_exe" ]
        then
            test_exe=$potential_test_exe
        fi
    fi
done

if [ -z "$test_exe" ]
then
    echo "You don't seem to have compiled any test executable" >&2
    exit 1
else
    printf "Using test executable '%s'\n" "$test_exe"
fi

if ! $test_exe 'force_load_game'
then
	echo "Test failure with dda"
	exit
fi
mod_sets=$(./build-scripts/get_all_mods.py "$@")
while IFS= read -r mod_set
do
    [ -n "$mod_set" ] || continue
	printf "Running %s\n", "$mod_set"
	if ! $test_exe --mods="$mod_set" 'force_load_game'
	then
		printf "Test failure with mods '%s'\n" "$mod_set"
		exit
	fi
done <<< "$mod_sets"

echo "All mod configurations good"
