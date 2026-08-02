#!/usr/bin/env python3
"""Build a deterministic, bounded context pack from tracked CCB metadata."""

from __future__ import annotations

import argparse
import fnmatch
import json
import subprocess
import sys
from pathlib import Path

import jsonschema
import yaml


ROOT = Path(__file__).resolve().parents[2]
MIN_TOKEN_LIMIT = 512


def load_yaml(path: Path) -> dict:
    data = yaml.safe_load(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict):
        raise ValueError(f"{path.relative_to(ROOT)} must contain a mapping")
    return data


def tracked_paths() -> list[str]:
    output = subprocess.run(
        ["git", "ls-files", "-z", "--cached"],
        cwd=ROOT,
        check=True,
        stdout=subprocess.PIPE,
    ).stdout.decode("utf-8")
    paths = sorted(item for item in output.split("\0") if item)
    if any("obj-lua" in Path(path).parts for path in paths):
        raise ValueError("obj-lua must not enter a context pack")
    return paths


def matches(pattern: str, path: str) -> bool:
    clean = pattern.rstrip("/")
    if "obj-lua" in Path(clean).parts:
        raise ValueError("obj-lua is forbidden in task routing")
    if any(char in clean for char in "*?["):
        return fnmatch.fnmatch(path, clean)
    return path == clean or path.startswith(clean + "/")


def pattern_exists(pattern: str, known: list[str]) -> bool:
    return any(matches(pattern, path) for path in known)


def selected_routes(
    router: dict,
    task: str,
    task_ids: list[str],
    files: list[str],
) -> list[dict]:
    by_id = {entry["id"]: entry for entry in router["entries"]}
    unknown = sorted(set(task_ids) - set(by_id))
    if unknown:
        raise ValueError("unknown task route: " + ", ".join(unknown))
    selected = {task_id for task_id in task_ids}
    if selected:
        return [by_id[route_id] for route_id in sorted(selected)]
    folded = task.casefold()
    for entry in router["entries"]:
        if any(keyword.casefold() in folded for keyword in entry["keywords"]):
            selected.add(entry["id"])
        if any(
            matches(pattern, file_path)
            for pattern in entry["paths"]
            for file_path in files
        ):
            selected.add(entry["id"])
    if not selected:
        selected.add("repository-navigation")
    return [by_id[route_id] for route_id in sorted(selected)]


def nearest_agents(files: list[str], project_entries: list[dict]) -> list[str]:
    candidates = {"AGENTS.md"}
    candidates.update(entry["instructions"] for entry in project_entries)
    for file_path in files:
        parent = Path(file_path).parent
        while str(parent) not in {"", "."}:
            candidate = str(parent / "AGENTS.md")
            if (ROOT / candidate).is_file():
                candidates.add(candidate)
            parent = parent.parent
    return sorted(candidates, key=lambda item: (item.count("/"), item))


def generated_for_paths(generated: dict, patterns: list[str], files: list[str]) -> list[dict]:
    selected: list[dict] = []
    for entry in generated["entries"]:
        generated_paths = entry.get("paths", [])
        overlaps = any(
            matches(left, right.rstrip("/")) or matches(right, left.rstrip("/"))
            for left in generated_paths
            for right in patterns
        )
        file_match = any(
            matches(pattern, file_path)
            for pattern in generated_paths
            for file_path in files
        )
        if overlaps or file_match:
            selected.append(
                {
                    "id": entry["id"],
                    "paths": generated_paths,
                    "generated_by": entry["generated_by"],
                    "validation_id": entry["validation_id"],
                    "tracked": entry["tracked"],
                }
            )
    return sorted(selected, key=lambda item: item["id"])


def estimated_tokens(value: object) -> int:
    encoded = json.dumps(value, ensure_ascii=False, sort_keys=True)
    return (len(encoded) + 3) // 4


def truncate_linewise(content: str, characters: int) -> tuple[str, bool]:
    if len(content) <= characters:
        return content, False
    if characters <= 32:
        return "[truncated]\n"[:characters], True
    prefix = content[: characters - 13]
    if "\n" in prefix:
        prefix = prefix.rsplit("\n", 1)[0]
    return prefix.rstrip() + "\n[truncated]\n", True


def fit_budget(pack: dict, agent_paths: list[str], token_limit: int) -> dict:
    contents = {
        path: (ROOT / path).read_text(encoding="utf-8") for path in agent_paths
    }
    pack["agents"] = [
        {"path": path, "content": "", "truncated": False} for path in agent_paths
    ]
    pack["estimated_tokens"] = estimated_tokens(pack)
    pack["truncated"] = False

    prune_order = ("source_paths", "source_symbols", "documentation_ids")
    for field in prune_order:
        while pack["estimated_tokens"] > token_limit and len(pack[field]) > 1:
            pack[field].pop()
            pack["truncated"] = True
            pack["estimated_tokens"] = estimated_tokens(pack)

    available_chars = max(0, (token_limit - pack["estimated_tokens"]) * 4)
    for index, path in enumerate(agent_paths):
        remaining = len(agent_paths) - index
        allocation = available_chars // remaining if remaining else 0
        content, was_truncated = truncate_linewise(contents[path], allocation)
        pack["agents"][index]["content"] = content
        pack["agents"][index]["truncated"] = was_truncated
        pack["truncated"] = pack["truncated"] or was_truncated
        available_chars -= len(content)

    pack["estimated_tokens"] = estimated_tokens(pack)
    while pack["estimated_tokens"] > token_limit:
        changed = False
        for agent in reversed(pack["agents"]):
            if not agent["content"]:
                continue
            excess = (pack["estimated_tokens"] - token_limit) * 4
            keep = max(0, len(agent["content"]) - excess - 8)
            agent["content"], _ = truncate_linewise(agent["content"], keep)
            agent["truncated"] = True
            pack["truncated"] = True
            changed = True
            break
        if not changed:
            break
        pack["estimated_tokens"] = estimated_tokens(pack)
    return pack


