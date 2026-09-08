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
            (kind == "boolean" and isinstance(value, bool)) or
            (kind == "integer" and integer(value) and
                -(2**63) <= value < 2**63) or
            (kind == "float" and isinstance(value, (int, float)) and
                not isinstance(value, bool) and math.isfinite(value)) or
            (kind == "string" and isinstance(value, str))
        )
        if not valid:
            raise ValueError(f"{location}.{key}: invalid {kind!r} value")
        row = {"key": key, "type": kind}
        if show_values:
            row["value"] = value
        result.append(row)
    return result


def task_participants(values: object, location: str) -> list:
    if not isinstance(values, list):
        raise ValueError(f"{location}: expected participants array")
    rows, roles = [], set()
    for index, participant in enumerate(values):
        where = f"{location}.participants[{index}]"
        if not isinstance(participant, dict):
            raise ValueError(f"{where}: expected participant object")
        role, kind = participant.get("role"), participant.get("kind")
        if not isinstance(role, str) or not role or role in roles:
            raise ValueError(f"{where}: missing or repeated participant role")
        roles.add(role)
        if kind not in ("character", "item", "monster", "vehicle"):
            raise ValueError(f"{where}: invalid participant kind")
        stable_id = participant.get("stable_id")
        maximum = 2**31 if kind == "character" else 2**63
        if not integer(stable_id) or not 0 < stable_id < maximum:
            raise ValueError(f"{where}: invalid participant stable_id")
        hint_scope = participant.get("hint_scope")
        if (not isinstance(hint_scope, str) or "\0" in hint_scope or
                len(hint_scope.encode("utf-8")) > 64):
            raise ValueError(f"{where}: invalid participant hint_scope")
        for key in ("hint_x", "hint_y", "hint_z"):
            value = participant.get(key)
            if not integer(value) or not -(2**31) <= value < 2**31:
                raise ValueError(f"{where}: invalid participant {key}")
        if not isinstance(participant.get("pending", False), bool):
            raise ValueError(f"{where}: invalid participant pending flag")
        rows.append({key: participant[key] for key in (
            "role", "kind", "stable_id", "hint_scope",
            "hint_x", "hint_y", "hint_z")})
        rows[-1]["pending"] = participant.get("pending", False)
    return rows


def task_actor(task: dict, location: str) -> dict:
    """Validate and report native actor identity and hint fields."""
    result = {}
    actor_count = 0
    for kind in ("character", "item", "monster", "vehicle"):
        prefix = f"actor_{kind}"
        identity_key = prefix + ("_id" if kind == "character" else "_uid")
        hint_keys = [
            prefix +
            "_hint_" +
            axis for axis in (
                "scope",
                "x",
                "y",
                "z")]
        pending_key = prefix + "_pending"
        metadata = [] if kind == "character" else hint_keys + [pending_key]
        if identity_key not in task:
            if any(key in task for key in metadata):
                raise ValueError(
                    f"{location}: actor metadata requires {identity_key}")
            continue
        actor_count += 1
        identity = task[identity_key]
        maximum = 2**31 if kind == "character" else 2**63
        if not integer(identity) or not 0 < identity < maximum:
            raise ValueError(f"{location}: invalid {identity_key}")
        result[identity_key] = identity
        if kind == "character":
            continue
        if any(key in task for key in hint_keys):
            if not all(key in task for key in hint_keys):
                raise ValueError(f"{location}: incomplete {prefix} hint")
            scope = task[hint_keys[0]]
            if (not isinstance(scope, str) or "\0" in scope or
                    len(scope.encode("utf-8")) > 64):
                raise ValueError(f"{location}: invalid {prefix} hint scope")
            for key in hint_keys[1:]:
                if not integer(task[key]) or not -(2**31) <= task[key] < 2**31:
                    raise ValueError(f"{location}: invalid {key}")
            result.update((key, task[key]) for key in hint_keys)
        if pending_key in task:
            if not isinstance(task[pending_key], bool):
                raise ValueError(f"{location}: invalid {pending_key}")
            result[pending_key] = task[pending_key]
    if actor_count > 1:
        raise ValueError(f"{location}: multiple actor identities")
    return result


