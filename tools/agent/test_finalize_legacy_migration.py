from __future__ import annotations

import copy
import io
import tempfile
import unittest
from argparse import Namespace
from contextlib import redirect_stderr, redirect_stdout
from datetime import date
from pathlib import Path
from unittest.mock import patch

import finalize_legacy_migration as migration

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
        self.assertIn("may then be removed", content)
        self.assertIn("Last in-repository commit / 仓库内最后适用 commit", content)
        self.assertNotIn("Migration in progress", content)
        self.assertNotIn("Updates to this in-repository body are optional", content)

    def test_migration_banner_allows_optional_updates_without_deletion_deadline(self) -> None:
        result = final_entry(self.entry(), date(2026, 8, 2))
        content = banner(result, phase="in-progress")
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
        content = banner([first, second], phase="in-progress")
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
        completed = banner([first, second])
        self.assertIn("Stable document IDs and last commits / 稳定文档 ID 与最后 commit:", completed)
        self.assertIn("Moved / 已迁移", completed)
        self.assertIn("retained through `2027-02-02`", completed)

    def test_completed_migration_banner_is_still_available(self) -> None:
        result = final_entry(self.entry(), date(2026, 8, 2))
        content = banner(result)
        self.assertIn("Moved / 已迁移", content)
        self.assertIn("The maintained documentation now lives in CCB-Docs.", content)
        self.assertIn("retained through `2027-02-02`", content)
        self.assertIn("may then be removed", content)
        self.assertIn("remains permanently", content)
        self.assertNotIn("No deletion deadline is set", content)
        self.assertNotIn("Migration in progress", content)

    def test_archive_in_progress_preserves_reason_without_deletion_permission(self) -> None:
        entry = self.entry("archive_public")
        entry["archive_reason"] = "Dated upstream lore; preserved for historical context."
        result = final_entry(entry, date(2026, 8, 2))
        content = banner(result, phase="in-progress")
        self.assertIn("Archiving in progress / 归档中", content)
        self.assertIn("Archiving start date / 开始归档日期: `2026-08-02`", content)
        self.assertIn(entry["archive_reason"], content)
        self.assertIn("归档整理尚未完成", content)
        self.assertIn("不代表当前 CCB 的设定、实现或规则", content)
        self.assertIn("explicit maintainer decision", content)
        self.assertIn("No deletion deadline is set", content)
        self.assertNotIn("2027-02-02", content)
        self.assertNotIn("本仓库正文不再维护", content)

    def test_phase_arguments_preserve_legacy_finalization_and_require_explicit_progress(self) -> None:
        with patch("sys.argv", ["finalize", "--moved-date", "2026-08-02"]):
            args = migration.parse_args()
        self.assertEqual(args.phase, "finalized")
        self.assertEqual(args.moved_date, date(2026, 8, 2))
        with patch("sys.argv", ["finalize", "--phase", "in-progress", "--check"]):
            args = migration.parse_args()
        self.assertEqual(args.phase, "in-progress")
        self.assertIsNone(args.moved_date)
        self.assertTrue(args.check)
        for arguments in (
            ["finalize"],
            ["finalize", "--phase", "in-progress", "--moved-date", "2026-08-02"],
        ):
            with self.subTest(arguments=arguments), patch("sys.argv", arguments):
                with redirect_stderr(io.StringIO()), self.assertRaises(SystemExit) as error:
                    migration.parse_args()
                self.assertEqual(error.exception.code, 2)

    def test_progress_mode_preserves_inventory_bodies_aliases_and_active_docs(self) -> None:
        for newline in ("\n", "\r\n"):
            with self.subTest(newline=repr(newline)), tempfile.TemporaryDirectory(dir=".") as directory:
                root = Path(directory).resolve()
                first = final_entry(self.entry(), date(2026, 8, 2))
                first.update(original_path="example.md", blockers=["review pending"])
                alias = dict(first, original_path="alias.md", stable_document_id="example.alias")
                archived = final_entry(self.entry("archive_public"), date(2026, 8, 2))
                archived.update(original_path="archive.md", stable_document_id="example.archive")
                active = dict(first, original_path="current.md", stable_document_id="example.current")
                data = {"documents": [first, alias, archived, active]}
                original_data = copy.deepcopy(data)
                inventory = root / "inventory.yml"
                inventory_bytes = b"frozen inventory sentinel\n"
                inventory.write_bytes(inventory_bytes)
                source = root / "example.md"
                archive_source = root / "archive.md"
                body = "\n# Historical body\n\n".replace("\n", newline).encode("utf-8")
                for path, entries in ((source, [first, alias]), (archive_source, [archived])):
                    path.write_bytes(banner(entries).replace("\n", newline).encode("utf-8") + body)
                (root / "alias.md").write_bytes(b"example.md")
                (root / "current.md").write_bytes(b"# Current platform docs\n")
                originals = {path: path.read_bytes() for path in root.iterdir()}
                args = Namespace(phase="in-progress", moved_date=None, check=True)
                with (
                    patch.object(migration, "ROOT", root),
                    patch.object(migration, "INVENTORY", inventory),
                    patch.object(migration, "load_inventory", return_value=data),
                    patch.object(migration, "parse_args", return_value=args),
                    patch.object(migration, "finalized_inventory", side_effect=AssertionError("must not finalize")),
                    redirect_stdout(io.StringIO()),
                    redirect_stderr(io.StringIO()),
                ):
                    self.assertEqual(migration.main(), 1)
                    self.assertEqual(originals, {path: path.read_bytes() for path in root.iterdir()})
                    args.check = False
                    self.assertEqual(migration.main(), 0)
                    written = {path: path.read_bytes() for path in root.iterdir()}
                    args.check = True
                    self.assertEqual(migration.main(), 0)
                    self.assertEqual(written, {path: path.read_bytes() for path in root.iterdir()})
                self.assertEqual(data, original_data)
                self.assertEqual(inventory.read_bytes(), inventory_bytes)
                for path in (source, archive_source):
                    marker = END.encode("utf-8")
                    self.assertEqual(path.read_bytes().count(marker), 1)
                    self.assertEqual(path.read_bytes().partition(marker)[2], originals[path].partition(marker)[2])
                self.assertIn(b"Migration in progress", source.read_bytes())
                self.assertIn(b"Archiving in progress", archive_source.read_bytes())
                self.assertEqual((root / "alias.md").read_bytes(), originals[root / "alias.md"])
                self.assertEqual((root / "current.md").read_bytes(), originals[root / "current.md"])

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
