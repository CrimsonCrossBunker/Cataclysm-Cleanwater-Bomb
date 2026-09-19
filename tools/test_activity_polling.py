#!/usr/bin/env python3
"""Run the production activity loop with a deterministic clock and fake actor."""
from pathlib import Path
import os
import subprocess
import tempfile
import unittest
from test_android_joystick_repeat import braced_block

ROOT = Path(__file__).resolve().parents[1]

class ActivityPollingTest(unittest.TestCase):
    def test_activity_steps_yield_to_input(self):
        source = Path(os.environ.get('CCB_DO_TURN_SOURCE', ROOT / 'src/do_turn.cpp')).read_text()
        marker = 'void process_avatar_activity( avatar &u )'
        if marker in source:
            body = braced_block(source, source.index(marker))
        else:
            loop = braced_block(source, source.index('while( u.get_moves() > 0 && u.activity )'))
            body = marker + ' {' + loop + '}'
        # Replace only the clock provider, not scheduling or activity logic.
        body = body.replace('std::chrono::steady_clock::now()', 'clock_now()')
        with tempfile.TemporaryDirectory() as temp:
            cpp = Path(temp) / 'probe.cpp'
            binary = Path(temp) / 'probe'
            cpp.write_text(FIXTURE.replace('// PRODUCTION', body))
            build = subprocess.run([os.environ.get('CXX', 'c++'), '-std=c++17', str(cpp), '-o', str(binary)], capture_output=True, text=True)
            self.assertEqual(build.returncode, 0, build.stderr)
            run = subprocess.run([str(binary)], capture_output=True, text=True)
            self.assertEqual(run.returncode, 0, run.stderr)

FIXTURE = r'''
#include <cassert>
#include <chrono>
int elapsed=0, calls=0, polls=0;
bool inside_actor=false, cancel=true, spend_moves=false;
std::chrono::steady_clock::time_point clock_now() {
    return std::chrono::steady_clock::time_point(std::chrono::milliseconds(elapsed));
}
struct avatar;
struct Activity {
    bool active=true;
    explicit operator bool() const { return active; }
    void do_turn(avatar &u);
};
struct avatar {
    Activity activity;
    int moves=100;
    int get_moves() const { return moves; }
} player;
void Activity::do_turn(avatar &u) {
    inside_actor=true;
    ++calls; elapsed+=25;
    assert(calls < 100); // A loop without polling would never yield.
    if(spend_moves) u.moves-=25;
    inside_actor=false;
}
void handle_key_blocking_activity(int timeout) {
    assert(timeout == 0 && !inside_actor);
    ++polls;
    if(cancel) player.activity.active=false;
}
// PRODUCTION
int main() {
    process_avatar_activity(player);
    assert(calls==4 && polls==1 && player.moves==100);
    // Declining cancellation allows completion by move exhaustion.
    player.activity.active=true; cancel=false; spend_moves=true; calls=0;
    process_avatar_activity(player);
    assert(calls==4 && player.moves==0);
    // A later turn still polls even when each actor consumes all moves.
    player.moves=25; calls=0; elapsed+=100; cancel=true;
    process_avatar_activity(player);
    assert(calls==0 && player.moves==25 && !player.activity);
}
'''
if __name__ == '__main__':
    unittest.main()
