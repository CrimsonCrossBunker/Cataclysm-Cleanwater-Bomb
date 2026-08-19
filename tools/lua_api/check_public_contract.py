#!/usr/bin/env python3
"""Validate the checked Lua API v5 contract, coverage, and source parity."""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Iterable

try:
    from .generate_public_contract import (
        CONTRACT_SCHEMA,
        COVERAGE_SCHEMA,
        DEFAULT_COVERAGE,
        DEFAULT_OUTPUT,
        REPOSITORY_ROOT,
        build_contract,
        build_coverage,
    )
except ImportError:
    from generate_public_contract import (  # type: ignore
        CONTRACT_SCHEMA,
        COVERAGE_SCHEMA,
        DEFAULT_COVERAGE,
        DEFAULT_OUTPUT,
        REPOSITORY_ROOT,
        build_contract,
        build_coverage,
    )


CALLABLE_SECTIONS = ("functions", "methods", "operators")
LIST_SECTIONS = (
    "modules",
    "namespaces",
    "classes",
    "functions",
    "methods",
    "properties",
    "operators",
    "enums",
    "events",
    "hooks",
    "callbacks",
    "capabilities",
    "manifest_fields",
)


def load_object(path: Path) -> dict[str, object]:
    value = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(value, dict):
        raise RuntimeError(f"{path} must contain a JSON object")
    return value


def validate_schema_instance(
    value: dict[str, object], schema_path: Path, identity: str
) -> None:
    try:
        import jsonschema
    except ImportError as error:
        raise RuntimeError(
            "jsonschema is required; install tools/lua_api/requirements.txt"
        ) from error
    schema = load_object(schema_path)
    try:
        jsonschema.Draft202012Validator.check_schema(schema)
        jsonschema.Draft202012Validator(schema).validate(value)
    except jsonschema.exceptions.SchemaError as error:
        raise RuntimeError(
            f"{identity} Schema is invalid: {error.message}"
        ) from error
    except jsonschema.exceptions.ValidationError as error:
        location = ".".join(str(part) for part in error.absolute_path)
        suffix = f" at {location}" if location else ""
        raise RuntimeError(
            f"{identity} fails Schema validation{suffix}: {error.message}"
        ) from error


def entries(
    contract: dict[str, object],
) -> Iterable[tuple[str, dict[str, object]]]:
    for section in LIST_SECTIONS:
        values = contract.get(section)
        if not isinstance(values, list):
            raise RuntimeError(f"contract section {section} must be an array")
        for value in values:
            if not isinstance(value, dict):
                raise RuntimeError(
                    f"contract section {section} contains a non-object")
            yield section, value
            if section == "classes":
                for field in value.get("fields", []):
                    yield "class_fields", field
            if section == "events":
                for field in value.get("fields", []):
                    yield "event_fields", field


def validate_source(source: object, identity: str) -> None:
    if not isinstance(source, dict):
        raise RuntimeError(f"{identity} has a non-object source reference")
    path_value = source.get("path")
    line = source.get("line")
    authority = source.get("authority")
    if not isinstance(path_value, str) or not path_value:
        raise RuntimeError(f"{identity} has an invalid source path")
    if not isinstance(line, int) or line < 1:
        raise RuntimeError(f"{identity} has an invalid source line")
    if not isinstance(authority, str) or not authority:
        raise RuntimeError(f"{identity} has an invalid source authority")
    path = REPOSITORY_ROOT / path_value
    if not path.is_file():
        raise RuntimeError(
            f"{identity} source path does not exist: {path_value}")
    line_count = len(path.read_text(
        encoding="utf-8", errors="replace").splitlines())
    if line > line_count:
        raise RuntimeError(
            f"{identity} source line {line} exceeds {path_value}:{line_count}"
        )


