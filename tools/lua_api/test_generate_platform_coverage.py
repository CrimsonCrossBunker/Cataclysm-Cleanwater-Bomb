#!/usr/bin/env python3
"""Regression tests for Platform synchronization coverage generation."""

from __future__ import annotations

import unittest

try:
    from .generate_platform_contract import (
        build_contract,
        parse_luals_declarations,
    )
    from .generate_platform_coverage import (
        build_coverage,
        serialize_coverage,
    )
except ImportError:
    from generate_platform_contract import (  # type: ignore
        build_contract,
        parse_luals_declarations,
    )
    from generate_platform_coverage import (  # type: ignore
        build_coverage,
        serialize_coverage,
    )

try:
    from .test_generate_platform_contract import DECLARATIONS, NATIVE_INVENTORY
except ImportError:
    from test_generate_platform_contract import (  # type: ignore
        DECLARATIONS,
        NATIVE_INVENTORY,
    )


class PlatformCoverageGeneratorTest(unittest.TestCase):
    def test_synchronization_coverage_matches_declared_native_root(
        self,
    ) -> None:
        contract = build_contract(
            declarations=parse_luals_declarations(DECLARATIONS),
            native_inventory=NATIVE_INVENTORY,
        )
        coverage = build_coverage(contract, NATIVE_INVENTORY)
        sync = coverage["platform_sync"]
        self.assertTrue(sync["synchronized"])
        self.assertEqual(sync["native_export_roots_declared"], 1)
        self.assertIn(
            "platform_luals_native_registration", coverage["coverage_kind"]
        )
        self.assertNotIn("JSON/EOC", serialize_coverage(coverage))

    def test_unmatched_native_root_is_reported(self) -> None:
        contract = build_contract(
            declarations=parse_luals_declarations(DECLARATIONS),
            native_inventory=NATIVE_INVENTORY,
        )
        inventory = {
            "export_roots": [{"id": "other", "lua_name": "OtherRoot"}]
        }
        coverage = build_coverage(contract, inventory)
        self.assertFalse(coverage["platform_sync"]["synchronized"])
        self.assertEqual(
            coverage["platform_sync"]["unmatched_native_export_roots"],
            ["OtherRoot"],
        )


if __name__ == "__main__":
    unittest.main()
