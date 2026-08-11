#!/usr/bin/env python3
"""Regression tests for the checked-in CCB-native Lua inventory."""

from __future__ import annotations

import copy
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
                "export_roots": 101,
                "api_v5_roots": 16,
                "platform_v1_roots": 97,
                "shared_roots": 12,
                "member_dispositions": 761,
            },
        )

    def write_inventory(self, directory: str, value: object) -> Path:
        path = Path(directory) / "inventory.json"
        path.write_text(
            json.dumps(value, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
        return path

    def test_missing_platform_shared_root_is_rejected(self) -> None:
        stale = copy.deepcopy(build_inventory())
        graph = stale["export_installation_graph"]
        graph["edges"] = [
            edge
            for edge in graph["edges"]
            if not all(
                (
                    edge["caller"] == "platform_v1.install_runtime_api",
                    edge["callee"] == "shared.install_game_handle_api",
                )
            )
        ]
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaisesRegex(
                RuntimeError,
                r"platform_v1 installation root parity.*GameHandle",
            ):
                check(self.write_inventory(directory, stale))

    def test_root_without_member_disposition_is_rejected(self) -> None:
        stale = copy.deepcopy(build_inventory())
        root = next(
            entry
            for entry in stale["export_roots"]
            if entry["lua_name"] == "GameHandle"
        )
        root.pop("member_disposition")
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaisesRegex(
                RuntimeError,
                r"GameHandle lacks member disposition structure",
            ):
                check(self.write_inventory(directory, stale))

    def test_member_without_disposition_is_rejected(self) -> None:
        stale = copy.deepcopy(build_inventory())
        root = next(
            entry
            for entry in stale["export_roots"]
            if entry["lua_name"] == "GameHandle"
        )
        member = next(
            entry
            for entry in root["member_disposition"]["members"]
            if entry["id"] == "status"
        )
        member.pop("disposition")
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaisesRegex(
                RuntimeError,
                r"GameHandle.status lacks a valid disposition",
            ):
                check(self.write_inventory(directory, stale))

    def test_unbound_member_without_reason_is_rejected(self) -> None:
        stale = copy.deepcopy(build_inventory())
        root = next(
            entry
            for entry in stale["export_roots"]
            if entry["lua_name"] == "UnitValue"
        )
        member = next(
            entry
            for entry in root["member_disposition"]["members"]
            if entry["id"] == "native.canonical_wide"
        )
        member["reason"] = ""
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaisesRegex(
                RuntimeError,
                r"UnitValue.native.canonical_wide unbound.*reason",
            ):
                check(self.write_inventory(directory, stale))

    def test_registered_root_missing_from_inventory_is_rejected(self) -> None:
        stale = copy.deepcopy(build_inventory())
        stale["export_roots"] = [
            entry
            for entry in stale["export_roots"]
            if entry["lua_name"] != "GameHandle"
        ]
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaisesRegex(
                RuntimeError,
                r"registered export roots missing from inventory.*GameHandle",
            ):
                check(self.write_inventory(directory, stale))

    def test_adapted_member_without_lua_access_is_rejected(self) -> None:
        stale = copy.deepcopy(build_inventory())
        root = next(
            entry
            for entry in stale["export_roots"]
            if entry["lua_name"] == "PointCoord"
        )
        member = next(
            entry
            for entry in root["member_disposition"]["members"]
            if entry["id"] == "native.line_to"
        )
        member["lua_access"] = []
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaisesRegex(
                RuntimeError,
                r"PointCoord.native.line_to adapted.*Lua access",
            ):
                check(self.write_inventory(directory, stale))

    def test_source_drift_is_rejected(self) -> None:
        stale = build_inventory()
        stale["id_kinds"] = stale["id_kinds"][:-1]
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaisesRegex(RuntimeError, "stale"):
                check(self.write_inventory(directory, stale))

    def test_non_object_inventory_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "inventory.json"
            path.write_text("[]\n", encoding="utf-8")
            with self.assertRaisesRegex(RuntimeError, "JSON object"):
                check(path)


if __name__ == "__main__":
    unittest.main()
