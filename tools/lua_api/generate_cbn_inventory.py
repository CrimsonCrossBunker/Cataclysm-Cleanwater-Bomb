#!/usr/bin/env python3
"""Generate a deterministic inventory of Cataclysm-BN's public Lua surface."""

from __future__ import annotations

import argparse
import json
import re
import subprocess
from pathlib import Path
from typing import Iterable


REPOSITORY = "https://github.com/cataclysmbn/Cataclysm-BN"


def source_files(root: Path) -> list[Path]:
    src = root / "src"
    return sorted(
        path
        for path in src.glob("catalua*")
        if path.is_file() and path.suffix in {".cpp", ".h"}
    )


def relative(path: Path, root: Path) -> str:
    return path.relative_to(root).as_posix()


def matches(
    files: Iterable[Path],
    root: Path,
    pattern: re.Pattern[str],
    kind: str,
    groups: tuple[str, ...],
) -> list[dict[str, object]]:
    result: list[dict[str, object]] = []
    for path in files:
        for line_number, line in enumerate(
            path.read_text(encoding="utf-8", errors="replace").splitlines(), 1
        ):
            for match in pattern.finditer(line):
                entry: dict[str, object] = {
                    "kind": kind,
                    "file": relative(path, root),
                    "line": line_number,
                }
                for group in groups:
                    value = match.groupdict().get(group)
                    if value is not None:
                        entry[group] = value.strip()
                result.append(entry)
    return result


def unique_sorted(
    entries: Iterable[dict[str, object]], *, semantic: bool = False
) -> list[dict[str, object]]:
    unique: dict[tuple[object, ...], dict[str, object]] = {}
    for entry in entries:
        fields = ["kind", "name", "cpp_type", "lua_name"]
        if not semantic:
            fields.extend(("file", "line"))
        key = tuple(entry.get(name) for name in fields)
        unique.setdefault(key, entry)
    return sorted(
        unique.values(),
        key=lambda item: (
            str(item.get("kind", "")),
            str(item.get("name", "")),
            str(item.get("cpp_type", "")),
            str(item.get("lua_name", "")),
            str(item.get("file", "")),
            int(item.get("line", 0)),
        ),
    )


def git_commit(root: Path) -> str:
    completed = subprocess.run(
        ["git", "-C", str(root), "rev-parse", "HEAD"],
        check=True,
        capture_output=True,
        text=True,
    )
    return completed.stdout.strip()


