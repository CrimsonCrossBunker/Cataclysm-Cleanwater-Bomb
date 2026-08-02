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


if __name__ == "__main__":
    raise SystemExit(main())