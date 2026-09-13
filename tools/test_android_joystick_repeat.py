#!/usr/bin/env python3
"""Compile the production Android hold-repeat block in a small event fixture.

This checks scheduling and input ownership without an Android device. The SDL
queue and normal dispatcher are simulated; this is not a full SDL/game test.
Set CCB_SDLTILES_SOURCE to compare against an older src/sdltiles.cpp.
"""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
SOURCE = Path(os.environ.get("CCB_SDLTILES_SOURCE", ROOT / "src/sdltiles.cpp"))


def braced_block(source, start):
    opening = source.index("{", start)
    depth = 1
    end = opening + 1
    while depth:
        depth += (source[end] == "{") - (source[end] == "}")
        end += 1
    return source[start:end]


class JoystickRepeatTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        source = SOURCE.read_text()
        function = braced_block(
            source, source.index("static void CheckMessages()"))
        start = function.index("// Handle repeating inputs from touch + holds")
        block = braced_block(function, function.index("if(", start))
        # Preserve production ordering relative to the normal SDL dispatcher.
        dispatcher = function.index(
            "while( SDL_PollEvent( &ev ) )",
            function.index("using cata::options::mouse"))
        body = ("dispatch();\n" + block if start > dispatcher
                else "if(!needupdate) {" + block + "}\ndispatch();")
        cls.temp = tempfile.TemporaryDirectory()
        root = Path(cls.temp.name)
        cpp = root / "probe.cpp"
        cpp.write_text(FIXTURE.replace("// PRODUCTION_REPEAT", body))
        cls.binary = root / "probe"
        subprocess.run(
            [os.environ.get("CXX", "c++"), "-std=c++17", "-Wall", "-Wextra",
             str(cpp), "-o", str(cls.binary)], check=True, capture_output=True)

    @classmethod
    def tearDownClass(cls):
        cls.temp.cleanup()

    def check_case(self, case):
        result = subprocess.run(
            [str(self.binary), case], capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)

    def test_turn_left(self):
        self.check_case("left")

    def test_turn_right(self):
        self.check_case("right")

    def test_latest_motion_wins(self):
        self.check_case("burst")

    def test_release_stops_without_extra_step(self):
        self.check_case("release")

    def test_keyboard_not_discarded_or_overwritten(self):
        self.check_case("keyboard")

    def test_quit_not_discarded(self):
        self.check_case("quit")

    def test_second_finger_suppresses_single_finger_repeat(self):
        self.check_case("second")

    def test_repeat_interval_respected(self):
        self.check_case("early")

    def test_motion_redraw_does_not_starve_repeat(self):
        self.check_case("continuous")

    def test_pending_redraw_still_defers_repeat(self):
        self.check_case("redraw")


FIXTURE = r'''#include <algorithm>
#include <cassert>
#include <cmath>
#include <cstdint>
#include <deque>
#include <string>
struct Event { int type; float x = 0; float y = 0; } ev;
enum { motion, CATA_FINGERUP, key, close_window, second_down };
std::deque<Event> events;
bool SDL_PollEvent(Event *out) {
    if(events.empty()) return false;
    *out = events.front(); events.pop_front(); return true;
}
int GetFingerID(Event) { return 0; }
void finger_slot_clear(int) {}
enum class input_event_t { error, keyboard_char };
struct {
    input_event_t type = input_event_t::error;
    int direction = 0;
} last_input;
struct { bool captures_touch = false; } android_imgui_touch_state;
namespace android_ui_mode { bool is_new_ui_build() { return true; } }
bool is_quick_shortcut_touch = false, is_two_finger_touch = false;
bool is_three_finger_touch = false, is_default_mode = true;
bool needupdate = false, quit = false;
float finger_down_x = 0, finger_down_y = 0;
float finger_curr_x = 0, finger_curr_y = 100;
float second_finger_down_x, second_finger_curr_x;
float third_finger_down_x, third_finger_curr_x;
float second_finger_down_y, second_finger_curr_y;
float third_finger_down_y, third_finger_curr_y;
uint32_t ticks = 1000, finger_down_time = 1;
uint32_t finger_repeat_time = 800, finger_repeat_delay = 100;
int WindowWidth = 1000, WindowHeight = 500, repeats = 0;
template<class T> T get_option(const char *name) {
    const std::string s(name);
    if(s == "ANDROID_INITIAL_DELAY") return T(250);
    if(s == "ANDROID_DEADZONE_RANGE") return T(0.04);
    return T(false);
}
void handle_finger_input(uint32_t) {
    ++repeats;
    last_input.type = input_event_t::keyboard_char;
    last_input.direction = finger_curr_x < 0 ? -1 : finger_curr_x > 0 ? 1 : 2;
}
void dispatch() {
    while(SDL_PollEvent(&ev)) {
        if(ev.type == motion) {
            finger_curr_x = ev.x; finger_curr_y = ev.y; needupdate = true;
        }
        if(ev.type == CATA_FINGERUP) {
            finger_down_time = 0; finger_repeat_time = 0;
        }
        if(ev.type == key) {
            last_input.type = input_event_t::keyboard_char;
            last_input.direction = 9;
        }
        if(ev.type == close_window) quit = true;
        if(ev.type == second_down) is_two_finger_touch = true;
    }
}
void pump() {
    [[maybe_unused]] const bool allow_touch_repeat = !needupdate;
    // PRODUCTION_REPEAT
}
int main(int argc, char **argv) {
    assert(argc == 2);
    const std::string scenario(argv[1]);
    if(scenario == "left") events.push_back({motion, -100, 0});
    if(scenario == "right") events.push_back({motion, 100, 0});
    if(scenario == "burst") {
        events.push_back({motion, -100, 0});
        events.push_back({motion, 100, 0});
    }
    if(scenario == "release") events.push_back({CATA_FINGERUP});
    if(scenario == "keyboard") events.push_back({key});
    if(scenario == "quit") events.push_back({close_window});
    if(scenario == "second") events.push_back({second_down});
    if(scenario == "early") ticks = 850;
    if(scenario == "redraw") needupdate = true;
    if(scenario == "continuous") {
        for(int i = 0; i < 20; ++i) {
            int direction = i % 2 ? 1 : -1;
            events.push_back({motion, float(direction * 100), 0});
            last_input.type = input_event_t::error;
            needupdate = false;
            ticks += 101;
            pump();
            assert(last_input.direction == direction);
        }
        assert(repeats == 20);
        return 0;
    }
    pump();
    if(scenario == "left") assert(last_input.direction == -1 && repeats == 1);
    if(scenario == "right" || scenario == "burst") {
        assert(last_input.direction == 1 && repeats == 1);
    }
    if(scenario == "release") assert(finger_down_time == 0 && repeats == 0);
    if(scenario == "keyboard") {
        assert(last_input.direction == 9 && repeats == 0);
    }
    if(scenario == "quit") assert(quit && repeats == 0);
    if(scenario == "second") assert(is_two_finger_touch && repeats == 0);
    if(scenario == "early" || scenario == "redraw") assert(repeats == 0);
    assert(events.empty());
}
'''

if __name__ == "__main__":
    unittest.main()
