import unittest
from unittest import mock

import import_legacy_audits as importer


class ImportLegacyAuditsTest(unittest.TestCase):
    def test_review_import_rejects_dirty_identity_and_normalizes_target(self):
        base = {
            "original_path": "doc/example.md",
            "source_commit": "a" * 40,
            "contributors": [
                "Valid Person",
                "Injected git config --global user.name Bad",
            ],
            "license": "CC-BY-SA-3.0",
            "action": "review",
            "history_strategy": "evaluate_filtered_history",
        }
        audit = {
            "action": "migrate_rewrite",
            "stable_document_id": "example.document",
            "domain": "testing",
            "priority": "P0",
            "target_path": "testing/example.md",
            "replacement": "example.document",
            "history_strategy": "preserve_source_commit_and_history_url",
            "last_applicable_commit": "b" * 40,
            "ccb_specificity": "mixed",
            "upstream_relation": "upstream_derived",
            "source_paths": ["tests/example_test.cpp"],
            "source_symbols": ["example_test"],
            "translation_required": True,
            "include_in_ai_index": True,
            "blockers": [],
            "evidence": ["Reviewed against the current test."],
        }
        anomalies = []

        result = importer.reviewed_record(base, audit, anomalies)

        self.assertEqual(result["contributors"], ["Valid Person"])
        self.assertEqual(result["contributor_anomaly_count"], 1)
        self.assertEqual(result["target_path"], "docs/zh_CN/testing/example.md")
        self.assertEqual(result["migration_status"], "classified")
        self.assertEqual(result["migration_batch"], "phase-0-testing")
        self.assertNotIn("value", anomalies[0])

    def test_import_requires_exact_review_coverage(self):
        inventory = {
            "source_commit": "a" * 40,
            "scope": "test",
            "documents": [
                {
                    "original_path": "doc/missing.md",
                    "action": "review",
                }
            ],
        }

        with self.assertRaisesRegex(ValueError, "coverage mismatch"):
            importer.import_audits(inventory, {})

    @mock.patch.object(
        importer,
        "direct_path_contributors",
        return_value=["Direct Author"],
    )
    def test_upgrade_preserves_review_state(self, _contributors):
        inventory = {
            "source_commit": "a" * 40,
            "scope": "test",
            "documents": [
                {
                    "original_path": "doc/review.md",
                    "source_commit": "a" * 40,
                    "contributors": ["Direct Author"],
                    "license": "CC-BY-SA-3.0",
                    "action": "review",
                    "history_strategy": "evaluate_filtered_history",
                }
            ],
        }

        result, anomalies = importer.upgrade_baseline(inventory)

        self.assertEqual(result["schema_version"], 2)
        self.assertEqual(result["classification_summary"]["review"], 1)
        self.assertEqual(result["documents"][0]["action"], "review")
        self.assertEqual(result["documents"][0]["contributors"], ["Direct Author"])
        self.assertEqual(anomalies, [])


if __name__ == "__main__":
    unittest.main()