def generate(root: Path) -> dict[str, object]:
    files = source_files(root)
    if not files:
        raise RuntimeError(f"{root} does not contain src/catalua* sources")
    engine_files = sorted(
        path
        for path in (root / "src").rglob("*")
        if path.is_file() and path.suffix in {".cpp", ".h"}
    )

    type_entries = matches(
        engine_files,
        root,
        re.compile(
            r"\bLUNA_(?P<macro>VAL|DOC|ID|ENUM|PTR)\s*\(\s*"
            r"(?P<cpp_type>[^,]+?)\s*,\s*\"(?P<lua_name>[^\"]+)\""
        ),
        "type",
        ("macro", "cpp_type", "lua_name"),
    )
    for entry in type_entries:
        entry["kind"] = str(entry.pop("macro")).lower()

    explicit_functions = matches(
        engine_files,
        root,
        re.compile(
            r"\bluna::set_fx\s*\(\s*[^,]+,\s*"
            r"(?:\"(?P<name>[^\"]+)\"|"
            r"sol::meta_function::(?P<meta>[A-Za-z0-9_]+))"
        ),
        "function",
        ("name", "meta"),
    )
    for entry in explicit_functions:
        if "name" not in entry:
            entry["name"] = f"@meta:{entry.pop('meta')}"

    macro_functions = matches(
        engine_files,
        root,
        re.compile(
            r"\bSET_FX(?:_T)?\s*\(\s*(?P<name>[A-Za-z_][A-Za-z0-9_]*)"
            r"|\bSET_FX_N(?:_T)?\s*\(\s*[A-Za-z_][A-Za-z0-9_]*\s*,\s*"
            r"\"(?P<named>[^\"]+)\""
        ),
        "function",
        ("name", "named"),
    )
    for entry in macro_functions:
        if "name" not in entry:
            entry["name"] = entry.pop("named")

    table_functions = matches(
        files,
        root,
        re.compile(r"\bset_function\s*\(\s*\"(?P<name>[^\"]+)\""),
        "table_function",
        ("name",),
    )

    member_entries = matches(
        files,
        root,
        re.compile(
            r"\bSET_MEMB(?:_RO)?\s*\(\s*(?P<name>[A-Za-z_][A-Za-z0-9_]*)"
            r"|\bSET_MEMB_N(?:_RO)?\s*\(\s*[A-Za-z_][A-Za-z0-9_]*\s*,\s*"
            r"\"(?P<named>[^\"]+)\""
        ),
        "member",
        ("name", "named"),
    )
    for entry in member_entries:
        if "name" not in entry:
            entry["name"] = entry.pop("named")

    hook_entries = matches(
        engine_files,
        root,
        re.compile(r"\brun_hooks\s*\(\s*\"(?P<name>[^\"]+)\""),
        "hook",
        ("name",),
    )

    id_entries = matches(
        files,
        root,
        re.compile(r"\breg_id\s*<\s*(?P<cpp_type>[^,>]+)"),
        "id",
        ("cpp_type",),
    )

    actor_entries = matches(
        engine_files,
        root,
        re.compile(r"\bclass\s+(?P<name>lua_[A-Za-z0-9_]*actor)\b"),
        "callback_actor",
        ("name",),
    )
    callback_entries = matches(
        engine_files,
        root,
        re.compile(
            r"\b(?P<name>call_(?:on|can|get|has)_[A-Za-z0-9_]+)\s*\("
        ),
        "callback",
        ("name",),
    )

    domains = sorted(
        {
            path.stem.removeprefix("catalua_bindings_")
            for path in files
            if all(
                (
                    path.name.startswith("catalua_bindings_"),
                    path.suffix == ".cpp",
                    path.stem not in {"catalua_bindings_utils"},
                )
            )
        }
    )

    inventory: dict[str, list[dict[str, object]]] = {
        "types": unique_sorted(type_entries),
        "functions": unique_sorted(
            explicit_functions + macro_functions + table_functions
        ),
        "members": unique_sorted(member_entries),
        "ids": unique_sorted(id_entries),
        "hooks": unique_sorted(hook_entries, semantic=True),
        "callback_actors": unique_sorted(actor_entries, semantic=True),
        "callbacks": unique_sorted(callback_entries),
    }
    summary = {name: len(entries) for name, entries in inventory.items()}
    summary["domains"] = len(domains)

    return {
        "schema_version": 1,
        "source": {
            "repository": REPOSITORY,
            "commit": git_commit(root),
        },
        "summary": summary,
        "domains": domains,
        **inventory,
    }


def check_snapshot(path: Path) -> None:
    payload = json.loads(path.read_text(encoding="utf-8"))
    if payload.get("schema_version") != 1:
        raise RuntimeError("unsupported CBN Lua inventory schema")
    summary = payload.get("summary")
    if not isinstance(summary, dict):
        raise RuntimeError("inventory summary is missing")
    for key in (
        "types",
        "functions",
        "members",
        "ids",
        "hooks",
        "callback_actors",
        "callbacks",
    ):
        entries = payload.get(key)
        if not isinstance(entries, list) or not entries:
            raise RuntimeError(f"inventory section {key!r} is empty")
        if summary.get(key) != len(entries):
            raise RuntimeError(f"inventory summary for {key!r} is stale")
    domains = payload.get("domains")
    if not isinstance(domains, list) or summary.get("domains") != len(domains):
        raise RuntimeError("inventory domain summary is stale")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--cbn-root", type=Path)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--check-snapshot", type=Path)
    args = parser.parse_args()

    if args.check_snapshot is not None:
        check_snapshot(args.check_snapshot)
        return
    if args.cbn_root is None or args.output is None:
        parser.error("--cbn-root and --output are required when generating")

    payload = generate(args.cbn_root.resolve())
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(payload, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )


if __name__ == "__main__":
    main()
