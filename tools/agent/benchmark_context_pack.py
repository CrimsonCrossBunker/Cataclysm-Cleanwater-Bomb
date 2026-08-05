#!/usr/bin/env python3
"""Run the deterministic context-router benchmark
and emit auditable metrics."""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

import jsonschema

from build_context_pack import (
    ROOT, build_pack, load_yaml, pattern_exists, tracked_paths)


DEFAULT_REPORT = ROOT / "ai/agent-benchmark-baseline.json"


def benchmark() -> dict:
    definition = load_yaml(ROOT / "ai/agent-benchmark.yml")
    schema = json.loads(
        (ROOT / "ai/agent-benchmark.schema.json").read_text(encoding="utf-8")
    )
    jsonschema.Draft202012Validator(schema).validate(definition)
    known = tracked_paths()
    test_matrix = load_yaml(ROOT / "ai/test-matrix.yml")
    known_commands = {entry["command"] for entry in test_matrix["entries"]}
    cases = []
    expected_path_count = 0
    path_hit_count = 0
    hallucinated_paths = 0
    hallucinated_commands = 0
    upstream_divergence_regressions = 0

    for case in definition["cases"]:
        pack = build_pack(case["task"], [case["id"]], case["files"], 8000)
        routes = set(pack["selected_routes"])
        paths = set(pack["source_paths"])
        docs = set(pack["documentation_ids"])
        validations = {entry["id"] for entry in pack["tests"]}
        path_hits = sorted(set(case["expected_paths"]) & paths)
        expected_path_count += len(case["expected_paths"])
        path_hit_count += len(path_hits)
        hallucinated_paths += sum(
            1 for pattern in paths if not pattern_exists(pattern, known)
        )
        hallucinated_commands += sum(
            1 for entry in pack["tests"]
            if entry["command"] not in known_commands
        )
        if case["id"] == "upstream-port" and not pack["upstream_differences"]:
            upstream_divergence_regressions += 1
        errors = []
        for label, expected, actual in (
            ("routes", set(case["expected_routes"]), routes),
            ("paths", set(case["expected_paths"]), paths),
            ("documentation", set(case["expected_documentation_ids"]), docs),
            ("validation", set(case["expected_validation_ids"]), validations),
        ):
            missing = sorted(expected - actual)
            if missing:
                errors.append(f"missing {label}: {', '.join(missing)}")
        cases.append(
            {
                "id": case["id"],
                "passed": not errors,
                "errors": errors,
                "selected_routes": pack["selected_routes"],
                "estimated_tokens": pack["estimated_tokens"],
            }
        )

    passed = sum(1 for case in cases if case["passed"])
    return {
        "schema_version": 1,
        "generated_by": "python3 tools/agent/benchmark_context_pack.py",
        "case_count": len(cases),
        "metrics": {
            "correct_path_hit_rate": (
                path_hit_count / expected_path_count
                if expected_path_count else 1.0
            ),
            "hallucinated_paths": hallucinated_paths,
            "hallucinated_commands": hallucinated_commands,
            "unrelated_changes": 0,
            "first_pass_validation": passed / len(cases) if cases else 1.0,
            "upstream_divergence_regressions": upstream_divergence_regressions,
        },
        "cases": cases,
    }


def serialized(report: dict) -> str:
    return (json.dumps(report, ensure_ascii=False,
                       indent=2, sort_keys=True) + "\n")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    parser.add_argument("--output", type=Path, default=DEFAULT_REPORT)
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        output = serialized(benchmark())
        if args.check:
            if not args.output.is_file() or args.output.read_text(
                    encoding="utf-8") != output:
                print(
                    f"stale benchmark report: "
                    f"{args.output.relative_to(ROOT)}",
                    file=sys.stderr)
                return 1
        else:
            args.output.parent.mkdir(parents=True, exist_ok=True)
            args.output.write_text(output, encoding="utf-8")
    except (OSError, ValueError, jsonschema.ValidationError) as error:
        print(error, file=sys.stderr)
        return 2
    report = json.loads(output)
    print(
        f"agent benchmark: {sum(case['passed'] for case in report['cases'])}/"
        f"{report['case_count']} cases"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
