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
    def graph(self, windows, vcpkg):
        source = (ROOT / "src/CMakeLists.txt").read_text()
        start = source.index("        if(VCPKG_MANIFEST_MODE AND WIN32)")
        stop = source.index("        add_dependencies(cataclysm-tiles-common compile_shaders)", start)
        stop = source.index("\n", stop)
        block = source[start:stop]
        with tempfile.TemporaryDirectory(prefix="ccb shader graph ") as directory:
            path = Path(directory)
            shaders = path / "data/shaders"
            shaders.mkdir(parents=True)
            (shaders / "sample.frag").write_text("void main() {}\n")
            tools = path / "tools"
            tools.mkdir()
            shutil.copyfile(ROOT / "tools/build_shaders.py", tools / "build_shaders.py")
            (path / "CMakeLists.txt").write_text(f'''
cmake_minimum_required(VERSION 3.20)
project(ShaderGraph NONE)
set(WIN32 {"ON" if windows else "OFF"})
set(VCPKG_MANIFEST_MODE {"ON" if vcpkg else "OFF"})
set(VCPKG_INSTALLED_DIR "${{CMAKE_SOURCE_DIR}}/sdk with spaces")
set(VCPKG_TARGET_TRIPLET x64-windows)
set(CATA_SHADER_FORMATS spv)
set(_SHADERS_DIR "${{CMAKE_SOURCE_DIR}}/data/shaders")
set(_SHADER_SOURCES "${{_SHADERS_DIR}}/sample.frag")
set(_SHADERS_STAMP "${{_SHADERS_DIR}}/build-spv.stamp")
add_custom_target(cataclysm-tiles-common)
{block}
''')
            result = subprocess.run(
                ["cmake", "-G", "Ninja", "-S", str(path), "-B", str(path / "build")],
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
        graph = self.graph(windows=True, vcpkg=True)
        self.assertIn("glslangValidator.exe", graph)
        self.assertIn("shadercross.exe", graph)
        self.assertIn("sample.frag.spv", graph)
        self.assertIn("sample.frag.dxil", graph)
        self.assertNotIn("--stamp", graph)

    def test_non_vcpkg_uses_existing_python_shader_builder(self):
        for windows in (True, False):
            with self.subTest(windows=windows):
                graph = self.graph(windows=windows, vcpkg=False)
                self.assertIn("build_shaders.py", graph)
                self.assertIn("--stamp", graph)
                self.assertNotIn("shadercross.exe", graph)


if __name__ == "__main__":
    unittest.main()
