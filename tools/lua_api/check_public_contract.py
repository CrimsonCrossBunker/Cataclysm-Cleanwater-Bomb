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


if __name__ == "__main__":
    raise SystemExit(main())