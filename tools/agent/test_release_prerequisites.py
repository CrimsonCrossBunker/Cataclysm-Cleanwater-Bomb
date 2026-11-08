"""Exercise release prerequisite failures without remote downloads."""

import http.server
import io
import json
import os
import shutil
import subprocess
import sys
import tarfile
import tempfile
import threading
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
RETRY = ROOT / "build-scripts/retry-download-command.py"


class DownloadRetryTest(unittest.TestCase):
    def run_download(self, outcomes):
        with tempfile.TemporaryDirectory() as directory:
            counter = Path(directory) / "attempts"
            command = """
import json, sys
from pathlib import Path
p = Path(sys.argv[1])
n = int(p.read_text()) if p.exists() else 0
p.write_text(str(n + 1))
outcomes = json.loads(sys.argv[2])
message, code = outcomes[min(n, len(outcomes) - 1)]
print(message)
sys.exit(code)
"""
            result = subprocess.run(
                [sys.executable, str(RETRY), "--delay", "0", "--",
                 sys.executable, "-c", command, str(counter),
                 json.dumps(outcomes)], capture_output=True, text=True,
            )
            return result, int(counter.read_text())

    def test_recovers_from_the_observed_http_504(self):
        result, attempts = self.run_download([
            ("HTTP/2 504", 22), ("download complete", 0),
        ])
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(attempts, 2)

    def test_stops_after_three_transient_failures(self):
        result, attempts = self.run_download([("HTTP/2 503", 22)])
        self.assertEqual(result.returncode, 22)
        self.assertEqual(attempts, 3)

    def test_does_not_retry_permanent_or_non_network_errors(self):
        for message in ("HTTP/2 404", "CMake Error: invalid configuration"):
            with self.subTest(message=message):
                result, attempts = self.run_download([(message, 17)])
                self.assertEqual(result.returncode, 17)
                self.assertEqual(attempts, 1)

    def test_success_runs_once(self):
        result, attempts = self.run_download([("cached archive", 0)])
        self.assertEqual(result.returncode, 0)
        self.assertEqual(attempts, 1)


def translation_install_script():
    workflow = (ROOT / ".github/workflows/build-translations.yml").read_text()
    start = workflow.index("      - name: Install Transifex CLI\n")
    start = workflow.index("        run: |\n", start) + len("        run: |\n")
    lines = []
    for line in workflow[start:].splitlines():
        if line and not line.startswith("          "):
            break
        lines.append(line[10:] if line else "")
    return "\n".join(lines)


@unittest.skipUnless(shutil.which("curl") and shutil.which("tar"),
                     "curl and tar are required")
class TransifexInstallTest(unittest.TestCase):
    def install(self, statuses, valid_archive=True):
        archive = io.BytesIO()
        with tarfile.open(fileobj=archive, mode="w:gz") as output:
            content = b"#!/bin/sh\necho test-cli\n"
            entry = tarfile.TarInfo("tx")
            entry.size = len(content)
            entry.mode = 0o755
            output.addfile(entry, io.BytesIO(content))
        payload = (archive.getvalue() if valid_archive
                   else b"<html>error</html>")
        requests = []

        class Handler(http.server.BaseHTTPRequestHandler):
            def do_GET(self):
                status = statuses[min(len(requests), len(statuses) - 1)]
                requests.append(status)
                self.send_response(status)
                self.end_headers()
                self.wfile.write(payload if status == 200 else b"unavailable")

            def log_message(self, *args):
                pass

        with tempfile.TemporaryDirectory(
            prefix="ccb tx install "
        ) as directory:
            path = Path(directory)
            install_dir = path / "installed"
            install_dir.mkdir()
            binary_dir = path / "bin"
            binary_dir.mkdir()
            sudo = binary_dir / "sudo"
            sudo.write_text("""#!/usr/bin/env python3
import os, sys
args = sys.argv[1:]
assert args[0] == "tar"
assert args[args.index("-C") + 1] == "/usr/bin"
args[args.index("-C") + 1] = os.environ["TEST_INSTALL_DIR"]
os.execvp(args[0], args)
""")
            sudo.chmod(0o755)
            server = http.server.ThreadingHTTPServer(("127.0.0.1", 0), Handler)
            thread = threading.Thread(target=server.serve_forever, daemon=True)
            thread.start()
            try:
                script = translation_install_script().replace(
                    "https://github.com/transifex/cli/releases/download/"
                    "v1.6.17/tx-linux-amd64.tar.gz",
                    f"http://127.0.0.1:{server.server_port}/tx.tar.gz",
                )
                env = dict(os.environ)
                env.update(
                    RUNNER_TEMP=str(path),
                    TEST_INSTALL_DIR=str(install_dir),
                    PATH=str(binary_dir) + os.pathsep + os.environ["PATH"],
                )
                result = subprocess.run(
                    ["bash", "-e", "-o", "pipefail", "-c", script],
                    env=env, capture_output=True, text=True, timeout=30,
                )
                installed = (install_dir / "tx").exists()
            finally:
                server.shutdown()
                server.server_close()
                thread.join()
            return result, requests, installed

    def test_http_504_recovers_before_extracting(self):
        result, requests, installed = self.install([504, 200])
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(requests, [504, 200])
        self.assertTrue(installed)

    def test_http_404_never_reaches_installation(self):
        result, requests, installed = self.install([404])
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(requests, [404])
        self.assertFalse(installed)

    def test_invalid_archive_is_not_installed(self):
        result, requests, installed = self.install([200], valid_archive=False)
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(requests, [200])
        self.assertFalse(installed)


@unittest.skipUnless(shutil.which("make"), "make is required")
class FormatterCheckoutTest(unittest.TestCase):
    def test_sparse_formatter_checkout_resolves_makefile_includes(self):
        path = ROOT / ".github/workflows/compose-tilesets.yml"
        workflow = path.read_text()
        block = workflow.split("          sparse-checkout: |\n", 1)[1]
        paths = []
        for line in block.splitlines():
            if not line.startswith("            "):
                break
            paths.append(line.strip())
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            shutil.copyfile(ROOT / "Makefile", root / "Makefile")
            (root / "src").mkdir()
            for name in ("json.cpp", "wcwidth.cpp"):
                (root / "src" / name).touch()
            if "build-scripts" in paths:
                (root / "build-scripts").mkdir()
                shutil.copyfile(ROOT / "build-scripts/coop.mk",
                                root / "build-scripts/coop.mk")
            result = subprocess.run(
                ["make", "-n", "tools/format/json_formatter.cgi"],
                cwd=root, capture_output=True, text=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr)


if __name__ == "__main__":
    unittest.main()
