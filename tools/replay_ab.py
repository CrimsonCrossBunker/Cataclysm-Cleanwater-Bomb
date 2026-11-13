#!/usr/bin/env python3
"""Compare isolated native replay runs using file contents, not timestamps.

Legacy --bin runs the same executable twice. Add --candidate-bin to compare two
builds using the same recording and starting user directory. Both SDL3 and
headless binaries can replay inputs; use --runtime-dir when assets are separate
from the executable. For example:

  python tools/replay_ab.py --bin /build/base/cataclysm-tiles \
      --candidate-bin /build/new/cataclysm-tiles --runtime-dir /checkout \
      --replay /fixtures/carrier.replay --userdir-template /fixtures/user \
      --world Carrier --report /results/comparison.json

Exit 0 means matching, changed saves; 1 means differing saves;
2 means invalid/inconclusive runs. Missing, empty or unchanged saves fail.
Every unsuccessful run retains its files and logs.
Add --expected-turns N to require the native --replay-report protocol and N
completed do_turn calls (calendar advancement is reported separately). Without
it, this only checks save bytes. Neither mode proves visual parity or speedup.
Process elapsed times include startup and saving and are only diagnostics.
"""

import argparse
import hashlib
import json
import math
from pathlib import Path
import shutil
import subprocess
import tempfile
import time


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def tree_manifest(root: Path) -> dict:
    """Read regular files, retain empty directories and reject links.

    Fixtures must be owned copies: following links during copy could read live
    saves or build caches. Do not descend into the protected local build cache.
    """
    if any(part.startswith("obj-lua") for part in root.parts):
        raise ValueError("protected build cache cannot be a fixture")
    if not root.is_dir() or root.is_symlink():
        raise ValueError(f"not a regular directory: {root}")
    result = {}
    pending = [root]
    while pending:
        directory = pending.pop()
        for path in sorted(directory.iterdir()):
            if path.name.startswith("obj-lua"):
                raise ValueError(f"protected build cache in fixture: {path}")
            relative = path.relative_to(root).as_posix()
            if path.is_symlink():
                raise ValueError(f"symlink in fixture/save tree: {path}")
            if path.is_dir():
                result[relative] = {"type": "directory"}
                pending.append(path)
            elif path.is_file():
                result[relative] = {
                    "type": "file",
                    "size": path.stat().st_size,
                    "sha256": sha256(path),
                }
            else:
                raise ValueError(f"not a regular file/directory: {path}")
    return dict(sorted(result.items()))


def manifest_digest(manifest: dict) -> str:
    encoded = json.dumps(
        manifest, sort_keys=True, separators=(",", ":")
    ).encode()
    return hashlib.sha256(encoded).hexdigest()


def diff_manifests(a: dict, b: dict) -> list[str]:
    result = []
    for name in sorted(a.keys() | b.keys()):
        if name not in b:
            result.append(f"only in A: {name}")
        elif name not in a:
            result.append(f"only in B: {name}")
        elif a[name] != b[name]:
            result.append(f"differs:   {name}")
    return result


def diff_trees(a: Path, b: Path) -> list[str]:
    return diff_manifests(tree_manifest(a), tree_manifest(b))


def player_saves(manifest: dict) -> dict:
    return {
        name: value
        for name, value in manifest.items()
        if name.endswith((".sav", ".sav.zzip")) and value["type"] == "file"
    }


def replay_metadata(path: Path) -> dict:
    """Record the header and event count; native code parses events."""
    profile_seed = None
    with path.open(encoding="utf-8") as stream:
        header = stream.readline().strip()
        if header not in ("CATA_REPLAY 1", "CATA_REPLAY 2", "CATA_REPLAY 3"):
            raise ValueError("replay must have a CATA_REPLAY 1, 2, or 3 header")
        seed_line = stream.readline().split()
        if len(seed_line) != 2 or seed_line[0] != "SEED":
            raise ValueError("replay must have a SEED header")
        seed = int(seed_line[1])
        if not 0 <= seed <= 0xFFFFFFFF:
            raise ValueError("replay seed must fit an unsigned 32-bit integer")
        if header != "CATA_REPLAY 1":
            fields = stream.readline().split()
            if (len(fields) != 2 or fields[0] != "PROFILE_SEED" or
                    len(fields[1]) != 32 or
                    any(c not in "0123456789abcdef" for c in fields[1])):
                raise ValueError(
                    "replay must have a valid PROFILE_SEED header")
            profile_seed = fields[1]
        events = sum(line.startswith("EV ") for line in stream)
    if not events:
        raise ValueError("replay has no input events")
    result = {
        "path": str(path),
        "sha256": sha256(path),
        "seed": seed,
        "recorded_events": events,
    }
    if profile_seed is not None:
        result["profile_seed"] = profile_seed
    return result


