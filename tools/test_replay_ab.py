from contextlib import redirect_stderr, redirect_stdout
import io
import json
import os
from pathlib import Path
import sys
import tempfile
import unittest

import replay_ab


class SaveComparisonTest(unittest.TestCase):
    def test_equal_stat_does_not_hide_different_bytes(self):
        with tempfile.TemporaryDirectory() as folder:
            a, b = Path(folder) / "a", Path(folder) / "b"
            a.mkdir()
            b.mkdir()
            (a / "player.sav").write_bytes(b"turn=100")
            (b / "player.sav").write_bytes(b"turn=200")
            stamp = 1_700_000_000_000_000_000
            for path in [a / "player.sav", b / "player.sav"]:
                os.utime(path, ns=(stamp, stamp))
            self.assertEqual(
                replay_ab.diff_trees(a, b), ["differs:   player.sav"]
            )

    def test_hidden_files_and_empty_directories_are_compared(self):
        with tempfile.TemporaryDirectory() as folder:
            a, b = Path(folder) / "a", Path(folder) / "b"
            a.mkdir()
            b.mkdir()
            (a / ".hidden").write_bytes(b"data")
            (b / "empty").mkdir()
            self.assertEqual(
                replay_ab.diff_trees(a, b),
                ["only in A: .hidden", "only in B: empty"],
            )

    def test_missing_save_tree_is_not_equal(self):
        with tempfile.TemporaryDirectory() as folder:
            with self.assertRaises(ValueError):
                replay_ab.diff_trees(Path(folder) / "a", Path(folder) / "b")


