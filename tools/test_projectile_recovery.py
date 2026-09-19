#!/usr/bin/env python3
"""Exercise the production recovery block; full ballistic coverage is in Catch2."""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest
from test_android_joystick_repeat import braced_block

ROOT = Path(__file__).resolve().parents[1]

class ProjectileRecoveryTest(unittest.TestCase):
    def test_recovered_round_keeps_metadata(self):
        source = Path(os.environ.get('CCB_RANGED_SOURCE', ROOT / 'src/ranged.cpp')).read_text()
        block = braced_block(source, source.index('if( recover && !fx.count( ammo_effect_IGNITE )'))
        with tempfile.TemporaryDirectory() as temp:
            cpp = Path(temp) / 'probe.cpp'
            binary = Path(temp) / 'probe'
            cpp.write_text(FIXTURE.replace('// PRODUCTION', block))
            result = subprocess.run([os.environ.get('CXX', 'c++'), '-std=c++17', str(cpp), '-o', str(binary)], capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            result = subprocess.run([str(binary)], capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)

FIXTURE = r'''
#include <cassert>
#include <set>
#include <string>
namespace calendar { int turn=0; }
enum { ammo_effect_IGNITE, ammo_effect_EXPLOSIVE, ammo_effect_ACT_ON_RANGED_HIT };
struct item {
    std::string type, label;
    int charges=1, damage=0;
    bool is_favorite=false, active=false;
    item() = default;
    item(std::string t, int, int c) : type(t), charges(c) {}
    void set_favorite(bool f) { is_favorite=f; }
};
struct Gun {
    item round, battery;
    const item &loaded_ammo() const { return round; }
    const item &first_ammo() const { return battery; }
    const Gun &get_contents() const { return *this; }
    std::string ammo_current() const { return round.type; }
} gun;
struct Projectile {
    item drop;
    bool exists=false;
    void set_drop(const item &it) { exists=true; drop=it; }
} proj;
bool recover=true;
std::set<int> fx;
void make_drop() {
    // PRODUCTION
}
int main() {
    gun.round=item("arrow", 0, 15); gun.round.label="marked";
    gun.round.damage=1000; gun.round.is_favorite=true;
    gun.battery=item("battery", 0, 100);
    make_drop();
    assert(proj.exists && proj.drop.type=="arrow" && proj.drop.charges==1);
    assert(proj.drop.label=="marked" && proj.drop.damage==1000 && proj.drop.is_favorite);
    assert(gun.round.charges==15 && !proj.drop.active);
    fx={ammo_effect_ACT_ON_RANGED_HIT}; make_drop(); assert(proj.drop.active);
    for(int excluded : {ammo_effect_IGNITE, ammo_effect_EXPLOSIVE}) {
        proj={}; fx={excluded}; make_drop(); assert(!proj.exists);
    }
    proj={}; fx.clear(); recover=false; make_drop(); assert(!proj.exists);
}
'''
if __name__ == '__main__':
    unittest.main()
