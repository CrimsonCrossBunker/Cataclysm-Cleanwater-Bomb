#!/usr/bin/env python3
"""Deterministic replay A/B harness (sim/render decoupling plan, phase 0.5).

Runs the headless Cataclysm binary twice over the SAME recorded input log and
the SAME starting world, then diffs the two resulting save trees. If the build
is deterministic, the two saves are byte-identical and this exits 0. Any diff
pinpoints exactly which save file (and thus which subsystem) drifted -- that is
the empirical signal we use to decide what, if anything, needs a determinism
fix, instead of trusting a theoretical audit.

This does NOT try to fix non-determinism. It only measures it.

Typical use:
  1. Record a session interactively (tiles build):
       cataclysm-tiles --replay-record run.replay --world TestWorld
  2. A/B the recording headlessly:
       python tools/replay_ab.py \
           --bin build/cataclysm-headless.exe \
           --replay run.replay \
           --userdir-template saves/TestWorld_userdir

The --userdir-template is a prepared user directory (containing the save to
load) that is copied fresh for each of the two runs so they start identical.
"""

import argparse
import filecmp
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path


def run_once(binary: Path, replay: Path, userdir_src: Path, run_userdir: Path,
             world: str, extra_args: list[str]) -> int:
    """Copy the template userdir, run one headless replay into it."""
    shutil.copytree(userdir_src, run_userdir)
    cmd = [
        str(binary),
        "--replay-play", str(replay),
        "--userdir", str(run_userdir) + "/",
    ]
    if world:
        cmd += ["--world", world]
    cmd += extra_args
    print(f"  $ {' '.join(cmd)}")
    try:
        proc = subprocess.run(cmd, capture_output=True, text=True, cwd=str(binary.parent),
                              timeout=300)
    except subprocess.TimeoutExpired:
        sys.stderr.write(f"[A/B] TIMEOUT: binary did not exit within 300 s\n")
        return -1
    if proc.returncode != 0:
        sys.stderr.write(proc.stdout)
        sys.stderr.write(proc.stderr)
    return proc.returncode


def diff_trees(a: Path, b: Path) -> list[str]:
    """Return a list of human-readable difference descriptions between two save dirs."""
    diffs: list[str] = []

    def walk(cmp_obj: filecmp.dircmp, rel: str) -> None:
        for name in cmp_obj.left_only:
            diffs.append(f"only in A: {rel}{name}")
        for name in cmp_obj.right_only:
            diffs.append(f"only in B: {rel}{name}")
        for name in cmp_obj.diff_files:
            diffs.append(f"differs:   {rel}{name}")
        for name in cmp_obj.funny_files:
            diffs.append(f"unreadable: {rel}{name}")
        for sub_name, sub in cmp_obj.subdirs.items():
            walk(sub, f"{rel}{sub_name}/")

    # shallow=True (default): uses os.stat before content comparison.
    # For compressed binary saves, size differs whenever content differs, so
    # this is correct in practice and avoids reading large files unnecessarily.
    walk(filecmp.dircmp(a, b), "")
    return diffs


def find_save_dir(userdir: Path) -> Path:
    save = userdir / "save"
    return save if save.is_dir() else userdir


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--bin", required=True, type=Path,
                    help="path to the headless cataclysm binary")
    ap.add_argument("--replay", required=True, type=Path,
                    help="recorded .replay input log")
    ap.add_argument("--userdir-template", required=True, type=Path,
                    help="prepared user directory (with the save to load) copied per run")
    ap.add_argument("--world", default="",
                    help="world name to auto-load on startup")
    ap.add_argument("--keep", action="store_true",
                    help="keep the two run directories for inspection")
    ap.add_argument("extra", nargs="*",
                    help="extra args passed through to the binary")
    args = ap.parse_args()

    if not args.bin.exists():
        ap.error(f"binary not found: {args.bin}")
    if not args.replay.exists():
        ap.error(f"replay log not found: {args.replay}")
    if not args.userdir_template.is_dir():
        ap.error(f"userdir template not found: {args.userdir_template}")

    # Resolve to absolute paths: each run executes with the binary's own dir as
    # cwd (so it finds data/, gfx/ etc.), which would break relative paths.
    args.bin = args.bin.resolve()
    args.replay = args.replay.resolve()
    args.userdir_template = args.userdir_template.resolve()

    work = Path(tempfile.mkdtemp(prefix="replay_ab_"))
    run_a = work / "A"
    run_b = work / "B"
    try:
        print("[A/B] run A")
        rc_a = run_once(args.bin, args.replay, args.userdir_template, run_a,
                        args.world, args.extra)
        print("[A/B] run B")
        rc_b = run_once(args.bin, args.replay, args.userdir_template, run_b,
                        args.world, args.extra)

        if rc_a != 0 or rc_b != 0:
            print(f"[A/B] FAIL: a run exited non-zero (A={rc_a}, B={rc_b})")
            return 2

        diffs = diff_trees(find_save_dir(run_a), find_save_dir(run_b))
        if not diffs:
            print("[A/B] PASS: save trees are byte-identical. Build is deterministic "
                  "for this recording.")
            return 0

        print(f"[A/B] DRIFT: {len(diffs)} difference(s) -- these name the "
              f"non-deterministic subsystem(s):")
        for d in diffs:
            print(f"    {d}")
        print(f"[A/B] run dirs kept at {work} for inspection.")
        args.keep = True
        return 1
    finally:
        if not args.keep:
            shutil.rmtree(work, ignore_errors=True)


if __name__ == "__main__":
    sys.exit(main())
