from __future__ import annotations

import unittest
from datetime import date

from finalize_legacy_migration import (
    END,
    START,
    add_months,
    banner,
    english_url,
    final_entry,
    strip_banner,
)


class FinalizeLegacyMigrationTests(unittest.TestCase):
    def entry(self, action: str = "migrate_rewrite") -> dict:
        return {
            "original_path": "doc/example.md",
            "target_path": "docs/zh_CN/reference/example.md",
            "replacement": None,
            "stable_document_id": "example.reference",
            "action": action,
            "archive_reason": None,
            "migration_status": "classified",
            "source_commit": "2" * 40,
            "last_applicable_commit": "1" * 40,
            "blockers": ["pending"],
            "evidence": ["classified"],
        }

    def test_final_entry_has_bilingual_urls_and_retention(self) -> None:
        result = final_entry(self.entry(), date(2026, 8, 2))
        self.assertEqual(result["migration_status"], "stubbed")
        self.assertEqual(
            result["zh_url"],
            "https://crimsoncrossbunker.github.io/CCB-Docs/reference/example/",
        )
        self.assertEqual(
            result["en_url"],
            "https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/example/",
        )
        self.assertEqual(result["retained_body_until"], "2027-02-02")
        self.assertEqual(result["blockers"], [])

    def test_archive_uses_archived_terminal_state(self) -> None:
        result = final_entry(self.entry("archive_public"), date(2026, 8, 2))
        self.assertEqual(result["migration_status"], "archived")
        self.assertIn("Archived / 已归档", banner(result))

    def test_banner_replacement_is_idempotent(self) -> None:
        result = final_entry(self.entry(), date(2026, 8, 2))
        content = banner(result) + "# Historical\n"
        self.assertTrue(content.startswith(START))
        self.assertIn(END, content)
        self.assertIn("`" + "2" * 40 + "`", content)
        self.assertNotIn("`None`", content)
        self.assertFalse(any(line.endswith(" ") for line in content.splitlines()))
        self.assertEqual(strip_banner(content), "# Historical\n")

    def test_english_url_is_not_double_prefixed(self) -> None:
        value = "https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/example/"
        self.assertEqual(english_url(value), value)

    def test_six_month_calendar_retention(self) -> None:
        self.assertEqual(add_months(date(2026, 8, 31), 6), date(2027, 2, 28))


if __name__ == "__main__":
    unittest.main()