def read_native_completion(path: Path, replay: dict, turns: int) -> dict:
    """Require explicit completion; an OS exit status alone is insufficient."""
    if path.stat().st_size > 65536 + 256 * turns:
        raise ValueError("native completion report is unexpectedly large")
    result = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(result, dict):
        raise ValueError("native completion report must be an object")
    version = result.get("schema_version")
    if type(version) is not int or version not in (1, 2):
        raise ValueError(f"unsupported native schema_version: {version!r}")
    required = {
        "status": "complete", "seed": replay["seed"],
        "events_total": replay["recorded_events"], "events_remaining": 0,
        "input_failed": False, "game_started": True, "quit_saved": True,
        "completed_turn_calls": turns,
    }
    for key, value in required.items():
        actual = result.get(key)
        if type(actual) is not type(value) or actual != value:
            raise ValueError(
                f"native {key}: expected {value!r}, got {actual!r}")
    timings = result.get("turn_wall_ns")
    if (not isinstance(timings, list) or len(timings) != turns or
            any(type(value) is not int or value < 0 for value in timings)):
        raise ValueError("invalid native turn timings")
    for key in ("turn_start", "turn_end", "completion_wall_ns"):
        if type(result.get(key)) is not int:
            raise ValueError(f"invalid native {key}")
    if (result["completion_wall_ns"] < 0 or
            result["turn_end"] < result["turn_start"]):
        raise ValueError("invalid native time range")
    for key in ("initial_monsters", "final_monsters"):
        if type(result.get(key)) is not int or result[key] < 0:
            raise ValueError(f"invalid native {key}")
    for key in ("initial_position", "final_position"):
        value = result.get(key)
        if (not isinstance(value, list) or len(value) != 3 or
                any(type(coordinate) is not int for coordinate in value)):
            raise ValueError(f"invalid native {key}")
    if version == 2:
        positions = result.get("turn_positions")
        if (not isinstance(positions, list) or len(positions) != turns or
                any(not isinstance(point, list) or len(point) != 3 or
                    any(type(value) is not int for value in point)
                    for point in positions)):
            raise ValueError("invalid native turn_positions")
        if positions and positions[-1] != result["final_position"]:
            raise ValueError("native trajectory does not reach final_position")
    elif "turn_positions" in result:
        raise ValueError("native v1 report cannot declare a trajectory")
    return result


def run_once(
    binary: Path,
    replay: Path,
    userdir_src: Path,
    run_userdir: Path,
    world: str,
    extra_args: list[str],
    *,
    timeout: float = 300,
    runtime_dir: Path | None = None,
    completion_path: Path | None = None,
) -> dict:
    """Copy a fixture and run a process, retaining bounded-memory file logs."""
    copy_started = time.perf_counter()
    shutil.copytree(userdir_src, run_userdir)
    copy_seconds = time.perf_counter() - copy_started
    cmd = [
        str(binary),
        "--replay-play",
        str(replay),
        "--userdir",
        str(run_userdir) + "/",
    ]
    if world:
        cmd += ["--world", world]
    if completion_path is not None:
        cmd += ["--replay-report", str(completion_path)]
    cmd += extra_args
    stdout_path = run_userdir.parent / (run_userdir.name + ".stdout.log")
    stderr_path = run_userdir.parent / (run_userdir.name + ".stderr.log")
    record = {
        "command": cmd,
        "cwd": str(runtime_dir or binary.parent),
        "copy_seconds": copy_seconds,
        "returncode": None,
        "timed_out": False,
        "stdout": str(stdout_path),
        "stderr": str(stderr_path),
    }
    with stdout_path.open("wb") as stdout, stderr_path.open("wb") as stderr:
        started = time.perf_counter()
        try:
            proc = subprocess.run(
                cmd,
                cwd=runtime_dir or binary.parent,
                stdout=stdout,
                stderr=stderr,
                timeout=timeout,
            )
            record["returncode"] = proc.returncode
        except subprocess.TimeoutExpired:
            record["timed_out"] = True
        except OSError as error:
            record["error"] = str(error)
        record["process_wall_seconds"] = time.perf_counter() - started
    return record


