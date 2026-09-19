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
            "CCB_POCKET_SOURCE", ROOT / "src/item_pocket.cpp")).read_text()
        body = braced_block(
            source, source.index("void item_pocket::restack()"))
        body += braced_block(
            source, source.index("item *item_pocket::restack("))
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
#include <iterator>
#include <list>
enum class pocket_type { MAGAZINE };
struct item {
    int kind, charges;
    bool counted=true;
    bool count_by_charges() const { return counted; }
    bool combine(const item &rhs) {
        if(!counted || !rhs.counted || kind != rhs.kind) return false;
        charges+=rhs.charges; return true;
    }
};
struct item_pocket {
    std::list<item> contents;
    bool is_type(pocket_type) const { return true; }
    void restack();
    item *restack(item *it);
};
// PRODUCTION
int main() {
    for(bool tracked : {false, true}) {
        item_pocket pocket;
        pocket.contents={{1,1}, {1,2}, {1,3}, {2,4}, {1,5}};
        item *ret=&*std::next(pocket.contents.begin(),2);
        if(tracked) ret=pocket.restack(ret); else pocket.restack();
        assert(pocket.contents.size()==3);
        assert(pocket.contents.front().charges==6);
        assert(std::next(pocket.contents.begin())->kind==2);
        assert(pocket.contents.back().charges==5);
        if(tracked) assert(ret==&pocket.contents.front());
        // Unsupported legacy contents must not leave the iterator stuck.
        pocket.contents={{0,1,false}, {1,2}, {1,3}};
        if(tracked) pocket.restack(&pocket.contents.back());
        else pocket.restack();
        assert(pocket.contents.size()==2 && pocket.contents.back().charges==5);
    }
}
'''

if __name__ == "__main__":
    unittest.main()
