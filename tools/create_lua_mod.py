#!/usr/bin/env python3
"""Create an author-owned, zero-JSON Lua-first Platform Mod."""

from __future__ import annotations

import argparse
import shutil
import tempfile
from pathlib import Path


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]
TEMPLATE_ROOT = REPOSITORY_ROOT / "data" / "lua" / "templates"
MOD_ID_TOKEN = "__CCB_LUA_FIRST_MOD_ID__"


def normalized_mod_id(target: Path) -> str:
    candidate = target.name
    if (
        not candidate
        or "#" in candidate
        or any(character.isspace() for character in candidate)
    ):
        raise ValueError(
            "target directory name becomes the Mod id and must be non-empty "
            "without '#'/whitespace"
        )
    return candidate


def lua_quote(value: str) -> str:
    escaped = (
        value.replace("\\", "\\\\")
        .replace("\n", "\\n")
        .replace("\r", "\\r")
        .replace("\t", "\\t")
        .replace('"', '\\"')
    )
    return f'"{escaped}"'


def render_template_file(source: Path, destination: Path, mod_id: str) -> None:
    destination.parent.mkdir(parents=True, exist_ok=True)
    if source.suffix in {".lua", ".md"}:
        contents = source.read_text(encoding="utf-8")
        destination.write_text(
            contents.replace(MOD_ID_TOKEN, lua_quote(mod_id)),
            encoding="utf-8",
        )
    else:
        shutil.copyfile(source, destination)


def _install_staged_directory(staging: Path, target: Path) -> None:
    staging.replace(target)


def create_mod(target: Path, template: str) -> None:
    source = TEMPLATE_ROOT / template
    if not source.is_dir():
        raise ValueError(f"unknown Lua-first template: {template}")
    mod_id = normalized_mod_id(target)
    if target.is_symlink():
        raise FileExistsError(f"target must not be a symbolic link: {target}")
    had_empty_target = target.exists()
    target_identity: tuple[int, int] | None = None
    if had_empty_target:
        if not target.is_dir():
            raise FileExistsError(f"target is not a directory: {target}")
        if any(target.iterdir()):
            raise FileExistsError(f"target directory is not empty: {target}")
        target_stat = target.stat()
        target_identity = (target_stat.st_dev, target_stat.st_ino)
    target.parent.mkdir(parents=True, exist_ok=True)
    staging = Path(
        tempfile.mkdtemp(
            prefix=f".{target.name}.lua-first-", dir=target.parent
        )
    )
    try:
        for entry in sorted(source.rglob("*")):
            relative = entry.relative_to(source)
            destination = staging / relative
            if entry.is_dir():
                destination.mkdir(parents=True, exist_ok=True)
            elif entry.is_file():
                render_template_file(entry, destination, mod_id)
            else:
                raise ValueError(f"unsupported template entry: {entry}")
        removed_empty_target = False
        if target.exists() or target.is_symlink():
            if target.is_symlink() or not had_empty_target:
                raise FileExistsError(
                    f"target appeared while the scaffold was being prepared: {target}"
                )
            current_stat = target.stat()
            if (current_stat.st_dev, current_stat.st_ino) != target_identity:
                raise FileExistsError(
                    f"target changed while the scaffold was being prepared: {target}"
                )
            # The target was proven empty above.  If an author or another
            # process adds a file meanwhile, rmdir fails and preserves it.
            target.rmdir()
            removed_empty_target = True
        try:
            _install_staged_directory(staging, target)
        except Exception:
            # Preserve the caller's pre-existing empty directory when the
            # final same-filesystem installation itself fails.  Never replace
            # a path concurrently recreated by somebody else.
            if (
                had_empty_target
                and removed_empty_target
                and not target.exists()
                and not target.is_symlink()
            ):
                target.mkdir()
            raise
    except Exception:
        shutil.rmtree(staging, ignore_errors=True)
        raise


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Create a manifest-free Lua-first Platform Mod"
    )
    parser.add_argument("target", type=Path)
    parser.add_argument(
        "--template", choices=("minimal", "complete"), default="minimal"
    )
    args = parser.parse_args()
    try:
        create_mod(args.target, args.template)
    except (FileExistsError, OSError, ValueError) as error:
        parser.error(str(error))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
