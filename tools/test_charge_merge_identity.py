#!/usr/bin/env python3
"""Run production stack code with small deterministic stand-ins, not a game."""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest
from test_android_joystick_repeat import braced_block

ROOT = Path(__file__).resolve().parents[1]


class RegressionTest(unittest.TestCase):
    def test_production_behavior(self):
        source = Path(os.environ.get(
            "CCB_ITEM_SOURCE", ROOT / "src/item.cpp")).read_text()
        body = braced_block(source, source.index("bool item::can_combine("))
        body += braced_block(source, source.index("bool item::merge_charges("))
        with tempfile.TemporaryDirectory() as temp:
            cpp = Path(temp) / "probe.cpp"
            binary = Path(temp) / "probe"
            cpp.write_text(FIXTURE.replace("// PRODUCTION", body))
            build = subprocess.run(
                [os.environ.get("CXX", "c++"), "-std=c++17", str(cpp),
                 "-o", str(binary)], capture_output=True, text=True)
            self.assertEqual(build.returncode, 0, build.stderr)
            result = subprocess.run(
                [str(binary)], capture_output=True, text=True, timeout=3)
            self.assertEqual(result.returncode, 0, result.stderr)


FIXTURE = r'''
#include <cassert>
const int INFINITE_CHARGES=2147483647;
struct item {
    int charges=10, damage_=1001, components=1, item_counter=0;
    struct { bool empty() const { return true; } } contents;
    bool count_by_charges() const { return true; }
    bool stacks_with(const item &rhs, bool check_components=false,
                     bool=false) const {
        return damage_/1000 == rhs.damage_/1000 &&
               (!check_components || components == rhs.components);
    }
    bool can_combine(const item &) const;
    bool merge_charges(const item &);
};
// PRODUCTION
int main() {
    item a, b; b.damage_=1002;
    assert(a.stacks_with(b));
    assert(!a.can_combine(b) && !a.merge_charges(b));
    assert(a.charges==10 && b.charges==10);
    b.damage_=a.damage_; b.components=2;
    assert(!a.can_combine(b) && !a.merge_charges(b));
    b.components=1;
    assert(a.can_combine(b) && a.merge_charges(b));
    assert(a.charges==20);
}
'''

if __name__ == "__main__":
    unittest.main()
