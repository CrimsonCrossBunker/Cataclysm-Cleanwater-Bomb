#!/usr/bin/env python3
"""Exercise the production HEADLESS executable without a terminal or display.

Run with --binary <cataclysm> --basepath <source directory>.  Full saved-game
replay equivalence is a separate integration gate; these tests cover startup
and failure paths using isolated, disposable user directories.
"""

import argparse
import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


class HeadlessCommandLineTest(unittest.TestCase):
    binary: Path
    basepath: Path

    def setUp(self):
        temporary = tempfile.TemporaryDirectory(prefix="ccb-headless-cli-")
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.user = self.root / "user"
        self.user.mkdir()
        self.report = self.root / "completion.json"
        self.environment = os.environ.copy()
        for key in (
            "DISPLAY", "WAYLAND_DISPLAY", "WAYLAND_SOCKET",
            "DBUS_SESSION_BUS_ADDRESS", "SDL_VIDEO_DRIVER",
            "SDL_RENDER_DRIVER", "SDL_AUDIODRIVER",
        ):
            self.environment.pop(key, None)

    def invoke(self, *arguments, timeout=45):
        return subprocess.run(
            [str(self.binary), "--basepath", str(self.basepath) + "/",
             "--userdir", str(self.user) + "/", *map(str, arguments)],
            cwd=self.basepath, env=self.environment, stdin=subprocess.DEVNULL,
            capture_output=True, text=True, timeout=timeout,
        )

    def assert_rejected(self, result):
        self.assertGreater(result.returncode, 0, result.stdout + result.stderr)

    def test_version_does_not_require_input(self):
        result = self.invoke("--version")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("Cataclysm", result.stdout)

    def test_help_does_not_require_input(self):
        result = self.invoke("--help")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("--replay-play", result.stdout)

    def test_missing_input_is_rejected_before_entering_a_menu(self):
        result = self.invoke()
        self.assert_rejected(result)
        self.assertIn("--replay-play", result.stderr)
        self.assertFalse(self.report.exists())

    def test_recording_cannot_replace_an_input_source(self):
        recording = self.root / "recording.replay"
        result = self.invoke("--replay-record", recording)
        self.assert_rejected(result)
        self.assertIn("--replay-play", result.stderr)
        self.assertFalse(recording.exists())

    def test_malformed_recording_does_not_report_success(self):
        replay = self.root / "malformed.replay"
        replay.write_text("CATA_REPLAY 999\nSEED 20261101\n", encoding="utf-8")
        original = replay.read_bytes()
        result = self.invoke("--replay-play", replay,
                             "--replay-report", self.report)
        self.assert_rejected(result)
        self.assertEqual(replay.read_bytes(), original)
        self.assertFalse(self.report.exists())

    def test_menu_input_exhaustion_reports_incomplete(self):
        replay = self.root / "exhausted.replay"
        replay.write_text("CATA_REPLAY 1\nSEED 20261101\n"
                          "EV 3 0 1 32 0 0 - -\n", encoding="utf-8")
        original = replay.read_bytes()
        result = self.invoke("--replay-play", replay,
                             "--replay-report", self.report)
        self.assert_rejected(result)
        self.assertEqual(replay.read_bytes(), original)
        completion = json.loads(self.report.read_text(encoding="utf-8"))
        self.assertEqual(completion["status"], "incomplete")
        self.assertTrue(completion["input_failed"])
        self.assertEqual(completion["events_remaining"], 0)
        self.assertFalse(completion["quit_saved"])

    def test_json_validation_does_not_require_input(self):
        result = self.invoke("--jsonverify")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_mod_validation_does_not_require_input(self):
        result = self.invoke("--check-mods", "dda")
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--binary", required=True, type=Path)
    parser.add_argument("--basepath", required=True, type=Path)
    options, remaining = parser.parse_known_args()
    HeadlessCommandLineTest.binary = options.binary.resolve(strict=True)
    HeadlessCommandLineTest.basepath = options.basepath.resolve(strict=True)
    unittest.main(argv=[__file__, *remaining])
