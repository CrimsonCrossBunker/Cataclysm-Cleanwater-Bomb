#!/usr/bin/env python3
"""Exercise the production CMake version generator in real Git layouts."""

from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]


@unittest.skipUnless(shutil.which("cmake") and shutil.which("git"),
                     "requires CMake and Git")
class CMakeVersionTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="ccb-version-")
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)

    def source(self, path):
        (path / "src").mkdir(parents=True)
        shutil.copy2(ROOT / "src/version.cmake", path / "src/version.cmake")
        # The old generator used this module; copy it so the regression fails
        # on its actual worktree handling rather than a missing dependency.
        (path / "CMakeModules").mkdir()
        for name in ("GetGitRevisionDescription.cmake",
                     "GetGitRevisionDescription.cmake.in"):
            shutil.copy2(ROOT / "CMakeModules" / name,
                         path / "CMakeModules" / name)
        (path / ".gitignore").write_text(
            "src/version.h\nVERSION.txt\nCMakeFiles/\n", encoding="utf-8")
        (path / "tracked.txt").write_text("initial\n", encoding="utf-8")
        return path

    def git(self, path, *args):
        return subprocess.run(
            ["git", "-c", "user.name=CCB version test",
             "-c", "user.email=ccb-test@example.invalid",
             "-c", "commit.gpgsign=false", *args], cwd=path,
            text=True, capture_output=True, check=True).stdout.strip()

    def repository(self):
        path = self.source(self.root / "main repo")
        self.git(path, "init", "-b", "main")
        self.git(path, "add", ".")
        self.git(path, "commit", "-m", "version fixture")
        return path

    def generate(self, path):
        result = subprocess.run(
            ["cmake", "-P", "src/version.cmake"], cwd=path,
            text=True, capture_output=True, check=True)
        return (path / "src/version.h").read_text(encoding="utf-8"), result

    def check_revision(self, path, dirty=False):
        revision = self.git(path, "describe", "--tags", "--always",
                            "--match", "cdda-*")
        header, result = self.generate(path)
        suffix = revision + ("-dirty" if dirty else "")
        self.assertIn(suffix + '"', header)
        self.assertRegex(header, r'#define VERSION "\d{4}-\d{2}-\d{2}-')
        self.assertNotIn("NOTFOUND", header)
        self.assertIn(suffix, result.stderr)
        self.assertIn(self.git(path, "rev-parse", "HEAD"),
                      (path / "VERSION.txt").read_text(encoding="utf-8"))
        stamp = (path / "src/version.h").stat().st_mtime_ns
        again, _ = self.generate(path)
        self.assertEqual(header, again)
        self.assertEqual(stamp, (path / "src/version.h").stat().st_mtime_ns)

    def test_main_checkout_and_dirty_state(self):
        path = self.repository()
        self.check_revision(path)
        (path / "tracked.txt").write_text("changed\n", encoding="utf-8")
        self.check_revision(path, dirty=True)
        self.git(path, "add", "tracked.txt")
        self.check_revision(path, dirty=True)

    def test_linked_worktree_clean_dirty_and_detached(self):
        main = self.repository()
        path = self.root / "linked worktree"
        self.git(main, "worktree", "add", "-b", "test-branch", str(path))
        self.assertTrue((path / ".git").is_file())
        self.check_revision(path)
        (path / "tracked.txt").write_text("changed\n", encoding="utf-8")
        self.check_revision(path, dirty=True)
        self.git(path, "restore", "tracked.txt")
        self.git(path, "checkout", "--detach")
        self.check_revision(path)

    def test_source_archive_preserves_existing_version(self):
        path = self.source(self.root / "archive")
        expected = ('// NOLINT(cata-header-guard)\n'
                    '#define VERSION "release-42"\n')
        (path / "src/version.h").write_text(expected, encoding="utf-8")
        header, result = self.generate(path)
        self.assertEqual(header, expected)
        self.assertIn("release-42", result.stderr)

    def test_source_archive_without_version_has_valid_fallback(self):
        path = self.source(self.root / "archive")
        header, result = self.generate(path)
        self.assertIn('#define VERSION "unknown"', header)
        self.assertIn("unknown", result.stderr)


if __name__ == "__main__":
    unittest.main()
