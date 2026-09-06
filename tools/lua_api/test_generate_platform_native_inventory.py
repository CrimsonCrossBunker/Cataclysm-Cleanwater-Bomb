#!/usr/bin/env python3
"""Regression tests for the Platform-native Lua inventory generator."""

from __future__ import annotations

import json
import unittest

try:
    from .generate_platform_native_inventory import (
        DEFAULT_OUTPUT,
        NATIVE_DOMAINS,
        build_installer_model,
        build_native_inventory,
        parse_event_types,
        parse_id_kinds,
        parse_json_types,
        parse_usertype_registrations,
        serialize_native_inventory,
    )
except ImportError:
    from generate_platform_native_inventory import (
        DEFAULT_OUTPUT,
        NATIVE_DOMAINS,
        build_installer_model,
        build_native_inventory,
        parse_event_types,
        parse_id_kinds,
        parse_json_types,
        parse_usertype_registrations,
        serialize_native_inventory,
    )


class PlatformNativeInventoryGeneratorTest(unittest.TestCase):
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

    def test_usertype_parser_handles_nested_cpp_and_top_level_keys(
        self,
    ) -> None:
        registrations = parse_usertype_registrations(
            r'''
            // lua.new_usertype<ignored>("Ignored", sol::no_constructor);
            lua.new_usertype<std::pair<int, std::vector<long>>>(
                "FutureRoot", sol::no_constructor,
                "value", []( const auto &self ) {
                    return std::string( "not,a,member" ) + self.value;
                },
                sol::meta_function::to_string, &future_root::to_string );
            ''',
            "fixture.cpp",
        )
        self.assertEqual(len(registrations), 1)
        self.assertEqual(
            registrations[0]["cpp_type"],
            "std::pair<int, std::vector<long>>",
        )
        self.assertEqual(registrations[0]["lua_name"], "FutureRoot")
        self.assertEqual(
            [entry["id"] for entry in registrations[0]["members"]],
            ["value", "__tostring"],
        )
        self.assertEqual(
            registrations[0]["members"][0]["cpp_members"], ["value"]
        )

    def test_all_runtime_usertype_installers_are_modelled(self) -> None:
        installers, edges, registrations_by_installer = build_installer_model()
        runtime_installer = next(
            installer
            for installer in installers
            if installer["id"] == "platform_v1.install_runtime_api"
        )
        self.assertEqual(
            runtime_installer["source"]["path"],
            "src/lua_platform_runtime_services.cpp",
        )
        expected_content_installers = {
            "platform_v1.items_content_transaction.install_lua_api": (
                "src/lua_platform_content_items.cpp"
            ),
            "platform_v1.creatures_content_transaction.install_lua_api": (
                "src/lua_platform_content_creatures.cpp"
            ),
            "platform_v1.character_content_transaction.install_lua_api": (
                "src/lua_platform_content_character.cpp"
            ),
            "platform_v1.presentation_content_transaction.install_lua_api": (
                "src/lua_platform_content_presentation.cpp"
            ),
            "platform_v1.worldgen_content_transaction.install_lua_api": (
                "src/lua_platform_content_worldgen.cpp"
            ),
        }
        self.assertEqual(
            {
                str(installer["id"]): str(installer["source"]["path"])
                for installer in installers
                if str(installer["id"]) in expected_content_installers
            },
            expected_content_installers,
        )
        expected_roots = {
            "platform_v1.install_runtime_callback_api": [],
            "platform_v1.install_runtime_dialogue_presentation_api": [
                "PlatformCanvasContext",
                "PlatformDialogueContext",
            ],
            "platform_v1.install_runtime_state_task_api": [],
            "shared.install_camp_api": [
                "CampExpansionToken",
                "CampTaskToken",
            ],
            "shared.install_map_api": ["MapTileToken"],
            "shared.install_mapgen_service_api": ["MapgenUpdateToken"],
            "shared.install_overmap_api": ["OvermapTileToken"],
            "shared.install_trade_api": ["TradeQuoteToken"],
        }
        roots_by_installer = {
            str(installer["id"]): installer["direct_roots"]
            for installer in installers
            if str(installer["id"]) in expected_roots
        }
        self.assertEqual(roots_by_installer, expected_roots)
        self.assertEqual(
            {
                str(registration["lua_name"]): str(registration["_installer"])
                for installer_id, registrations in (
                    registrations_by_installer.items()
                )
                if installer_id in expected_roots
                for registration in registrations
            },
            {
                root: installer_id
                for installer_id, roots in expected_roots.items()
                for root in roots
            },
        )
        runtime_edges = {
            (str(edge["caller"]), str(edge["callee"])) for edge in edges
        }
        self.assertTrue(
            all(
                ("platform_v1.install_runtime_api", installer_id)
                in runtime_edges
                for installer_id in expected_roots
            )
        )
        self.assertTrue(
            all(
                (
                    "platform_v1.content_transaction.install_lua_api",
                    installer_id,
                )
                in runtime_edges
                for installer_id in expected_content_installers
            )
        )

    def test_repository_inventory_has_expected_native_baselines(self) -> None:
        inventory = build_native_inventory()
        self.assertEqual(inventory["schema_version"], 2)
        self.assertEqual(len(inventory["id_kinds"]), 132)
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
        surfaces = {
            entry["id"]: set(entry["roots"])
            for entry in inventory["export_surfaces"]
        }
        self.assertEqual(
            set(surfaces), {"platform_v1"}
        )
        self.assertEqual(
            len(inventory["export_roots"]), len(surfaces["platform_v1"])
        )

    def test_repository_inventory_records_alias_and_dispositions(self) -> None:
        inventory = build_native_inventory()
        roots = {
            entry["lua_name"]: entry
            for entry in inventory["export_roots"]
        }
        self.assertEqual(
            roots["ModDefinition"]["registration_name"],
            "_ModDefinitionNative",
        )
        unit_members = {
            entry["id"]: entry
            for entry in roots["UnitValue"]["member_disposition"]["members"]
        }
        self.assertEqual(
            unit_members["native.canonical_wide"]["disposition"],
            "unbound",
        )
        point_members = {
            entry["id"]: entry
            for entry in roots["PointCoord"]["member_disposition"]["members"]
        }
        self.assertEqual(
            point_members["native.line_to"]["lua_access"],
            ["ccb.services.coords.line"],
        )
        handle_members = {
            entry["id"]: entry
            for entry in roots["GameHandle"]["member_disposition"]["members"]
        }
        self.assertEqual(
            handle_members["native.resolve_item"]["reason_code"],
            "native-pointer-escape",
        )
        self.assertEqual(
            handle_members["native.runtime_owner"]["disposition"],
            "unbound",
        )
        self.assertIn(
            "runtime-owner-identity",
            roots["GameHandle"]["lifetime"]["guards"],
        )
        zone_members = {
            entry["id"]: entry
            for entry in roots["ZoneToken"]["member_disposition"]["members"]
        }
        self.assertNotIn("native.ordinal", zone_members)
        self.assertNotIn("native.runtime_generation", zone_members)
        self.assertEqual(
            zone_members["native.runtime"]["disposition"],
            "unbound",
        )
        self.assertEqual(
            zone_members["native.lifetime_identity"]["disposition"],
            "unbound",
        )
        item_use_members = {
            entry["id"]: entry
            for entry in roots["ItemUseContext"]["member_disposition"][
                "members"
            ]
        }
        self.assertIn("native.handle_runtime", item_use_members)
        for identity in (
            "native.copy_constructor",
            "native.copy_assignment",
            "native.move_constructor",
            "native.move_assignment",
        ):
            self.assertEqual(
                item_use_members[identity]["disposition"], "unbound"
            )
        self.assertIn(
            "scope-lease",
            roots["ItemUseContext"]["lifetime"]["guards"],
        )
        self.assertIn(
            "noncopyable-nonmovable",
            roots["ItemUseContext"]["lifetime"]["guards"],
        )
        for token_name in (
            "MissionToken",
            "HordeEntityToken",
            "LegacyHordeToken",
        ):
            token_members = {
                entry["id"]: entry
                for entry in roots[token_name]["member_disposition"][
                    "members"
                ]
            }
            self.assertEqual(
                token_members["native.runtime_context"]["disposition"],
                "unbound",
            )
            self.assertEqual(
                token_members["native.belongs_to"]["lua_access"],
                [f"{token_name}.is_valid"],
            )

    def test_repository_inventory_uses_generator_format(self) -> None:
        serialized = serialize_native_inventory(build_native_inventory())
        self.assertEqual(
            serialized,
            DEFAULT_OUTPUT.read_text(encoding="utf-8"),
        )
        self.assertEqual(json.loads(serialized), build_native_inventory())


if __name__ == "__main__":
    unittest.main()
