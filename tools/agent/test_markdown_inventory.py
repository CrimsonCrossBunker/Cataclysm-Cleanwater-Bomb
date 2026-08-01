import unittest
from pathlib import Path

import yaml


ROOT = Path(__file__).resolve().parents[2]


class MarkdownInventoryTest(unittest.TestCase):
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


if __name__ == "__main__":
    unittest.main()
