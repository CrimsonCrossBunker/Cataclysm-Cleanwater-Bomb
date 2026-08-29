import unittest

import generate_migration_reports as reports


class MigrationReportsTest(unittest.TestCase):
    def test_report_covers_the_frozen_inventory(self):
        data = reports.load_inventory()
        rendered = reports.render_report(data)

        self.assertEqual(data["document_count"], len(data["documents"]))
        for item in data["documents"]:
            stable_id = reports.CURRENT_PLATFORM_DOCUMENTS.get(
                item["original_path"], item["stable_document_id"]
            )
            self.assertIn(f"`{stable_id}`", rendered)
        self.assertIn("Remaining `review` actions: **0**", rendered)

    def test_batch_counts_match_documents(self):
        data = reports.load_inventory()
        batches = reports.build_batches(data)
        expected = sum(
            1
            for item in data["documents"]
            if (
                item["migration_batch"] and
                item["original_path"] not in
                reports.CURRENT_PLATFORM_DOCUMENTS and
                not reports.is_retired_platform_path(item["original_path"]) and
                item["migration_status"] not in {
                    "verified", "stubbed", "archived"
                }
            )
        )

        self.assertEqual(batches["document_count"], expected)
        self.assertEqual(batches["batch_count"], len(batches["batches"]))

    def test_retired_platform_entries_are_historical_only(self):
        data = reports.load_inventory()
        retired = next(
            item
            for item in data["documents"]
            if "api_" + "v" + "5" in item["original_path"]
        )
        self.assertEqual(reports.report_status(retired), "historical")
        self.assertEqual(reports.report_target(retired), "historical-only")
        self.assertEqual(reports.report_action(retired), "historical")

    def test_current_platform_readmes_override_old_inventory_status(self):
        data = reports.load_inventory()
        readme = next(
            item for item in data["documents"]
            if item["original_path"] == "data/lua/README.md"
        )
        self.assertEqual(reports.report_status(readme), "active")
        self.assertEqual(reports.report_target(readme), "data/lua/README.md")
        self.assertEqual(reports.report_action(readme), "keep_in_repo")


if __name__ == "__main__":
    unittest.main()
