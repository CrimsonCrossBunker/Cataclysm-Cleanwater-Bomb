#!/usr/bin/env python3
"""Regression tests for the complete Lua v5 public-contract generator."""

from __future__ import annotations

import json
import tempfile
import unittest
from pathlib import Path

try:
    from .generate_public_contract import (
        CONTRACT_SCHEMA,
        COVERAGE_SCHEMA,
        DECLARATIONS,
        DEFAULT_COVERAGE,
        DEFAULT_OUTPUT,
        build_contract,
        build_coverage,
        parse_luals,
        section_counts,
    )
except ImportError:
    from generate_public_contract import (  # type: ignore
        CONTRACT_SCHEMA,
        COVERAGE_SCHEMA,
        DECLARATIONS,
        DEFAULT_COVERAGE,
        DEFAULT_OUTPUT,
        build_contract,
        build_coverage,
        parse_luals,
        section_counts,
    )


class PublicContractGeneratorTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.contract = build_contract()
        cls.coverage = build_coverage(cls.contract)

    def declarations_with_replacement(self, old: str, new: str) -> Path:
        contents = DECLARATIONS.read_text(encoding="utf-8")
        self.assertIn(old, contents)
        self.temporary_directory = tempfile.TemporaryDirectory()
        path = Path(self.temporary_directory.name) / DECLARATIONS.name
        path.write_text(contents.replace(old, new, 1), encoding="utf-8")
        return path

    def tearDown(self) -> None:
        temporary = getattr(self, "temporary_directory", None)
        if temporary is not None:
            temporary.cleanup()

    def test_complete_public_denominator(self) -> None:
        self.assertEqual(
            section_counts(self.contract),
            {
                "modules": 3,
                "namespaces": 68,
                "classes": 261,
                "functions": 488,
                "methods": 142,
                "properties": 51,
                "operators": 47,
                "enums": 26,
                "events": 113,
                "hooks": 52,
                "callbacks": 38,
                "capabilities": 16,
                "manifest_fields": 6,
            },
        )
        self.assertEqual(
            sum(len(event["fields"]) for event in self.contract["events"]),
            242,
        )

    def test_inventory_coverage_is_exactly_complete(self) -> None:
        self.assertEqual(self.coverage["public_symbols"], 2815)
        self.assertEqual(self.coverage["documented_symbols"], 2815)
        self.assertEqual(
            self.coverage["undocumented_symbols"],
            {"count": 0, "ids": []},
        )
        self.assertEqual(self.coverage["inventory_coverage_percent"], 100.0)
        self.assertIsNone(self.coverage["published_ccb_docs_coverage_percent"])

    def test_checked_outputs_match_the_generator(self) -> None:
        self.assertEqual(
            json.loads(DEFAULT_OUTPUT.read_text(encoding="utf-8")),
            self.contract,
        )
        self.assertEqual(
            json.loads(DEFAULT_COVERAGE.read_text(encoding="utf-8")),
            self.coverage,
        )

    def test_contract_schema_is_valid_with_jsonschema(self) -> None:
        try:
            import jsonschema
        except ImportError:
            self.skipTest("jsonschema is not installed")
        schema = json.loads(CONTRACT_SCHEMA.read_text(encoding="utf-8"))
        jsonschema.Draft202012Validator.check_schema(schema)
        jsonschema.validate(self.contract, schema)
        coverage_schema = json.loads(
            COVERAGE_SCHEMA.read_text(encoding="utf-8")
        )
        jsonschema.Draft202012Validator.check_schema(coverage_schema)
        jsonschema.validate(self.coverage, coverage_schema)

    def test_contract_is_complete_before_coverage_is_built(self) -> None:
        contract = build_contract()
        for event in contract["events"]:
            for field in event["fields"]:
                self.assertIn("documentation", field)

    def test_duplicate_documentation_ids_are_rejected(self) -> None:
        contract = json.loads(json.dumps(self.contract))
        contract["functions"][1]["documentation"] = dict(
            contract["functions"][0]["documentation"]
        )
        with self.assertRaisesRegex(
            RuntimeError, "duplicate generated documentation ids"
        ):
            build_coverage(contract)

    def test_game_handle_locator_cannot_regress_to_a_field(self) -> None:
        path = self.declarations_with_replacement(
            "local GameHandle = {}\n\n"
            "---@return CcbHandleLocator\n"
            "function GameHandle:locator() end",
            "---@field locator CcbHandleLocator\n"
            "local GameHandle = {}",
        )
        with self.assertRaisesRegex(
            RuntimeError, "locator must be declared as a method"
        ):
            parse_luals(path)

    def test_tripoint_fictional_method_cannot_return(self) -> None:
        path = self.declarations_with_replacement(
            "---@overload fun(self: TripointCoord, "
            "other: PointCoord): TripointCoord\n"
            "---@param other TripointCoord\n"
            "---@return TripointCoord\n"
            "function TripointCoord:add(other) end",
            "---@param other TripointCoord\n"
            "---@return TripointCoord\n"
            "function TripointCoord:add(other) end\n\n"
            "---@param other PointCoord\n"
            "---@return TripointCoord\n"
            "function TripointCoord:add_xy(other) end",
        )
        with self.assertRaisesRegex(RuntimeError, "add_xy/subtract_xy"):
            parse_luals(path)

    def test_callback_consuming_field_cannot_disappear(self) -> None:
        path = self.declarations_with_replacement(
            "---@field consuming boolean\n",
            "",
        )
        with self.assertRaisesRegex(RuntimeError, "consuming must be boolean"):
            parse_luals(path)


if __name__ == "__main__":
    unittest.main()
