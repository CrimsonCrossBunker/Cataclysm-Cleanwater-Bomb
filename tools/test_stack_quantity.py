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
            "CCB_AIM_LISTITEM_SOURCE",
            ROOT / "src/advanced_inv_listitem.cpp")).read_text()
        body = "\n".join(line for line in source.splitlines()
                         if not line.startswith("#include"))
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
#include <string>
#include <vector>
#define cata_assert assert
using itype_id=int;
namespace tname { const int tname_sort_key=0; }
struct item_category {} category;
enum aim_location { AIM_CENTER };
struct item {
    int charges=1; bool counted=false, resource=false;
    int typeId() const { return 1; }
    std::string tname(int, int=0) const { return "item"; }
    struct aggregate { unsigned count=0; };
    aggregate aggregated_contents() const { return {}; }
    bool is_stackable() const { return resource; }
    bool count_by_charges() const { return counted; }
    int count() const { return counted ? charges : 1; }
    int volume() const { return count()*2; }
    int weight() const { return count()*3; }
    const item_category &get_category_of_contents() const { return category; }
};
struct item_location {
    item *ptr;
    item *operator->() const { return ptr; }
    item &operator*() const { return *ptr; }
};
struct Auto { bool has_rule(item *) const { return false; } } ap;
Auto &get_auto_pickup() { return ap; }
struct advanced_inv_listitem {
    int idx; aim_location area; itype_id id;
    std::vector<item_location> items;
    std::string name, name_without_prefix;
    unsigned contents_count; bool autopickup;
    int stacks, amount, volume, weight;
    const item_category *cat; bool from_vehicle;
    advanced_inv_listitem(const item_location &, int, int, aim_location, bool);
    advanced_inv_listitem(const std::vector<item_location> &, int,
                          aim_location, bool);
};
// PRODUCTION
int main() {
    for(bool resource : {false,true}) {
        item ammo; ammo.charges=5000; ammo.counted=true;
        ammo.resource=resource; item_location loc{&ammo};
        advanced_inv_listitem one(loc,0,1,AIM_CENTER,false);
        advanced_inv_listitem vec(std::vector<item_location>{loc},0,
                                  AIM_CENTER,false);
        assert(one.amount==5000 && vec.amount==5000);
        assert(one.stacks==1 && one.weight==15000 && one.volume==10000);
    }
    item gun; gun.charges=30; item_location loc{&gun};
    advanced_inv_listitem guns(std::vector<item_location>{loc,loc},0,
                               AIM_CENTER,false);
    assert(guns.amount==2 && guns.stacks==2);
}
'''

if __name__ == "__main__":
    unittest.main()
