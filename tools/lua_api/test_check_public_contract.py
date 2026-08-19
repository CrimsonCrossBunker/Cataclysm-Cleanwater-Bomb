#!/usr/bin/env python3
"""Regression tests for checked Lua v5 contract and coverage drift."""

from __future__ import annotations

import copy
import json
import tempfile
import unittest
from pathlib import Path

try:
    from .check_public_contract import check, load_object, validate_contract
    from .generate_public_contract import (
        DEFAULT_COVERAGE,
        DEFAULT_OUTPUT,
        build_contract,
        build_coverage,
    )
except ImportError:
    from check_public_contract import check, load_object, validate_contract
    from generate_public_contract import (  # type: ignore
        DEFAULT_COVERAGE,
        DEFAULT_OUTPUT,
        build_contract,
        build_coverage,
    )


class PublicContractCheckTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.contract = build_contract()
        cls.coverage = build_coverage(cls.contract)

    def test_checked_contract_matches_all_authorities(self) -> None:
        summary = check(DEFAULT_OUTPUT, DEFAULT_COVERAGE)
        self.assertEqual(summary["functions"], 536)
        self.assertEqual(summary["methods"], 162)
        self.assertEqual(summary["events"], 113)

    def test_stale_inventory_is_rejected(self) -> None:
        contract = copy.deepcopy(self.contract)
        contract["functions"].pop()
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            inventory = root / "inventory.json"
            coverage = root / "coverage.json"
            inventory.write_text(json.dumps(contract), encoding="utf-8")
            coverage.write_text(json.dumps(self.coverage), encoding="utf-8")
            with self.assertRaisesRegex(RuntimeError, "contract is stale"):
                check(inventory, coverage)

    def test_missing_source_is_rejected(self) -> None:
        contract = copy.deepcopy(self.contract)
        contract["functions"][0]["sources"][0]["path"] = "missing/source.cpp"
        with self.assertRaisesRegex(RuntimeError, "does not exist"):
            validate_contract(contract)

    def test_missing_callable_metadata_is_rejected(self) -> None:
        contract = copy.deepcopy(self.contract)
        contract["functions"][0].pop("errors")
        with self.assertRaisesRegex(RuntimeError, "lacks callable metadata"):
            validate_contract(contract)

    def test_json_inputs_must_be_objects(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "array.json"
            path.write_text("[]\n", encoding="utf-8")
            with self.assertRaisesRegex(RuntimeError, "JSON object"):
                load_object(path)


if __name__ == "__main__":
    unittest.main()
