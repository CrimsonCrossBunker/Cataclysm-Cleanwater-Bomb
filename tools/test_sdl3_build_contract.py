"""Exercise legacy flag failures and dependency-free utility targets."""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


class SDL3BuildContractTest(unittest.TestCase):
    def run_command(self, command, **kwargs):
        return subprocess.run(command, cwd=ROOT, text=True,
                              stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                              timeout=45, **kwargs)

    @unittest.skipUnless(shutil.which("cmake"), "CMake is unavailable")
    def test_cmake_rejects_removed_backend_before_toolchain_discovery(self):
        with tempfile.TemporaryDirectory(
                prefix="ccb-sdl3-cmake-") as directory:
            result = self.run_command([
                "cmake", "-S", str(ROOT), "-B", directory,
                "-DTILES=ON", "-DUSE_SDL3=OFF",
                "-DCMAKE_CXX_COMPILER=/nonexistent/ccb-cxx",
            ])
            self.assertNotEqual(result.returncode, 0, result.stdout)
            self.assertIn("USE_SDL3=OFF is no longer supported", result.stdout)
            self.assertNotIn("compiler identification", result.stdout)

    @unittest.skipUnless(shutil.which("make"), "GNU Make is unavailable")
    def test_make_rejects_removed_tiles_backend(self):
        result = self.run_command([
            "make", "-n", "TILES=1", "SDL3=0", "ASTYLE=0", "LINTJSON=0",
            "LOCALIZE=0", "TESTS=0", "CATA_ENABLE_LUA_PLATFORM=0",
        ])
        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertIn("SDL3=0 is no longer supported", result.stdout)

    @unittest.skipUnless(shutil.which("make"), "GNU Make is unavailable")
    def test_localization_ignores_inherited_sdl_dependency_flags(self):
        with tempfile.TemporaryDirectory(
                prefix="ccb-sdl3-utility-") as directory:
            marker = Path(directory) / "sdl-query"
            pkg_config = Path(directory) / "pkg-config"
            pkg_config.write_text(
                '#!/bin/sh\ncase "$*" in *sdl*|*SDL*) '
                ': > "$CCB_SDL_QUERY_MARKER"; exit 99;; esac\nexit 0\n'
            )
            pkg_config.chmod(0o755)
            environment = dict(
                os.environ, SDL3="1", TILES="1", SOUND="1",
                CCB_SDL_QUERY_MARKER=str(marker),
                PATH=directory + os.pathsep + os.environ["PATH"],
            )
            result = self.run_command([
                "make", "-n", "localization", "SDL3=1", "TILES=1", "SOUND=1",
                "ASTYLE=0", "LINTJSON=0", "LOCALIZE=0", "LANGUAGES=",
                "ODIR=" + directory + "/obj",
                "CATA_ENABLE_LUA_PLATFORM=0",
            ], env=environment)
            self.assertEqual(result.returncode, 0, result.stdout[-4000:])
            self.assertFalse(marker.exists(), result.stdout[-4000:])


if __name__ == "__main__":
    unittest.main()
