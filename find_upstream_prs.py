#!/usr/bin/env python3
"""
发现上游 (CleverRaven/Cataclysm-DDA) 领先于本地 fork 的 PR。

通过 GitHub Search API 查询 merge-base 日期之后合并到 upstream/master 的所有 PR，
与本地黑名单 (SYNC_EXCLUDED_PRS.md) 交叉比对，输出结构化 JSON 方便筛选。

用法:
  python find_upstream_prs.py                  # 输出 JSON
  python find_upstream_prs.py --format table   # 输出表格
  python find_upstream_prs.py --format csv     # 输出 CSV
  python find_upstream_prs.py --since 2026-06-20  # 指定起始日期（覆盖 merge-base 日期）
  python find_upstream_prs.py --output result.json
  python find_upstream_prs.py --blacklist my_excludes.md
"""

import argparse
import json
import os
import re
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

# --------------- configuration ---------------

UPSTREAM_REPO = "CleverRaven/Cataclysm-DDA"
UPSTREAM_REMOTE = "upstream"
UPSTREAM_BRANCH = "master"
DEFAULT_BLACKLIST = "SYNC_EXCLUDED_PRS.md"
SCRIPT_DIR = Path(__file__).resolve().parent


# --------------- git helpers ---------------

def run_git(*args: str) -> str:
    """Run a git command and return stdout, stripped."""
    try:
        result = subprocess.run(
            ["git"] + list(args),
            capture_output=True, text=True, encoding="utf-8", check=True,
            cwd=str(SCRIPT_DIR),
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        sys.exit(f"git {' '.join(args)} 失败: {e.stderr.strip()}")


def get_merge_base_date() -> tuple[str, bool]:
    """Return (ISO-date YYYY-MM-DD, already_synced) for the merge-base between HEAD and upstream/master.

    already_synced is True when HEAD already contains all of upstream/master (zero PRs ahead).
    """
    # make sure we have the latest upstream refs
    run_git("fetch", UPSTREAM_REMOTE, UPSTREAM_BRANCH, "--quiet")
    upstream_ref = f"{UPSTREAM_REMOTE}/{UPSTREAM_BRANCH}"
    base_sha = run_git("merge-base", "HEAD", upstream_ref)
    if not base_sha:
        sys.exit("无法计算 merge-base，请确认 upstream remote 配置正确。")

    upstream_sha = run_git("rev-parse", upstream_ref)
    already_synced = (base_sha == upstream_sha)

    date_str = run_git("log", "-1", "--format=%aI", base_sha)
    # %aI gives ISO 8601 like 2026-06-29T13:24:15+00:00; truncate to date
    return date_str[:10], already_synced


# --------------- blacklist parsing ---------------

def parse_blacklist(filepath: str) -> dict[int, dict]:
    """Parse SYNC_EXCLUDED_PRS.md and return {pr_number: {reason, status}} for excluded PRs.

    Only PRs under exclusion sections are returned.  The "已入库、保留不回退" subsection
    is explicitly skipped.
    """
    path = Path(filepath)
    if not path.is_absolute():
        path = SCRIPT_DIR / path
    if not path.exists():
        print(f"[warn] 黑名单文件不存在: {path}", file=sys.stderr)
        return {}

    text = path.read_text(encoding="utf-8")

    excluded: dict[int, dict] = {}
    current_section: str | None = None
    in_keep_section = False

    for line in text.splitlines():
        # detect section headers
        if line.startswith("## ") or line.startswith("### "):
            heading = line.strip("# ").strip()
            current_section = heading
            in_keep_section = ("保留不回退" in heading)
            continue

        # skip non-table lines
        if not line.startswith("|") or not line.endswith("|"):
            continue
        # skip header/separator rows
        if re.match(r"^\|[\s:-]+\|", line):
            continue

        # we are inside a table row
        if in_keep_section:
            continue  # explicitly not excluded

        cells = [c.strip() for c in line.strip("|").split("|")]
        if not cells:
            continue

        pr_cell = cells[0]
        m = re.match(r"#(\d+)", pr_cell)
        if not m:
            continue

        pr_num = int(m.group(1))
        title = cells[2] if len(cells) > 2 else ""
        status = cells[3] if len(cells) > 3 else ""
        reason = cells[4] if len(cells) > 4 else ""
        # section name as catch-all reason
        if not reason and current_section:
            reason = current_section

        excluded[pr_num] = {
            "status": status,
            "reason": reason,
            "title_at_exclusion": title,
        }

    return excluded


# --------------- GitHub API via gh CLI ---------------

def _gh_api(endpoint: str) -> dict | list:
    """Call `gh api <endpoint>` and return parsed JSON."""
    try:
        result = subprocess.run(
            ["gh", "api", "--hostname", "github.com", endpoint],
            capture_output=True, text=True, encoding="utf-8", check=True,
            cwd=str(SCRIPT_DIR),
        )
        return json.loads(result.stdout)
    except subprocess.CalledProcessError as e:
        sys.exit(f"gh api 调用失败: {e.stderr.strip()}")
    except json.JSONDecodeError as e:
        sys.exit(f"gh api 返回非 JSON: {e}")


def fetch_merged_prs(since_date: str) -> list[dict]:
    """Fetch all PRs merged into upstream master since *since_date* (YYYY-MM-DD).

    Uses the GitHub Search Issues API with pagination.  Returns a list of
    simplified PR dicts sorted by merge date ascending.
    """
    query = (
        f"repo:{UPSTREAM_REPO}"
        f"+is:pr"
        f"+is:merged"
        f"+base:master"
        f"+merged:>={since_date}"
    )
    all_items: list[dict] = []
    page = 1
    per_page = 100

    while True:
        endpoint = (
            f"search/issues"
            f"?q={query}"
            f"&sort=created"
            f"&order=asc"
            f"&per_page={per_page}"
            f"&page={page}"
        )
        data = _gh_api(endpoint)

        if not isinstance(data, dict):
            sys.exit(f"search API 返回异常数据: {type(data)}")

        items = data.get("items", [])
        all_items.extend(items)

        total = data.get("total_count", 0)
        fetched = page * per_page
        if fetched >= total or len(items) < per_page:
            break
        page += 1

    # simplify to fields we care about
    results: list[dict] = []
    for item in all_items:
        pr_num = item.get("number")
        if pr_num is None:
            continue
        merged_at_raw = (item.get("pull_request") or {}).get("merged_at")
        results.append({
            "number": pr_num,
            "title": item.get("title", ""),
            "merged_at": merged_at_raw,
            "url": item.get("html_url", ""),
            "author": (item.get("user") or {}).get("login", ""),
            "labels": [lb["name"] for lb in item.get("labels", [])],
        })

    # sort by merged_at ascending (defensive — search API should already sort)
    results.sort(key=lambda p: p["merged_at"] or "")
    return results


# --------------- output formatters ---------------

def format_table(prs: list[dict]) -> str:
    """Pretty-print as aligned text table."""
    if not prs:
        return "(无上游领先 PR)"

    lines: list[str] = []
    header = f"{'PR':>7}  {'合并日':>10}  {'作者':<20}  {'排除':^4}  {'标题'}"
    lines.append(header)
    lines.append("-" * len(header))

    for p in prs:
        date = (p["merged_at"] or "")[:10]
        author = p["author"][:20]
        flag = " [X]" if p["excluded"] else ""
        lines.append(
            f"#{p['number']:<6}  {date:>10}  {author:<20}  {flag:^4}  {p['title']}"
        )
    return "\n".join(lines)


def format_csv(prs: list[dict]) -> str:
    """Simple CSV with header."""
    import csv
    import io

    buf = io.StringIO()
    w = csv.writer(buf)
    w.writerow(["number", "merged_at", "author", "title", "url", "excluded", "exclude_reason"])
    for p in prs:
        w.writerow([
            p["number"],
            p["merged_at"],
            p["author"],
            p["title"],
            p["url"],
            "yes" if p["excluded"] else "",
            p.get("exclude_reason", ""),
        ])
    return buf.getvalue()


# --------------- main ---------------

def main() -> None:
    parser = argparse.ArgumentParser(
        description="发现上游 CleverRaven/Cataclysm-DDA 领先本地的 PR",
    )
    parser.add_argument(
        "--since",
        help="起始日期 YYYY-MM-DD（默认自动从 merge-base 计算）",
        default=None,
    )
    parser.add_argument(
        "--format", "-f",
        choices=("json", "table", "csv"),
        default="json",
        help="输出格式 (default: json)",
    )
    parser.add_argument(
        "--output", "-o",
        help="输出文件路径（默认 stdout）",
        default=None,
    )
    parser.add_argument(
        "--blacklist",
        help=f"黑名单文件路径 (default: {DEFAULT_BLACKLIST})",
        default=DEFAULT_BLACKLIST,
    )
    parser.add_argument(
        "--no-fetch",
        action="store_true",
        help="跳过 git fetch upstream",
    )
    args = parser.parse_args()

    # ensure stdout can handle Unicode on Windows
    try:
        sys.stdout.reconfigure(encoding="utf-8")
    except Exception:
        pass

    # 1. determine the since-date
    already_synced = False
    if args.since:
        since_date = args.since
        # validate format
        try:
            datetime.strptime(since_date, "%Y-%m-%d")
        except ValueError:
            sys.exit(f"--since 日期格式无效: {since_date}，应为 YYYY-MM-DD")
    else:
        if not args.no_fetch:
            print("[info] 正在 fetch upstream/master ...", file=sys.stderr)
        since_date, already_synced = get_merge_base_date()
        print(f"[info] merge-base 日期: {since_date}", file=sys.stderr)

    if already_synced:
        print("[info] HEAD 已包含 upstream/master 全部提交，无领先 PR。", file=sys.stderr)

    # 2. read blacklist
    blacklist = parse_blacklist(args.blacklist)
    if blacklist:
        print(f"[info] 黑名单已加载 {len(blacklist)} 条", file=sys.stderr)

    # 3. fetch merged PRs from GitHub (skip if already synced and no --since override)
    if already_synced and not args.since:
        prs = []
    else:
        print(f"[info] 正在查询 upstream PR (merged >= {since_date}) ...", file=sys.stderr)
        prs = fetch_merged_prs(since_date)
    print(f"[info] API 返回 {len(prs)} 个 PR", file=sys.stderr)

    # 4. annotate with blacklist info
    for p in prs:
        bl = blacklist.get(p["number"])
        p["excluded"] = bl is not None
        if bl:
            p["exclude_status"] = bl["status"]
            p["exclude_reason"] = bl["reason"]

    # 5. output
    if args.format == "json":
        out = json.dumps(prs, ensure_ascii=False, indent=2)
    elif args.format == "csv":
        out = format_csv(prs)
    else:
        out = format_table(prs)

    if args.output:
        Path(args.output).write_text(out, encoding="utf-8")
        print(f"[info] 结果已写入 {args.output}", file=sys.stderr)
    else:
        print(out)


if __name__ == "__main__":
    main()
