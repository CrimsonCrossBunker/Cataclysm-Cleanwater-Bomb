#!/usr/bin/env bash

set -euo pipefail

lua_ui_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
lua_ui_user_dir="$lua_ui_root/.codex-build/lua-user"

mkdir -p -- "$lua_ui_user_dir"

exec "$lua_ui_root/.codex-build/linux-lua-sdl2/src/cataclysm-tiles" \
    --basepath "$lua_ui_root" \
    --userdir "$lua_ui_user_dir" \
    "$@"
