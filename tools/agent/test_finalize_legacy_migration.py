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
        entry = self.entry("archive_public")
        entry["archive_reason"] = "Superseded upstream policy."
        result = final_entry(entry, date(2026, 8, 2))
        self.assertEqual(result["migration_status"], "archived")
        content = banner(result)
        self.assertIn("Archived / 已归档", content)
        self.assertIn("Moved date / 迁移日期: `2026-08-02`", content)
        self.assertIn("Superseded upstream policy.", content)
        self.assertIn("no longer maintained", content)
        self.assertIn("retained through `2027-02-02`", content)
        self.assertNotIn("Migration in progress", content)
        self.assertNotIn("Updates to this in-repository body are optional", content)

    def test_migration_banner_allows_optional_updates_without_deletion_deadline(self) -> None:
        result = final_entry(self.entry(), date(2026, 8, 2))
        content = banner(result)
        self.assertIn("Migration in progress / 迁移中", content)
        self.assertIn("Migration start date / 开始迁移日期: `2026-08-02`", content)
        self.assertIn(
            "Source commit referenced by the last migration record / 上次迁移记录参考 commit: "
            "`" + "2" * 40 + "`",
            content,
        )
        self.assertIn(result["zh_url"], content)
        self.assertIn(result["en_url"], content)
        for statement in (
            "CCB-Docs is still a work in progress",
            "Updates to this in-repository body are optional for now",
            "no comprehensive revision is currently planned",
            "Developers may update it as needed",
            "consult the relevant source code when using or updating it",
            "Documentation may be updated alongside new or changed features",
            "which may rewrite or omit the original text",
            "本仓库正文暂不列入必须更新项",
            "后续整理不保证原文保留",
        ):
            with self.subTest(statement=statement):
                self.assertIn(statement, content)
        for obsolete_statement in (
            "The maintained documentation now lives in CCB-Docs.",
            "no longer maintained",
            "本仓库正文不再维护",
            "2027-02-02",
            "remains permanently",
        ):
            with self.subTest(obsolete_statement=obsolete_statement):
                self.assertNotIn(obsolete_statement, content)

    def test_shared_banner_preserves_document_ids_and_commit_references(self) -> None:
        first = final_entry(self.entry(), date(2026, 8, 2))
        second = dict(first, stable_document_id="example.alias", source_commit="3" * 40)
        second["action"] = "archive_public"
        content = banner([first, second])
        self.assertIn("Migration in progress / 迁移中", content)
        self.assertIn(
            "Stable document IDs and source commits referenced by the last migration record / "
            "稳定文档 ID 与上次迁移记录参考 commit:",
            content,
        )
        self.assertIn("`example.reference`: `" + "2" * 40 + "`", content)
        self.assertIn("`example.alias`: `" + "3" * 40 + "`", content)
        self.assertEqual(content.count(first["zh_url"]), 1)
        self.assertEqual(content.count(first["en_url"]), 1)
        self.assertIn("Migration start date / 开始迁移日期: `2026-08-02`", content)
        self.assertNotIn("no longer maintained", content)

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
