#!/usr/bin/env python3
"""Regression tests for Platform synchronization coverage checking."""

from __future__ import annotations

import unittest
import json
import tempfile
from pathlib import Path

try:
    from .check_platform_coverage import check
    from .generate_platform_contract import build_contract, parse_luals_declarations
    from .generate_platform_coverage import build_coverage
except ImportError:
    from check_platform_coverage import check  # type: ignore
    from generate_platform_contract import build_contract, parse_luals_declarations  # type: ignore
    from generate_platform_coverage import build_coverage  # type: ignore

try:
    from .test_generate_platform_contract import DECLARATIONS, NATIVE_INVENTORY
except ImportError:
    from test_generate_platform_contract import DECLARATIONS, NATIVE_INVENTORY  # type: ignore


class PlatformCoverageCheckTest(unittest.TestCase):
    def test_matching_synchronization_is_accepted(self) -> None:
        contract = build_contract(
            declarations=parse_luals_declarations(DECLARATIONS),
            native_inventory=NATIVE_INVENTORY,
        )
        coverage = build_coverage(contract, NATIVE_INVENTORY)
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "coverage.json"
            inventory = Path(directory) / "inventory.json"
            path.write_text(json.dumps(coverage), encoding="utf-8")
            inventory.write_text(json.dumps(NATIVE_INVENTORY), encoding="utf-8")
            summary = check(path, inventory, expected=coverage)
            self.assertEqual(summary["native_roots"], 1)

    def test_incomplete_synchronization_is_not_accepted(self) -> None:
        contract = build_contract(
            declarations=parse_luals_declarations(DECLARATIONS),
            native_inventory=NATIVE_INVENTORY,
        )
        coverage = build_coverage(contract, {"export_roots": [{"lua_name": "MissingRoot"}]})
        self.assertFalse(coverage["platform_sync"]["synchronized"])


if __name__ == "__main__":
    unittest.main()