def summarize(document: object, mod: str | None = None,
              limit: int = 20, show_values: bool = False,
              task_id: int | None = None) -> dict:
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
    if task_id is not None:
        if mod is None:
            raise ValueError(
                "a task ID requires --mod because IDs are local to each Mod")
        if not integer(task_id) or not 0 < task_id < 2**63:
            raise ValueError("task ID must be a positive native integer")
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
        counter_persisted = "last_task_id" in record
        last_task_id = record.get("last_task_id", 0)
        if not integer(last_task_id) or not 0 <= last_task_id < 2**63:
            raise ValueError(f"{owner}: invalid last_task_id")
        task_rows, seen = [], set()
        for index, task in enumerate(tasks):
            location = f"{owner}.tasks[{index}]"
            if not isinstance(task, dict):
                raise ValueError(f"{location}: expected task object")
            stored_id = task.get("id")
            if not integer(stored_id) or not 0 < stored_id < 2**63:
                raise ValueError(f"{location}: invalid task id")
            if counter_persisted and stored_id > last_task_id:
                raise ValueError(
                    f"{location}: task id exceeds saved last_task_id")
            last_task_id = max(last_task_id, stored_id)
            if stored_id in seen:
                raise ValueError(f"{location}: duplicate task id {stored_id}")
            seen.add(stored_id)
            if not isinstance(task.get("handler"), str) or not task["handler"]:
                raise ValueError(f"{location}: missing handler")
            due = task.get("due_turn")
            interval = task.get("interval_turns", 0)
            if not integer(due) or not -(2**63) <= due < 2**63:
                raise ValueError(f"{location}: invalid due_turn")
            if not integer(interval) or not 0 <= interval < 2**63:
                raise ValueError(f"{location}: invalid interval_turns")
            version = task.get("payload_version")
            if not integer(version) or not 0 < version < 2**31:
                raise ValueError(f"{location}: invalid payload_version")
            if task.get("owner_mod_id", owner) != owner:
                raise ValueError(
                    f"{location}: owner_mod_id differs from record")
            payload = typed_values(task.get("payload"), location,
                                   show_values)
            participants = task_participants(
                task.get("participants", []), location)
            row = {key: task[key] for key in ("id", "handler", "due_turn")}
            row["interval_turns"] = interval
            row["payload_version"] = version
            row["payload"] = payload[:limit]
            row["payload_count"] = len(payload)
            row["participants"] = participants[:limit]
            row["participant_count"] = len(participants)
            row["actor"] = task_actor(task, location)
            if task_id is None or task["id"] == task_id:
                task_rows.append(row)
        if task_id is not None and not task_rows:
            raise ValueError(
                f"{owner}: task {task_id} is absent from this snapshot")
        rows.append({"mod": owner,
                     "last_task_id": last_task_id,
                     "task_counter_persisted": counter_persisted,
                     "state_count": len(values),
                     "state": values[:limit],
                     "task_count": len(tasks),
                     "matched_task_count": len(task_rows),
                     "tasks": sorted(task_rows,
                                     key=lambda row: row["id"])[:limit],
                     })
    return {"version": 1, "scope": scope, "mod_count": len(mods),
            "matched_mod_count": len(rows), "mods": rows[:limit],
            "note": "Saved snapshot only; handler availability, participant "
                    "liveness and runtime execution are not verified."}


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("file", type=Path)
    parser.add_argument("--mod", help="show only one saved Mod record")
    parser.add_argument(
        "--task",
        type=int,
        help="show one saved task ID; requires --mod")
    parser.add_argument("--limit", type=int, default=20,
                        help="maximum displayed entries per list (1-200)")
    parser.add_argument("--values", action="store_true",
                        help="include state and payload values")
    args = parser.parse_args(argv)
    try:
        report = summarize(read_snapshot(args.file), args.mod,
                           args.limit, args.values, args.task)
        report["file"] = str(args.file.resolve())
        print(json.dumps(report, indent=2, ensure_ascii=True, allow_nan=False))
    except (OSError, ValueError, OverflowError, RecursionError) as error:
        print(f"{args.file}: {error}", file=sys.stderr)
        return 2
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
