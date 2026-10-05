import tempfile
import unittest
from pathlib import Path

from analyze_action_phases import Event, intersection, merged, read_events, span, summarize


class ActionPhaseTests(unittest.TestCase):
    def fixture(self):
        return [
            Event("input.acquire", 0, 1000, "2"),
            Event("tiles.draw", 10, 20, "2"),
            Event("game.action_execute", 1000, 5, "2", "UP"),
            Event("game.mid_step", 1005, 5, "2"),
            Event("tiles.draw", 1007, 2, "2"),
            Event("input.acquire", 1010, 30, "2"),
            Event("tiles.draw", 1020, 4, "2"),
            Event("game.action_execute", 1040, 5, "2", "DOWN"),
            Event("simulate_turn_suffix", 1050, 7, "2"),
            Event("monmove", 1051, 3, "2"),
            Event("game.mid_step", 1057, 8, "2"),
            Event("tiles.draw", 1060, 4, "2"),
            Event("input.acquire", 1065, 1935, "2"),
            Event("tiles.draw", 1100, 5, "2"),
            Event("tiles.draw", 1030, 50, "worker"),
        ]

    def test_idle_start_tail_and_workers_are_excluded(self):
        result = summarize(self.fixture(), ["UP", "DOWN"], ["UP", "DOWN"])
        self.assertEqual(result["window_ns"], [1000, 1065])
        self.assertEqual(result["zones"]["input.acquire"]["union_elapsed_ns"], 30)
        self.assertEqual(result["zones"]["tiles.draw"]["union_elapsed_ns"], 10)
        self.assertEqual(result["phase_covered_elapsed_ns"], 60)
        self.assertEqual(result["outside_named_phases_elapsed_ns"], 5)
        self.assertEqual(result["phase_overlap_ns"], 0)
        self.assertEqual(result["tiles_draw_inside_phase_ns"], {
            "game.action_execute": 0, "input.acquire": 4,
            "game.mid_step": 6, "simulate_turn_suffix": 0,
        })

    def test_overlaps_are_unioned_without_double_counting(self):
        self.assertEqual(merged([(5, 10), (0, 7), (10, 11), (20, 20)]), [(0, 11)])
        self.assertEqual(span([(0, 10), (5, 15)]), 15)
        self.assertEqual(intersection([(0, 8), (10, 20)], [(4, 12)]), [(4, 8), (10, 12)])
        events = self.fixture() + [Event("input.acquire", 1000, 65, "2")]
        result = summarize(events, ["UP", "DOWN"], ["UP", "DOWN"])
        self.assertEqual(result["phase_covered_elapsed_ns"], 65)
        self.assertEqual(result["phase_overlap_ns"], 30)
        self.assertEqual(result["tiles_draw_outside_named_phases_ns"], 0)

    def test_partial_scope_is_clipped_and_not_a_complete_call(self):
        events = self.fixture() + [Event("tiles.layer_loop", 990, 25, "2")]
        result = summarize(events, ["UP", "DOWN"], ["UP", "DOWN"])
        zone = result["zones"]["tiles.layer_loop"]
        self.assertEqual(zone["union_elapsed_ns"], 15)
        self.assertEqual(zone["overlapping_calls"], 1)
        self.assertEqual(zone["complete_calls"], 0)
        self.assertIsNone(zone["complete_call_ms"])

    def test_wrong_order_or_count_is_rejected(self):
        for expected in (["DOWN", "UP"], ["UP"], ["UP", "DOWN", "UP"]):
            with self.subTest(expected=expected), self.assertRaises(ValueError):
                summarize(self.fixture(), expected, ["UP", "DOWN"])

    def test_intervening_ui_action_is_rejected(self):
        events = self.fixture() + [Event("game.action_execute", 1030, 2, "2", "look")]
        with self.assertRaisesRegex(ValueError, "unexpected action"):
            summarize(events, ["UP", "DOWN"], ["UP", "DOWN"])

    def test_missing_completed_tail_is_rejected(self):
        events = [e for e in self.fixture() if not (e.name == "game.mid_step" and e.start == 1057)]
        with self.assertRaisesRegex(ValueError, "incomplete capture"):
            summarize(events, ["UP", "DOWN"], ["UP", "DOWN"])

    def test_deferred_frame_extends_window_past_undrawn_mid_step(self):
        events = [e for e in self.fixture() if not (e.name == "tiles.draw" and e.start == 1060)]
        events += [Event("game.input_redraw", 1066, 8, "2"),
                   Event("tiles.draw", 1068, 4, "2")]
        result = summarize(events, ["UP", "DOWN"], ["UP", "DOWN"])
        self.assertEqual(result["window_ns"], [1000, 1074])
        self.assertEqual(result["presentation_tail"]["zone"], "game.input_redraw")
        self.assertEqual(result["zones"]["input.acquire"]["overlapping_calls"], 2)
        self.assertEqual(result["zones"]["input.acquire"]["complete_calls"], 1)
        self.assertEqual(result["tiles_draw_inside_phase_ns"]["input.acquire"], 8)

    def test_undrawn_mid_step_is_not_a_completed_frame(self):
        events = [e for e in self.fixture() if not (e.name == "tiles.draw" and e.start == 1060)]
        with self.assertRaisesRegex(ValueError, "incomplete capture"):
            summarize(events, ["UP", "DOWN"], ["UP", "DOWN"])

    def test_worker_draw_cannot_complete_the_avatar_frame(self):
        events = [e for e in self.fixture() if not (e.name == "tiles.draw" and e.start == 1060)]
        events += [Event("game.input_redraw", 1066, 8, "worker"),
                   Event("tiles.draw", 1068, 4, "worker")]
        with self.assertRaisesRegex(ValueError, "incomplete capture"):
            summarize(events, ["UP", "DOWN"], ["UP", "DOWN"])

    def test_multiple_action_threads_are_rejected(self):
        events = [Event(e.name, e.start, e.duration, "worker", e.value)
                  if e.value == "DOWN" else e for e in self.fixture()]
        with self.assertRaisesRegex(ValueError, "multiple Tracy threads"):
            summarize(events, ["UP", "DOWN"], ["UP", "DOWN"])

    def test_bad_sequence_is_rejected(self):
        for expected in ([], "UP", [None], [""]):
            with self.subTest(expected=expected), self.assertRaises(ValueError):
                summarize(self.fixture(), expected, ["UP", "DOWN"])

    def test_csv_values_and_malformed_rows(self):
        header = "name,src_file,src_line,ns_since_start,exec_time_ns,thread,value\n"
        good = 'game.action_execute,a.cpp,12,100,20,2,"menu, quoted"\n'
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "events.csv"
            path.write_text(header + good)
            self.assertEqual(read_events([path]), [Event("game.action_execute", 100, 20, "2", "menu, quoted")])
            with self.assertRaisesRegex(ValueError, "duplicate"):
                read_events([path, path])
            for body in ("wrong_header\n", header + good.replace(",100,20,", ",-1,20,"),
                         header + "game.action_execute,a.cpp,12,100,20,2,UP,extra\n",
                         header + "game.action_execute,a.cpp,12,100,20,2\n"):
                path.write_text(body)
                with self.subTest(body=body), self.assertRaises(ValueError):
                    read_events([path])

    def pause_fixture(self):
        return [
            Event("game.action_execute", 1000, 5, "2", "PAUSE"),
            Event("game.mid_step", 1005, 5, "2"),
            Event("tiles.draw", 1007, 2, "2"),
            Event("simulate_turn_suffix", 1010, 20, "2"),
            Event("monmove", 1012, 15, "2"),
            Event("input.acquire", 1030, 70, "2"),
            Event("game.action_execute", 1100, 5, "2", "PAUSE"),
            Event("game.mid_step", 1105, 5, "2"),
            Event("tiles.draw", 1107, 2, "2"),
            Event("simulate_turn_suffix", 1110, 20, "2"),
            Event("monmove", 1112, 15, "2"),
            Event("game.input_redraw", 1130, 20, "2"),
            Event("tiles.draw", 1132, 10, "2"),
        ]

    def pause_summary(self, events):
        return summarize(events, ["PAUSE", "PAUSE"], ["PAUSE"],
                         require_turn_per_action=True)

    def test_pause_tail_includes_simulation_after_early_action_redraw(self):
        events = self.pause_fixture()
        default = summarize(events, ["PAUSE", "PAUSE"], ["PAUSE"])
        self.assertEqual(default["window_ns"], [1000, 1110])
        result = self.pause_summary(events)
        self.assertEqual(result["window_ns"], [1000, 1150])
        self.assertEqual(result["completed_turns"]["count"], 2)
        self.assertEqual(result["completed_turns"]["last_suffix_end_ns"], 1130)
        for name in ("simulate_turn_suffix", "monmove"):
            self.assertEqual(result["zones"][name]["complete_calls"], 2)

    def test_acknowledged_pause_without_simulation_is_rejected(self):
        events = [e for e in self.pause_fixture()
                  if not (e.name == "simulate_turn_suffix" and e.start == 1110)]
        with self.assertRaisesRegex(ValueError, "action 2.*completed turn suffix"):
            self.pause_summary(events)

    def test_one_turn_per_pause_cannot_be_replaced_by_a_total_count(self):
        events = [e for e in self.pause_fixture()
                  if not (e.name == "simulate_turn_suffix" and e.start == 1110)]
        events.append(Event("simulate_turn_suffix", 1050, 20, "2"))
        with self.assertRaisesRegex(ValueError, "action 1.*completed turn suffix"):
            self.pause_summary(events)

    def test_turn_must_finish_before_next_pause(self):
        events = [Event(e.name, e.start, 100, e.thread, e.value)
                  if e.name == "simulate_turn_suffix" and e.start == 1010 else e
                  for e in self.pause_fixture()]
        with self.assertRaisesRegex(ValueError, "action 1.*completed turn suffix"):
            self.pause_summary(events)

    def test_missing_partial_or_worker_only_monster_update_is_rejected(self):
        for replacement in (None, Event("monmove", 1112, 30, "2"),
                            Event("monmove", 1112, 15, "worker")):
            events = [e for e in self.pause_fixture()
                      if not (e.name == "monmove" and e.start == 1112)]
            if replacement:
                events.append(replacement)
            with self.subTest(replacement=replacement), self.assertRaisesRegex(
                    ValueError, "action 2.*completed monster update"):
                self.pause_summary(events)

    def test_worker_suffix_cannot_complete_avatar_turn(self):
        events = [Event(e.name, e.start, e.duration, "worker", e.value)
                  if e.name == "simulate_turn_suffix" and e.start == 1110 else e
                  for e in self.pause_fixture()]
        with self.assertRaisesRegex(ValueError, "action 2.*completed turn suffix"):
            self.pause_summary(events)

    def test_extra_monster_update_outside_suffix_is_rejected(self):
        events = self.pause_fixture() + [Event("monmove", 1040, 5, "2")]
        with self.assertRaisesRegex(ValueError, "outside a selected turn suffix"):
            self.pause_summary(events)

    def test_pre_simulation_frame_cannot_complete_pause_sequence(self):
        events = [e for e in self.pause_fixture() if e.start < 1130]
        with self.assertRaisesRegex(ValueError, "incomplete capture"):
            self.pause_summary(events)


if __name__ == "__main__":
    unittest.main()
