#!/usr/bin/env python3
"""Run production stack code with small deterministic stand-ins, not a game."""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class RegressionTest(unittest.TestCase):
    def test_production_behavior(self):
        source = Path(os.environ.get(
            "CCB_ITEM_SOURCE", ROOT / "src/item.cpp")).read_text()
        start = source.index("stacking_info item::stacks_with(")
        # Execute the production identity preconditions; all other fields
        # are identical in this fixture, so the remaining comparison is true.
        start = source.index("{", start) + 1
        end = source.index("    if( count_by_charges()", start)
        body = source[start:end]
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
struct item {
    int owner=0, old_owner=0;
    bool stacks_with(const item &rhs) const {
        // PRODUCTION
        return true;
    }
};
int main() {
    item a, b;
    assert(a.stacks_with(b));
    a.owner=1; assert(!a.stacks_with(b) && !b.stacks_with(a));
    b.owner=2; assert(!a.stacks_with(b));
    b.owner=1; assert(a.stacks_with(b));
    b.old_owner=2; assert(!a.stacks_with(b));
    a.old_owner=2; assert(a.stacks_with(b));
}
'''

if __name__ == "__main__":
    unittest.main()
