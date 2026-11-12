import sys
import unittest
from unittest.mock import patch

with patch.object(sys, "argv", ["gun_variant_validator.py", "."]):
    from gun_variant_validator import firing_mode_signature


class FiringModeSignatureTest(unittest.TestCase):
    def test_legacy_and_explicit_bursts(self):
        legacy = firing_mode_signature(["BURST", "3 rd.", 3])
        self.assertEqual(legacy, firing_mode_signature(["brust-rpm", "900", 3]))
        self.assertNotEqual(legacy, firing_mode_signature(["brust-rpm", "800", 3]))

    def test_full_auto_and_fixed_quantities(self):
        self.assertEqual(firing_mode_signature(["AUTO", "auto", 2]),
                         firing_mode_signature(["AUTO", "auto-rpm", "600"]))
        self.assertEqual(firing_mode_signature(["DEFAULT", "semi-auto", 1]), (1, 0))
        self.assertEqual(firing_mode_signature(["BURST", "volley", 2, "VOLLEY"]), (2, 0))