def build_pack(task: str, task_ids: list[str], files: list[str], token_limit: int) -> dict:
    if token_limit < MIN_TOKEN_LIMIT:
        raise ValueError(f"token limit must be at least {MIN_TOKEN_LIMIT}")
    known = tracked_paths()
    unknown_files = sorted(set(files) - set(known))
    if unknown_files:
        raise ValueError("requested files are not tracked: " + ", ".join(unknown_files))

    router = load_yaml(ROOT / "ai/task-router.yml")
    project = load_yaml(ROOT / "ai/project-map.yml")
    tests = load_yaml(ROOT / "ai/test-matrix.yml")
    generated = load_yaml(ROOT / "ai/generated-files.yml")
    routes = selected_routes(router, task, task_ids, files)

    project_by_id = {entry["id"]: entry for entry in project["entries"]}
    project_ids = sorted({item for route in routes for item in route["project_ids"]})
    project_entries = [project_by_id[item] for item in project_ids]
    route_patterns = {
        pattern for route in routes for pattern in route["paths"]
    }
    project_patterns = {
        pattern for entry in project_entries for pattern in entry["paths"]
    }
    patterns = sorted(route_patterns | project_patterns)
    missing_patterns = [
        pattern for pattern in patterns if not pattern_exists(pattern, known)
    ]
    if missing_patterns:
        raise ValueError(
            f"router paths do not match tracked files: {', '.join(missing_patterns)}"
        )

    route_validation_ids = {
        item for route in routes for item in route["validation_ids"]
    }
    project_validation_ids = {
        item
        for entry in project_entries
        for item in entry.get("validation_ids", [])
    }
    validation_ids = sorted(route_validation_ids | project_validation_ids)
    tests_by_id = {entry["id"]: entry for entry in tests["entries"]}
    selected_tests = [tests_by_id[item] for item in validation_ids]
    route_compatibility = {
        item for route in routes for item in route["compatibility"]
    }
    project_boundaries = {
        item
        for entry in project_entries
        for item in entry.get("boundaries", [])
    }
    pack = {
        "schema_version": 1,
        "task": task,
        "selected_routes": [entry["id"] for entry in routes],
        "requested_files": sorted(files),
        "token_limit": token_limit,
        "estimated_tokens": 0,
        "truncated": False,
        "agents": [],
        "source_paths": patterns,
        "source_symbols": sorted(
            {item for route in routes for item in route["source_symbols"]}
        ),
        "documentation_ids": sorted(
            {item for route in routes for item in route["documentation_ids"]}
        ),
        "tests": selected_tests,
        "generated_boundaries": generated_for_paths(generated, patterns, files),
        "compatibility": sorted(route_compatibility | project_boundaries),
        "upstream_differences": sorted(
            {item for route in routes for item in route["upstream_differences"]}
        ),
        "acceptance_commands": [
            f"(cd {entry['workdir']} && {entry['command']})"
            for entry in selected_tests
        ],
    }
    return fit_budget(pack, nearest_agents(files, project_entries), token_limit)


def markdown(pack: dict) -> str:
    lines = [
        f"# Context pack: {pack['task'] or 'repository navigation'}",
        "",
        "Routes: " + ", ".join(pack["selected_routes"]),
        f"Budget: {pack['estimated_tokens']}/{pack['token_limit']} estimated tokens",
        "",
    ]
    for agent in pack["agents"]:
        lines.extend([f"## {agent['path']}", "", agent["content"].rstrip(), ""])
    for title, field in (
        ("Source paths", "source_paths"),
        ("Source symbols", "source_symbols"),
        ("Documentation IDs", "documentation_ids"),
        ("Compatibility", "compatibility"),
        ("Upstream differences", "upstream_differences"),
        ("Acceptance commands", "acceptance_commands"),
    ):
        lines.extend([f"## {title}", ""])
        lines.extend(f"- {item}" for item in pack[field])
        lines.append("")
    return "\n".join(lines).rstrip() + "\n"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--task", default="")
    parser.add_argument("--task-id", action="append", default=[])
    parser.add_argument("--file", action="append", default=[])
    parser.add_argument("--token-limit", type=int, default=8000)
    parser.add_argument("--format", choices=("json", "markdown"), default="json")
    parser.add_argument("--output", type=Path)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        pack = build_pack(args.task, args.task_id, args.file, args.token_limit)
        schema = json.loads((ROOT / "ai/context-pack.schema.json").read_text(encoding="utf-8"))
        jsonschema.Draft202012Validator(schema).validate(pack)
    except (OSError, ValueError, jsonschema.ValidationError) as error:
        print(error, file=sys.stderr)
        return 2
    output = (
        json.dumps(pack, ensure_ascii=False, indent=2) + "\n"
        if args.format == "json"
        else markdown(pack)
    )
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(output, encoding="utf-8")
    else:
        print(output, end="")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
