#!/usr/bin/env python3
"""Regression tests for the Platform v1 public-contract checker."""

from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

try:
    from .check_platform_contract import check
    from .generate_platform_contract import (
        build_contract,
        parse_luals_declarations,
        serialize_contract,
    )
except ImportError:
    from check_platform_contract import check  # type: ignore
    from generate_platform_contract import (  # type: ignore
        build_contract,
        parse_luals_declarations,
        serialize_contract,
    )

try:
    from .test_generate_platform_contract import DECLARATIONS, NATIVE_INVENTORY
except ImportError:
    from test_generate_platform_contract import (  # type: ignore
        DECLARATIONS,
        NATIVE_INVENTORY,
    )


class PlatformContractCheckTest(unittest.TestCase):
    def test_checked_in_contract_matches_sources(self) -> None:
        summary = check()
        self.assertGreater(summary["export_roots"], 0)

    def test_matching_contract_is_accepted(self) -> None:
        contract = build_contract(
            declarations=parse_luals_declarations(DECLARATIONS),
            native_inventory=NATIVE_INVENTORY,
        )
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "contract.json"
            declarations = Path(directory) / "declarations.d.lua"
            inventory = Path(directory) / "inventory.json"
            path.write_text(serialize_contract(contract), encoding="utf-8")
            declarations.write_text(DECLARATIONS, encoding="utf-8")
            inventory.write_text(
                json.dumps(NATIVE_INVENTORY), encoding="utf-8"
            )
            expected_contract = build_contract(
                declarations=parse_luals_declarations(DECLARATIONS),
                native_inventory=NATIVE_INVENTORY,
                declarations_path=declarations,
                native_inventory_path=inventory,
            )
            path.write_text(
                serialize_contract(expected_contract), encoding="utf-8"
            )
            summary = check(path, inventory, declarations)
            self.assertEqual(summary["export_roots"], 1)

    def test_changed_contract_is_rejected(self) -> None:
        contract = build_contract(
            declarations=parse_luals_declarations(DECLARATIONS),
            native_inventory=NATIVE_INVENTORY,
        )
        contract["entrypoint"]["module"] = "wrong"
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "contract.json"
            declarations = Path(directory) / "declarations.d.lua"
            inventory = Path(directory) / "inventory.json"
            path.write_text(json.dumps(contract), encoding="utf-8")
            declarations.write_text(DECLARATIONS, encoding="utf-8")
            inventory.write_text(
                json.dumps(NATIVE_INVENTORY), encoding="utf-8"
            )
            with self.assertRaisesRegex(RuntimeError, "stale"):
                check(path, inventory, declarations)


if __name__ == "__main__":
    unittest.main()