def validate_contract(contract: dict[str, object]) -> dict[str, int]:
    if contract.get("schema_version") != 1 or contract.get("api_version") != 5:
        raise RuntimeError("public contract must be schema 1 for API v5")
    schema = load_object(CONTRACT_SCHEMA)
    if schema.get("$schema") != "https://json-schema.org/draft/2020-12/schema":
        raise RuntimeError(
            "public contract schema is not JSON Schema draft 2020-12")

    seen: dict[str, set[str]] = {section: set() for section in LIST_SECTIONS}
    documented_id_counts: dict[str, int] = {}
    property_documentation_ids = {
        str(entry.get("documentation", {}).get("id"))
        for entry in contract.get("properties", [])
        if isinstance(entry, dict) and
        isinstance(entry.get("documentation"), dict)
    }
    for section, entry in entries(contract):
        identity_value = entry.get("id", entry.get("name"))
        identity = f"{section}:{identity_value}"
        if section in seen:
            if not isinstance(identity_value, str) or not identity_value:
                raise RuntimeError(f"{section} entry lacks a stable id")
            if identity_value in seen[section]:
                raise RuntimeError(f"duplicate {section} id {identity_value}")
            seen[section].add(identity_value)
        sources = entry.get("sources")
        if not isinstance(sources, list) or not sources:
            raise RuntimeError(f"{identity} lacks source evidence")
        for source_value in sources:
            validate_source(source_value, identity)
        documentation = entry.get("documentation")
        if not isinstance(documentation, dict) or not documentation.get("id"):
            raise RuntimeError(
                f"{identity} lacks generated documentation metadata")
        if documentation.get("status") != "generated-contract-source":
            raise RuntimeError(
                f"{identity} has an invalid documentation status")
        documentation_id = str(documentation["id"])
        documented_id_counts[documentation_id] = (
            documented_id_counts.get(documentation_id, 0) + 1
        )
        if documented_id_counts[documentation_id] > 1 and (
            documentation_id not in property_documentation_ids or
            documented_id_counts[documentation_id] > 2
        ):
            raise RuntimeError(
                f"duplicate generated documentation id {documentation_id}"
            )

        if section in CALLABLE_SECTIONS:
            required = (
                "parameters",
                "returns",
                "errors",
                "api_version",
                "since",
                "deprecated",
                "deprecation_replacement",
                "capabilities",
                "examples",
            )
            missing = [field for field in required if field not in entry]
            if missing:
                raise RuntimeError(
                    f"{identity} lacks callable metadata {missing}")
            if entry["api_version"] != 5 or not entry["since"]:
                raise RuntimeError(
                    f"{identity} has invalid API version metadata")
            if not isinstance(entry["deprecated"], bool):
                raise RuntimeError(
                    f"{identity} has invalid deprecation metadata")

    counts = {section: len(values) for section, values in seen.items()}
    expected_counts = {
        "modules": 3,
        "namespaces": 71,
        "classes": 286,
        "functions": 536,
        "methods": 162,
        "properties": 51,
        "operators": 47,
        "enums": 26,
        "events": 113,
        "hooks": 54,
        "callbacks": 38,
        "capabilities": 17,
        "manifest_fields": 6,
    }
    if counts != expected_counts:
        raise RuntimeError(
            "public contract denominator drifted: "
            f"{counts}, expected {expected_counts}"
        )
    validate_schema_instance(contract, CONTRACT_SCHEMA, "public contract")
    return {**counts, "documented_ids": len(documented_id_counts)}


def check(inventory_path: Path, coverage_path: Path) -> dict[str, int]:
    expected_inventory = build_contract()
    expected_coverage = build_coverage(expected_inventory)
    actual_inventory = load_object(inventory_path)
    actual_coverage = load_object(coverage_path)
    if actual_inventory != expected_inventory:
        raise RuntimeError(
            "Lua v5 public contract is stale; run "
            "python3 tools/lua_api/generate_public_contract.py"
        )
    if actual_coverage != expected_coverage:
        raise RuntimeError(
            "Lua v5 public contract coverage is stale; run "
            "python3 tools/lua_api/generate_public_contract.py"
        )
    summary = validate_contract(actual_inventory)
    validate_schema_instance(
        actual_coverage, COVERAGE_SCHEMA, "public contract coverage"
    )
    if actual_coverage.get("undocumented_symbols") != {
        "count": 0,
        "ids": [],
    }:
        raise RuntimeError(
            "Lua v5 public contract contains undocumented symbols")
    if actual_coverage.get("inventory_coverage_percent") != 100.0:
        raise RuntimeError(
            "Lua v5 public contract inventory coverage is not 100%")
    if actual_coverage.get("public_symbols") != summary["documented_ids"]:
        raise RuntimeError(
            "Lua v5 public contract coverage denominator does not match "
            "its unique documented symbols"
        )
    return summary


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--inventory", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--coverage", type=Path, default=DEFAULT_COVERAGE)
    arguments = parser.parse_args()
    summary = check(arguments.inventory, arguments.coverage)
    print(
        "Lua v5 public contract verified: "
        f"{summary['functions']} callable paths, "
        f"{summary['methods']} methods, {summary['properties']} properties, "
        f"{summary['operators']} operators, {summary['events']} events, "
        f"{summary['hooks']} hooks, {summary['callbacks']} callbacks, "
        "0 undocumented symbols"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
