"""Generate the real shader command graph without requiring a Windows SDK."""

import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


@unittest.skipUnless(shutil.which("cmake") and shutil.which("ninja"),
                     "CMake and Ninja are required")
class ShaderCMakeGraphTest(unittest.TestCase):
    def graph(self, windows, vcpkg, formats="spv"):
        source = (ROOT / "src/CMakeLists.txt").read_text()
        start = source.index("if(VCPKG_MANIFEST_MODE AND WIN32)")
        start = source.rfind("\n", 0, start) + 1
        dependency = ("add_dependencies(cataclysm-tiles-common "
                      "compile_shaders)")
        stop = source.index(dependency, start)
        stop = source.index("\n", stop)
        block = source[start:stop]
        temporary = tempfile.TemporaryDirectory(prefix="ccb shader graph ")
        with temporary as directory:
            path = Path(directory)
            shaders = path / "data/shaders"
            shaders.mkdir(parents=True)
            (shaders / "sample.frag").write_text("void main() {}\n")
            (shaders / "sample.vert").write_text("void main() {}\n")
            (shaders / "common.glsl").write_text("// shared constants\n")
            tools = path / "tools"
            tools.mkdir()
            shutil.copyfile(ROOT / "tools/build_shaders.py",
                            tools / "build_shaders.py")
            (path / "CMakeLists.txt").write_text(f'''
cmake_minimum_required(VERSION 3.20)
project(ShaderGraph NONE)
set(WIN32 {"ON" if windows else "OFF"})
set(VCPKG_MANIFEST_MODE {"ON" if vcpkg else "OFF"})
set(VCPKG_INSTALLED_DIR "${{CMAKE_SOURCE_DIR}}/sdk with spaces")
set(VCPKG_TARGET_TRIPLET x64-windows)
set(CATA_SHADER_FORMATS "{formats}")
set(_SHADERS_DIR "${{CMAKE_SOURCE_DIR}}/data/shaders")
set(_SHADER_SOURCES "${{_SHADERS_DIR}}/sample.frag"
                    "${{_SHADERS_DIR}}/sample.vert")
set(_SHADER_INCLUDES "${{_SHADERS_DIR}}/common.glsl")
set(_SHADERS_STAMP "${{_SHADERS_DIR}}/build-spv.stamp")
add_custom_target(cataclysm-tiles-common)
{block}
''')
            result = subprocess.run(
                ["cmake", "-G", "Ninja", "-S", str(path),
                 "-B", str(path / "build")],
                capture_output=True, text=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            result = subprocess.run(
                ["ninja", "-C", str(path / "build"), "-n", "compile_shaders"],
                capture_output=True, text=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            return (path / "build/build.ninja").read_text()

    def test_vcpkg_windows_uses_shader_tools_and_spirv_dependency(self):
        graph = self.graph(windows=True, vcpkg=True, formats="dxil")
        self.assertIn("glslangValidator.exe", graph)
        self.assertIn("shadercross.exe", graph)
        self.assertIn("sample.frag.spv", graph)
        self.assertIn("sample.frag.dxil", graph)
        self.assertIn("sample.vert.dxil", graph)
        self.assertIn("common.glsl", graph)
        self.assertNotIn("-S frag", graph)
        self.assertNotIn("--stamp", graph)

    def test_vcpkg_windows_respects_requested_shader_formats(self):
        graph = self.graph(windows=True, vcpkg=True, formats="spv")
        self.assertIn("sample.frag.spv", graph)
        self.assertNotIn("shadercross.exe", graph)
        self.assertNotIn("sample.frag.dxil", graph)
        graph = self.graph(windows=True, vcpkg=True, formats="spv,dxil,msl")
        self.assertIn("sample.frag.dxil", graph)
        self.assertIn("sample.vert.msl", graph)

    def test_non_vcpkg_uses_existing_python_shader_builder(self):
        for windows in (True, False):
            with self.subTest(windows=windows):
                graph = self.graph(windows=windows, vcpkg=False)
                self.assertIn("build_shaders.py", graph)
                self.assertIn("--stamp", graph)
                self.assertIn("common.glsl", graph)
                self.assertNotIn("shadercross.exe", graph)


@unittest.skipUnless(shutil.which("cmake"), "CMake is required")
class NativeScopeCMakeTest(unittest.TestCase):
    def test_curses_batches_do_not_expand_the_lua_scope(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            tests = root / "tests"
            tests.mkdir()
            support = ROOT / "tests/test_support_sources.txt"
            shutil.copyfile(support, tests / support.name)
            shutil.copyfile(ROOT / "tests/CMakeLists.txt",
                            tests / "CMakeLists.txt")
            names = set(support.read_text().splitlines())
            names.update(("lua_platform_scope_test.cpp", "other_test.cpp"))
            for name in names:
                (tests / name).touch()
            (root / "CMakeLists.txt").write_text('''
cmake_minimum_required(VERSION 3.20)
project(NativeScope LANGUAGES CXX)
enable_testing()
set(BUILD_TESTING ON)
set(CURSES ON)
set(CATA_ENABLE_LUA_PLATFORM ON)
add_library(cataclysm-common INTERFACE)
add_subdirectory(tests)
''')
            for scope in ("all", "lua"):
                with self.subTest(scope=scope):
                    build = root / scope
                    result = subprocess.run(
                        ["cmake", "-S", str(root), "-B", str(build),
                         "-DCATA_TEST_SUITE=" + scope],
                        capture_output=True, text=True,
                    )
                    self.assertEqual(result.returncode, 0, result.stderr)
                    registry = build / "tests/CTestTestfile.cmake"
                    registered = registry.read_text()
                    if scope == "lua":
                        self.assertIn("[lua][platform]", registered)
                        self.assertNotIn("cata.test-1", registered)
                    else:
                        self.assertIn("cata.test-1", registered)
                        self.assertIn("cata.test-2", registered)
                        self.assertIn("test_user_dir_1", registered)
                        self.assertIn("test_user_dir_2", registered)


if __name__ == "__main__":
    unittest.main()