def parser() -> argparse.ArgumentParser:
    ap = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    ap.add_argument(
        "--bin", required=True, type=Path, help="baseline executable"
    )
    ap.add_argument(
        "--candidate-bin",
        type=Path,
        help="candidate executable (default: repeat --bin)",
    )
    ap.add_argument("--replay", required=True, type=Path)
    ap.add_argument("--userdir-template", required=True, type=Path)
    ap.add_argument("--world", default="")
    ap.add_argument(
        "--invocation-seeds", nargs=2, metavar=("A", "B"),
        help="CLI seed strings for A/B; the recording must override both",
    )
    ap.add_argument(
        "--expected-turns", type=int,
        help="require native completion and this many completed do_turn calls",
    )
    ap.add_argument(
        "--runtime-dir", type=Path, help="working directory containing assets"
    )
    ap.add_argument(
        "--work-root", type=Path, help="existing parent for temporary runs"
    )
    ap.add_argument(
        "--report",
        type=Path,
        help="persistent JSON report outside the fixture",
    )
    ap.add_argument(
        "--timeout", type=float, default=300, help="seconds per process"
    )
    ap.add_argument(
        "--keep", action="store_true", help="also retain successful runs"
    )
    ap.add_argument("extra", nargs="*", help="shared game arguments after --")
    return ap


