#!/usr/bin/env python3
"""Finalize the frozen legacy inventory and maintain bilingual migration banners."""

from __future__ import annotations

import argparse
import copy
import re
import sys
from collections import Counter
from datetime import date
from pathlib import Path
from urllib.parse import urlsplit, urlunsplit

import yaml


ROOT = Path(__file__).resolve().parents[2]
INVENTORY = ROOT / "doc/migration/markdown-inventory.yml"
SITE_BASE = "https://crimsoncrossbunker.github.io/CCB-Docs/"
START = "<!-- CCB-DOC-MOVED-START -->"
END = "<!-- CCB-DOC-MOVED-END -->"
TERMINAL_IN_REPO = {"keep_in_repo", "retain_third_party"}
ARCHIVE_ACTION = "archive_public"


def load_inventory(path: Path = INVENTORY) -> dict:
    data = yaml.safe_load(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict):
        raise ValueError("migration inventory must contain a mapping")
    return data


def add_months(value: date, months: int) -> date:
    month_index = value.month - 1 + months
    year = value.year + month_index // 12
    month = month_index % 12 + 1
    month_lengths = (31, 29 if year % 4 == 0 else 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
    return date(year, month, min(value.day, month_lengths[month - 1]))


def target_url(entry: dict) -> str:
    replacement = entry.get("replacement")
    if replacement and str(replacement).startswith(("https://", "http://")):
        return replacement
    target = entry.get("target_path") or ""
    prefix = "docs/zh_CN/"
    if not target.startswith(prefix) or not target.endswith(".md"):
        raise ValueError(
            f"{entry['original_path']} has no CCB-Docs replacement or target"
        )
    relative = target[len(prefix):-len(".md")].strip("/") + "/"
    return SITE_BASE + relative


def english_url(chinese_url: str) -> str:
    split = urlsplit(chinese_url)
    marker = "/CCB-Docs/"
    if marker not in split.path:
        raise ValueError(f"not a CCB-Docs URL: {chinese_url}")
    before, after = split.path.split(marker, 1)
    if after.startswith("en/"):
        english_path = split.path
    else:
        english_path = before + marker + "en/" + after
    return urlunsplit((split.scheme, split.netloc, english_path, split.query, split.fragment))


def strip_banner(content: str) -> str:
    if not content.startswith(START):
        return content.lstrip("\n")
    end = content.find(END)
    if end < 0:
        raise ValueError("unterminated CCB moved banner")
    return content[end + len(END):].lstrip("\n")


def banner(entry: dict | list[dict], *, phase: str = "finalized") -> str:
    if phase not in {"finalized", "in-progress"}:
        raise ValueError(f"unknown banner phase: {phase}")
    entries = entry if isinstance(entry, list) else [entry]
    primary = entries[0]
    archived = all(item["action"] == ARCHIVE_ACTION for item in entries)
    in_progress = phase == "in-progress"
    if in_progress:
        state_en = "Archiving in progress" if archived else "Migration in progress"
        state_zh = "归档中" if archived else "迁移中"
        date_label = (
            "Archiving start date / 开始归档日期" if archived else
            "Migration start date / 开始迁移日期"
        )
    else:
        state_en = "Archived" if archived else "Moved"
        state_zh = "已归档" if archived else "已迁移"
        date_label = "Moved date / 迁移日期"
    commit_label = (
        "Source commit referenced by the last migration record / 上次迁移记录参考 commit"
        if in_progress else "Last in-repository commit / 仓库内最后适用 commit"
    )
    commits_label = (
        "Stable document IDs and source commits referenced by the last migration record / "
        "稳定文档 ID 与上次迁移记录参考 commit" if in_progress else
        "Stable document IDs and last commits / 稳定文档 ID 与最后 commit"
    )
    default_reason = (
        "Historical material; not a current CCB contract or policy." if in_progress else
        "The maintained documentation now lives in CCB-Docs."
    )
    reasons = sorted({item.get("archive_reason") or default_reason for item in entries})
    lines = [
        START,
        f"> [!IMPORTANT] **{state_en} / {state_zh}**",
        ">",
    ]
    if len(entries) == 1:
        lines.extend(
            [
                f"> Stable document ID / 稳定文档 ID: `{primary['stable_document_id']}`",
                f"> 中文: {primary['zh_url']}",
                f"> English: {primary['en_url']}",
                f"> {date_label}: `{primary['moved_at']}`",
                f"> {commit_label}: `{primary['source_commit']}`",
            ]
        )
    else:
        lines.append(f"> {commits_label}:")
        lines.extend(
            f"> - `{item['stable_document_id']}`: `{item['source_commit']}`"
            for item in sorted(entries, key=lambda value: value["stable_document_id"])
        )
        for chinese in sorted({item["zh_url"] for item in entries}):
            lines.append(f"> 中文: {chinese}")
        for english in sorted({item["en_url"] for item in entries}):
            lines.append(f"> English: {english}")
        lines.append(f"> {date_label}: `{primary['moved_at']}`")
    if not in_progress:
        lines.extend(
            [
                *(f"> {reason}" for reason in reasons),
                "> This in-repository body is no longer maintained. The historical body "
                f"is retained through `{primary['retained_body_until']}` and may then be "
                "removed; this bilingual entry banner remains permanently.",
                "> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。",
            ]
        )
    elif archived:
        lines.extend(
            [
                *(f"> {reason}" for reason in reasons),
                "> This in-repository body is retained as historical reference while archive "
                "organization is still in progress. No deletion deadline is set. The content may "
                "reflect older upstream lore, proposals, or processes and does not "
                "represent current CCB lore, implementation, or policy. Additions or "
                "corrections should identify differences from the historical content. "
                "The body will serve as a reference for later archive organization. "
                "Any removal requires a separate review and an explicit maintainer "
                "decision; neither dates nor status changes authorize deletion.",
                "> 本仓库正文暂作为历史参考保留，归档整理尚未完成，暂不设置删除期限。"
                "内容可能反映旧上游设定、方案或流程，"
                "不代表当前 CCB 的设定、实现或规则。如需补充或纠错，应注明与历史内容的区别。"
                "正文将作为后续归档与整理的参考来源；是否移除正文应另行复核，由维护者明确决定，"
                "不因日期或状态变化自动删除。",
            ]
        )
    else:
        lines.extend(
            [
                "> CCB-Docs is still a work in progress; the links above are migration targets.",
                "> CCB-Docs 仍在整理中；上方链接为迁移目标。",
                "> Updates to this in-repository body are optional for now, and no "
                "comprehensive revision is currently planned. Developers may update "
                "it as needed. Some content has not been checked against the current "
                "CCB implementation; consult the relevant source code when using or "
                "updating it. Documentation may be updated alongside new or changed "
                "features. The retained body will serve as a reference for later "
                "documentation migration and reorganization, which may rewrite or "
                "omit the original text.",
                "> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。"
                "部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。"
                "新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，"
                "后续整理不保证原文保留。",
            ]
        )
    lines.extend([END, ""])
    return "\n".join(lines)


def final_entry(entry: dict, moved: date) -> dict:
    result = copy.deepcopy(entry)
    if entry["action"] in TERMINAL_IN_REPO:
        result["migration_status"] = "verified"
        result["moved_at"] = None
        result["zh_url"] = None
        result["en_url"] = None
        result["retained_body_until"] = None
        result["blockers"] = []
        return result

    chinese = target_url(entry)
    result["migration_status"] = (
        "archived" if entry["action"] == ARCHIVE_ACTION else "stubbed"
    )
    result["moved_at"] = moved.isoformat()
    result["zh_url"] = chinese
    result["en_url"] = english_url(chinese)
    result["retained_body_until"] = add_months(moved, 6).isoformat()
    result["blockers"] = []
    evidence = list(result["evidence"])
    statement = (
        "Permanent bilingual repository entry prepared at "
        f"{moved.isoformat()}; the historical body remains during retention."
    )
    if statement not in evidence:
        evidence.append(statement)
    result["evidence"] = evidence
    return result


def finalized_inventory(data: dict, moved: date) -> dict:
    result = copy.deepcopy(data)
    result["documents"] = [final_entry(entry, moved) for entry in data["documents"]]
    actions = Counter(entry["action"] for entry in result["documents"])
    statuses = Counter(entry["migration_status"] for entry in result["documents"])
    result["classification_summary"] = {
        "review": actions.get("review", 0),
        "actions": dict(sorted(actions.items())),
        "migration_statuses": dict(sorted(statuses.items())),
    }
    return result


def render_yaml(data: dict) -> str:
    return yaml.safe_dump(data, allow_unicode=True, sort_keys=False, width=100)


def expected_sources(data: dict) -> dict[Path, str]:
    grouped: dict[Path, list[tuple[Path, dict]]] = {}
    for entry in data["documents"]:
        if entry["action"] in TERMINAL_IN_REPO:
            continue
        path = ROOT / entry["original_path"]
        if not path.is_file():
            raise ValueError(f"missing legacy source: {entry['original_path']}")
        grouped.setdefault(path.resolve(), []).append((path, entry))

    outputs = {}
    for resolved, members in grouped.items():
        physical = next((path for path, _ in members if not path.is_symlink()), resolved)
        body = strip_banner(physical.read_text(encoding="utf-8"))
        retention_required = any(entry["retained_body_until"] for _, entry in members)
        if retention_required and not body.strip():
            paths = ", ".join(entry["original_path"] for _, entry in members)
            raise ValueError(
                f"historical body was removed before retention: {paths}"
            )
        outputs[physical] = banner([entry for _, entry in members]) + body
    return outputs


def progress_sources(data: dict) -> dict[Path, str]:
    """Update existing banners without finalizing records or changing retained bodies."""
    by_id = {entry["stable_document_id"]: entry for entry in data["documents"]}
    outputs = {}
    for entry in data["documents"]:
        if entry["action"] in TERMINAL_IN_REPO:
            continue
        path = (ROOT / entry["original_path"]).resolve()
        if path in outputs or not path.is_file():
            continue
        content = path.read_bytes().decode("utf-8")
        if not content.startswith(START):
            continue
        end = content.find(END)
        if end < 0:
            raise ValueError(f"unterminated CCB moved banner: {entry['original_path']}")
        header = content[:end]
        ids = re.findall(r"(?m)^> (?:Stable document ID[^:]*: |-[ ]+)`([^`]+)`", header)
        if not ids or any(value not in by_id for value in ids):
            raise ValueError(f"unknown document IDs in banner: {entry['original_path']}")
        newline = "\r\n" if "\r\n" in header else "\n"
        replacement = banner([by_id[value] for value in ids], phase="in-progress")
        outputs[path] = (
            replacement[:replacement.index(END)].replace("\n", newline) + content[end:]
        )
    return outputs


def validate_terminal(data: dict) -> None:
    if len(data["documents"]) != 175:
        raise ValueError("frozen migration inventory must contain 175 documents")
    for entry in data["documents"]:
        expected = "verified" if entry["action"] in TERMINAL_IN_REPO else (
            "archived" if entry["action"] == ARCHIVE_ACTION else "stubbed"
        )
        if entry["migration_status"] != expected:
            raise ValueError(
                f"non-terminal migration status for {entry['original_path']}: "
                f"{entry['migration_status']}"
            )
        if entry["blockers"]:
            raise ValueError(f"terminal entry retains blockers: {entry['original_path']}")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--phase", choices=("finalized", "in-progress"), default="finalized",
        help="finalized updates records and banners; in-progress only updates existing banners",
    )
    parser.add_argument("--moved-date", type=date.fromisoformat)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    if args.phase == "finalized" and args.moved_date is None:
        parser.error("--moved-date is required for --phase finalized")
    if args.phase == "in-progress" and args.moved_date is not None:
        parser.error("--moved-date cannot be used with --phase in-progress")
    return args


