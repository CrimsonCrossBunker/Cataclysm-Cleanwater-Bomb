#!/usr/bin/env python3
"""Regression tests for the Platform v1 public-contract generator."""

from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

try:
    from .generate_platform_contract import (
        build_contract,
        parse_luals_declarations,
        read_declarations,
        serialize_contract,
    )
except ImportError:
    from generate_platform_contract import (  # type: ignore
        build_contract,
        parse_luals_declarations,
        read_declarations,
        serialize_contract,
    )


DECLARATIONS = """\
---@class GameHandle
---@class CcbPlatformV1
---@field platform_version 1
---@field content table
---@field runtime table
---@field dialogue table
---@field state table
---@field tasks table
---@field presentation table
---@field services table
local ccb = {}
function CcbPlatformServices.message(text) end
function CcbPlatformRuntime.on(event_name, handler_id) end
return ccb
"""

NATIVE_INVENTORY = {
    "export_roots": [
        {
            "id": "shared.game_handle",
            "lua_name": "GameHandle",
            "cpp_type": "game_handle",
            "registration": {"path": "src/lua_platform_handle.cpp"},
            "surfaces": ["platform_v1"],
        }
    ]
}


class PlatformContractGeneratorTest(unittest.TestCase):
    def test_luals_parser_collects_platform_root_and_functions(self) -> None:
        parsed = parse_luals_declarations(DECLARATIONS)
        self.assertEqual(parsed["class_count"], 2)
        self.assertEqual(parsed["function_count"], 2)
        self.assertEqual(parsed["classes"][0]["name"], "CcbPlatformV1")

    def test_contract_has_one_ccb_entrypoint_and_native_source(self) -> None:
        contract = build_contract(
            declarations=parse_luals_declarations(DECLARATIONS),
            native_inventory=NATIVE_INVENTORY,
        )
        self.assertEqual(contract["entrypoint"]["module"], "ccb")
        self.assertEqual(contract["entrypoint"]["global_tables"], [])
        self.assertEqual(contract["native"]["export_roots"][0]["lua_name"], "GameHandle")
        self.assertIn('"contract_id": "ccb_platform_api_v1"', serialize_contract(contract))

    def test_forbidden_game_surface_is_rejected_by_build_validation(self) -> None:
        invalid = DECLARATIONS.replace("---@field services table", "---@field services table\n-- game.handlers")
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "declarations.d.lua"
            path.write_text(invalid, encoding="utf-8")
            with self.assertRaisesRegex(RuntimeError, "game"):
                read_declarations(path)


if __name__ == "__main__":
    unittest.main()
