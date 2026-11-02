"""Execute the production solid-fuel overview callback without a curses UI."""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]


class VehicleFuelOverviewTest(unittest.TestCase):
    def test_empty_and_loaded_magazine_fuel(self):
        source = Path(os.environ.get(
            "CCB_VEH_INTERACT_SOURCE", ROOT / "src/veh_interact.cpp"))
        code = source.read_text()
        start = code.index("auto no_tank_details =")
        end = code.index("\n            };", start) + len("\n            };")
        code = FIXTURE.replace("// CALLBACK", code[start:end])
        with tempfile.TemporaryDirectory() as temp:
            cpp = Path(temp) / "probe.cpp"
            binary = Path(temp) / "probe"
            cpp.write_text(code)
            result = subprocess.run([
                os.environ.get("CXX", "c++"), "-std=c++17", str(cpp),
                "-o", str(binary)], capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            result = subprocess.run([str(binary)], capture_output=True,
                                    text=True)
            self.assertEqual(result.returncode, 0, result.stderr)


FIXTURE = r'''
#include <cassert>
#include <cmath>
#include <string>
namespace catacurses { struct window {}; }
struct itype {
    int color = 1;
};
struct itype_id {
    bool empty = false;
    bool is_null() const { return empty; }
};
struct item {
    double liters = 0;
    double volume() const { return liters; }
    static const itype *find_type(itype_id) {
        static const itype type;
        return &type;
    }
    static std::string nname(itype_id) { return "charcoal"; }
};
int ammo_reads = 0;
struct base_item {
    item ammo;
    const item &first_ammo() const { ++ammo_reads; return ammo; }
    const item &legacy_front() const {
        assert(false && "solid fuel has no CONTAINER pocket");
        return ammo;
    }
};
struct vehicle_part {
    base_item base;
    int charges = 0;
    bool leaking = false;
    // The real fuel store returns a default type even while empty.
    itype_id ammo_current() const { return {}; }
    int ammo_remaining() const { return charges; }
    bool is_leaking() const { return leaking; }
};
double to_liter(double value) { return value; }
double round_up(double value, int) { return std::ceil(value * 10) / 10; }
const std::string leak_marker = "!";
template<class... T> std::string str_cat(T... parts) {
    return (std::string{} + ... + parts);
}
double displayed_volume = -1;
std::string string_format(const std::string &, const std::string &, double v) {
    displayed_volume = v;
    return "formatted";
}
int draws = 0;
void right_print(const catacurses::window &, int, int, int,
                 const std::string &) {
    ++draws;
}
// CALLBACK
int main() {
    const catacurses::window window;
    vehicle_part part;
    for(bool leaking : {false, true}) {
        part.leaking = leaking;
        part.charges = 0;
        ammo_reads = draws = 0;
        no_tank_details(part, window, 0);
        assert(ammo_reads == 0 && draws == 0);
        part.charges = 100;
        part.base.ammo.liters = 2.5;
        no_tank_details(part, window, 0);
        assert(ammo_reads == 1 && draws == 1);
        assert(displayed_volume == 2.5);
    }
}
'''


if __name__ == "__main__":
    unittest.main()
