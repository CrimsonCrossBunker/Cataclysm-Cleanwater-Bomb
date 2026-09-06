#!/usr/bin/env python3
"""Regression tests for the checked-in Platform-native Lua inventory."""

from __future__ import annotations

import copy
import json
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

try:
    from .check_platform_native_inventory import check
    from .generate_platform_native_inventory import (
        DEFAULT_OUTPUT,
    )
except ImportError:
    from check_platform_native_inventory import check
    from generate_platform_native_inventory import (
        DEFAULT_OUTPUT,
    )


class PlatformNativeInventoryCheckTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.inventory = json.loads(DEFAULT_OUTPUT.read_text(encoding="utf-8"))

    def check_fixture(self, path: Path) -> dict[str, int]:
        # Negative cases exercise validation against a fixed source snapshot.
        # The repository test below keeps the real source scan end to end.
        with patch(
            f"{check.__module__}.build_native_inventory",
            return_value=self.inventory,
        ):
            return check(path)

    def test_checked_in_inventory_matches_sources(self) -> None:
        summary = check(DEFAULT_OUTPUT)
        for key in (
            "id_kinds",
            "json_types",
            "event_types",
            "native_domains",
            "export_roots",
            "platform_v1_roots",
            "member_dispositions",
        ):
            self.assertGreater(summary[key], 0)
        self.assertEqual(summary["export_roots"], summary["platform_v1_roots"])

    def write_inventory(self, directory: str, value: object) -> Path:
        path = Path(directory) / "inventory.json"
        path.write_text(
            json.dumps(value, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
        return path

    def test_missing_platform_shared_root_is_rejected(self) -> None:
        stale = copy.deepcopy(self.inventory)
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
                self.check_fixture(self.write_inventory(directory, stale))

    def test_root_without_member_disposition_is_rejected(self) -> None:
        stale = copy.deepcopy(self.inventory)
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
                self.check_fixture(self.write_inventory(directory, stale))

    def test_member_without_disposition_is_rejected(self) -> None:
        stale = copy.deepcopy(self.inventory)
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
                self.check_fixture(self.write_inventory(directory, stale))

    def test_unbound_member_without_reason_is_rejected(self) -> None:
        stale = copy.deepcopy(self.inventory)
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
                self.check_fixture(self.write_inventory(directory, stale))

    def test_registered_root_missing_from_inventory_is_rejected(self) -> None:
        stale = copy.deepcopy(self.inventory)
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
                self.check_fixture(self.write_inventory(directory, stale))

    def test_adapted_member_without_lua_access_is_rejected(self) -> None:
        stale = copy.deepcopy(self.inventory)
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
                self.check_fixture(self.write_inventory(directory, stale))

    def test_source_drift_is_rejected(self) -> None:
        stale = copy.deepcopy(self.inventory)
        stale["id_kinds"] = stale["id_kinds"][:-1]
        with tempfile.TemporaryDirectory() as directory:
            with self.assertRaisesRegex(RuntimeError, "stale"):
                self.check_fixture(self.write_inventory(directory, stale))

    def test_non_object_inventory_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "inventory.json"
            path.write_text("[]\n", encoding="utf-8")
            with self.assertRaisesRegex(RuntimeError, "JSON object"):
                self.check_fixture(path)


if __name__ == "__main__":
    unittest.main()
