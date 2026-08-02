import unittest
from pathlib import Path
from unittest import mock

import generate_documentation_registry as registry


class DocumentationRegistryTest(unittest.TestCase):
    @mock.patch.object(registry.subprocess, "run")
    def test_tracked_discovery_reads_only_the_git_index(self, run):
        run.return_value.stdout = b"AGENTS.md\0doc/example.md\0"

        self.assertEqual(
            registry.tracked_paths(),
            ["AGENTS.md", "doc/example.md"],
        )
        command = run.call_args.args[0]
        self.assertEqual(command[:3], ["git", "ls-files", "-z"])
        self.assertIn("--cached", command)
        self.assertNotIn("--others", command)

    def test_registry_covers_every_selected_tracked_path(self):
        data = registry.build_registry("0" * 40)
        expected = {
            path
            for path in registry.tracked_paths()
            if registry.is_documentation_path(path)
        }
        actual = {entry["path"] for entry in data["entries"]}

        self.assertEqual(expected, actual)
        self.assertEqual(data["entry_count"], len(actual))
        self.assertFalse(
            any("obj-lua" in Path(path).parts for path in actual)
        )

    def test_generated_and_third_party_boundaries_are_explicit(self):
        legacy = registry.load_inventory()
        generated = registry.classify(
            "data/lua/reference/ccb_native_inventory.json",
            legacy,
        )
        third_party = registry.classify(
            "src/third-party/zstd/README.md",
            legacy,
        )

        self.assertTrue(generated["generated"])
        self.assertTrue(generated["generated_by"])
        self.assertEqual(generated["status"], "generated")
        self.assertFalse(third_party["include_in_ai_index"])
        self.assertEqual(third_party["status"], "third_party")

    def test_ccb_docs_ids_prefer_reviewed_merge_target(self):
        legacy = {
            "doc/merged.md": {
                "action": "merge_into",
                "migration_status": "stubbed",
                "stable_document_id": "legacy.doc-merged",
                "merge_target": "maintenance.releases",
                "include_in_ai_index": True,
            },
            "doc/direct.md": {
                "action": "migrate_rewrite",
                "migration_status": "stubbed",
                "stable_document_id": "cpp.activities",
                "merge_target": None,
                "include_in_ai_index": True,
            },
        }

        merged = registry.classify("doc/merged.md", legacy)
        direct = registry.classify("doc/direct.md", legacy)

        self.assertEqual(merged["ccb_docs_ids"], ["maintenance.releases"])
        self.assertEqual(direct["ccb_docs_ids"], ["cpp.activities"])


if __name__ == "__main__":
    unittest.main()
