#!/usr/bin/env python3
"""Execute production tap/automove code with deterministic input fixtures.

This does not emulate SDL, the full game, or an Android device.
"""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

from test_android_joystick_repeat import braced_block

ROOT = Path(__file__).resolve().parents[1]


class ActivityInterruptTest(unittest.TestCase):
    def test_taps_and_route_cancellation(self):
        source = Path(os.environ.get("CCB_SDLTILES_SOURCE", ROOT / "src/sdltiles.cpp")).read_text()
        tap = braced_block(source, source.index("void handle_finger_input( uint32_t ticks )"))
        source = Path(os.environ.get("CCB_HANDLE_ACTION_SOURCE", ROOT / "src/handle_action.cpp")).read_text()
        route = braced_block(source, source.index("if( player_character.has_destination() )", source.index("bool game::handle_action(")))
        code = FIXTURE.replace("// TAP", tap).replace("// ROUTE", route)
        with tempfile.TemporaryDirectory() as temp:
            cpp = Path(temp) / "probe.cpp"
            binary = Path(temp) / "probe"
            cpp.write_text(code)
            result = subprocess.run([os.environ.get("CXX", "c++"), "-std=c++17", str(cpp), "-o", str(binary)], capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            result = subprocess.run([str(binary)], capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)


FIXTURE = r'''
#include <algorithm>
#include <cassert>
#include <cmath>
#include <cstdint>
#include <string>
enum class input_event_t { error, keyboard_char, gamepad };
struct input_event {
    int key = 0;
    input_event_t type = input_event_t::error;
    input_event() = default;
    input_event(int k, input_event_t t) : key(k), type(t) {}
} last_input;
enum { KEY_RIGHT=300, KEY_DOWN, KEY_LEFT, KEY_UP, KEY_ESCAPE,
       JOY_LS_UP_RIGHT, JOY_LS_DOWN_RIGHT, JOY_LS_UP_LEFT, JOY_LS_DOWN_LEFT };
struct Context {
    std::string category = "DEFAULTMODE";
    bool is_action_registered(const char *) { return false; }
    std::string get_category() { return category; }
} touch_input_context;
struct Client { void process_cata_input(input_event) {} } client, *imclient = &client;
bool active_world = true;
bool android_has_active_world() { return active_world; }
struct Avatar {
    bool activity = false;
    int steps = 0, consumed = 0;
    bool has_destination() { return steps > 0; }
    int get_next_auto_move_direction() { ++consumed; --steps; return 1; }
    void abort_automove() { steps = 0; }
} avatar;
Avatar &get_avatar() { return avatar; }
int pause_key = 'p';
int choose_best_key_for_action(const std::string &a, const std::string &c) {
    assert(a == "pause" && c == "DEFAULTMODE"); return pause_key;
}
template<class T> T get_option(const char *name) {
    return std::string(name) == "ANDROID_INITIAL_DELAY" ? T(250) : T(0.04f);
}
template<> std::string get_option<std::string>(const char *) { return "."; }
int get_key_event_from_string(const std::string &s) { return s[0]; }
float finger_curr_x=0, finger_down_x=0, finger_curr_y=0, finger_down_y=0;
int WindowWidth=1000, WindowHeight=500;
uint32_t finger_down_time=1000, last_tap_time=0;
// TAP
int polls=0;
bool cancel=false;
void handle_key_blocking_activity() { ++polls; if(cancel) avatar.abort_automove(); }
const int ACTION_NULL=0, m_info=0;
const char *_(const char *s) { return s; }
void add_msg(int, const char *) {}
bool route_step() {
    Avatar &player_character=avatar;
    int act=ACTION_NULL;
    // ROUTE
    return act != ACTION_NULL;
}
int main() {
    // A short busy tap is immediate, including repeated attempts and rebound pause.
    for(bool route : {false, true}) {
        avatar.activity = !route; avatar.steps = route ? 3 : 0;
        for(uint32_t previous : {0u, 1050u}) {
            last_tap_time=previous; last_input={};
            handle_finger_input(1100);
            assert(last_input.key == 'p' && last_tap_time == 0);
        }
    }
    // Normal idle tap and menu double-tap retain their existing meanings.
    avatar.steps=0; avatar.activity=false; last_tap_time=0; last_input={};
    handle_finger_input(1100);
    assert(last_input.type == input_event_t::error && last_tap_time == 1100);
    touch_input_context.category="MENU"; avatar.activity=true; last_input={};
    handle_finger_input(1150); assert(last_input.key == KEY_ESCAPE);
    // Movement gestures still steer rather than becoming cancellation.
    touch_input_context.category="DEFAULTMODE"; finger_curr_x=100;
    handle_finger_input(1150); assert(last_input.key == KEY_RIGHT);
    // Cancellation never consumes or executes a route step, including the last.
    for(int remaining : {1, 3}) {
        avatar.steps=remaining; avatar.consumed=0; cancel=true; polls=0;
        assert(!route_step()); assert(avatar.consumed == 0 && polls == 1);
        avatar.steps=remaining; cancel=false; polls=0;
        assert(route_step()); assert(avatar.steps == remaining-1 && polls == 1);
    }
}
'''

if __name__ == "__main__":
    unittest.main()
