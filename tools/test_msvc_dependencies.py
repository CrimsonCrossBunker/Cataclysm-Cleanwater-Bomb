import os
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CMAKE = shutil.which("cmake")
PREFIX = "\u6ce8\u610f: \u5305\u542b\u6587\u4ef6:  "


@unittest.skipUnless(CMAKE, "CMake is required")
class MsvcDependenciesTest(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory(prefix="ccb msvc dependencies ")
        self.addCleanup(temporary.cleanup)
        self.path = Path(temporary.name)
        source = (ROOT / "CMakeLists.txt").read_text(encoding="utf-8")
        start = source.index('if (MSVC AND CMAKE_GENERATOR MATCHES "Ninja")')
        self.block = source[start:source.index("add_subdirectory(src)", start)]
        self.compiler = self.path / "compiler.py"
        self.compiler.write_text(
            'import os, pathlib, sys\n'
            'assert os.environ["VSLANG"] == "1033"\n'
            'prefix = pathlib.Path("prefix.txt").read_bytes()\n'
            'sys.stdout.buffer.write(prefix + '
            'str(pathlib.Path.cwd() / "probe.h").encode("utf-8") + b"\\n")\n',
            encoding="utf-8",
        )

    def run_script(self, source, prefix=PREFIX.encode("utf-8"), expected_status=0):
        script = self.path / "check.cmake"
        probe = self.path / "CMakeFiles/ccb-showincludes"
        probe.mkdir(parents=True, exist_ok=True)
        (probe / "prefix.txt").write_bytes(prefix)
        script.write_text(
            f'set(CMAKE_BINARY_DIR "{self.path.as_posix()}")\n'
            f'set(CMAKE_MODULE_PATH "{(ROOT / "CMakeModules").as_posix()}")\n'
            f'set(CMAKE_CXX_COMPILER "{Path(sys.executable).as_posix()}")\n'
            f'set(CMAKE_CXX_COMPILER_ARG1 "{self.compiler.as_posix()}")\n' + source,
            encoding="utf-8",
        )
        result = subprocess.run(
            [CMAKE, "-P", str(script)], capture_output=True, text=True,
        )
        self.assertEqual(result.returncode, expected_status, result.stdout + result.stderr)
        return result

    def test_prefix_bytes_are_not_transcoded(self):
        for encoding in ("utf-8", "gbk"):
            with self.subTest(encoding=encoding):
                self.run_script(
                    'set(MSVC TRUE)\nset(CMAKE_GENERATOR Ninja)\n' + self.block + '\n'
                    'file(READ "${CMAKE_BINARY_DIR}/CMakeFiles/ccb-showincludes/prefix.txt" expected)\n'
                    'if(NOT CMAKE_CL_SHOWINCLUDES_PREFIX STREQUAL expected)\n'
                    'message(FATAL_ERROR "prefix bytes changed")\nendif()\n',
                    prefix=PREFIX.encode(encoding),
                )

    def test_missing_prefix_fails_configuration(self):
        result = self.run_script(
            'set(MSVC TRUE)\nset(CMAKE_GENERATOR Ninja)\n' + self.block,
            prefix=b"unexpected compiler output ", expected_status=1,
        )
        self.assertIn("Cannot detect the MSVC /showIncludes prefix", result.stderr)

    def test_ninja_launchers_preserve_cache_and_arguments(self):
        for generator in ("Ninja", "Ninja Multi-Config"):
            with self.subTest(generator=generator):
                self.run_script(
                    f'set(MSVC TRUE)\nset(CMAKE_GENERATOR "{generator}")\n'
                    'set(CMAKE_CL_SHOWINCLUDES_PREFIX "stale prefix")\n'
                    'set(CMAKE_C_COMPILER_LAUNCHER "cache with spaces" --flag)\n'
                    'set(CMAKE_CXX_COMPILER_LAUNCHER "cache with spaces" --flag)\n'
                    + self.block + '\n'
                    'if(NOT CMAKE_CL_SHOWINCLUDES_PREFIX STREQUAL '
                    f'"{PREFIX}")\nmessage(FATAL_ERROR "bad prefix")\nendif()\n'
                    'foreach(language C CXX)\n'
                    'if(NOT "${CMAKE_${language}_COMPILER_LAUNCHER}" STREQUAL '
                    '"${CMAKE_COMMAND};-E;env;VSLANG=1033;cache with spaces;--flag")\n'
                    'message(FATAL_ERROR "bad launcher")\nendif()\nendforeach()\n'
                )

    def test_other_builds_keep_their_configuration(self):
        for compiler, generator in (("FALSE", "Ninja"), ("TRUE", "Visual Studio 17 2022")):
            with self.subTest(compiler=compiler, generator=generator):
                self.run_script(
                    f'set(MSVC {compiler})\nset(CMAKE_GENERATOR "{generator}")\n'
                    'set(CMAKE_CL_SHOWINCLUDES_PREFIX "original")\n'
                    'set(CMAKE_CXX_COMPILER_LAUNCHER "original launcher")\n'
                    + self.block + '\n'
                    'if(NOT CMAKE_CL_SHOWINCLUDES_PREFIX STREQUAL "original" OR '
                    'NOT CMAKE_CXX_COMPILER_LAUNCHER STREQUAL "original launcher" OR '
                    'DEFINED CMAKE_C_COMPILER_LAUNCHER)\n'
                    'message(FATAL_ERROR "unrelated build changed")\nendif()\n'
                )

    def test_launcher_overrides_the_build_environment(self):
        child = self.path / "child.cmake"
        child.write_text(
            'if(NOT "$ENV{VSLANG}" STREQUAL "1033")\n'
            'message(FATAL_ERROR "compiler language was not fixed")\nendif()\n',
            encoding="utf-8",
        )
        self.run_script(
            'set(MSVC TRUE)\nset(CMAKE_GENERATOR Ninja)\n'
            'set(ENV{VSLANG} 2052)\n' + self.block + '\n'
            f'execute_process(COMMAND ${{CMAKE_CXX_COMPILER_LAUNCHER}} '
            f'"${{CMAKE_COMMAND}}" -P "{child.as_posix()}" RESULT_VARIABLE status)\n'
            'if(NOT status EQUAL 0)\nmessage(FATAL_ERROR "launcher failed")\nendif()\n'
        )

    @unittest.skipUnless(os.name == "nt" and shutil.which("cl") and shutil.which("ninja"),
                         "MSVC and Ninja are required")
    def test_header_changes_rebuild_both_languages(self):
        self.check_header_rebuild()

    @unittest.skipUnless(os.name == "nt" and all(shutil.which(tool) for tool in ("cl", "ninja", "ccache")),
                         "MSVC, Ninja and ccache are required")
    def test_header_changes_rebuild_cached_objects(self):
        self.check_header_rebuild(shutil.which("ccache"))

    def check_header_rebuild(self, launcher=None):
        launchers = ""
        if launcher:
            for language in ("C", "CXX"):
                launchers += f'set(CMAKE_{language}_COMPILER_LAUNCHER "{Path(launcher).as_posix()}")\n'
        (self.path / "CMakeLists.txt").write_text(
            'cmake_minimum_required(VERSION 3.20)\n'
            'project(DependencyProbe LANGUAGES C CXX)\n'
            f'list(APPEND CMAKE_MODULE_PATH "{(ROOT / "CMakeModules").as_posix()}")\n'
            'set(CMAKE_CL_SHOWINCLUDES_PREFIX "stale prefix")\n'
            + launchers + self.block + '\nadd_library(probe OBJECT probe.c probe.cpp)\n',
            encoding="utf-8",
        )
        header = self.path / "probe.h"
        header.write_text("#define PROBE_VALUE 1\n", encoding="utf-8")
        for suffix, function in (("c", "probe_c"), ("cpp", "probe_cpp")):
            (self.path / f"probe.{suffix}").write_text(
                f'#include "probe.h"\nint {function}(void) {{ return PROBE_VALUE; }}\n',
                encoding="utf-8",
            )
        build = self.path / "build"
        environment = dict(os.environ, VSLANG="2052", CCACHE_DIR=str(self.path / "ccache"))

        def run(*command):
            result = subprocess.run(command, capture_output=True, text=True, env=environment)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            return result.stdout

        run(CMAKE, "-S", str(self.path), "-B", str(build), "-G", "Ninja")
        build_output = run(CMAKE, "--build", str(build))
        dependencies = run("ninja", "-C", str(build), "-t", "deps")
        rules = (build / "CMakeFiles/rules.ninja").read_text(encoding="utf-8", errors="replace")
        prefixes = "\n".join(line for line in rules.splitlines() if "msvc_deps_prefix" in line)
        self.assertEqual(dependencies.count("probe.h"), 2,
                         dependencies + build_output + prefixes)
        objects = list((build / "CMakeFiles/probe.dir").glob("*.obj"))
        self.assertEqual(len(objects), 2)
        timestamps = {path: path.stat().st_mtime_ns for path in objects}
        contents = {path: path.read_bytes() for path in objects}
        header.write_text("#define PROBE_VALUE 2\n", encoding="utf-8")
        run(CMAKE, "--build", str(build))
        for path in objects:
            self.assertGreater(path.stat().st_mtime_ns, timestamps[path])
            self.assertNotEqual(path.read_bytes(), contents[path])


if __name__ == "__main__":
    unittest.main()

