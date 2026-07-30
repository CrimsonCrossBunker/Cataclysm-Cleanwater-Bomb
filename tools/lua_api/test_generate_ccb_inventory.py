#!/usr/bin/env python3
"""Regression tests for the CCB-native Lua inventory generator."""

from __future__ import annotations

import unittest

try:
    from .generate_ccb_inventory import (
        NATIVE_DOMAINS,
        build_inventory,
        parse_event_types,
        parse_id_kinds,
        parse_json_types,
    )
except ImportError:
    from generate_ccb_inventory import (
        NATIVE_DOMAINS,
        build_inventory,
        parse_event_types,
        parse_id_kinds,
        parse_json_types,
    )


class CcbInventoryGeneratorTest(unittest.TestCase):
    def test_id_kinds_are_sorted_and_keep_native_types(self) -> None:
        entries = parse_id_kinds(
            """
            { "zone", &valid_id<zone_type> },
            { "item", &valid_id<itype> },
            """
        )
        self.assertEqual(
            entries,
            [
                {"kind": "item", "native_type": "itype"},
                {"kind": "zone", "native_type": "zone_type"},
            ],
        )

    def test_duplicate_id_kinds_are_rejected(self) -> None:
        with self.assertRaisesRegex(RuntimeError, "duplicate"):
            parse_id_kinds(
                """
                { "item", &valid_id<itype> },
                { "item", &valid_id<itype> },
                """
            )

    def test_json_loader_aliases_are_counted_once(self) -> None:
        entries = parse_json_types(
            """
            add( "terrain", &load_terrain );
            add( "ITEM", &items::load );
            add( "terrain", &load_terrain_compat );
            """
        )
        self.assertEqual(
            entries,
            [
                {"type": "ITEM", "registration_count": 1},
                {"type": "terrain", "registration_count": 2},
            ],
        )

    def test_native_event_order_is_preserved(self) -> None:
        events = parse_event_types(
            """
            enum class event_type : int {
                first_event,
                second_event,
                num_event_types // last
            };
            """
        )
        self.assertEqual(
            events,
            [{"type": "first_event"}, {"type": "second_event"}],
        )

    def test_repository_inventory_has_expected_native_baselines(self) -> None:
        inventory = build_inventory()
        self.assertEqual(len(inventory["id_kinds"]), 131)
        self.assertEqual(len(inventory["json_types"]), 190)
        self.assertEqual(len(inventory["event_types"]), 113)
        self.assertEqual(
            [entry["id"] for entry in inventory["native_domains"]],
            [domain for domain, _ in NATIVE_DOMAINS],
        )
        self.assertEqual(
            sorted(domain for domain, _ in NATIVE_DOMAINS),
            [domain for domain, _ in NATIVE_DOMAINS],
        )


if __name__ == "__main__":
    unittest.main()
