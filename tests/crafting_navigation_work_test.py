#!/usr/bin/env python3
"""Execute production display preparation/cache code with counted inventory.

The fixture substitutes game data and ImGui, not the production algorithm.
This bounds work per redraw; it does not measure real save/device latency.
"""
from pathlib import Path
import os
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


def block(source, marker):
    start = source.index(marker)
    opening = source.index('{', start)
    depth = 1
    end = opening + 1
    while depth:
        depth += (source[end] == '{') - (source[end] == '}')
        end += 1
    return source[start:end]


class CraftingWorkTest(unittest.TestCase):
    def test_inventory_work_is_linear_and_not_repeated_on_redraw(self):
        helpers = (ROOT / 'src/crafting_gui_helpers.cpp').read_text()
        gui = Path(os.environ.get(
            'CCB_CRAFTING_GUI_SOURCE', ROOT / 'src/crafting_gui.cpp'
        )).read_text()
        header = (ROOT / 'src/crafting_gui_helpers.h').read_text()
        structure = block(header, 'struct crafting_component_display') + ';'
        builder = block(helpers, 'crafting_component_groups '
                        'build_component_display(')
        draw = block(gui, 'void crafting_ui_impl::draw_components(')
        draw = draw[:draw.index('    const auto component_text')] + '}\n'
        timer = block(gui, 'int64_t expected_time(')
        fixture = (FIXTURE.replace('// STRUCTURE', structure)
                   .replace('// BUILDER', builder)
                   .replace('// DRAW', draw)
                   .replace('// TIMER', timer))
        with tempfile.TemporaryDirectory() as directory:
            cpp = Path(directory) / 'probe.cpp'
            binary = Path(directory) / 'probe'
            cpp.write_text(fixture)
            result = subprocess.run([
                os.environ.get('CXX', 'c++'), '-std=c++17', str(cpp),
                '-o', str(binary)], capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            result = subprocess.run(
                [str(binary)], capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            print(result.stdout.strip())


FIXTURE = r'''
#include <algorithm>
#include <cassert>
#include <climits>
#include <cstdint>
#include <iostream>
#include <map>
#include <utility>
#include <vector>
using nc_color = int;
constexpr int c_red = 1;
int quantity_queries = 0, requirement_queries = 0, time_queries = 0;
struct recipe;
struct Character {
    int64_t expected_time_to_craft(const recipe &, int batch) const {
        ++time_queries;
        return 100 * batch;
    }
};
struct inventory {
    int charges_of(int type, int, int) const {
        ++quantity_queries;
        return type % 3;
    }
    int amount_of(int type, bool, int, int) const {
        ++quantity_queries;
        return type % 3;
    }
};
struct item {
    static bool count_by_charges(int type) { return type % 2; }
};
struct item_comp {
    int type;
    bool has(const Character *, const inventory &, int, int batch) const {
        return type % 3 >= batch;
    }
    int get_color(const Character *, bool, const inventory &, int,
                  int batch) const { return 10 + type % 3 + batch; }
};
struct requirement_data {
    std::vector<std::vector<item_comp>> components;
    void can_make_with_inventory(const Character *, const inventory &,
                                  int, int) const { ++requirement_queries; }
    const auto &get_components() const { return components; }
};
struct recipe {
    requirement_data req;
    const auto &simple_requirements() const { return req; }
    int get_component_filter() const { return 0; }
};
// STRUCTURE
using crafting_component_groups =
    std::vector<std::vector<crafting_component_display>>;
// BUILDER
struct crafting_ui_impl {
    Character *crafter;
    std::map<std::pair<const recipe *, int>, crafting_component_groups>
        component_cache;
    std::map<std::pair<const recipe *, int>, int64_t> expected_time_cache;
    // TIMER
    void draw_components(const recipe &, const inventory &, int, bool);
};
// DRAW
int main() {
    Character actor;
    inventory inv;
    recipe rec;
    rec.req.components.emplace_back();
    for (int i = 0; i < 300; ++i) {
        rec.req.components.front().push_back({i});
    }
    crafting_ui_impl ui{&actor, {}, {}};
    for (int frame = 0; frame < 100; ++frame) {
        ui.draw_components(rec, inv, 1, false);
        assert(ui.expected_time(rec, 1) == 100);
    }
    assert(quantity_queries == 300);
    assert(requirement_queries == 1);
    assert(time_queries == 1);
    const auto &group = ui.component_cache.at({&rec, 1}).front();
    int previous_rank = -1;
    int previous_type = -1;
    for (const auto &entry : group) {
        assert(entry.rank >= previous_rank);
        if (entry.rank == previous_rank) {
            assert(entry.component->type > previous_type);
        }
        previous_rank = entry.rank;
        previous_type = entry.component->type;
    }
    ui.draw_components(rec, inv, 2, false);
    assert(ui.expected_time(rec, 2) == 200);
    assert(quantity_queries == 600 && requirement_queries == 2);
    assert(time_queries == 2);
    // Returning to a previous selection reuses its prepared values.
    ui.draw_components(rec, inv, 1, false);
    assert(quantity_queries == 600);
    std::cout << "300 alternatives, 100 redraws: 300 count queries, "
                 "1 requirement check, 1 time calculation\n";
}
'''

if __name__ == '__main__':
    unittest.main()
