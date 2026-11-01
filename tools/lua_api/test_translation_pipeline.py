import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
UPDATE_POT = ROOT / "lang/update_pot.sh"
WORKFLOW = ROOT / ".github/workflows/text-changes-analyzer.yml"
HEADER = (
    'msgid ""\nmsgstr ""\n'
    '"Content-Type: text/plain; charset=UTF-8\\n"\n\n'
)


def lua_pipeline():
    script = UPDATE_POT.read_text(encoding="utf-8")
    start = script.index('echo "> Extracting strings from Lua"')
    return script[start:script.index('package="cataclysm-dda"', start)]


class TranslationWorkflowTest(unittest.TestCase):
    def test_lua_changes_and_pipeline_changes_trigger_analysis(self):
        workflow = WORKFLOW.read_text(encoding="utf-8")
        paths = workflow.split("concurrency:", 1)[0]
        for pattern in (
            "'**.lua'", "'lang/update_pot.sh'",
            "'tools/lua_api/*translat*.py'",
        ):
            with self.subTest(pattern=pattern):
                self.assertIn(pattern, paths)
        self.assertIn("-p 'test_*translat*.py'", workflow)

    def test_base_uses_the_pr_lua_extractor_without_overlaying_game_data(self):
        workflow = WORKFLOW.read_text(encoding="utf-8")
        overlay = workflow.split("git checkout pr-head --", 1)[1]
        overlay = overlay.split('      - name:', 1)[0]
        self.assertEqual(
            overlay.count("tools/lua_api/extract_translations.py"), 2,
        )
        self.assertNotIn("data/", overlay)


@unittest.skipUnless(
    all(shutil.which(tool) for tool in ("bash", "git", "xgettext", "msgcat")),
    "Bash, Git and GNU gettext are required",
)
class LuaPotPipelineTest(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.root = Path(self.directory.name)
        self.base = self.root / "lang/po/base.pot"
        self.base.parent.mkdir(parents=True)
        self.original = HEADER + 'msgid "Existing native text"\nmsgstr ""\n'
        self.base.write_text(self.original, encoding="utf-8")
        extractor = self.root / "tools/lua_api/extract_translations.py"
        extractor.parent.mkdir(parents=True)
        shutil.copy2(ROOT / "tools/lua_api/extract_translations.py", extractor)
        self.git("init", "-q")

    def git(self, *arguments):
        return subprocess.run(
            ["git", *arguments], cwd=self.root, capture_output=True,
            text=True, check=True,
        )

    def source(self, filename, content, tracked=True):
        path = self.root / filename
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(content, encoding="utf-8")
        if tracked:
            self.git("add", "--", filename)

    def run_pipeline(self):
        environment = dict(os.environ)
        environment["PYTHONUTF8"] = "1"
        return subprocess.run(
            ["bash", "-e", "-o", "pipefail", "-c", lua_pipeline()],
            cwd=self.root, env=environment, capture_output=True,
            text=True, encoding="utf-8",
        )

    def test_merges_tracked_runtime_strings_with_native_messages(self):
        filename = "data/mods/example/content.lua"
        self.source(filename, '''
error("Lua must not execute")
ccb.services.translate("A Lua greeting", "greeting")
ccb.content.plural_text("one charm", "many charms")
local response = {
    text = "A dialogue reply", text_translation = { context = "reply" }
}
''')
        self.source(
            "data/lua/runtime.lua", 'ccb.content.text("Runtime text")\n',
        )
        self.source(
            "data/mods/example/spaced path.lua",
            'ccb.content.text("Text from a spaced path")\n',
        )
        result = self.run_pipeline()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        catalog = self.base.read_text(encoding="utf-8").replace("\\", "/")
        for message in (
            'msgid "Existing native text"', 'msgid "A Lua greeting"',
            'msgctxt "greeting"', 'msgid_plural "many charms"',
            'msgid "A dialogue reply"', 'msgctxt "reply"',
            'msgid "Runtime text"', 'msgid "Text from a spaced path"',
            filename,
        ):
            with self.subTest(message=message):
                self.assertIn(message, catalog)

    def test_excludes_non_runtime_and_untracked_sources(self):
        for filename in (
            "data/lua/types/example.d.lua",
            "data/lua/reference/example.lua",
            "data/lua/templates/minimal/main.lua",
            "data/mods/TEST_DATA/nested/main.lua",
            "data/mods/Standard_Combat_Tests/main.lua",
            "tools/example.lua",
        ):
            self.source(filename, 'ccb.content.text("Excluded text")\n')
        self.source(
            "data/mods/example/untracked.lua",
            'ccb.content.text("Untracked text")\n', tracked=False,
        )
        self.source(
            "data/mods/example/main.lua", 'ccb.content.text("Included text")',
        )
        result = self.run_pipeline()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        catalog = self.base.read_text(encoding="utf-8")
        self.assertIn('msgid "Included text"', catalog)
        self.assertNotIn("Excluded text", catalog)
        self.assertNotIn("Untracked text", catalog)

    def test_no_lua_sources_preserves_native_catalog(self):
        result = self.run_pipeline()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(self.base.read_text(encoding="utf-8"), self.original)

    def test_lua_without_messages_is_valid(self):
        self.source("data/mods/example/main.lua", "local value = 42\n")
        result = self.run_pipeline()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertIn(
            'msgid "Existing native text"',
            self.base.read_text(encoding="utf-8"),
        )

    def test_failed_extraction_does_not_replace_native_catalog(self):
        self.source(
            "data/mods/example/main.lua", 'ccb.content.text("Runtime text")',
        )
        (self.root / "tools/lua_api/extract_translations.py").write_text(
            "raise SystemExit(7)\n", encoding="utf-8",
        )
        result = self.run_pipeline()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Error in extracting strings from Lua", result.stdout)
        self.assertEqual(self.base.read_text(encoding="utf-8"), self.original)


if __name__ == "__main__":
    unittest.main()
