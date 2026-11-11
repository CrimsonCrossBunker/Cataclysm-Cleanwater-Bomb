from contextlib import redirect_stderr, redirect_stdout
import io
import json
import os
from pathlib import Path
import sys
import tempfile
import unittest

import replay_ab


def native_summary(**changes):
    result = {
        "schema_version": 2, "status": "complete", "seed": 123,
        "events_total": 1, "events_remaining": 0, "input_failed": False,
        "game_started": True, "quit_saved": True, "completed_turn_calls": 2,
        "turn_start": 100, "turn_end": 101,
        "initial_position": [1, 2, 0], "final_position": [1, 2, 0],
        "turn_positions": [[1, 2, 0], [1, 2, 0]],
        "initial_monsters": 759, "final_monsters": 759,
        "turn_wall_ns": [1000, 2000], "completion_wall_ns": 500,
    }
    return {**result, **changes}


class NativeCompletionTest(unittest.TestCase):
    def test_report_requires_observed_complete_run(self):
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "result.json"
            replay = {"seed": 123, "recorded_events": 1}
            path.write_text(json.dumps(native_summary()))
            self.assertEqual(replay_ab.read_native_completion(path, replay, 2),
                             native_summary())
            bad = [
                {"status": "incomplete"}, {"schema_version": True},
                {"schema_version": 0}, {"schema_version": 3},
                {"seed": 124}, {"events_remaining": 1}, {"events_total": 2},
                {"input_failed": True}, {"game_started": False},
                {"quit_saved": False}, {"completed_turn_calls": 1},
                {"turn_wall_ns": [1000]}, {"turn_wall_ns": [-1, 2000]},
                {"turn_wall_ns": [True, 2000]}, {"completion_wall_ns": -1},
                {"turn_end": 99}, {"turn_start": 100.0},
                {"initial_position": [0, 0]}, {"final_position": [0, 0, True]},
                {"initial_monsters": False}, {"final_monsters": -1},
                {"turn_positions": None}, {"turn_positions": []},
                {"turn_positions": [[1, 2, 0]]},
                {"turn_positions": [[1, 2], [1, 2, 0]]},
                {"turn_positions": [[True, 2, 0], [1, 2, 0]]},
                {"turn_positions": [[1, 2, 0], [2, 2, 0]]},
            ]
            for change in bad:
                with self.subTest(change=change):
                    path.write_text(json.dumps(native_summary(**change)))
                    with self.assertRaises(ValueError):
                        replay_ab.read_native_completion(path, replay, 2)

    def test_trace_is_required_in_v2_but_legacy_reports_remain_readable(self):
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "result.json"
            replay = {"seed": 123, "recorded_events": 1}
            missing = native_summary()
            del missing["turn_positions"]
            path.write_text(json.dumps(missing))
            with self.assertRaises(ValueError):
                replay_ab.read_native_completion(path, replay, 2)
            missing["schema_version"] = 1
            path.write_text(json.dumps(missing))
            self.assertEqual(replay_ab.read_native_completion(path, replay, 2),
                             missing)

    def test_empty_trace_can_describe_zero_completed_turns(self):
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / "result.json"
            report = native_summary(completed_turn_calls=0, turn_positions=[],
                                    turn_wall_ns=[], turn_end=100)
            path.write_text(json.dumps(report))
            self.assertEqual(replay_ab.read_native_completion(
                path, {"seed": 123, "recorded_events": 1}, 0), report)


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

    def native_executable(self, name, summary):
        return self.executable(
            name, "import json\nplayer.write_bytes(b'turn=010')\n"
            "out = Path(sys.argv[sys.argv.index('--replay-report') + 1])\n"
            f"out.write_text(json.dumps({summary!r}))",
        )

    def test_native_completion_is_required_when_requested(self):
        code, report = self.execute(["--expected-turns", "2"])
        self.assertEqual(code, 2)
        self.assertTrue(report["errors"])
        self.binary = self.native_executable("native", native_summary())
        code, report = self.execute(["--expected-turns", "2"])
        self.assertEqual(code, 0)
        self.assertEqual(
            report["runs"][0]["native_completion"], native_summary())

    def test_recorded_zero_overrides_distinct_invocation_seeds(self):
        self.replay.write_text(
            self.replay.read_text().replace("SEED 123", "SEED 0"))
        self.binary = self.native_executable("native", native_summary(seed=0))
        code, report = self.execute([
            "--expected-turns", "2", "--invocation-seeds", "first", "second",
        ])
        self.assertEqual(code, 0)
        for run, seed in zip(report["runs"], ("first", "second")):
            command = run["command"]
            self.assertEqual(command[command.index("--seed") + 1], seed)
            self.assertEqual(run["native_completion"]["seed"], 0)

    def test_invocation_seed_leaking_into_save_fails_comparison(self):
        self.binary = self.executable(
            "seed_leak",
            "player.write_text(sys.argv[sys.argv.index('--seed') + 1])",
        )
        code, report = self.execute(["--invocation-seeds", "first", "second"])
        self.assertEqual(code, 1)
        self.assertEqual(report["differences"], [
                         "differs:   world/player.sav"])

    def test_conflicting_invocation_seeds_fail_before_copying(self):
        for extra in (["--seed", "shared"], ["--seed=shared"]):
            self.assert_invalid(
                ["--invocation-seeds", "first", "second", "--", *extra])

    def test_different_native_positions_fail_even_with_equal_save_bytes(self):
        self.binary = self.native_executable("native", native_summary())
        candidate = self.native_executable(
            "candidate", native_summary(final_position=[2, 2, 0],
                                        turn_positions=[[1, 2, 0], [2, 2, 0]]))
        code, report = self.execute([
            "--expected-turns", "2", "--candidate-bin", str(candidate),
        ])
        self.assertEqual(code, 1)
        self.assertIn("native differs: final_position", report["differences"])

    def test_different_routes_fail_even_with_equal_final_positions_and_saves(
            self):
        self.binary = self.native_executable("native", native_summary())
        candidate = self.native_executable(
            "candidate", native_summary(turn_positions=[[2, 2, 0], [1, 2, 0]]))
        code, report = self.execute([
            "--expected-turns", "2", "--candidate-bin", str(candidate),
        ])
        self.assertEqual(code, 1)
        self.assertEqual(report["differences"],
                         ["native differs: turn_positions"])

    def test_mixed_report_versions_cannot_claim_matching_trajectories(self):
        legacy = native_summary(schema_version=1)
        del legacy["turn_positions"]
        self.binary = self.native_executable("native", legacy)
        candidate = self.native_executable("candidate", native_summary())
        code, report = self.execute([
            "--expected-turns", "2", "--candidate-bin", str(candidate),
        ])
        self.assertEqual(code, 1)
        self.assertIn("native differs: schema_version", report["differences"])

    def test_incomplete_native_run_cannot_pass_with_matching_saves(self):
        self.binary = self.native_executable(
            "native", native_summary(quit_saved=False))
        code, report = self.execute(["--expected-turns", "2"])
        self.assertEqual(code, 2)
        self.assertIn("native quit_saved", report["errors"][0])

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

    def test_profile_seed_is_recorded_without_changing_legacy_metadata(self):
        legacy = replay_ab.replay_metadata(self.replay)
        self.assertNotIn("profile_seed", legacy)
        seed = "0123456789abcdef0123456789abcdef"
        self.replay.write_text(
            f"CATA_REPLAY 2\nSEED 123\nPROFILE_SEED {seed}\n"
            "EV 1 0 1 46 0 0 - -\n")
        current = replay_ab.replay_metadata(self.replay)
        self.assertEqual(current["profile_seed"], seed)
        self.assertEqual(current["seed"], legacy["seed"])
        self.assertEqual(current["recorded_events"], legacy["recorded_events"])
        self.assertNotEqual(current["sha256"], legacy["sha256"])

    def test_malformed_profile_seeds_are_rejected_before_launch(self):
        for header in ["", "PROFILE_SEED", "PROFILE_SEED " + "A" * 32,
                       "PROFILE_SEED " + "a" * 31,
                       "PROFILE_SEED " + "a" * 32 + " extra"]:
            with self.subTest(header=header):
                self.replay.write_text(
                    f"CATA_REPLAY 2\nSEED 123\n{header}\nEV 1 0 1 46 0 0 - -\n"
                )
                self.assert_invalid([])

    def test_directory_overrides_are_rejected_before_launch(self):
        for option in ["--userdir", "--configdir", "--world", "--replay-play",
                       "--replay-report"]:
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
