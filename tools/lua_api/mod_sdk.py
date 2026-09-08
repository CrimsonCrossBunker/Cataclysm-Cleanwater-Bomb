#!/usr/bin/env python3
"""Snapshot CCB declarations, compare upgrades, and report LuaLS errors."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import tempfile
from pathlib import Path
from urllib.parse import urlparse
from urllib.request import url2pathname

ROOT = Path(__file__).resolve().parents[2]
DEFAULT_DECLARATIONS = ROOT / "data/lua/types/ccb_platform_v1.d.lua"
SDK_DIRECTORY = ".ccb-sdk"


def digest(contents: bytes) -> str:
    return hashlib.sha256(contents).hexdigest()


def write_editor_files(target: Path, declarations: Path) -> None:
    """Write only inside an unpublished scaffold or SDK staging directory."""
    contents = declarations.read_bytes()
    text = contents.decode("utf-8")
    if "---@class CcbPlatformV1" not in text or "return ccb" not in text:
        raise ValueError("expected CCB Platform v1 LuaLS declarations")
    sdk = target / SDK_DIRECTORY
    sdk.mkdir()
    # The editor resolves require("ccb") from this library file. The game
    # resolves its own reserved module and never loads this metadata file.
    (sdk / "ccb.lua").write_bytes(contents)
    metadata = {
        "schema_version": 1,
        "platform_version": 1,
        "lua_version": "5.4",
        "declarations_sha256": digest(contents),
    }
    (sdk / "version.json").write_text(
        json.dumps(metadata, indent=2) + "\n", encoding="utf-8"
    )
    settings = {
        "$schema": ("https://raw.githubusercontent.com/LuaLS/"
                    "vscode-lua/master/setting/schema.json"),
        "runtime.version": "Lua 5.4",
        "runtime.path": ["?.lua", "?/init.lua"],
        "workspace.library": [SDK_DIRECTORY],
        "workspace.ignoreDir": [SDK_DIRECTORY],
        "workspace.checkThirdParty": False,
        "diagnostics.libraryFiles": "Disable",
    }
    (target / ".luarc.json").write_text(
        json.dumps(settings, indent=2) + "\n", encoding="utf-8"
    )


def initialize_sdk(mod: Path, declarations: Path) -> dict:
    """Add editor metadata without replacing existing author files."""
    mod = mod.resolve(strict=True)
    if not mod.is_dir():
        raise ValueError(f"{mod}: expected an existing Mod directory")
    sdk = mod / SDK_DIRECTORY
    for destination in (sdk, mod / ".luarc.json"):
        if destination.exists() or destination.is_symlink():
            raise ValueError(
                f"{destination}: already exists; "
                "keep or integrate the existing editor setup")
    with tempfile.TemporaryDirectory(prefix="ccb-sdk-init-") as directory:
        staging = Path(directory)
        write_editor_files(staging, declarations)
        created = []
        # Exclusive reservation; never adopt an existing directory.
        sdk.mkdir()
        try:
            for relative in (
                    Path(SDK_DIRECTORY) / "ccb.lua",
                    Path(SDK_DIRECTORY) / "version.json",
                    Path(".luarc.json")):
                destination = mod / relative
                with destination.open("xb") as stream:
                    created.append(destination)
                    stream.write((staging / relative).read_bytes())
            return read_sdk(mod)[0]
        except BaseException:
            # Remove only files created by this attempt; preserve a raced
            # config.
            for destination in reversed(created):
                destination.unlink(missing_ok=True)
            try:
                sdk.rmdir()
            except OSError:
                # Do not remove any unexpected files added by another process.
                pass
            raise


def read_sdk(mod: Path) -> tuple[dict, str]:
    sdk = mod / SDK_DIRECTORY
    metadata = json.loads((sdk / "version.json").read_text(encoding="utf-8"))
    if (not isinstance(metadata, dict) or
            type(metadata.get("schema_version")) is not int or
            metadata["schema_version"] != 1):
        raise ValueError(f"{sdk}: unsupported SDK metadata format")
    if (type(metadata.get("platform_version")) is not int or
            metadata["platform_version"] != 1 or
            metadata.get("lua_version") != "5.4"):
        raise ValueError(
            f"{sdk}: unsupported Platform/Lua version in SDK metadata")
    contents = (sdk / "ccb.lua").read_bytes()
    if metadata.get("declarations_sha256") != digest(contents):
        raise ValueError(f"{sdk}: declaration checksum mismatch")
    return metadata, contents.decode("utf-8")


def declaration_surface(text: str) -> dict[str, list[str]]:
    """Compare annotations as declarations, not as a proof of compatibility."""
    result: dict[str, list[str]] = {}
    owner = ""
    annotations: list[str] = []
    alias_lines: list[str] | None = None
    for line in text.splitlines():
        line = line.strip()
        if line.startswith("---|") and alias_lines is not None:
            alias_lines.append(line)
            continue
        alias_lines = None
        match = re.match(r"---@class\s+(\w+)", line)
        if match:
            owner = match[1]
            result.setdefault(f"class {owner}", []).append(line)
            annotations = []
            continue
        match = re.match(r"---@alias\s+(\w+)", line)
        if match:
            alias_lines = [line]
            result[f"alias {match[1]}"] = alias_lines
            annotations = []
            continue
        if line.startswith("---@operator") and owner:
            result.setdefault(f"class {owner}", []).append(line)
            continue
        match = re.match(r"---@field\s+(\w+)\??\s+", line)
        if match and owner:
            result.setdefault(f"{owner}.{match[1]}", []).append(line)
            continue
        if line.startswith(("---@param", "---@return", "---@overload",
                            "---@deprecated", "---@generic")):
            annotations.append(line)
            continue
        match = re.match(r"function\s+(\w+[.:]\w+)\s*\(", line)
        if match:
            result.setdefault(match[1], []).extend(annotations + [line])
            annotations = []
        elif line and not line.startswith("--"):
            annotations = []
    return result


def compare_sdks(old: Path, new: Path) -> dict:
    old_metadata, old_text = read_sdk(old)
    new_metadata, new_text = read_sdk(new)
    return compare_declarations(old_metadata, old_text, new_metadata, new_text)


def compare_release(mod: Path, declarations: Path) -> dict:
    """Compare against an explicitly selected game file, without a scaffold."""
    old_metadata, old_text = read_sdk(mod)
    content = declarations.read_bytes()
    new_text = content.decode("utf-8")
    if ("---@class CcbPlatformV1" not in new_text or
            "return ccb" not in new_text):
        raise ValueError("expected CCB Platform v1 LuaLS declarations")
    new_metadata = {
        "schema_version": 1,
        "platform_version": 1,
        "lua_version": "5.4",
        "declarations_sha256": digest(content),
    }
    report = compare_declarations(
        old_metadata, old_text, new_metadata, new_text)
    report["target_declarations"] = str(declarations.resolve())
    return report


def compare_declarations(old_metadata: dict, old_text: str,
                         new_metadata: dict, new_text: str) -> dict:
    before = declaration_surface(old_text)
    after = declaration_surface(new_text)
    return {
        "old": old_metadata,
        "new": new_metadata,
        "added": sorted(after.keys() - before.keys()),
        "removed": sorted(before.keys() - after.keys()),
        "changed": {
            name: {"before": before[name], "after": after[name]}
            for name in sorted(before.keys() & after.keys())
            if before[name] != after[name]
        },
        "note": "Declaration changes require review; unchanged signatures do "
                "not prove runtime or save compatibility.",
    }


def check_mod(mod: Path, language_server: str) -> list[str]:
    """Use the author's pinned SDK/config; never run the game or Mod entry."""
    mod = mod.resolve()
    read_sdk(mod)
    if not (mod / ".luarc.json").is_file():
        raise ValueError(f"{mod}: missing .luarc.json editor configuration")
    with tempfile.TemporaryDirectory(prefix="ccb-luals-") as directory:
        result = subprocess.run(
            [language_server, "--check=" + str(mod), "--checklevel=Warning",
             "--check_format=json",
             "--configpath=" + str(mod / ".luarc.json"),
             "--logpath=" + directory],
            cwd=mod, capture_output=True, text=True, timeout=120,
        )
        if result.returncode < 0:
            raise RuntimeError(
                f"LuaLS exited {result.returncode} "
                "before completing diagnostics: " +
                (result.stderr or result.stdout)[-2000:]
            )
        report = Path(directory) / "check.json"
        if not report.is_file():
            raise RuntimeError(
                "LuaLS produced no diagnostic report "
                f"(exit {result.returncode}): " +
                (result.stderr or result.stdout)[-2000:]
            )
        data = json.loads(report.read_text(encoding="utf-8"))
        if data == []:
            data = {}  # LuaLS serializes an empty Lua table as a JSON array.
        if not isinstance(data, dict):
            raise ValueError("LuaLS report must map file URIs to diagnostics")
        diagnostics = []
        for uri, entries in sorted(data.items()):
            if not isinstance(entries, list):
                raise ValueError(
                    f"LuaLS report for {uri}: expected diagnostic array")
            for index, entry in enumerate(entries):
                location = f"LuaLS report for {uri}, diagnostic {index}"
                if not isinstance(
                        entry, dict) or not isinstance(
                        entry.get("message"), str):
                    raise ValueError(f"{location}: missing diagnostic message")
                span = entry.get("range")
                start = span.get("start") if isinstance(span, dict) else None
                if not isinstance(start, dict):
                    raise ValueError(f"{location}: missing start position")
                if any(not isinstance(start.get(key), int) or
                       isinstance(start[key], bool) or start[key] < 0
                       for key in ("line", "character")):
                    raise ValueError(f"{location}: invalid start position")
            path = uri
            if uri.startswith("file:"):
                parsed = urlparse(uri)
                host = parsed.netloc if parsed.netloc != "localhost" else ""
                path = url2pathname(
                    ("//" + host if host else "") + parsed.path
                )
            for entry in sorted(entries, key=lambda e: (
                e["range"]["start"]["line"],
                e["range"]["start"]["character"], str(e.get("code", "")),
            )):
                start = entry["range"]["start"]
                diagnostics.append(
                    f"{path}:{start['line'] + 1}:{start['character'] + 1}: "
                    f"{entry.get('code', 'diagnostic')}: {entry['message']}"
                )
        if result.returncode != 0 and not diagnostics:
            raise RuntimeError(
                f"LuaLS exited {result.returncode} without diagnostics: " +
                (result.stderr or result.stdout)[-2000:]
            )
        return diagnostics


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest="command", required=True)
    initialize = commands.add_parser(
        "init", help="add an editor SDK to an existing Mod directory")
    initialize.add_argument("mod", type=Path)
    initialize.add_argument(
        "--declarations",
        type=Path,
        default=DEFAULT_DECLARATIONS,
        help="declaration file from the target game package")
    compare = commands.add_parser(
        "compare", help="compare two Mod SDK snapshots"
    )
    compare.add_argument("old", type=Path)
    compare.add_argument("new", type=Path)
    release = commands.add_parser(
        "compare-release", help="compare an SDK with target game declarations"
    )
    release.add_argument("mod", type=Path)
    release.add_argument("--declarations", type=Path, required=True,
                         help="declaration file from the target game package")
    check = commands.add_parser(
        "check", help="report LuaLS warnings and errors"
    )
    check.add_argument("mod", type=Path)
    check.add_argument("--language-server", default="lua-language-server")
    args = parser.parse_args()
    try:
        if args.command == "init":
            metadata = initialize_sdk(args.mod, args.declarations)
            print(json.dumps(
                {"mod": str(args.mod.resolve()), "sdk": metadata}, indent=2))
            return 0
        if args.command == "compare":
            print(json.dumps(compare_sdks(args.old, args.new),
                             ensure_ascii=False, indent=2))
            return 0
        if args.command == "compare-release":
            print(json.dumps(compare_release(args.mod, args.declarations),
                             ensure_ascii=False, indent=2))
            return 0
        diagnostics = check_mod(args.mod, args.language_server)
        for diagnostic in diagnostics:
            print(diagnostic)
        print(f"LuaLS: {len(diagnostics)} diagnostic(s)")
        return 1 if diagnostics else 0
    except (OSError, ValueError, RuntimeError,
            subprocess.TimeoutExpired) as error:
        parser.exit(2, f"Mod SDK: {error}\n")


if __name__ == "__main__":
    raise SystemExit(main())
