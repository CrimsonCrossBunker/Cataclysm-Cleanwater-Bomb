from __future__ import annotations

import json
import os
import struct
import subprocess
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
WORKFLOW = ROOT / ".github/workflows/build-translations.yml"

FAKE_GH = r'''#!/usr/bin/env python3
import json
import os
import re
import sys
from pathlib import Path

scenario = json.loads(Path(os.environ["GH_SCENARIO"]).read_text())
args = sys.argv[1:]
def value(flag):
    return args[args.index(flag) + 1]

if args[:2] == ["run", "list"]:
    if value("--branch") != "master" or value("--event") != "push":
        sys.exit("Only trusted master push runs may supply translations")
    runs = scenario.get(value("--workflow"), [])
    if "--status" in args:
        runs = [run for run in runs if run["status"] == value("--status")]
    if ".[0]" in value("--jq"):
        runs = runs[:1]
    if runs:
        sys.stdout.buffer.write(
            ("\n".join(str(run["id"]) for run in runs) + "\n").encode()
        )
elif args[0] == "api":
    endpoint = next(
        (arg for arg in args[1:] if "/runs/" in arg and "/artifacts" in arg),
        None,
    )
    if endpoint is None:
        sys.exit(f"Unexpected artifacts API request: {args!r}")
    match = re.search(r"/runs/(\d+)/artifacts", endpoint)
    if match is None:
        sys.exit(f"Unexpected artifacts endpoint: {endpoint!r}")
    run_id = match.group(1)
    artifact = scenario["artifacts"].get(run_id)
    if artifact and (
        not artifact["expired"] or ".expired" not in value("--jq")
    ):
        print(run_id)
elif args[:2] == ["run", "download"]:
    run_id = args[2]
    with Path(os.environ["GH_DOWNLOADS"]).open("a") as log:
        log.write(run_id + "\n")
    artifact = scenario["artifacts"].get(run_id)
    if not artifact or artifact["expired"]:
        sys.exit("no valid artifacts found to download")
    destination = Path(value("--dir"))
    for name, content in {
        "lang/po/zh_CN.po": "catalog",
        "lang/mo/zh_CN/LC_MESSAGES/cataclysm-dda.mo": "compiled catalog",
        "src/lang_stats.inc": "translation statistics",
    }.items():
        target = destination / name
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(content)
else:
    sys.exit("Unexpected GitHub CLI operation")
'''


def fallback_script() -> str:
    workflow = WORKFLOW.read_text()
    step = workflow.index("      - name: Reuse ")
    block = workflow.index("        run: |\n", step) + len("        run: |\n")
    lines = []
    for line in workflow[block:].splitlines():
        if line and not line.startswith("          "):
            break
        lines.append(line[10:] if line else "")
    return "\n".join(lines)


class BuildTranslationsFallbackTest(unittest.TestCase):
    def run_fallback(
        self, scenario: dict, event_name: str = "pull_request"
    ) -> tuple[subprocess.CompletedProcess, list[str], dict[str, object]]:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            stats_file = root / "src/lang_stats.inc"
            stats_file.parent.mkdir(parents=True)
            stats_file.write_text("checked out language statistics\n")
            executable = root / "bin/gh"
            executable.parent.mkdir()
            executable.write_text(FAKE_GH)
            executable.chmod(0o755)
            scenario_file = root / "scenario.json"
            scenario_file.write_text(json.dumps(scenario))
            downloads = root / "downloads"
            env = dict(os.environ)
            env.update({
                "PATH": f"{executable.parent}:{os.environ['PATH']}",
                "GH_SCENARIO": str(scenario_file),
                "GH_DOWNLOADS": str(downloads),
                "GITHUB_REPOSITORY": (
                    "CrimsonCrossBunker/Cataclysm-Cleanwater-Bomb"
                ),
                "GITHUB_EVENT_NAME": event_name,
                "RUNNER_TEMP": str(root / "runner"),
            })
            result = subprocess.run(
                ["bash", "-e", "-o", "pipefail", "-c", fallback_script()],
                cwd=root, env=env, text=True, capture_output=True,
            )
            downloaded = (
                downloads.read_text().splitlines() if downloads.exists()
                else []
            )
            mo_file = root / "lang/mo/zh_CN/LC_MESSAGES/cataclysm-dda.mo"
            placeholder_po = root / "lang/po/placeholder.po"
            placeholder_mo = (
                root / "lang/mo/placeholder/LC_MESSAGES/cataclysm-dda.mo"
            )
            files = {
                "zh_cn_mo": mo_file.is_file(),
                "placeholder_po": (
                    placeholder_po.read_text()
                    if placeholder_po.is_file() else ""
                ),
                "placeholder_mo": (
                    placeholder_mo.read_bytes()
                    if placeholder_mo.is_file() else b""
                ),
                "stats": stats_file.read_text() if stats_file.is_file() else "",
            }
            return result, downloaded, files

    def test_uses_translation_job_from_running_parent_build(self) -> None:
        result, downloads, files = self.run_fallback({
            "matrix.yml": [{"id": 30, "status": "in_progress"},
                           {"id": 20, "status": "success"}],
            "artifacts": {"30": {"expired": False}, "20": {"expired": True}},
        })
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(downloads, ["30"])
        self.assertTrue(files["zh_cn_mo"])

    def test_skips_expired_artifacts_and_uses_release_build(self) -> None:
        result, downloads, files = self.run_fallback({
            "matrix.yml": [{"id": 40, "status": "success"}],
            "release.yml": [{"id": 35, "status": "in_progress"}],
            "artifacts": {"40": {"expired": True}, "35": {"expired": False}},
        })
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(downloads, ["35"], result.stdout + result.stderr)
        self.assertTrue(files["zh_cn_mo"])

    def test_creates_empty_catalog_for_pull_request_without_artifact(self) -> None:
        result, downloads, files = self.run_fallback({
            "matrix.yml": [{"id": 40, "status": "success"}],
            "artifacts": {"40": {"expired": True}},
        })
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(downloads, [])
        self.assertIn(
            r'"Content-Type: text/plain; charset=UTF-8\n"',
            files["placeholder_po"],
        )
        self.assertIn(
            r'"Plural-Forms: nplurals=2; plural=(n != 1);\n"',
            files["placeholder_po"],
        )
        self.assertEqual(
            struct.unpack("<7I", files["placeholder_mo"]),
            (0x950412DE, 0, 0, 28, 28, 0, 0),
        )
        self.assertEqual(files["stats"], "checked out language statistics\n")

    def test_still_fails_for_push_without_translation_artifact(self) -> None:
        result, downloads, files = self.run_fallback({
            "matrix.yml": [{"id": 40, "status": "success"}],
            "artifacts": {"40": {"expired": True}},
        }, event_name="push")
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("No downloadable translation artifact", result.stdout)
        self.assertEqual(downloads, [])
        self.assertFalse(files["placeholder_po"])
        self.assertFalse(files["placeholder_mo"])


if __name__ == "__main__":
    unittest.main()
