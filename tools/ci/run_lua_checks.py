#!/usr/bin/env python3
"""Run the Lua checks affected by a CI change, without building the engine."""

from __future__ import annotations

import argparse
import ast
import json
import os
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
TOOLS = ROOT / "tools/lua_api"
WORKFLOW = ".github/workflows/lua-contract.yml"
BUILD_INPUTS = {
    "CMakeLists.txt", "Makefile", "tests/CMakeLists.txt", "tests/Makefile",
    "tests/test_support_sources.txt", "src/CMakeLists.txt",
    "src/lua/CMakeLists.txt", "src/sol/config.hpp", "src/main.cpp",
    "src/init.cpp",
}
SCAFFOLD_INPUTS = {
    "tools/create_lua_mod.py", "tools/test_create_lua_mod.py",
    "tools/lua_api/mod_sdk.py", "tools/lua_api/test_mod_sdk.py",
}
CONTRACT_CHECKS = [
    "check_luals_declarations", "check_platform_native_inventory",
    "check_platform_contract", "check_platform_coverage",
]


def affected_tool_tests(changed: set[str]) -> list[str]:
    """Follow local imports so generator/checker dependencies stay together."""
    if not changed:
        return []
    modules = {path.stem: path for path in TOOLS.glob("*.py")}
    tests = {name for name in modules if name.startswith("test_")}
    if changed - modules.keys():
        return sorted(tests)  # Includes removed/renamed tools.
    dependencies = {}
    for name, path in modules.items():
        imports = set()
        for node in ast.walk(ast.parse(path.read_text(encoding="utf-8"))):
            if isinstance(node, ast.Import):
                imports.update(
                    alias.name.split(".")[-1] for alias in node.names)
            elif isinstance(node, ast.ImportFrom):
                if node.module:
                    imports.add(node.module.split(".")[-1])
                else:
                    imports.update(alias.name for alias in node.names)
        dependencies[name] = imports & modules.keys()
    affected = set(changed)
    while True:
        dependants = {name for name, imports in dependencies.items()
                      if imports & affected}
        expanded = affected | dependants
        if expanded == affected:
            return sorted(tests & affected)
        affected = expanded


def select_checks(paths: list[str] | None) -> dict:
    full = paths is None or WORKFLOW in paths or any(
        path in {"tools/ci/run_lua_checks.py",
                 "tools/ci/test_run_lua_checks.py",
                 "tools/lua_api/requirements.txt"}
        for path in paths)
    paths = paths or []
    api = full or any(
        path.startswith(("data/lua/types/", "data/lua/reference/",
                         "src/lua_platform")) or
        path in {"src/event.h", "src/init.cpp"}
        for path in paths)
    build = full or bool(set(paths) & BUILD_INPUTS)
    scaffold = full or any(
        path.startswith("data/lua/templates/") or
        path in SCAFFOLD_INPUTS
        for path in paths)
    editor = full or scaffold or any(
        path.startswith("data/lua/types/") for path in paths)
    changed_tools = {
        Path(path).stem for path in paths
        if path.startswith("tools/lua_api/") and path.endswith(".py")}
    tool_tests = affected_tool_tests(
        {path.stem for path in TOOLS.glob("*.py")} if full else changed_tools)
    # Changing build selection must exercise actual Make/CMake selection, too.
    if build and "test_check_cmake_contract" not in tool_tests:
        tool_tests.append("test_check_cmake_contract")
    editor = editor or "test_mod_sdk" in tool_tests
    tests = {"tools.lua_api." + name for name in tool_tests}
    if full:
        tests.add("tools.ci.test_run_lua_checks")
    if editor and "tools.lua_api.test_mod_sdk" not in tests:
        tests.add("tools.lua_api.test_mod_sdk."
                  "LuaLanguageServerIntegrationTest")
    if scaffold:
        tests.add("tools.test_create_lua_mod")
    checks = list(CONTRACT_CHECKS if api else [])
    if build:
        checks.append("check_cmake_contract")
    # Checker regression modules already execute their repository check.
    checks = [name for name in checks
              if "tools.lua_api.test_" + name not in tests]
    return {"checks": checks, "tests": sorted(tests), "editor": editor}


def changed_paths() -> list[str] | None:
    event_name = os.environ.get("GITHUB_EVENT_NAME")
    if event_name == "pull_request":
        # actions/checkout fetch-depth=2 supplies the merge's base parent.
        base = "HEAD^1"
    elif event_name == "push":
        event = json.loads(Path(os.environ["GITHUB_EVENT_PATH"]).read_text())
        base = event.get("before", "")
        if len(base) != 40 or any(c not in "0123456789abcdef" for c in base):
            return None
        if base == "0" * 40:
            return None
        if subprocess.run(["git", "cat-file", "-e", base + "^{commit}"],
                          cwd=ROOT, capture_output=True).returncode:
            if subprocess.run(["git", "fetch", "--no-tags", "--depth=1",
                               "origin", base], cwd=ROOT).returncode:
                return None
    else:
        return None  # Manual acceptance or unavailable change history.
    result = subprocess.run([
        "git", "diff", "--name-only", "-z", base, "HEAD", "--", ".",
        ":!obj-lua", ":!obj-lua/**",
    ], cwd=ROOT, capture_output=True)
    if result.returncode:
        return None
    return [path for path in result.stdout.decode("utf-8").split("\0") if path]


def run_checks(plan: dict) -> None:
    if plan["editor"] and not os.environ.get("CCB_LUALS"):
        raise RuntimeError("selected editor checks require CCB_LUALS")
    for name in plan["checks"]:
        subprocess.run([sys.executable, str(TOOLS / (name + ".py"))],
                       cwd=ROOT, check=True)
    if plan["tests"]:
        environment = os.environ.copy()
        # Preserve script-style imports in the existing tool regression tests.
        paths = [str(TOOLS), str(ROOT / "tools")]
        if environment.get("PYTHONPATH"):
            paths.append(environment["PYTHONPATH"])
        environment["PYTHONPATH"] = os.pathsep.join(paths)
        subprocess.run([sys.executable, "-m", "unittest", *plan["tests"]],
                       cwd=ROOT, env=environment, check=True)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--plan", type=Path, required=True)
    parser.add_argument("--run", action="store_true")
    parser.add_argument("--github-output", type=Path)
    args = parser.parse_args()
    if args.run:
        run_checks(json.loads(args.plan.read_text()))
    else:
        plan = select_checks(changed_paths())
        args.plan.write_text(json.dumps(plan) + "\n", encoding="utf-8")
        print(json.dumps(plan, indent=2))
        if args.github_output:
            with args.github_output.open("a", encoding="utf-8") as output:
                output.write("editor=" + str(plan["editor"]).lower() + "\n")
                required = bool(plan["checks"] or plan["tests"])
                output.write("checks=" + str(required).lower() + "\n")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
