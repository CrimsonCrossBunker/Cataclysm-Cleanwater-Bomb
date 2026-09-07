#!/usr/bin/env python3
"""Inspect saved Platform state without executing Lua or changing the save."""

from __future__ import annotations

import argparse
import json
import math
import sys
from pathlib import Path

MAX_FILE_BYTES = 16 * 1024 * 1024


def unique_object(pairs: list[tuple[str, object]]) -> dict:
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f"duplicate JSON member: {key!r}")
        result[key] = value
    return result


def read_snapshot(path: Path) -> dict:
    if not path.is_file():
        raise ValueError(f"not a regular file: {path}")
    with path.open("rb") as stream:
        content = stream.read(MAX_FILE_BYTES + 1)
    if len(content) > MAX_FILE_BYTES:
        raise ValueError("Platform state file exceeds 16 MiB")
    return json.loads(content, object_pairs_hook=unique_object)


def integer(value: object) -> bool:
    return isinstance(value, int) and not isinstance(value, bool)


def typed_values(values: object, location: str, show_values: bool) -> list:
    if not isinstance(values, dict):
        raise ValueError(f"{location}: expected typed-value object")
    result = []
    for key, entry in sorted(values.items()):
        if not isinstance(entry, dict) or "value" not in entry:
            raise ValueError(f"{location}.{key}: missing typed value")
        kind, value = entry.get("type"), entry["value"]
        valid = (
            (kind == "boolean" and isinstance(value, bool))
            or (kind == "integer" and integer(value)
                and -(2**63) <= value < 2**63)
            or (kind == "float" and isinstance(value, (int, float))
                and not isinstance(value, bool) and math.isfinite(value))
            or (kind == "string" and isinstance(value, str))
        )
        if not valid:
            raise ValueError(f"{location}.{key}: invalid {kind!r} value")
        row = {"key": key, "type": kind}
        if show_values:
            row["value"] = value
        result.append(row)
    return result


def summarize(document: object, mod: str | None = None,
              limit: int = 20, show_values: bool = False) -> dict:
    if not isinstance(document, dict) or not integer(document.get("version")):
        raise ValueError("expected Platform state with an integer version")
    if document["version"] != 1:
        raise ValueError(
            f"unsupported Platform state version: {document['version']}")
    scope = document.get("scope")
    if scope not in ("world", "character"):
        raise ValueError("expected world or character scope")
    mods = document.get("mods")
    if not isinstance(mods, dict):
        raise ValueError("expected mods object")
    if mod is not None and mod not in mods:
        raise ValueError(f"Mod {mod!r} is absent from this snapshot")
    if not 1 <= limit <= 200:
        raise ValueError("limit must be between 1 and 200")
    rows = []
    for owner, record in sorted(mods.items()):
        if mod is not None and owner != mod:
            continue
        if not isinstance(record, dict):
            raise ValueError(f"{owner}: expected Mod record")
        values = typed_values(record.get("values"), owner, show_values)
        tasks = record.get("tasks", [])
        if not isinstance(tasks, list):
            raise ValueError(f"{owner}.tasks: expected array")
        task_rows, seen = [], set()
        for index, task in enumerate(tasks):
            location = f"{owner}.tasks[{index}]"
            if not isinstance(task, dict):
                raise ValueError(f"{location}: expected task object")
            task_id = task.get("id")
            if not integer(task_id) or not 0 < task_id < 2**63:
                raise ValueError(f"{location}: invalid task id")
            if task_id in seen:
                raise ValueError(f"{location}: duplicate task id {task_id}")
            seen.add(task_id)
            if not isinstance(task.get("handler"), str) or not task["handler"]:
                raise ValueError(f"{location}: missing handler")
            due = task.get("due_turn")
            interval = task.get("interval_turns", 0)
            if not integer(due) or not -(2**63) <= due < 2**63:
                raise ValueError(f"{location}: invalid due_turn")
            if not integer(interval) or not 0 <= interval < 2**63:
                raise ValueError(f"{location}: invalid interval_turns")
            version = task.get("payload_version")
            if not integer(version) or version <= 0:
                raise ValueError(f"{location}: invalid payload_version")
            if task.get("owner_mod_id", owner) != owner:
                raise ValueError(
                    f"{location}: owner_mod_id differs from record")
            payload = typed_values(task.get("payload"), location,
                                   show_values)
            participants = task.get("participants", [])
            if not isinstance(participants, list):
                raise ValueError(f"{location}: expected participants array")
            row = {key: task[key] for key in ("id", "handler", "due_turn")}
            row["interval_turns"] = interval
            row["payload_version"] = version
            row["payload"] = payload[:limit]
            row["payload_count"] = len(payload)
            row["participants"] = participants[:limit]
            row["participant_count"] = len(participants)
            row["actor"] = {
                key: value for key, value in task.items()
                if key.startswith("actor_")
            }
            task_rows.append(row)
        rows.append({
            "mod": owner, "state_count": len(values),
            "state": values[:limit], "task_count": len(task_rows),
            "tasks": sorted(task_rows, key=lambda row: row["id"])[:limit],
        })
    return {"version": 1, "scope": scope, "mods": rows,
            "note": "Saved snapshot only; handler availability, participant "
                    "liveness and runtime execution are not verified."}


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("file", type=Path)
    parser.add_argument("--mod", help="show only one saved Mod record")
    parser.add_argument("--limit", type=int, default=20,
                        help="maximum displayed entries per list (1-200)")
    parser.add_argument("--values", action="store_true",
                        help="include state and payload values")
    args = parser.parse_args(argv)
    try:
        report = summarize(read_snapshot(args.file), args.mod,
                           args.limit, args.values)
        report["file"] = str(args.file.resolve())
        print(json.dumps(report, indent=2, ensure_ascii=True, allow_nan=False))
    except (OSError, ValueError, OverflowError, RecursionError) as error:
        print(f"{args.file}: {error}", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
