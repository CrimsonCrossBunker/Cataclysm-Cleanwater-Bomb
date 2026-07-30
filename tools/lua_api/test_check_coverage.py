"""Regression tests for the entry-level CBN coverage validator."""

from __future__ import annotations

import copy
import json
import tempfile
import unittest
from pathlib import Path
from typing import Callable

from .check_coverage import check, load


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
INVENTORY = REPOSITORY_ROOT / "data/lua/reference/cbn_api_inventory.json"
COVERAGE = REPOSITORY_ROOT / "data/lua/reference/cbn_coverage.json"


class CoverageValidatorTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.inventory = load(INVENTORY)
        cls.coverage = load(COVERAGE)

    def check_modified(
        self,
        mutation: Callable[[dict[str, object]], None],
        message: str,
    ) -> None:
        payload = copy.deepcopy(self.coverage)
        mutation(payload)
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            inventory_path = root / INVENTORY.name
            coverage_path = root / COVERAGE.name
            inventory_path.write_text(
                json.dumps(self.inventory), encoding="utf-8"
            )
            coverage_path.write_text(
                json.dumps(payload), encoding="utf-8"
            )
            with self.assertRaisesRegex(RuntimeError, message):
                check(inventory_path, coverage_path, True)

    def test_committed_manifest_is_complete(self) -> None:
        result = check(INVENTORY, COVERAGE, True)
        self.assertEqual(result["completed"], 2398)
        self.assertEqual(result["percent"], 100.0)

    def test_missing_entry_is_rejected(self) -> None:
        self.check_modified(
            lambda payload: payload["entries"].pop(),
            "lack coverage",
        )

    def test_duplicate_entry_is_rejected(self) -> None:
        self.check_modified(
            lambda payload: payload["entries"].append(
                copy.deepcopy(payload["entries"][0])
            ),
            "duplicate coverage key",
        )

    def test_stale_entry_is_rejected(self) -> None:
        def add_stale(payload: dict[str, object]) -> None:
            entry = copy.deepcopy(payload["entries"][0])
            entry["key"] = "stale|entry|0|removed"
            payload["entries"].append(entry)

        self.check_modified(add_stale, "coverage entries are stale")

    def test_empty_evidence_is_rejected(self) -> None:
        def clear_evidence(payload: dict[str, object]) -> None:
            payload["entries"][0]["implementation_evidence"] = []

        self.check_modified(clear_evidence, "non-empty string list")

    def test_stale_evidence_anchor_is_rejected(self) -> None:
        def replace_evidence(payload: dict[str, object]) -> None:
            payload["entries"][0]["test_evidence"] = [
                "tests/catalua_ui_test.cpp#not a real test anchor"
            ]

        self.check_modified(replace_evidence, "evidence needle is stale")


if __name__ == "__main__":
    unittest.main()