@unittest.skipUnless(
    os.name == "posix", "fixture executables use a POSIX shebang"
)
class ReplayProcessTest(unittest.TestCase):
    """Run actual child processes to test the wrapper, not game correctness."""

    def setUp(self):
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.template = self.root / "template"
        self.save = self.template / "save" / "world" / "player.sav"
        self.save.parent.mkdir(parents=True)
        self.save.write_bytes(b"turn=000")
        self.replay = self.root / "input.replay"
        self.replay.write_text(
            "CATA_REPLAY 1\nSEED 123\nEV 1 0 1 46 0 0 - -\n"
        )
        self.report = self.root / "result.json"
        self.work = self.root / "work"
        self.work.mkdir()
        self.binary = self.executable(
            "baseline", "player.write_bytes(b'turn=010')"
        )

    def executable(self, name, body):
        path = self.root / name
        path.write_text(
            f"#!{sys.executable}\n"
            "from pathlib import Path\nimport os, shutil, sys, time\n"
            "root = Path(sys.argv[sys.argv.index('--userdir') + 1])\n"
            "player = root / 'save' / 'world' / 'player.sav'\n" + body + "\n"
        )
        path.chmod(0o755)
        return path

    def arguments(self, extra=()):
        return [
            "--bin",
            str(self.binary),
            "--replay",
            str(self.replay),
            "--userdir-template",
            str(self.template),
            "--work-root",
            str(self.work),
            "--report",
            str(self.report),
            *extra,
        ]

    def execute(self, extra=()):
        with redirect_stdout(io.StringIO()), redirect_stderr(io.StringIO()):
            result = replay_ab.main(self.arguments(extra))
        return result, json.loads(self.report.read_text())

    def assert_invalid(self, extra):
        with redirect_stdout(io.StringIO()), redirect_stderr(io.StringIO()):
            with self.assertRaises(SystemExit) as error:
                replay_ab.main(self.arguments(extra))
        self.assertEqual(error.exception.code, 2)
        self.assertEqual(list(self.work.iterdir()), [])

    def test_legacy_single_binary_runs_twice_without_changing_fixture(self):
        before = replay_ab.tree_manifest(self.template)
        code, report = self.execute()
        self.assertEqual(code, 0)
        self.assertEqual(report["status"], "save_match")
        self.assertEqual(len(report["runs"]), 2)
        self.assertEqual(len(report["binary_sha256"]), 1)
        self.assertEqual(before, replay_ab.tree_manifest(self.template))
        self.assertFalse(Path(report["work_directory"]).exists())

    def test_different_executables_can_produce_matching_saves(self):
        candidate = self.executable(
            "candidate", "player.write_bytes(b'turn=010')\nprint('candidate')"
        )
        code, report = self.execute(
            [
                "--candidate-bin",
                str(candidate),
                "--keep",
                "--runtime-dir",
                str(self.root),
                "--",
                "--seed",
                "123",
            ]
        )
        self.assertEqual(code, 0)
        self.assertEqual(len(report["binary_sha256"]), 2)
        self.assertEqual(report["runs"][1]["command"][0], str(candidate))
        self.assertEqual(report["runs"][1]["command"][-2:], ["--seed", "123"])
        self.assertEqual(report["runs"][1]["cwd"], str(self.root))
        self.assertEqual(
            Path(report["runs"][1]["stdout"]).read_text(), "candidate\n"
        )
        self.assertTrue(report["work_retained"])

    def test_different_same_stat_results_fail_and_are_retained(self):
        self.binary = self.executable(
            "baseline",
            "player.write_bytes(b'turn=010')\n"
            "os.utime(player, ns=(1000000000, 1000000000))",
        )
        candidate = self.executable(
            "candidate",
            "player.write_bytes(b'turn=020')\n"
            "os.utime(player, ns=(1000000000, 1000000000))",
        )
        code, report = self.execute(["--candidate-bin", str(candidate)])
        self.assertEqual(code, 1)
        self.assertEqual(
            report["differences"], ["differs:   world/player.sav"]
        )
        self.assertTrue(Path(report["work_directory"]).is_dir())

    def test_successful_exit_without_progress_cannot_pass(self):
        self.binary = self.executable("noop", "pass")
        code, report = self.execute()
        self.assertEqual(code, 2)
        self.assertEqual(len(report["errors"]), 2)
        self.assertIn("unchanged", report["errors"][0])
        self.assertTrue(report["work_retained"])

    def test_missing_or_empty_save_tree_cannot_pass(self):
        for body in [
            "shutil.rmtree(root / 'save')",
            "player.unlink()",
            "player.write_bytes(b'')",
        ]:
            with self.subTest(body=body):
                self.binary = self.executable("empty", body)
                code, report = self.execute()
                self.assertEqual(code, 2)
                self.assertEqual(report["status"], "invalid")
                self.assertTrue(report["errors"])

    def test_compressed_player_saves_are_supported(self):
        self.save.rename(self.save.with_suffix(".sav.zzip"))
        self.binary = self.executable(
            "compressed",
            "compressed = player.with_suffix('.sav.zzip')\n"
            "compressed.write_bytes(b'new compressed data')",
        )
        code, report = self.execute()
        self.assertEqual(code, 0)
        self.assertEqual(report["status"], "save_match")

    def test_nonzero_exit_retains_process_logs(self):
        self.binary = self.executable(
            "failed", "print('failure detail', file=sys.stderr)\nsys.exit(7)"
        )
        code, report = self.execute()
        self.assertEqual(code, 2)
        self.assertEqual(report["runs"][0]["returncode"], 7)
        self.assertIn(
            "failure detail", Path(report["runs"][0]["stderr"]).read_text()
        )
        self.assertTrue(report["work_retained"])

    def test_timeout_is_failure_with_retained_report(self):
        self.binary = self.executable("hung", "time.sleep(30)")
        code, report = self.execute(["--timeout", "0.05"])
        self.assertEqual(code, 2)
        self.assertTrue(all(run["timed_out"] for run in report["runs"]))
        self.assertTrue(
            (Path(report["work_directory"]) / "report.json").is_file()
        )

    def test_changed_input_fixture_cannot_pass(self):
        self.binary = self.executable(
            "mutator",
            "player.write_bytes(b'turn=010')\n"
            f"Path({str(self.save)!r}).write_bytes(b'changed')",
        )
        code, report = self.execute()
        self.assertEqual(code, 2)
        self.assertIn("fixture or replay changed", report["errors"][0])

    def test_changed_executable_cannot_pass(self):
        self.binary = self.executable(
            "mutator",
            "player.write_bytes(b'turn=010')\n"
            "with Path(__file__).open('a') as f: f.write('# changed\\n')",
        )
        code, report = self.execute()
        self.assertEqual(code, 2)
        self.assertIn("executable changed", report["errors"][0])

    def test_symlink_fixture_is_rejected_before_launch(self):
        (self.template / "linked").symlink_to(self.save)
        self.assert_invalid([])

    def test_empty_recording_is_rejected_before_launch(self):
        self.replay.write_text("CATA_REPLAY 1\nSEED 123\n")
        self.assert_invalid([])

    def test_directory_overrides_are_rejected_before_launch(self):
        for option in ["--userdir", "--configdir", "--world", "--replay-play"]:
            with self.subTest(option=option):
                self.assert_invalid(["--", option, "other"])

    def test_output_paths_cannot_modify_fixture_or_executable(self):
        for extra in [
            ["--work-root", str(self.template)],
            ["--report", str(self.save)],
            ["--report", str(self.binary)],
        ]:
            with self.subTest(extra=extra):
                self.assert_invalid(extra)

    def test_invalid_timeout_rejected_before_launch(self):
        for timeout in ["0", "-1", "nan", "inf"]:
            with self.subTest(timeout=timeout):
                self.assert_invalid(["--timeout", timeout])


if __name__ == "__main__":
    unittest.main()
