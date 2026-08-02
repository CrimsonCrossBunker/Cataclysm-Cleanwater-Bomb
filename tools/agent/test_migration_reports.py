import unittest

import generate_migration_reports as reports


class MigrationReportsTest(unittest.TestCase):
    def test_report_covers_the_frozen_inventory(self):
        data = reports.load_inventory()
        rendered = reports.render_report(data)

        self.assertEqual(data["document_count"], 175)
        for item in data["documents"]:
            self.assertIn(f"`{item['stable_document_id']}`", rendered)
        self.assertIn("Remaining `review` actions: **0**", rendered)

    def test_batch_counts_match_documents(self):
        data = reports.load_inventory()
        batches = reports.build_batches(data)
        expected = sum(
            1
            for item in data["documents"]
            if item["migration_batch"] and item["migration_status"] not in {
                "verified", "stubbed", "archived"
            }
        )

        self.assertEqual(batches["document_count"], expected)
        self.assertEqual(batches["batch_count"], len(batches["batches"]))
        self.assertEqual(expected, 0)


if __name__ == "__main__":
    unittest.main()
