"""Exercise the real Tracy CMake link gate with enabled/disabled client fixtures."""
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]


@unittest.skipUnless(all(shutil.which(x) for x in ('cmake', 'c++', 'ar')),
                     'CMake and native compiler tools are required')
class TracyConfigureTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='ccb-tracy-configure-')
        self.addCleanup(self.temp.cleanup)
        self.path = Path(self.temp.name)
        self.sdk = self.path / 'include'
        (self.sdk / 'tracy').mkdir(parents=True)
        (self.sdk / 'tracy/Tracy.hpp').write_text('''
#ifndef TRACY_ENABLE
#error link probe must enable profiling
#endif
inline double sdk_cast(int value) { return (double)value; }
extern "C" void tracy_probe_zone();
extern "C" void tracy_probe_frame();
extern "C" void tracy_probe_plot(double);
#define ZoneScopedN(name) tracy_probe_zone()
#define FrameMark tracy_probe_frame()
#define TracyPlot(name, value) tracy_probe_plot(value)
''')
        (self.sdk / 'tracy/TracyC.h').write_text('// C API is unused by these zones.\n')
        self.good = self.client_library('enabled', '''
extern "C" void tracy_probe_zone() {}
extern "C" void tracy_probe_frame() {}
extern "C" void tracy_probe_plot(double) {}
''')
        self.bad = self.client_library('disabled', 'void disabled_client() {}\n')
        self.project = self.path / 'project'
        self.project.mkdir()
        module = (ROOT / 'CMakeModules/CheckTracyClient.cmake').as_posix()
        (self.project / 'CMakeLists.txt').write_text(f'''
cmake_minimum_required(VERSION 3.20)
project(TracyLinkGate LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
find_package(Threads REQUIRED)
include("{module}")
ccb_check_tracy_client()
''')

    def client_library(self, name, source):
        cpp = self.path / (name + '.cpp')
        obj = self.path / (name + '.o')
        archive = self.path / ('lib' + name + '.a')
        cpp.write_text(source)
        subprocess.run(['c++', '-c', str(cpp), '-o', str(obj)], check=True,
                       capture_output=True, text=True)
        subprocess.run(['ar', 'rcs', str(archive), str(obj)], check=True,
                       capture_output=True, text=True)
        return archive

    def configure(self, library, *options):
        return subprocess.run([
            'cmake', '-S', str(self.project), '-B', str(self.path / 'build'),
            '-DTRACY_INCLUDE_DIR=' + str(self.sdk),
            '-DTRACY_LIBRARY=' + str(library),
        ] + list(options), capture_output=True, text=True)

    def test_enabled_client_links(self):
        result = self.configure(self.good)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_sdk_headers_keep_system_warning_policy(self):
        result = self.configure(self.good, '-DCMAKE_CXX_FLAGS=-Werror -Wold-style-cast')
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_disabled_client_is_rejected_with_repair_instructions(self):
        result = self.configure(self.bad)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('enabled profiling cannot link', ' '.join(result.stderr.split()))
        self.assertIn('TRACY_ENABLE=ON', result.stderr)

    def test_compile_only_toolchain_still_checks_linking(self):
        result = self.configure(self.bad, '-DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('enabled profiling cannot link', ' '.join(result.stderr.split()))

    def test_replacing_client_does_not_reuse_cached_success(self):
        good = self.configure(self.good)
        self.assertEqual(good.returncode, 0, good.stdout + good.stderr)
        bad = self.configure(self.bad)
        self.assertNotEqual(bad.returncode, 0)
        self.assertIn('enabled profiling cannot link', ' '.join(bad.stderr.split()))


if __name__ == '__main__':
    unittest.main()
