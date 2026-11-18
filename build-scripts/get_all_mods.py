#!/usr/bin/env python3

# The goal of this script is to print out sets of mods for testing.  Each line
# of output is a comma-separated list of mods.  Together the lines should cover
# all in-repo mods, in as few lines as possible.  Each line must contain only
# mods which are mutually compatible.

import argparse
import json
import os
from pathlib import Path
import subprocess
import tempfile

mods_this_time = []
mods_lists = []

exclusions = [
    # Tuple of (mod_id, mod_id) - these two mods will be incompatible
    # Note that mod_id is case sensitive
]


def compatible_with(mod, existing_mods):
    if mod in total_conversions and total_conversions & set(existing_mods):
        return False
    for entry in existing_mods:
        if mod in all_mod_conflicts[entry] or entry in all_mod_conflicts[mod]:
            return False
    for entry in exclusions:
        if entry[0] == mod and entry[1] in existing_mods:
            return False
        if entry[1] == mod and entry[0] in existing_mods:
            return False
    return True


def add_mods(mods):
    for mod in mods:
        if mod not in all_mod_dependencies:
            # Either an invalid mod id, or blacklisted.
            return False
    for mod in mods:
        if mod in mods_this_time:
            continue
        if not compatible_with(mod, mods_this_time):
            return False
        if add_mods(all_mod_dependencies[mod]):
            mods_this_time.append(mod)
        else:
            return False
    return True


def print_modlist(modlist, master_list):
    mods_lists.append(','.join(modlist))
    master_list -= set(modlist)
    modlist.clear()


all_mod_dependencies = {}
all_mod_conflicts = {}
total_conversions = set()
obsolete_mods = set()


def read_mod_catalog():
    parser = argparse.ArgumentParser(description="List compatible sets of bundled Mods")
    parser.add_argument("--game", type=Path, help="path to a built CCB game binary")
    args = parser.parse_args()
    game = args.game
    if game is None:
        game = next((path for path in map(Path, ("cataclysm", "cataclysm-tiles"))
                     if path.is_file() and os.access(path, os.X_OK)), None)
    if game is None:
        parser.error("no CCB binary found, pass its path with --game")
    try:
        with tempfile.TemporaryDirectory(prefix="ccb-mod-catalog-") as temp:
            profile = Path(temp)
            output = profile / "mods.json"
            config = profile / "config"
            config.mkdir()
            subprocess.run([
                str(game.resolve()),
                "--datadir", str(Path("data").resolve()),
                "--userdir", str(profile),
                "--configdir", str(config),
                "--mod-catalog", str(output),
            ], check=True, stdout=subprocess.DEVNULL)
            return json.loads(output.read_text(encoding="utf-8"))
    except (OSError, ValueError, subprocess.CalledProcessError) as error:
        parser.exit(1, f"Cannot read the CCB Mod catalog: {error}\n")


catalog = read_mod_catalog()
for mod in catalog:
    ident = mod["id"]
    if mod["obsolete"]:
        obsolete_mods.add(ident)
        continue
    if "lua_error" in mod:
        raise RuntimeError(f'{ident}: {mod["lua_error"]}')
    all_mod_dependencies[ident] = mod["dependencies"]
    all_mod_conflicts[ident] = mod["conflicts"]
    if mod["category"] == "total_conversion":
        total_conversions.add(ident)

for mod in catalog:
    ident = mod["id"]
    if ident in obsolete_mods or not mod["interactions"]:
        continue
    add_mods([ident])
    for companion in mod["interactions"]:
        if companion not in obsolete_mods:
            add_mods([companion])
    mods_lists.append(','.join(mods_this_time))
    mods_this_time.clear()

mods_remaining = set(all_mod_dependencies)

# Remove mods already covered by mod_interactions lists above
for ml in mods_lists:
    mods_remaining -= set(ml.split(','))

while mods_remaining:
    for mod in sorted(mods_remaining):
        if mod not in mods_this_time:
            add_mods([mod])
    if not mods_remaining & set(mods_this_time):
        raise RuntimeError(
            'mods remain ({}) but none could be added'.format(mods_remaining))
    print_modlist(mods_this_time, mods_remaining)

seen = set()
for entry in sorted(mods_lists, key=len, reverse=True):
    key = frozenset(entry.split(','))
    if entry and key not in seen:
        seen.add(key)
        print(entry)