def main(argv: list[str] | None = None) -> int:
    ap = parser()
    args = ap.parse_args(argv)
    if not math.isfinite(args.timeout) or args.timeout <= 0:
        ap.error("--timeout must be finite and positive")
    if args.expected_turns is not None and args.expected_turns < 0:
        ap.error("--expected-turns must be nonnegative")
    binaries = [args.bin.resolve(), (args.candidate_bin or args.bin).resolve()]
    for binary in binaries:
        if not binary.is_file():
            ap.error(f"binary not found: {binary}")
    replay = args.replay.resolve()
    template = args.userdir_template.resolve()
    for name in ("runtime_dir", "work_root"):
        value = getattr(args, name)
        if value is not None:
            value = value.resolve()
            if not value.is_dir():
                ap.error(f"not a directory: {value}")
            setattr(args, name, value)
    if args.work_root is not None and args.work_root.is_relative_to(template):
        ap.error("--work-root must be outside the fixture")
    protected_options = {
        "--userdir",
        "--configdir",
        "--savedir",
        "--world",
        "--replay-play",
        "--replay-record",
        "--replay-report",
    }
    if any(arg.split("=", 1)[0] in protected_options for arg in args.extra):
        ap.error(
            "extra arguments must not override replay, world "
            "or isolated directories"
        )
    if args.invocation_seeds and any(
        arg.split("=", 1)[0] == "--seed" for arg in args.extra
    ):
        ap.error("--invocation-seeds cannot be combined with extra --seed")
    report_path = args.report.resolve() if args.report else None
    if report_path and (
        report_path.is_relative_to(template) or
        report_path in binaries + [replay]
    ):
        ap.error("--report must not overwrite inputs or be inside the fixture")
    try:
        replay_info = replay_metadata(replay)
        fixture = tree_manifest(template)
        initial_saves = tree_manifest(template / "save")
        players = player_saves(initial_saves)
        if not players or any(
            value["size"] == 0 for value in players.values()
        ):
            raise ValueError(
                "fixture needs nonempty player .sav/.sav.zzip files "
                "under save/"
            )
        binary_hashes = {str(path): sha256(path) for path in set(binaries)}
    except (OSError, ValueError) as error:
        ap.error(str(error))

    work = Path(tempfile.mkdtemp(prefix="replay_ab_", dir=args.work_root))
    report = {
        "schema_version": 1,
        "status": "invalid",
        "work_directory": str(work),
        "validated_scope": (
            "changed save bytes only; "
            "not turn, visual or performance acceptance"
        ),
        "timing_scope": (
            "process wall time includes startup and saving; "
            "not a speedup estimate"
        ),
        "binary_sha256": binary_hashes,
        "replay": replay_info,
        "fixture_sha256": manifest_digest(fixture),
        "runs": [],
        "errors": [],
    }
    if args.expected_turns is not None:
        report["expected_turns"] = args.expected_turns
        report["validated_scope"] = (
            "native completion, observed turn calls and matching changed save "
            "bytes; not visual, full semantic or performance acceptance"
        )
    exit_code = 2
    try:
        for label, binary in zip(("A", "B"), binaries):
            print(f"[A/B] run {label}: {binary}")
            extra_args = list(args.extra)
            if args.invocation_seeds:
                extra_args += ["--seed",
                               args.invocation_seeds[0 if label == "A" else 1]]
            record = run_once(
                binary,
                replay,
                template,
                work / label,
                args.world,
                extra_args,
                timeout=args.timeout,
                runtime_dir=args.runtime_dir,
                completion_path=(work / f"{label}.completion.json"
                                 if args.expected_turns is not None else None),
            )
            report["runs"].append({"label": label, **record})
        for run in report["runs"]:
            if run["returncode"] != 0:
                report["errors"].append(
                    f"run {run['label']} failed or timed out"
                )
        if (
            tree_manifest(template) != fixture or
            sha256(replay) != replay_info["sha256"]
        ):
            report["errors"].append(
                "fixture or replay changed during comparison"
            )
        if any(
            sha256(Path(path)) != digest
            for path, digest in binary_hashes.items()
        ):
            report["errors"].append("executable changed during comparison")
        if not report["errors"]:
            if args.expected_turns is not None:
                for run in report["runs"]:
                    run["native_completion"] = read_native_completion(
                        work / f"{run['label']}.completion.json",
                        replay_info, args.expected_turns,
                    )
            saves = [
                tree_manifest(work / label / "save") for label in ("A", "B")
            ]
            for run, manifest in zip(report["runs"], saves):
                run["save_sha256"] = manifest_digest(manifest)
                current_players = player_saves(manifest)
                if not current_players or any(
                    v["size"] == 0 for v in current_players.values()
                ):
                    report["errors"].append(
                        f"run {run['label']} has missing/empty player saves"
                    )
                elif current_players == player_saves(initial_saves):
                    report["errors"].append(
                        f"run {run['label']} left player saves unchanged"
                    )
            if not report["errors"]:
                report["differences"] = diff_manifests(*saves)
                if args.expected_turns is not None:
                    a, b = [r["native_completion"] for r in report["runs"]]
                    for key in ("schema_version", "turn_positions",
                                "turn_start", "turn_end", "initial_position",
                                "final_position", "initial_monsters",
                                "final_monsters"):
                        if a.get(key) != b.get(key):
                            report["differences"].append(
                                f"native differs: {key}")
                exit_code = 1 if report["differences"] else 0
                report["status"] = (
                    "save_mismatch" if exit_code else "save_match"
                )
    except (OSError, ValueError) as error:
        report["errors"].append(str(error))
    finally:
        retain = args.keep or exit_code != 0
        report["work_retained"] = retain
        (work / "report.json").write_text(json.dumps(report, indent=2) + "\n")
        if report_path:
            report_path.parent.mkdir(parents=True, exist_ok=True)
            report_path.write_text(json.dumps(report, indent=2) + "\n")
        if not retain:
            shutil.rmtree(work)
    print(
        f"[A/B] {report['status']}: "
        f"{len(report.get('differences', []))} differing paths; "
        f"{len(report['errors'])} errors"
    )
    for error in report["errors"]:
        print(f"  {error}")
    if report["work_retained"]:
        print(f"[A/B] retained logs, saves and report: {work}")
    return exit_code


if __name__ == "__main__":
    raise SystemExit(main())
