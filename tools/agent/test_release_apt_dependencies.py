"""Exercise release dependency scripts without installing host packages."""

import json
import os
from pathlib import Path
import re
import subprocess
import tempfile
import textwrap
import unittest


ROOT = Path(__file__).resolve().parents[2]
STEPS = (
    ("compose-tilesets.yml", "Install dependencies"),
    ("release.yml", "install glslang"),
    ("release.yml", "Install dependencies (Linux)"),
    ("release.yml", "Setup Build and Dependencies (android)"),
)
FAKE_SUDO = '''#!/usr/bin/env python3
import json
import os
from pathlib import Path
import sys

args = sys.argv[1:]
assert args[0] == "apt-get", args
with Path(os.environ["APT_CALLS"]).open("a") as log:
    log.write(json.dumps(args) + "\\n")
scenario = os.environ["APT_SCENARIO"]
if "update" in args and scenario == "stale-index":
    # apt update normally accepts a partial failure and retains old indexes.
    print("W: Failed to fetch package index; old indexes used instead")
    sys.exit(100 if "--error-on=any" in args else 0)
if "install" in args and scenario == "missing-package":
    print("E: Failed to fetch libpoppler: 404 Not Found")
    sys.exit(100)
'''


def dependency_step(workflow, name):
    source = (ROOT / ".github/workflows" / workflow).read_text()
    match = re.search(r"^( *)- name: " + re.escape(name) + r"$",
                      source, re.MULTILINE)
    indent = len(match.group(1))
    lines = []
    for line in source[match.end():].splitlines():
        if line.strip() and len(line) - len(line.lstrip()) <= indent:
            break
        lines.append(line)
    return textwrap.dedent("\n".join(lines))


class ReleaseAptDependenciesTest(unittest.TestCase):
    def run_step(self, workflow, name, scenario):
        step = dependency_step(workflow, name)
        # Network failures must not hold the release queue for six hours.
        timeout = re.search(r"^timeout-minutes: (\d+)$", step, re.MULTILINE)
        self.assertIsNotNone(timeout, name)
        self.assertTrue(0 < int(timeout.group(1)) <= 15, name)
        self.assertIn("shell: bash", step)
        script = textwrap.dedent(step.split("run: |\n", 1)[1])
        with tempfile.TemporaryDirectory(prefix="ccb-release-apt-") as tmp:
            root = Path(tmp)
            sudo = root / "sudo"
            sudo.write_text(FAKE_SUDO)
            sudo.chmod(0o755)
            calls = root / "calls"
            result = subprocess.run(
                ["bash", "-e", "-o", "pipefail", "-c", script],
                env=dict(os.environ,
                         PATH=tmp + os.pathsep + os.environ["PATH"],
                         APT_SCENARIO=scenario, APT_CALLS=str(calls)),
                text=True, capture_output=True, timeout=10,
            )
            return result, [json.loads(line)
                            for line in calls.read_text().splitlines()]

    def test_refreshes_indexes_before_noninteractive_install(self):
        for workflow, name in STEPS:
            with self.subTest(workflow=workflow, step=name):
                result, calls = self.run_step(workflow, name, "success")
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(len(calls), 2)
                self.assertIn("update", calls[0])
                self.assertIn("install", calls[1])
                self.assertIn("-y", calls[1])

    def test_stale_indexes_stop_before_package_installation(self):
        for workflow, name in STEPS:
            with self.subTest(workflow=workflow, step=name):
                result, calls = self.run_step(workflow, name, "stale-index")
                self.assertEqual(result.returncode, 100, result.stdout)
                self.assertEqual(len(calls), 1)
                self.assertIn("update", calls[0])

    def test_missing_package_fails_the_step(self):
        for workflow, name in STEPS:
            with self.subTest(workflow=workflow, step=name):
                result, calls = self.run_step(
                    workflow, name, "missing-package")
                self.assertEqual(result.returncode, 100, result.stdout)
                self.assertIn("install", calls[-1])


if __name__ == "__main__":
    unittest.main()
