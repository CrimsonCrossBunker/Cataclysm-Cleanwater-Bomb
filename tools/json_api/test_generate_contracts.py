#!/usr/bin/env python3
"""Regression and parity tests for JSON/EOC contract generation."""

from __future__ import annotations

import copy
import json
import subprocess
import tempfile
import unittest
from pathlib import Path
from unittest import mock

import jsonschema

try:
    from .generate_contracts import (
        DEFAULT_OUTPUT_DIRECTORY,
        OUTPUT_NAMES,
        REPOSITORY_ROOT,
        aggregate_parser_entries,
        build_contracts,
        git_tracked_files,
        parse_json_registrations,
        parse_parser_vector,
        resolve_json_pointer,
        validate_contracts,
        write_or_check,
    )
except ImportError:
    from generate_contracts import (
        DEFAULT_OUTPUT_DIRECTORY,
        OUTPUT_NAMES,
        REPOSITORY_ROOT,
        aggregate_parser_entries,
        build_contracts,
        git_tracked_files,
        parse_json_registrations,
        parse_parser_vector,
        resolve_json_pointer,
        validate_contracts,
        write_or_check,
    )


class ParserFixtureTest(unittest.TestCase):
    def test_json_registration_preserves_variants_and_handlers(self) -> None:
        source = """
        void DynamicDataLoader::initialize()
        {
        #if defined(TILES)
            add( "one", &loader::load );
        #else
            add( "one", []( const JsonObject &jo ) { other::load( jo ); } );
        #endif
        }
        """
        entries = parse_json_registrations(source)
        self.assertEqual([entry["type"] for entry in entries], ["one", "one"])
        self.assertEqual(entries[0]["handler_symbol"], "loader::load")
        self.assertEqual(entries[1]["handler_kind"], "lambda")
        self.assertNotEqual(
            entries[0]["compile_context"],
            entries[1]["compile_context"])

    def test_non_literal_json_registration_fails_closed(self) -> None:
        source = """
        void DynamicDataLoader::initialize()
        {
            add( dynamic_name, &loader::load );
        }
        """
        with self.assertRaisesRegex(RuntimeError, "non-literal"):
            parse_json_registrations(source)

    def test_parser_aliases_and_shapes_are_preserved(self) -> None:
        source = """
        std::vector<condition_parser>
        parsers = {
            { "u_key", "npc_key", jarg::member | jarg::array,
              &scope::handler },
            { "other", jarg::string, &scope::other }
        };
        """
        parsed = parse_parser_vector(
            source,
            "std::vector<condition_parser>\n        parsers =",
            "src/condition.cpp",
            "object_member",
        )
        entries = aggregate_parser_entries(parsed, "condition")
        by_key = {entry["key"]: entry for entry in entries}
        self.assertEqual(by_key["u_key"]["aliases"], ["npc_key", "u_key"])
        self.assertEqual(
            by_key["u_key"]["accepted_json_shapes"], ["array", "member"]
        )
        self.assertEqual(
            by_key["npc_key"]["parser_registrations"][0]["alias_role"], "beta"
        )


class RepositoryParityTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.payloads = build_contracts()

    def test_runtime_registry_parity(self) -> None:
        payload = self.payloads["json_object_types"]
        self.assertEqual(payload["summary"]["registration_calls"], 191)
        self.assertEqual(payload["summary"]["registered_types"], 190)
        self.assertEqual(payload["summary"]["observed_types"], 183)
        self.assertEqual(payload["summary"]["observed_not_registered"], [])
        registrations = sum(len(entry["registrations"])
                            for entry in payload["entries"])
        self.assertEqual(registrations, 191)

    def test_eoc_parser_parity(self) -> None:
        conditions = self.payloads["eoc_conditions"]
        effects = self.payloads["eoc_effects"]
        self.assertEqual(
            conditions["summary"]["complex_parser_registrations"], 89)
        self.assertEqual(
            conditions["summary"]["simple_parser_registrations"], 77)
        self.assertEqual(
            effects["summary"]["object_parser_registrations"], 137)
        self.assertEqual(
            effects["summary"]["string_parser_registrations"], 117)
        self.assertEqual(conditions["summary"]["public_keys"], 275)
        self.assertEqual(effects["summary"]["public_keys"], 311)
        self.assertEqual({entry["key"] for entry in conditions["entries"]} & {
            "and", "or", "not"}, {"and", "or", "not"}, )
        self.assertEqual(
            conditions["global_contract"]["parser_order"],
            "first matching parser wins")
        self.assertEqual(
            effects["global_contract"]["parser_order"],
            "first matching parser wins")

    def test_generated_snapshots_match(self) -> None:
        for kind, filename in OUTPUT_NAMES.items():
            self.assertEqual(
                json.loads(
                    (DEFAULT_OUTPUT_DIRECTORY / filename).read_text(
                        encoding="utf-8")),
                self.payloads[kind],
            )

    def test_generated_snapshots_match_schema(self) -> None:
        schema = json.loads(
            (REPOSITORY_ROOT /
             "tools/json_api/contract-inventory.schema.json").read_text(
                encoding="utf-8"))
        jsonschema.Draft202012Validator.check_schema(schema)
        validator = jsonschema.Draft202012Validator(schema)
        for payload in self.payloads.values():
            validator.validate(payload)

    def test_inventory_schema_rejects_missing_contract_blocks(self) -> None:
        schema = json.loads(
            (REPOSITORY_ROOT /
             "tools/json_api/contract-inventory.schema.json").read_text(
                encoding="utf-8"))
        payload = copy.deepcopy(self.payloads["eoc_conditions"])
        del payload["entries"][0]["variables"]
        with self.assertRaises(jsonschema.ValidationError):
            jsonschema.Draft202012Validator(schema).validate(payload)

    def test_incomplete_contracts_are_explicit(self) -> None:
        json_entries = self.payloads["json_object_types"]["entries"]
        unclassified = [
            entry
            for entry in json_entries
            if entry["field_contract"]["status"] == "unclassified"
        ]
        self.assertEqual(len(unclassified), 189)
        self.assertTrue(all(entry["schema"]["status"] ==
                        "none" for entry in json_entries))
        condition = next(
            entry
            for entry in self.payloads["eoc_conditions"]["entries"]
            if entry["key"] == "u_has_trait"
        )
        self.assertEqual(condition["parameters"]["status"], "unclassified")
        self.assertEqual(
            condition["talker_semantics"]["status"],
            "legacy_alpha_beta_alias")

    def test_requiredness_comes_from_loader_evidence(self) -> None:
        entry = next(
            item
            for item in self.payloads["json_object_types"]["entries"]
            if item["type"] == "effect_on_condition"
        )
        fields = {
            field["name"]: field
            for field in entry["field_contract"]["fields"]
        }
        self.assertTrue(fields["id"]["required"])
        self.assertTrue(fields["required_event"]["required"])
        self.assertFalse(fields["global"]["required"])
        self.assertEqual(fields["id"]["requiredness_evidence"], "mandatory")

    def test_examples_resolve_to_tracked_json_pointers(self) -> None:
        tracked = set(git_tracked_files(REPOSITORY_ROOT, "data"))
        for kind, payload in self.payloads.items():
            for entry in payload["entries"]:
                block = entry.get(
                    "instance_evidence",
                    entry.get("example_evidence"))
                for evidence in block["examples"]:
                    self.assertIn(evidence["path"], tracked)
                    value = json.loads(
                        (REPOSITORY_ROOT /
                         evidence["path"]).read_text(
                            encoding="utf-8"))
                    pointer = evidence["pointer"]
                    resolved = resolve_json_pointer(value, pointer)
                    key_name = "type" if kind == "json_object_types" else "key"
                    key = entry[key_name]
                    if kind == "json_object_types":
                        self.assertEqual(resolved["type"], key)
                    else:
                        token = pointer.rsplit("/", 1)[-1]
                        token = token.replace("~1", "/").replace("~0", "~")
                        self.assertTrue(token == key or resolved == key)

    def test_stale_source_and_example_evidence_fail_closed(self) -> None:
        bad_source = copy.deepcopy(self.payloads)
        bad_source["json_object_types"]["entries"][0]["registrations"][0][
            "source"
        ]["line"] = 1
        with self.assertRaisesRegex(RuntimeError, "source evidence"):
            validate_contracts(bad_source)

        bad_example = copy.deepcopy(self.payloads)
        entry = next(
            item
            for item in bad_example["json_object_types"]["entries"]
            if item["instance_evidence"]["examples"]
        )
        entry["instance_evidence"]["examples"][0]["pointer"] = "/999999"
        with self.assertRaisesRegex(RuntimeError, "JSON Pointer"):
            validate_contracts(bad_example)

    def test_check_mode_reports_stale_without_writing(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory)
            stale = write_or_check(self.payloads, output, check=True)
            self.assertEqual(len(stale), 3)
            self.assertEqual(list(output.iterdir()), [])

    def test_check_mode_accepts_repository_formatter_whitespace(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory)
            for kind, filename in OUTPUT_NAMES.items():
                (output / filename).write_text(
                    json.dumps(self.payloads[kind], separators=(",", ":")),
                    encoding="utf-8",
                )
            self.assertEqual(
                write_or_check(self.payloads, output, check=True), [])

    def test_discovery_invokes_git_ls_files(self) -> None:
        completed = subprocess.CompletedProcess(
            args=[], returncode=0, stdout=b"src/init.cpp\0"
        )
        with mock.patch("subprocess.run", return_value=completed) as run:
            self.assertEqual(
                git_tracked_files(
                    Path("/repo"),
                    "src"),
                ["src/init.cpp"])
        command = run.call_args.args[0]
        self.assertEqual(command[:4], ["git", "ls-files", "-z", "--"])
        self.assertNotIn("obj-lua", command)


if __name__ == "__main__":
    unittest.main()
