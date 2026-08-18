"""Regression tests for LuaLS public-surface completeness checks."""

from __future__ import annotations

import tempfile
import unittest
from pathlib import Path

try:
    from .check_luals_declarations import (
        check,
        check_platform,
        validate_migration_content_methods,
        platform_source_usertypes,
        validate_table_mappings,
        validate_type_references,
    )
except ImportError:
    from check_luals_declarations import (
        check,
        check_platform,
        validate_migration_content_methods,
        platform_source_usertypes,
        validate_table_mappings,
        validate_type_references,
    )


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
DECLARATIONS = REPOSITORY_ROOT / "data/lua/types/ccb_api_v5.d.lua"
PLATFORM_DECLARATIONS = (
    REPOSITORY_ROOT / "data/lua/types/ccb_platform_v1.d.lua"
)


class LuaLsDeclarationTest(unittest.TestCase):
    def check_modified(
        self,
        old: str,
        new: str,
        message: str,
    ) -> None:
        contents = DECLARATIONS.read_text(encoding="utf-8")
        self.assertIn(old, contents)
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / DECLARATIONS.name
            path.write_text(
                contents.replace(old, new, 1), encoding="utf-8"
            )
            with self.assertRaisesRegex(RuntimeError, message):
                check(path)

    def test_committed_declarations_cover_the_native_surface(self) -> None:
        result = check(DECLARATIONS)
        self.assertEqual(result["tables"], 69)
        self.assertEqual(result["methods"], 469)
        self.assertEqual(result["game_tables"], 58)
        self.assertEqual(result["usertypes"], 16)
        self.assertEqual(result["coordinate_factories"], 36)

    def test_platform_declarations_cover_the_separate_native_surface(
        self,
    ) -> None:
        self.assertNotIn(
            "_ModDefinitionNative", platform_source_usertypes()
        )
        self.assertIn("ModDefinition", platform_source_usertypes())
        result = check_platform(PLATFORM_DECLARATIONS)
        self.assertEqual(result["usertypes"], 135)
        self.assertEqual(result["properties"], 9)
        self.assertEqual(result["methods"], 314)
        self.assertEqual(result["migration_content_methods"], 131)
        self.assertEqual(result["usertype_members"], 579)

        contents = PLATFORM_DECLARATIONS.read_text(encoding="utf-8")
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / PLATFORM_DECLARATIONS.name
            path.write_text(
                contents.replace(
                    "---@class ModDefinition\n",
                    "---@type ModDefinition\n",
                    1,
                ),
                encoding="utf-8",
            )
            with self.assertRaisesRegex(RuntimeError, "omit usertypes"):
                check_platform(path)

        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / PLATFORM_DECLARATIONS.name
            path.write_text(
                contents.replace("---@field core boolean\n", "", 1),
                encoding="utf-8",
            )
            with self.assertRaisesRegex(RuntimeError, "members differ"):
                check_platform(path)

        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / PLATFORM_DECLARATIONS.name
            path.write_text(
                contents.replace(
                    "---@field achievements CcbPlatformAchievementsApi\n",
                    "---@field achievements CcbPlatformAchievementsApi\n"
                    "---@field eocs CcbEocApi\n",
                    1,
                ),
                encoding="utf-8",
            )
            with self.assertRaisesRegex(RuntimeError, "service fields differ"):
                check_platform(path)

        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / PLATFORM_DECLARATIONS.name
            path.write_text(
                contents.replace(
                    "function CcbPlatformBionicsApi.grant("
                    "character, id) end\n",
                    "",
                    1,
                ),
                encoding="utf-8",
            )
            with self.assertRaisesRegex(RuntimeError, "methods differ"):
                check_platform(path)

    def test_migrator_cannot_emit_unregistered_or_dynamic_content_methods(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "migrator.py"
            path.write_text('output = "content.Mapgen {}"\n', encoding="utf-8")
            with self.assertRaisesRegex(RuntimeError, "unregistered"):
                validate_migration_content_methods({"add", "replace"}, path)

            path.write_text(
                'output = f"content.{constructor} {{}}"\n', encoding="utf-8"
            )
            with self.assertRaisesRegex(RuntimeError, "dynamic"):
                validate_migration_content_methods({"add", "replace"}, path)

    def test_unmapped_registered_table_is_rejected(self) -> None:
        with self.assertRaisesRegex(RuntimeError, "table mappings"):
            validate_table_mappings({"future_native_api": {"read"}})

    def test_undefined_luals_type_reference_is_rejected(self) -> None:
        contents = """\
---@class DefinedType
---@field child MissingType
local DefinedType = {}
"""
        with self.assertRaisesRegex(RuntimeError, "MissingType"):
            validate_type_references(contents)

    def test_platform_undefined_type_reference_is_rejected(self) -> None:
        contents = PLATFORM_DECLARATIONS.read_text(encoding="utf-8")
        old = "---@field environment CcbPlatformEnvironmentQueries\n"
        self.assertIn(old, contents)
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / PLATFORM_DECLARATIONS.name
            path.write_text(
                contents.replace(
                    old,
                    "---@field environment MissingPlatformType\n",
                    1,
                ),
                encoding="utf-8",
            )
            with self.assertRaisesRegex(
                RuntimeError,
                "MissingPlatformType",
            ):
                check_platform(path)

    def test_missing_registered_method_is_rejected(self) -> None:
        self.check_modified(
            "function CcbHordesApi.advance() end",
            "",
            "omit registered methods",
        )

    def test_missing_usertype_is_rejected(self) -> None:
        self.check_modified(
            "---@class GameHandle",
            "---@type GameHandle",
            "omit usertypes",
        )

    def test_missing_dynamic_coordinate_factory_is_rejected(self) -> None:
        self.check_modified(
            "---@field point_abs_ms fun",
            "---@field removed_abs_ms fun",
            "omit coordinate factories",
        )

    def test_missing_game_api_field_is_rejected(self) -> None:
        self.check_modified(
            "---@field weather CcbWeatherApi",
            "",
            "CcbGameApi fields",
        )

    def test_parameter_annotation_drift_is_rejected(self) -> None:
        self.check_modified(
            "---@param domain string\n"
            "---@return boolean\n"
            "function CcbGameApi.api_supports(domain) end",
            "---@param wrong_name string\n"
            "---@return boolean\n"
            "function CcbGameApi.api_supports(domain) end",
            "parameter annotations",
        )

    def test_duplicate_parameter_annotations_are_rejected(self) -> None:
        self.check_modified(
            "---@param key string\n"
            "---@param default T\n"
            "---@return T\n"
            "function CcbGameApi.state_get(key, default) end",
            "---@param key string\n"
            "---@param key T\n"
            "---@return T\n"
            "function CcbGameApi.state_get(key, default) end",
            "repeat a parameter annotation",
        )

    def test_reserved_parameter_names_are_rejected(self) -> None:
        self.check_modified(
            "---@param domain string\n"
            "---@return boolean\n"
            "function CcbGameApi.api_supports(domain) end",
            "---@param end string\n"
            "---@return boolean\n"
            "function CcbGameApi.api_supports(end) end",
            "reserved Lua parameter names",
        )

    def test_duplicate_option_fields_are_rejected(self) -> None:
        self.check_modified(
            "---@field id? string Required by `toggle_mutation`",
            "---@field uid? string Required by `toggle_mutation`",
            "repeat a field",
        )

    def test_untyped_options_tables_are_rejected(self) -> None:
        self.check_modified(
            "---@param options? CcbActionEnqueueOptions",
            "---@param options? table",
            "untyped options table",
        )

    def test_duplicate_method_declarations_are_rejected(self) -> None:
        self.check_modified(
            "function CcbHordesApi.advance() end",
            "function CcbHordesApi.advance() end\n"
            "function CcbHordesApi.advance() end",
            "repeat method",
        )

    def test_stale_v4_file_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = root / DECLARATIONS.name
            path.write_text(
                DECLARATIONS.read_text(encoding="utf-8"),
                encoding="utf-8",
            )
            (root / "ccb_api_v4.d.lua").write_text(
                "stale", encoding="utf-8"
            )
            with self.assertRaisesRegex(RuntimeError, "stale"):
                check(path)


if __name__ == "__main__":
    unittest.main()
