#!/usr/bin/env python3
"""Regression tests for the checked-in CCB-native Lua inventory."""

from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

try:
    from .check_ccb_inventory import check
    from .generate_ccb_inventory import DEFAULT_OUTPUT, build_inventory
except ImportError:
    from check_ccb_inventory import check
    from generate_ccb_inventory import DEFAULT_OUTPUT, build_inventory


class CcbInventoryCheckTest(unittest.TestCase):
    def test_checked_in_inventory_matches_sources(self) -> None:
        summary = check(DEFAULT_OUTPUT)
        self.assertEqual(
            summary,
            {
                "id_kinds": 132,
                "json_types": 190,
                "event_types": 113,
                "native_domains": 39,
            },
        )

    def test_source_drift_is_rejected(self) -> None:
        stale = build_inventory()
        stale["id_kinds"] = stale["id_kinds"][:-1]
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "inventory.json"
            path.write_text(
                json.dumps(stale, ensure_ascii=False, indent=2) + "\n",
                encoding="utf-8",
            )
            with self.assertRaisesRegex(RuntimeError, "stale"):
                check(path)

    def test_non_object_inventory_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "inventory.json"
            path.write_text("[]\n", encoding="utf-8")
            with self.assertRaisesRegex(RuntimeError, "JSON object"):
                check(path)


if __name__ == "__main__":
    unittest.main()
