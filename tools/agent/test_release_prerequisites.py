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
import zipfile
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

    def test_recovers_from_the_observed_vcpkg_download_failure(self):
        result, attempts = self.run_download([
            ("EXEC : error : curl operation failed with response code 504.",
             1),
            ("build complete", 0),
        ])
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(attempts, 2)

    def test_windows_build_uses_bounded_download_retries(self):
        workflow = (
            ROOT / ".github/workflows/msvc-full-features.yml"
        ).read_text()
        self.assertIn(
            "python build-scripts/retry-download-command.py -- msbuild -m",
            workflow,
        )

    def test_does_not_retry_permanent_or_non_network_errors(self):
        for message in ("HTTP/2 404", "CMake Error: invalid configuration",
                        "curl operation failed with response code 404."):
            with self.subTest(message=message):
                result, attempts = self.run_download([(message, 17)])
                self.assertEqual(result.returncode, 17)
                self.assertEqual(attempts, 1)

    def test_success_runs_once(self):
        result, attempts = self.run_download([("cached archive", 0)])
        self.assertEqual(result.returncode, 0)
        self.assertEqual(attempts, 1)


def workflow_script(path, name):
    workflow = (ROOT / path).read_text()
    start = workflow.index("- name: " + name + "\n")
    start = workflow.index("run: |\n", start) + len("run: |\n")
    body = workflow[start:].splitlines()
    indentation = len(body[0]) - len(body[0].lstrip())
    lines = []
    for line in body:
        if line and not line.startswith(" " * indentation):
            break
        lines.append(line[indentation:] if line else "")
    return "\n".join(lines)


def translation_install_script():
    return workflow_script(".github/workflows/build-translations.yml",
                           "Install Transifex CLI")


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


@unittest.skipUnless(
    shutil.which("curl") and shutil.which("tar") and shutil.which("bash"),
    "curl, tar and bash are required",
)
class CcacheInstallTest(unittest.TestCase):
    def install(self, statuses, valid_archive=True):
        archive = io.BytesIO()
        with tarfile.open(fileobj=archive, mode="w:xz") as output:
            content = b"#!/bin/sh\necho test-ccache\n"
            entry = tarfile.TarInfo(
                "ccache-4.10.2-linux-x86_64/ccache")
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
            prefix="ccb ccache install "
        ) as directory:
            root = Path(directory)
            marker = root / "install-commands"
            server = http.server.ThreadingHTTPServer(("127.0.0.1", 0), Handler)
            thread = threading.Thread(target=server.serve_forever, daemon=True)
            thread.start()
            try:
                script = workflow_script(
                    ".github/workflows/matrix.yml",
                    "install recent ccache on ubuntu")
                script = script.replace(
                    "https://github.com/ccache/ccache/releases/download/"
                    "v4.10.2/"
                    "ccache-4.10.2-linux-x86_64.tar.xz",
                    f"http://127.0.0.1:{server.server_port}/ccache.tar.xz",
                )
                env = dict(os.environ)
                env.update(RUNNER_TEMP=root.as_posix(),
                           TEST_INSTALL_MARKER=marker.as_posix())
                shell_setup = (
                    'ccache() { :; }\n'
                    'sudo() {\n'
                    '  printf "%s\\n" "$*" >> "$TEST_INSTALL_MARKER"\n'
                    '}\n'
                )
                result = subprocess.run(
                    ["bash", "-e", "-o", "pipefail", "-c",
                     shell_setup + script],
                    env=env, capture_output=True, text=True, timeout=30,
                )
                commands = marker.read_text() if marker.exists() else ""
            finally:
                server.shutdown()
                server.server_close()
                thread.join()
            return result, requests, commands

    def test_http_504_recovers_before_installing(self):
        result, requests, commands = self.install([504, 200])
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(requests, [504, 200])
        self.assertIn("apt-get remove", commands)
        self.assertIn("tar -xJf", commands)

    def test_http_404_preserves_the_installed_cache(self):
        result, requests, commands = self.install([404])
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(requests, [404])
        self.assertEqual(commands, "")

    def test_http_504_exhaustion_preserves_the_installed_cache(self):
        result, requests, commands = self.install([504])
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(requests, [504, 504, 504, 504])
        self.assertEqual(commands, "")

    def test_invalid_archive_preserves_the_installed_cache(self):
        result, requests, commands = self.install([200], valid_archive=False)
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(requests, [200])
        self.assertEqual(commands, "")


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


@unittest.skipUnless(shutil.which("unzip"), "unzip is required")
class TilesetDownloadTest(unittest.TestCase):
    def download(self, valid_archive=True, tag="undead-test"):
        with tempfile.TemporaryDirectory(prefix="ccb tileset ") as directory:
            root = Path(directory)
            archive = root / "fixture.zip"
            with zipfile.ZipFile(archive, "w") as output:
                output.writestr("UNDEAD_PEOPLE/tileset.txt", "tileset fixture")
            if not valid_archive:
                archive.write_text("not a zip archive")
            binary_dir = root / "bin"
            binary_dir.mkdir()
            (binary_dir / "gh").write_text("""#!/usr/bin/env python3
import os, sys
assert sys.argv[1:3] == ["release", "list"], "REST asset API is rate limited"
print(os.environ["TEST_TAG"])
""")
            (binary_dir / "curl").write_text("""#!/usr/bin/env python3
import os, shutil, sys
args = sys.argv[1:]
assert "--fail" in args and "--retry" in args
assert "--header" not in args and "--user" not in args
expected = ("https://github.com/CrimsonCrossBunker/CCB_UNDEAD_PEOPLE/"
            "releases/download/undead-test/CCB_UNDEAD_PEOPLE.zip")
assert args[-1] == expected
shutil.copyfile(os.environ["TEST_ARCHIVE"], args[args.index("--output") + 1])
""")
            for executable in binary_dir.iterdir():
                executable.chmod(0o755)
            env = dict(os.environ)
            env.update(
                PATH=str(binary_dir) + os.pathsep + os.environ["PATH"],
                TEST_ARCHIVE=str(archive), TEST_TAG=tag,
                TILESET_REPOSITORY="CrimsonCrossBunker/CCB_UNDEAD_PEOPLE",
                ASSET_NAME="CCB_UNDEAD_PEOPLE.zip", SUBDIR="UNDEAD_PEOPLE",
            )
            result = subprocess.run(
                ["bash", "-e", "-o", "pipefail", "-c", workflow_script(
                    ".github/workflows/compose-tilesets.yml",
                    "Download ${{ matrix.name }} from latest release")],
                cwd=root, env=env, capture_output=True, text=True,
            )
            return result, (root / "precomposed-tileset/tileset.txt").exists()

    def test_downloads_public_asset_without_rest_asset_api(self):
        result, installed = self.download()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue(installed)

    def test_rejects_invalid_archive_before_copying(self):
        result, installed = self.download(valid_archive=False)
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse(installed)

    def test_missing_release_does_not_download(self):
        result, installed = self.download(tag="")
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse(installed)


if __name__ == "__main__":
    unittest.main()
