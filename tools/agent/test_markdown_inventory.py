import unittest
from pathlib import Path
from unittest import mock

import yaml

import generate_markdown_inventory as inventory


ROOT = Path(__file__).resolve().parents[2]


class MarkdownInventoryTest(unittest.TestCase):
    @mock.patch.object(inventory, "git")
    @mock.patch.object(
        inventory,
        "tracked_markdown",
        return_value=["doc/existing.md", "doc/new.md"],
    )
    def test_recorded_contributors_are_stable_in_check_mode(
        self, tracked_markdown, git
    ):
        git.return_value = "Visible in this clone\n"

        data = inventory.build_inventory(
            "frozen-commit",
            {"doc/existing.md": ["Recorded from full history"]},
        )

        self.assertEqual(
            ["Recorded from full history"],
            data["documents"][0]["contributors"],
        )
        self.assertEqual(
            ["Visible in this clone"],
            data["documents"][1]["contributors"],
        )
        tracked_markdown.assert_called_once_with("frozen-commit")
        git.assert_called_once_with(
            "log",
            "frozen-commit",
            "--format=%aN",
            "--",
            "doc/new.md",
        )

    def test_frozen_phase_zero_scope(self):
        path = ROOT / "doc/migration/markdown-inventory.yml"
        data = yaml.safe_load(path.read_text(encoding="utf-8"))
        self.assertEqual(175, data["document_count"])
        self.assertEqual(175, len(data["documents"]))
        originals = [item["original_path"] for item in data["documents"]]
        self.assertEqual(len(originals), len(set(originals)))
        self.assertFalse(any(item.startswith(".") for item in originals))
        self.assertFalse(
            any("obj-lua" in Path(item).parts for item in originals)
        )
        for item in data["documents"]:
            self.assertTrue(item["contributors"])
            self.assertEqual(data["source_commit"], item["source_commit"])

    def test_all_legacy_reviews_are_classified(self):
        path = ROOT / "doc/migration/markdown-inventory.yml"
        data = yaml.safe_load(path.read_text(encoding="utf-8"))

        self.assertEqual(data["classification_summary"]["review"], 0)
        self.assertFalse(
            any(item["action"] == "review" for item in data["documents"])
        )
        self.assertFalse(
            any(
                item["migration_status"] == "inventoried"
                for item in data["documents"]
            )
        )

    def test_command_fragment_identity_is_rejected(self):
        clean, anomalies = inventory.sanitize_contributors(
            [
                "  Real   Contributor  ",
                "Real Contributor",
                "Name git config --global user.name Injected",
                "Another && command",
            ]
        )

        self.assertEqual(clean, ["Real Contributor"])
        self.assertEqual(len(anomalies), 2)
        self.assertTrue(
            all("command fragment" in item["reason"] for item in anomalies)
        )
        self.assertTrue(
            all(item["fingerprint"].startswith("sha256:") for item in anomalies)
        )
        self.assertTrue(all("value" not in item for item in anomalies))

    def test_control_character_identity_is_rejected(self):
        clean, anomalies = inventory.sanitize_contributors(
            ["Good Name", "Bad\x00Name", "Bad\nName"]
        )

        self.assertEqual(clean, ["Good Name"])
        self.assertEqual(len(anomalies), 2)
        self.assertTrue(
            all(
                item["reason"] == "identity contains a control character"
                for item in anomalies
            )
        )

    @mock.patch.object(
        inventory,
        "tracked_markdown",
        return_value=["doc/dirty.md"],
    )
    def test_dirty_snapshot_identity_cannot_reenter_inventory(self, _tracked):
        anomalies = []
        data = inventory.build_inventory(
            "frozen-commit",
            {
                "doc/dirty.md": [
                    "Responsible Person",
                    "Injected git config --global user.name Bad",
                ]
            },
            anomalies,
        )

        record = data["documents"][0]
        self.assertEqual(record["contributors"], ["Responsible Person"])
        self.assertEqual(record["contributor_anomaly_count"], 1)
        self.assertEqual(len(anomalies), 1)
        self.assertNotIn("Injected", inventory.render(data))
        self.assertEqual(data["classification_summary"]["review"], 1)


if __name__ == "__main__":
    unittest.main()
