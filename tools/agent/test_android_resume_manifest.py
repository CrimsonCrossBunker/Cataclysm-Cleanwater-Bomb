"""Guard configuration changes that must not tear down the native SDL game.

This checks the manifest contract, not process survival or device lifecycle.
"""
import os
from pathlib import Path
import unittest
import xml.etree.ElementTree as ET


ROOT = Path(__file__).resolve().parents[2]
ANDROID = "{http://schemas.android.com/apk/res/android}"


class AndroidResumeManifestTest(unittest.TestCase):
    def test_background_configuration_changes_retain_native_activity(self):
        manifest = Path(os.environ.get(
            "CCB_ANDROID_MANIFEST",
            ROOT / "android/app/src/main/AndroidManifest.xml"))
        activities = ET.parse(manifest).findall("application/activity")
        game = next(a for a in activities if a.get(
            ANDROID + "name").split(".")[-1] == "CataclysmDDA")
        handled = set(game.get(ANDROID + "configChanges", "").split("|"))
        # Android otherwise destroys/recreates SDLActivity and its native game
        # thread when returning to a changed configuration.
        changes = {
            "night mode while backgrounded": {"uiMode"},
            "fold or multi-window resize": {
                "screenLayout", "screenSize", "smallestScreenSize"},
            "rotate while backgrounded": {"orientation", "screenSize"},
            "display and accessibility settings": {
                "density", "fontScale", "fontWeightAdjustment"},
            "language settings": {
                "locale", "layoutDirection", "grammaticalGender"},
            "keyboard and navigation changes": {
                "keyboard", "keyboardHidden", "navigation"},
        }
        for scenario, flags in changes.items():
            with self.subTest(scenario=scenario):
                self.assertFalse(flags - handled, sorted(flags - handled))
        self.assertEqual(game.get(ANDROID + "launchMode"), "singleInstance")
        self.assertEqual(game.get(ANDROID + "alwaysRetainTaskState"), "true")


if __name__ == "__main__":
    unittest.main()
