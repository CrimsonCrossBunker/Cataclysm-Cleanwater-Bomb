"""Regression checks for the CMake-owned version header."""

from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


class BuildVersionTest(unittest.TestCase):
    def test_unchanged_version_preserves_generated_header_timestamp(self):
        cmake = shutil.which("cmake")
        true = shutil.which("true")
        if cmake is None or true is None:
            self.skipTest("CMake and a successful command stub are required")
        with tempfile.TemporaryDirectory() as name:
            root = Path(name)
            (root / "src").mkdir()
            (root / "CMakeModules").mkdir()
            script = root / "src/version.cmake"
            shutil.copyfile(ROOT / "src/version.cmake", script)
            # Keep Git's description constant; exercise the real header owner.
            (root / "CMakeModules/GetGitRevisionDescription.cmake").write_text(
                "function(git_describe result)\n"
                "  set(${result} test-version PARENT_SCOPE)\n"
                "endfunction()\n",
                encoding="utf-8",
            )
            command = [cmake, f"-DGIT_EXECUTABLE={true}", "-P", str(script)]
            subprocess.run(command, cwd=root, check=True, capture_output=True)
            header = root / "src/version.h"
            contents = header.read_text(encoding="utf-8")
            self.assertIn('test-version"', contents)
            old_time = 946684800000000000
            os.utime(header, ns=(old_time, old_time))
            subprocess.run(command, cwd=root, check=True, capture_output=True)
            self.assertEqual(header.read_text(encoding="utf-8"), contents)
            self.assertEqual(header.stat().st_mtime_ns, old_time)


if __name__ == "__main__":
    unittest.main()
