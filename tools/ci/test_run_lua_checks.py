"""Keep CI selection from silently dropping an affected check."""

from __future__ import annotations

import json
import subprocess
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

try:
    from .run_lua_checks import (
        affected_tool_tests, changed_paths, run_checks, select_checks,
    )
except ImportError:
    from run_lua_checks import (
        affected_tool_tests, changed_paths, run_checks, select_checks,
    )


class LuaCISelectionTest(unittest.TestCase):
    def test_binding_change_checks_contract_without_tool_or_editor_suite(self):
        plan = select_checks(["src/lua_platform_items.cpp"])
        self.assertEqual(len(plan["checks"]), 4)
        self.assertEqual(plan["tests"], [])
        self.assertFalse(plan["editor"])

    def test_declarations_also_run_real_editor_diagnostics(self):
        plan = select_checks(["data/lua/types/ccb_platform_v1.d.lua"])
        self.assertIn("tools.lua_api.test_mod_sdk."
                      "LuaLanguageServerIntegrationTest", plan["tests"])
        self.assertTrue(plan["editor"])

    def test_docs_and_unrelated_native_tests_have_no_lua_checks(self):
        self.assertEqual(select_checks([
            "data/lua/LUA_FIRST_EOC_WORKFLOW.md",
            "tests/vehicle_hover_test.cpp",
        ]), {"checks": [], "tests": [], "editor": False})

    def test_state_inspector_does_not_pull_in_editor_or_contract_checks(self):
        plan = select_checks(["tools/lua_api/inspect_state.py"])
        self.assertEqual(plan["tests"], ["tools.lua_api.test_inspect_state"])
        self.assertEqual(plan["checks"], [])
        self.assertFalse(plan["editor"])

    def test_generator_change_runs_dependent_checker_regressions(self):
        tests = affected_tool_tests({"generate_platform_native_inventory"})
        self.assertIn("test_generate_platform_native_inventory", tests)
        self.assertIn("test_check_platform_native_inventory", tests)
        self.assertNotIn("test_inspect_state", tests)

    def test_test_fixture_change_runs_its_dependent_tests(self):
        tests = affected_tool_tests({"test_generate_platform_contract"})
        self.assertIn("test_generate_platform_coverage", tests)

    def test_removed_tool_and_unknown_history_fall_back_to_tests(self):
        tests = affected_tool_tests({"removed_tool"})
        self.assertIn("test_check_platform_contract", tests)
        self.assertTrue(select_checks(None)["editor"])
        plan = select_checks(["tools/lua_api/removed_tool.py"])
        self.assertTrue(plan["editor"])

    def test_build_selection_checks_real_make_and_cmake_sources(self):
        plan = select_checks(["tests/test_support_sources.txt"])
        self.assertIn("tools.lua_api.test_check_cmake_contract", plan["tests"])
        self.assertEqual(plan["checks"], [])
        self.assertFalse(plan["editor"])

    def test_scaffold_change_runs_sdk_and_scaffold_checks(self):
        plan = select_checks(["tools/create_lua_mod.py"])
        self.assertIn("tools.test_create_lua_mod", plan["tests"])
        self.assertTrue(plan["editor"])

    def test_selected_editor_checks_cannot_silently_skip_without_luals(self):
        with patch.dict("os.environ", {}, clear=True):
            with self.assertRaisesRegex(RuntimeError, "require CCB_LUALS"):
                run_checks({"checks": [], "tests": [], "editor": True})


class LuaCIChangeHistoryTest(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        self.git("init", "-q", "--initial-branch=master")
        self.git("config", "user.name", "CI selection test")
        self.git("config", "user.email", "ci-test@example.invalid")
        self.commit("README.md")

    def git(self, *args):
        return subprocess.check_output(
            ["git", *args], cwd=self.root, text=True,
            stderr=subprocess.PIPE).strip()

    def commit(self, name):
        path = self.root / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(name)
        self.git("add", name)
        self.git("commit", "-qm", "test change")
        return self.git("rev-parse", "HEAD")

    def changes(self, event_name, event=None):
        event_file = self.root / "event.json"
        event_file.write_text(json.dumps(event or {}))
        environment = {"GITHUB_EVENT_NAME": event_name,
                       "GITHUB_EVENT_PATH": str(event_file)}
        with patch.dict("os.environ", environment):
            with patch(changed_paths.__module__ + ".ROOT", self.root):
                return changed_paths()

    def test_push_accounts_for_all_commits_instead_of_only_the_last(self):
        before = self.git("rev-parse", "HEAD")
        self.commit("src/lua_platform_items.cpp")
        self.commit("doc/change.md")
        self.assertEqual(set(self.changes("push", {"before": before})),
                         {"src/lua_platform_items.cpp", "doc/change.md"})

    def test_pr_diff_excludes_changes_already_in_its_merge_base(self):
        self.git("checkout", "-qb", "feature")
        self.commit("src/lua_platform_items.cpp")
        self.git("checkout", "-q", "master")
        self.commit("unrelated.cpp")
        self.git("merge", "-q", "--no-ff", "feature", "-m", "test merge")
        self.assertEqual(self.changes("pull_request"),
                         ["src/lua_platform_items.cpp"])

    def test_missing_history_and_new_branch_use_full_checks(self):
        self.assertIsNone(self.changes("pull_request"))
        self.assertIsNone(self.changes("push", {"before": "0" * 40}))
        self.assertIsNone(self.changes("push", {"before": "--malicious-ref"}))


if __name__ == "__main__":
    unittest.main()
