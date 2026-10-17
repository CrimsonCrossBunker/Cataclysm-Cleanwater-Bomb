import csv
import importlib
import json
import os
from pathlib import Path
import subprocess
import sys
import tarfile
import tempfile
import unittest
from unittest.mock import patch

import yaml


ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / "lang"))


class UpstreamTranslationExtractionTests(unittest.TestCase):
    def extract(self, module_name, function_name, payload):
        module = importlib.import_module(
            "string_extractor.parsers." + module_name)
        with patch.object(module, "write_text") as writer:
            getattr(module, function_name)(payload, "fixture.json")
        return [call.args[0] for call in writer.call_args_list]

    def test_extended_item_variants_are_translatable(self):
        payload = {"name": "coat", "extend": {"variants": [
            {"name": "striped coat", "description": "Bright stripes."}
        ]}}
        texts = self.extract("generic", "parse_subtypes", payload)
        self.assertIn("striped coat", texts)
        self.assertIn("Bright stripes.", texts)

    def test_spell_failure_messages_are_translatable(self):
        payload = {"name": "spell",
                   "caster_condition_fail_message": "Too tired.",
                   "target_condition_fail_message": "Target is immune."}
        texts = self.extract("spell", "parse_spell", payload)
        self.assertIn("Too tired.", texts)
        self.assertIn("Target is immune.", texts)

    def test_rejection_and_technique_effect_messages_are_translatable(self):
        texts = self.extract("shop_whitelist", "parse_shopkeeper_whitelist",
                             {"message": "No trading here.", "entries": []})
        self.assertIn("No trading here.", texts)
        payload = {"name": "jab",
                   "tech_effects": [{"message": "Off balance!"}]}
        texts = self.extract("technique", "parse_technique", payload)
        self.assertIn("Off balance!", texts)


class UpstreamReleaseToolsTests(unittest.TestCase):
    def test_macos_alias_columns_preserve_market_share(self):
        with tempfile.TemporaryDirectory() as directory:
            directory = Path(directory)
            files = []
            for name, headers, values in [
                ("aliases", ["macOS Sequoia", "macOS Sequoia.0",
                             "macOS Catalina", "macOS 19"],
                 [20, 30, 10, 5]),
                ("canonical", ["macOS Sequoia", "macOS Catalina"], [50, 15]),
            ]:
                filename = directory / (name + ".csv")
                with filename.open("w") as stream:
                    writer = csv.writer(stream)
                    writer.writerow(["Date", *headers])
                    writer.writerow(["2026-09", *values])
                command = [sys.executable,
                           str(ROOT / "tools/macos-market-share.py"),
                           str(filename)]
                result = subprocess.run(command, check=True,
                                        capture_output=True, text=True)
                files.append(result.stdout)
            self.assertEqual(files[0], files[1])

    def test_translation_archive_upload_uses_each_real_release_tag(self):
        source = ROOT / ".github/workflows/release.yml"
        workflow = yaml.safe_load(source.read_text())
        job = workflow["jobs"]["publish-translations"]
        script = job["steps"][-1]["run"]
        self.assertEqual(job["permissions"], {"contents": "write"})
        tags = ["2026-10-13-1200", "0.Ag-Candidate-2026-10-13-1200", "0.Ag"]
        for tag in tags:
            with self.subTest(tag=tag), \
                    tempfile.TemporaryDirectory() as directory:
                directory = Path(directory)
                (directory / "translations").mkdir()
                translation = directory / "translations/zh_CN.mo"
                translation.write_text("fixture translation")
                command = directory / "gh"
                command.write_text(
                    "#!" + sys.executable + "\nimport json, os, sys\n"
                    "with open(os.environ['UPLOAD_RECORD'], 'w') as stream:\n"
                    "    stream.write(json.dumps(sys.argv[1:]))\n")
                command.chmod(0o755)
                record = directory / "upload.json"
                search = str(directory) + os.pathsep + os.environ["PATH"]
                env = {**os.environ, "PATH": search,
                       "UPLOAD_RECORD": str(record), "RELEASE_TAG": tag,
                       "RELEASE_TIMESTAMP": "2026-10-13-1200"}
                subprocess.run(["bash", "-c", script], cwd=directory,
                               env=env, check=True)
                args = json.loads(record.read_text())
                self.assertEqual(args[:3], ["release", "upload", tag])
                with tarfile.open(directory / args[3]) as archive:
                    entry = archive.getmember("zh_CN.mo")
                    self.assertEqual(entry.uid, 0)
                    self.assertEqual(entry.gid, 0)
                    content = archive.extractfile(entry).read()
                    self.assertEqual(content, b"fixture translation")


if __name__ == "__main__":
    unittest.main()
