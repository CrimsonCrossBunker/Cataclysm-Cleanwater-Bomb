#!/usr/bin/env python3
"""Compare decoded saves without discarding gameplay or presentation state.

Input is JSON, not a compressed archive. Extract trusted archives into separate
scratch directories first. This complements replay_ab.py's byte comparison; it
does not change that tool's acceptance policy, execute a game, or prove speed.

Only proven storage representations are normalized:
* player traits and initial achievements: unordered_set in character.h and
  achievement.h, written by savegame_json.cpp and achievement.cpp;
* overmap NPC traits: the same Character::store/load contract;
* auto-note enabled/disabled/discovered: unordered_set in auto_note.h;
* map-memory v1 RLE: savegame_json.cpp, mm_submap/mm_region serialization.
  Symbols, IDs, rotations, subtiles and null submaps remain significant.

Unknown fields and every other array retain their order and values. There are
no ignore-path options or allowances for identities, versions or messages.
Exit 0: equal decoded state under these rules; 1: different; 2: invalid input.
"""

import argparse
import copy
import hashlib
import json
import math
from pathlib import Path

KINDS = ("json", "player", "overmap", "autonotes", "map-memory")
MAX_BYTES = 64 * 1024 * 1024
MAX_DIFFERENCES = 64
# Persisted v1 geometry, src/map_scale_constants.h. Unsupported layouts fail.
MEMORY_SUBMAPS = 8 * 8
SUBMAP_TILES = 12 * 12
MEMORY_FIELDS = ("symbol", "terrain", "terrain_subtile", "terrain_rotation",
                 "decoration", "decoration_subtile", "decoration_rotation")


def unique_object(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f"duplicate JSON member: {key}")
        result[key] = value
    return result


def reject_constant(value):
    raise ValueError(f"invalid JSON number: {value}")


def read_document(path):
    path = Path(path)
    if (any(part.startswith("obj-lua") for part in path.parts) or
            any(part.startswith("obj-lua") for part in path.resolve().parts)):
        raise ValueError("protected build cache cannot be an input")
    if (path.is_symlink() or not path.is_file() or
            path.stat().st_size > MAX_BYTES):
        raise ValueError(
            "input must be a regular decoded file of at most 64 MiB")
    with path.open("rb") as stream:
        raw = stream.read(MAX_BYTES + 1)
    if len(raw) > MAX_BYTES:
        raise ValueError("input exceeded 64 MiB while reading")
    text = raw.decode("utf-8")
    # Decode past CCB's header, but keep its comments (including save version)
    # for a separate exact comparison. Whitespace is only JSON formatting.
    lines = text.splitlines()
    first_json = 0
    preamble = []
    for line in lines:
        if line.strip() and not line.startswith("#"):
            break
        if line.startswith("#"):
            preamble.append(line)
        first_json += 1
    value = json.loads(
        "\n".join(lines[first_json:]), object_pairs_hook=unique_object,
        parse_constant=reject_constant)
    return value, hashlib.sha256(raw).hexdigest(), preamble


def validate_json(value):
    pending = [(value, 0)]
    while pending:
        node, depth = pending.pop()
        if depth > 128:
            raise ValueError("JSON nesting exceeds 128 levels")
        if type(node) is dict:
            if any(type(k) is not str for k in node):
                raise ValueError("JSON object keys must be strings")
            pending.extend((v, depth + 1) for v in node.values())
        elif type(node) is list:
            pending.extend((v, depth + 1) for v in node)
        elif type(node) is float:
            if not math.isfinite(node):
                raise ValueError("non-finite JSON number")
        elif node is not None and type(node) not in (str, int, bool):
            raise ValueError("unsupported JSON value")


def string_set(owner, key):
    if key not in owner:
        return
    value = owner[key]
    if (type(value) is not list or any(type(v) is not str for v in value) or
            len(value) != len(set(value))):
        raise ValueError(f"{key} must be an array of unique strings")
    owner[key] = sorted(value)


