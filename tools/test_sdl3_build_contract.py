"""Exercise legacy flag failures and dependency-free utility targets."""

import os
import shlex
from pathlib import Path
import shutil
import subprocess
import tempfile
import textwrap
import unittest


ROOT = Path(__file__).resolve().parents[1]


class SDL3BuildContractTest(unittest.TestCase):
    def run_command(self, command, **kwargs):
        return subprocess.run(command, cwd=ROOT, text=True,
                              stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                              timeout=45, **kwargs)

    def test_macos_setup_keeps_host_library_resolution_unchanged(self):
        action = (ROOT / ".github/actions/setup-sdl3-stack-macos/action.yml").read_text()
        configure = action.split("- name: Configure SDL3 environment\n", 1)[1]
        script = textwrap.dedent(configure.split("run: |\n", 1)[1])
        with tempfile.TemporaryDirectory(prefix="ccb-macos-env-") as directory:
            prefix = Path(directory) / "SDL3 prefix"
            env_file = Path(directory) / "github-env"
            result = self.run_command(
                ["bash", "-eu", "-c", script],
                env=dict(os.environ, SDL3_PREFIX=str(prefix),
                         GITHUB_ENV=str(env_file)),
            )
            self.assertEqual(result.returncode, 0, result.stdout)
            exported = dict(line.split("=", 1)
                            for line in env_file.read_text().splitlines())
            self.assertEqual(exported["PKG_CONFIG_PATH"],
                             f"{prefix}/lib/pkgconfig:/opt/local/lib/pkgconfig")
            self.assertEqual(exported["DYLIBBUNDLER_SEARCH_PATHS"],
                             f"{prefix}/lib /opt/local/lib")
            # Job-wide loader overrides also affect Homebrew git/gh and
            # checkout cleanup, even though SDL3 binaries have their own rpath.
            self.assertFalse(any(key.startswith("DYLD_") for key in exported),
                             exported)

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

    @unittest.skipUnless(shutil.which("make"), "GNU Make is unavailable")
    def test_macos_terminal_release_does_not_require_sdl(self):
        workflow = (ROOT / ".github/workflows/release.yml").read_text()
        step = workflow.split("- name: Build CDDA (osx, curses)\n", 1)[1]
        step = step.split("\n      - name:", 1)[0]
        build_line = next(line.strip() for line in step.splitlines()
                          if line.strip().startswith("make "))
        command = shlex.split(build_line.replace("${{ matrix.tiles }}", "0"))
        self.assertEqual(command.pop(), "dmgdist")
        with tempfile.TemporaryDirectory(
                prefix="ccb-macos-terminal-") as directory:
            # Reject SDL discovery even when SDK frameworks are installed.
            marker = Path(directory) / "sdl-query"
            find = Path(directory) / "find"
            find.write_text(
                '#!/bin/sh\ncase "$*" in *SDL3*) '
                ': > "$CCB_SDL_QUERY_MARKER"; exit 0;; esac\n'
                'exec ' + shlex.quote(shutil.which("find")) + ' "$@"\n'
            )
            find.chmod(0o755)
            environment = dict(
                os.environ, CCB_SDL_QUERY_MARKER=str(marker),
                PATH=directory + os.pathsep + os.environ["PATH"],
            )
            result = self.run_command([
                command[0], "-n", *command[1:], "NATIVE=osx", "FRAMEWORKSDIR=",
                "ASTYLE=0", "LINTJSON=0", "LOCALIZE=0", "LANGUAGES=",
                "CATA_ENABLE_LUA_PLATFORM=0", "ODIR=" + directory + "/obj",
                "appclean",
            ], env=environment)
            self.assertEqual(result.returncode, 0, result.stdout[-4000:])
            self.assertFalse(marker.exists(), result.stdout[-4000:])


if __name__ == "__main__":
    unittest.main()
