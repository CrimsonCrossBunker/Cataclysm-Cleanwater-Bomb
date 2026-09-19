#!/usr/bin/env python3
"""Exercise production crafting label setup with an input/shortcut fixture.

This is a focused C++ snippet test, not an Android device or full-game test.
CCB_CRAFTING_SOURCE can point at the pre-fix source for a negative control.
"""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class CraftingShortcutContextTest(unittest.TestCase):
    def test_refresh_preserves_crafting_shortcuts_and_cancel_binding(self):
        source = Path(os.environ.get(
            "CCB_CRAFTING_SOURCE", ROOT / "src/crafting_gui.cpp")).read_text()
        start = source.index("        static_popup popup;", source.index(
            "void crafting_ui_impl::recalculate_recipes()"))
        end = source.index("        std::function<void", start)
        setup = source[start:end]
        with tempfile.TemporaryDirectory() as directory:
            cpp = Path(directory) / "probe.cpp"
            binary = Path(directory) / "probe"
            cpp.write_text(FIXTURE.replace("// PRODUCTION_SETUP", setup))
            subprocess.run([
                os.environ.get("CXX", "c++"), "-std=c++17", str(cpp),
                "-o", str(binary)], check=True, capture_output=True)
            result = subprocess.run(
                [str(binary)], capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)


FIXTURE = r'''
#include <chrono>
#include <iostream>
#include <map>
#include <string>
#include <vector>

struct input_context {
    static std::vector<input_context *> stack;
    std::string category;
    explicit input_context(std::string name = "default") : category(name) {
        stack.push_back(this);
    }
    ~input_context() { stack.pop_back(); }
    void register_action(const std::string &) {}
    std::string get_button_text(const std::string &,
                                const std::string &) const {
        return category == "CRAFTING" ? "custom crafting cancel" : "Esc";
    }
};
std::vector<input_context *> input_context::stack;
struct static_popup {};
const char *_(const char *text) { return text; }

int main() {
    // The Android cache outlives character creation.  The generic category
    // already contains its keys when the first slow recipe refresh polls.
    std::map<std::string, std::string> shortcuts = {
        {"default", "name gender age height"},
        {"CRAFTING", "filter craft next category"}
    };
    input_context crafting("CRAFTING");
    const input_context *ctxt_ptr = &crafting;
    for (int refresh = 0; refresh != 2; ++refresh) {
        // PRODUCTION_SETUP
        const auto *active = input_context::stack.back();
        if (shortcuts.at(active->category) != "filter craft next category") {
            std::cerr << "recipe refresh activated character creation keys\n";
            return 1;
        }
        if (cancel_btn != "custom crafting cancel") {
            std::cerr << "recipe refresh ignored crafting cancel binding\n";
            return 2;
        }
    }
    if (input_context::stack.back() != &crafting) {
        return 3;
    }
}
'''

if __name__ == "__main__":
    unittest.main()
