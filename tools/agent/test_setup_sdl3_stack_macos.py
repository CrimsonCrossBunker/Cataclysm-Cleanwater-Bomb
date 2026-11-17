"""Check MacPorts index initialization before installing SDL3 dependencies."""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

import yaml


ROOT = Path(__file__).resolve().parents[2]
ACTION = ROOT / ".github/actions/setup-sdl3-stack-macos/action.yml"


@unittest.skipUnless(shutil.which("bash"), "bash is required")
class MacPortsSetupTest(unittest.TestCase):
    def install(self, sync_status=0):
        action = yaml.safe_load(ACTION.read_text(encoding="utf-8"))
        step = next(step for step in action["runs"]["steps"]
                    if step["name"] == "install macports packages (mac, SDL3)")
        script = """
sudo() {
    printf '%s\\n' "$*" >> "$TEST_COMMAND_LOG"
    if [ "$*" = "port -v sync" ]; then
        return "$TEST_SYNC_STATUS"
    fi
}
""" + step["run"]
        with tempfile.TemporaryDirectory() as directory:
            log = Path(directory) / "commands"
            env = dict(os.environ, TEST_COMMAND_LOG=str(log),
                       TEST_SYNC_STATUS=str(sync_status))
            result = subprocess.run(
                ["bash", "-e", "-o", "pipefail", "-c", script],
                env=env, capture_output=True, text=True, timeout=10,
            )
            commands = log.read_text(encoding="utf-8").splitlines()
        return result, commands

    def test_syncs_ports_before_installing_universal_dependencies(self):
        result, commands = self.install()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(len(commands), 2)
        self.assertEqual(commands[0], "port -v sync")
        expected = ["port", "install"]
        for package in ("freetype", "pkgconfig", "libiconv", "libogg",
                        "flac", "libvorbis", "wavpack", "mpg123"):
            expected.extend((package, "+universal"))
        self.assertEqual(commands[1].split(), expected)

    def test_failed_sync_stops_before_installing_packages(self):
        result, commands = self.install(sync_status=42)
        self.assertEqual(result.returncode, 42, result.stderr)
        self.assertEqual(commands, ["port -v sync"])


if __name__ == "__main__":
    unittest.main()
