#!/usr/bin/env python3
"""Validate Lua syntax, manifests, and the complete API v5 example Mod."""

from __future__ import annotations

import argparse
import json
import shutil
import subprocess
from pathlib import Path

try:
    from .generate_public_contract import (
        DEFAULT_OUTPUT,
        MANIFEST_SCHEMA,
        REPOSITORY_ROOT,
    )
except ImportError:
    from generate_public_contract import (  # type: ignore
        DEFAULT_OUTPUT,
        MANIFEST_SCHEMA,
        REPOSITORY_ROOT,
    )


BUILTIN_MANIFEST = REPOSITORY_ROOT / "data/lua/manifest.json"
EXAMPLE_ROOT = REPOSITORY_ROOT / "data/lua/examples/api_v5_mod"
EXAMPLE_MANIFEST = EXAMPLE_ROOT / "lua/manifest.json"
EXAMPLE_MODINFO = EXAMPLE_ROOT / "modinfo.json"
EXAMPLE_CONTRACT_IDS = {
    "events.emit",
    "events.on",
    "game.action_menu.register",
    "game.actions.context_snapshot",
    "game.add_msg",
    "game.hooks.on",
    "game.native_events.on",
    "game.time.snapshot",
    "game.weather.current",
    "i18n.gettext",
    "modules.source_id",
    "registry.list",
    "scheduler.after",
    "scheduler.now",
    "services.call",
    "services.provide",
    "sidebar.register_widget",
    "state.character.get",
    "state.character.set",
    "state.page.get",
    "state.page.set",
    "ui.open",
    "ui.page",
}


if __name__ == "__main__":
    raise SystemExit(main())