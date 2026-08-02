#!/usr/bin/env python3
"""Generate deterministic, source-backed JSON and EOC contract inventories.

Only tracked files returned by ``git ls-files`` are considered.  The extractor
records unknown details instead of inferring required fields or semantics from
data frequency.
"""

from __future__ import annotations

import argparse
import collections
import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path
from typing import Iterable


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]

DEFAULT_OUTPUT_DIRECTORY = REPOSITORY_ROOT / "data/reference/json"

OUTPUT_NAMES = {
    "json_object_types": "ccb_json_object_types.json",
    "eoc_conditions": "ccb_eoc_conditions.json",
    "eoc_effects": "ccb_eoc_effects.json",
}

CONTRACT_ROOTS = ("data/core", "data/json", "data/mods", "data/sound")

VARIABLE_SCOPES = ("u_val", "npc_val", "global_val", "var_val", "context_val")

VALUE_HELPERS = (
    "value_or_var",
    "value_or_var_pair",
    "dbl_or_var",
    "duration_or_var",
    "str_or_var",
    "translation_or_var",
    "eoc_math",
)