def main() -> int:
    args = parse_args()
    try:
        current = load_inventory()
        if args.phase == "in-progress":
            source_outputs = progress_sources(current)
            inventory_output = None
        else:
            expected_inventory = finalized_inventory(current, args.moved_date)
            validate_terminal(expected_inventory)
            source_outputs = expected_sources(expected_inventory)
            inventory_output = render_yaml(expected_inventory)
        if args.check:
            stale = []
            if (
                inventory_output is not None and
                INVENTORY.read_text(encoding="utf-8") != inventory_output
            ):
                stale.append(INVENTORY)
            stale.extend(
                path
                for path, content in source_outputs.items()
                if (
                    path.read_bytes().decode("utf-8") if args.phase == "in-progress" else
                    path.read_text(encoding="utf-8")
                ) != content
            )
            if stale:
                for path in stale:
                    print(f"stale moved entry: {path.relative_to(ROOT)}", file=sys.stderr)
                return 1
        else:
            if inventory_output is not None:
                INVENTORY.write_text(inventory_output, encoding="utf-8")
            for path, content in source_outputs.items():
                if args.phase == "in-progress":
                    path.write_bytes(content.encode("utf-8"))
                else:
                    path.write_text(content, encoding="utf-8")
    except (OSError, ValueError, yaml.YAMLError) as error:
        print(error, file=sys.stderr)
        return 2
    print(
        f"legacy migration entries ({args.phase}): {len(source_outputs)} paths with "
        f"bilingual banners, {len(current['documents'])} inventory records"
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
