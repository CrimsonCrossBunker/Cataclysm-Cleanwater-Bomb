import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


SCRIPT = Path(__file__).with_name(
    "assign_mission_target_needs_om_special.bash"
)
BASH = shutil.which("bash")


@unittest.skipUnless(BASH and shutil.which("jq"), "bash and jq are required")
class MissionTargetCheckTest(unittest.TestCase):
    def run_check(self, objects):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "data").mkdir()
            (root / "bin").mkdir()
            (root / "tmp").mkdir()
            (root / "data" / "missions.json").write_text(
                json.dumps(objects), encoding="utf-8"
            )
            wrapper = root / "bin" / "mktemp"
            wrapper.write_text(
                "#!/usr/bin/env bash\n"
                "case \"$1\" in\n"
                "  --suffix=-special-of-terrain.json|"
                "--suffix=-missing-om-special.json) ;;\n"
                "  *) exit 64 ;;\n"
                "esac\n"
                "printf '%s/%s\\n' \"$TMPDIR\" \"${1#--suffix=}\"\n",
                encoding="utf-8",
            )
            wrapper.chmod(0o755)
            environment = os.environ.copy()
            environment["PATH"] = (
                str(root / "bin") + os.pathsep + environment["PATH"]
            )
            environment["TMPDIR"] = (root / "tmp").as_posix()
            return subprocess.run(
                [BASH, SCRIPT.as_posix()], cwd=root, env=environment,
                capture_output=True, text=True, encoding="utf-8", check=False,
            )

    def fixture(self):
        return [
            {"type": "overmap_special", "id": "test_special",
             "overmaps": [{"overmap": "test_terrain"}]},
            {"type": "mission_definition", "id": "test_mission",
             "start": {"assign_mission_target": {
                 "om_terrain": "test_terrain", "om_special": "test_special",
             }}},
        ]

    def test_accepts_a_mission_with_its_special(self):
        result = self.run_check(self.fixture())
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stderr, "")

    def test_reports_a_missing_special(self):
        objects = self.fixture()
        del objects[1]["start"]["assign_mission_target"]["om_special"]
        result = self.run_check(objects)
        self.assertEqual(result.returncode, 1, result.stderr)
        self.assertIn("test_mission", result.stdout)
        self.assertIn("test_special", result.stdout)

    def test_accepts_inherited_specials_without_terrain_definitions(self):
        objects = self.fixture()
        objects.append({"type": "overmap_special", "id": "test_special",
                        "copy-from": "test_special", "occurrences": [1, 5]})
        result = self.run_check(objects)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stderr, "")
