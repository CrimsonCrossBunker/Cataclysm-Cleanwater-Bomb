#!/usr/bin/env python3
"""Finalize the frozen legacy inventory and maintain permanent moved banners."""

from __future__ import annotations

import argparse
import copy
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


def banner(entry: dict | list[dict]) -> str:
    entries = entry if isinstance(entry, list) else [entry]
    primary = entries[0]
    archived = all(item["action"] == ARCHIVE_ACTION for item in entries)
    state_en = "Archived" if archived else "Moved"
    state_zh = "已归档" if archived else "已迁移"
    default_reason = "The maintained documentation now lives in CCB-Docs."
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
                f"> Moved date / 迁移日期: `{primary['moved_at']}`",
                "> Last in-repository commit / 仓库内最后适用 commit: "
                f"`{primary['source_commit']}`",
            ]
        )
    else:
        lines.append("> Stable document IDs and last commits / 稳定文档 ID 与最后 commit:")
        lines.extend(
            f"> - `{item['stable_document_id']}`: `{item['source_commit']}`"
            for item in sorted(entries, key=lambda value: value["stable_document_id"])
        )
        for chinese in sorted({item["zh_url"] for item in entries}):
            lines.append(f"> 中文: {chinese}")
        for english in sorted({item["en_url"] for item in entries}):
            lines.append(f"> English: {english}")
        lines.append(f"> Moved date / 迁移日期: `{primary['moved_at']}`")
    lines.extend(
        [
            *(f"> {reason}" for reason in reasons),
            "> This in-repository body is no longer maintained. The historical body "
            f"is retained through `{primary['retained_body_until']}` and may then be "
            "removed; this bilingual entry banner remains permanently.",
            "> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。",
            END,
            "",
        ]
    )
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