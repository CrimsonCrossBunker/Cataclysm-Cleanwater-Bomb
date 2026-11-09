"""Check diagnostics from failed include-database preprocessing."""

import shlex
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
MAKE = shutil.which("make")
RECIPES = (
    ("Makefile", "$(ODIR)/%.inc: $(SRC_DIR)/%.cpp"),
    ("Makefile", "$(ODIR)/%.inc: $(SRC_DIR)/%.cc"),
    ("Makefile", "$(ODIR)/%.inc: $(SRC_DIR)/%.c"),
    ("tests/Makefile", "$(ODIR)/%.inc: %.cpp"),
)
INCLUDE_TRACE = ". test/header.h\n.. test/nested-header.h\n"
DIAGNOSTIC = "source.cpp:1:10: fatal error: missing-test-header.h\n"


@unittest.skipUnless(MAKE, "GNU Make is required")
class MakeIncludeDiagnosticsTest(unittest.TestCase):
    def run_recipe(self, filename, rule, compiler_status):
        lines = (ROOT / filename).read_text(encoding="utf-8").splitlines()
        recipe = lines[lines.index(rule) + 1]
        diagnostic = DIAGNOSTIC if compiler_status else ""
        compiler_output = INCLUDE_TRACE + diagnostic
        with tempfile.TemporaryDirectory() as directory:
            fixture = Path(directory)
            (fixture / "source.cpp").write_text("", encoding="utf-8")
            (fixture / "compiler.py").write_text(
                "import sys\n"
                f"sys.stderr.write({compiler_output!r})\n"
                f"sys.exit({compiler_status})\n",
                encoding="utf-8",
            )
            executable = shlex.quote(Path(sys.executable).as_posix())
            compiler = f"{executable} compiler.py"
            (fixture / "Makefile").write_text(
                f"CXX := {compiler}\n"
                f"COMPILE.cc := {compiler}\n"
                f"COMPILE.c := {compiler}\n"
                f"include.inc: source.cpp\n{recipe}\n",
                encoding="utf-8",
            )
            result = subprocess.run(
                [MAKE, "--no-print-directory", "--silent", "include.inc"],
                cwd=fixture, capture_output=True, text=True,
            )
            includes = (fixture / "include.inc").read_text(encoding="utf-8")
            return result, includes, compiler_output

    def test_failure_reports_diagnostics_and_preserves_exit_status(self):
        for filename, rule in RECIPES:
            with self.subTest(filename=filename, rule=rule):
                result, includes, output = self.run_recipe(filename, rule, 17)
                self.assertEqual(result.returncode, 2, result.stderr)
                self.assertIn(DIAGNOSTIC, result.stderr)
                self.assertIn("Error 17", result.stderr)
                self.assertNotIn(INCLUDE_TRACE, result.stderr)
                self.assertEqual(includes, output)

    def test_success_keeps_include_trace_out_of_console(self):
        for filename, rule in RECIPES:
            with self.subTest(filename=filename, rule=rule):
                result, includes, output = self.run_recipe(filename, rule, 0)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(result.stdout, "")
                self.assertEqual(result.stderr, "")
                self.assertEqual(includes, output)


if __name__ == "__main__":
    unittest.main()