def memory_region(value):
    if type(value.get("version")) is not int or value["version"] != 1:
        raise ValueError("only map-memory schema v1 is supported")
    regions = value.get("data")
    if type(regions) is not list or len(regions) != MEMORY_SUBMAPS:
        raise ValueError("map-memory region must contain 64 submaps")
    for index, runs in enumerate(regions):
        if runs is None:
            continue
        if type(runs) is not list:
            raise ValueError("map-memory submap must be null or an RLE array")
        tiles = []
        for run in runs:
            if type(run) is not list or len(run) not in (5, 8):
                raise ValueError("invalid map-memory RLE record")
            count, symbol, terrain, subtile, rotation = run[:5]
            decoration = run[5:] if len(run) == 8 else ["", 0, 0]
            if (type(count) is not int or not 1 <= count <= SUBMAP_TILES or
                    len(tiles) + count > SUBMAP_TILES):
                raise ValueError("invalid map-memory run length")
            if type(symbol) is not int or not -(2**31) <= symbol < 2**31:
                raise ValueError("invalid persisted map-memory symbol")
            if type(terrain) is not str or type(decoration[0]) is not str:
                raise ValueError("invalid map-memory ID")
            if any(type(v) is not int or not -128 <= v <= 127
                   for v in (subtile, rotation, *decoration[1:])):
                raise ValueError("invalid map-memory orientation")
            tile = dict(zip(MEMORY_FIELDS, [symbol, terrain, subtile, rotation,
                                            *decoration]))
            tiles.extend([tile] * count)
        if len(tiles) != SUBMAP_TILES:
            raise ValueError("map-memory submap must decode to 144 tiles")
        regions[index] = tiles


def normalize(kind, document):
    if kind not in KINDS:
        raise ValueError("unsupported save kind")
    validate_json(document)
    value = copy.deepcopy(document)
    if kind == "json":
        return value
    if type(value) is not dict:
        raise ValueError(f"{kind} root must be an object")
    if kind == "player":
        if type(value.get("player")) is not dict:
            raise ValueError("player save must contain a player object")
        string_set(value["player"], "traits")
        if "achievements_tracker" in value:
            tracker = value["achievements_tracker"]
            if type(tracker) is not dict:
                raise ValueError("invalid achievements tracker")
            string_set(tracker, "initial_achievements")
    elif kind == "overmap" and "npcs" in value:
        if type(value["npcs"]) is not list:
            raise ValueError("overmap npcs must be an ordered array")
        for npc in value["npcs"]:
            if type(npc) is not dict:
                raise ValueError("invalid NPC record")
            string_set(npc, "traits")
    elif kind == "autonotes":
        for key in ("enabled", "disabled", "discovered"):
            string_set(value, key)
    elif kind == "map-memory":
        memory_region(value)
    return value


def compare_documents(kind, a, b):
    a, b = normalize(kind, a), normalize(kind, b)
    differences = []
    absent = object()
    pending = [("", a, b)]
    while pending and len(differences) < MAX_DIFFERENCES:
        path, left, right = pending.pop()
        reason = None
        if left is absent or right is absent:
            reason = "missing"
        elif type(left) is not type(right):
            reason = "type"
        elif type(left) is dict:
            for key in sorted(left.keys() | right.keys(), reverse=True):
                child = path + "/" + key.replace("~", "~0").replace("/", "~1")
                if key not in left or key not in right:
                    # Distinguish absent members from explicit JSON null.
                    pending.append(
                        (child, left.get(key, absent), right.get(key, absent)))
                else:
                    pending.append((child, left[key], right[key]))
        elif type(left) is list:
            if len(left) != len(right):
                reason = "length"
            else:
                pending.extend((path + "/" + str(i), left[i], right[i])
                               for i in reversed(range(len(left))))
        elif left != right:
            reason = "value"
        if reason:
            differences.append({"path": path or "/", "reason": reason})
    return {"schema_version": 1, "kind": kind, "match": not differences,
            "differences": differences, "truncated": bool(pending),
            "scope": "Decoded persisted state; no identity, message, version, "
                     "glyph or unknown-field exclusions; "
                     "not runtime or visual acceptance"}


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--kind", choices=KINDS, required=True)
    parser.add_argument("a", type=Path)
    parser.add_argument("b", type=Path)
    args = parser.parse_args(argv)
    try:
        a, a_hash, a_header = read_document(args.a)
        b, b_hash, b_header = read_document(args.b)
        report = compare_documents(args.kind, a, b)
        report["preamble_match"] = a_header == b_header
        report["match"] = report["match"] and report["preamble_match"]
        report["input_sha256"] = {"a": a_hash, "b": b_hash}
        code = 0 if report["match"] else 1
    except (OSError, ValueError, RecursionError) as error:
        report = {"schema_version": 1,
                  "status": "invalid", "error": str(error)}
        code = 2
    print(json.dumps(report, ensure_ascii=False, sort_keys=True))
    return code


if __name__ == "__main__":
    raise SystemExit(main())
