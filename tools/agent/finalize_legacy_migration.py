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