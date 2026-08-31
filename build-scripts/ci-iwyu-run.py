# This file is intended to be run on github CI, not locally
# It only exists because I found it way too hard to present nice
# log output *while* maintaining the correct exit status in bash.
#
# Arguably this is 3x as much code as a bash equivalent, but I
# appeal to maintanability.
#
# For local development on linux, use the following command line
# (assuming both the iwyu source root and its build dir are in the PATH):
# python iwyu_tool.py \
#     $(find src/ tests/ -maxdepth 1 -name '*.cpp' \
#           | grep -v -f tools/iwyu/bad_files.txt) \
#     -p build --jobs 4 -- \
#     -Xiwyu "--mapping_file=${PWD}/tools/iwyu/cata.imp" -Xiwyu --cxx17ns  \
#     -Xiwyu --comment_style=long -Xiwyu --max_line_length=1000

import argparse
import logging
import os
import subprocess
import sys

from pathlib import Path

# hardcoded paths that could probably be passed via command line
CHANGED_FILES_INDEX = "files_changed"
GET_AFFECTED_FILES_SCRIPT = "build-scripts/get_affected_files.py"
BLACKLIST_PATH = "tools/iwyu/bad_files.txt"
MARKER_FORCE_GLOBAL_RUN = "MARKER_CHECK_ALL"
BOUNDED_GLOBAL_FILES = [
    Path("src/point.cpp"),
    Path("src/item_category.cpp"),
    Path("tests/point_test.cpp"),
]
BOUNDED_GLOBAL_PATHS = {
    Path(".github/workflows/iwyu.yml"),
    Path("build-scripts/ci-iwyu-run.py"),
    Path("build-scripts/get_affected_files.py"),
    Path("tools/iwyu"),
    Path("CMakeLists.txt"),
    Path("src/CMakeLists.txt"),
    Path("tests/CMakeLists.txt"),
}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--iwyu_tool_path", default="iwyu_tool.py")
    args = parser.parse_args()

    print("::group::Determining files to analyze")

    # files directly changed in this PR
    changed_files = get_changed_files()
    enforced_files = get_enforced_files(changed_files)
    print("changed files:")
    print_long_list(changed_files)
    # files transitively impacted by the direct change above
    # (and also the directly changed files themselves)
    affected_files = get_affected_files(changed_files)
    print("affected files:")
    print_long_list(affected_files)
    # files that we feed to IWYU. This excludes files blacklisted for
    # whatever reason
    files_to_analyze = filter_analyzable_files(affected_files)
    print("files to analyze:")
    print_long_list(files_to_analyze)
    print("::endgroup::")

    if not files_to_analyze:
        print("Nothing to analyze!")
        sys.exit(0)

    # Run IWYU with the files provided. Forward its exit code.
    status = run_iwyu_on(
        args.iwyu_tool_path, files_to_analyze, enforced_files
    )
    sys.exit(status)


def get_changed_files() -> list[Path]:
    # The ci workflow places the list of files changed in the PR
    # into `./files_changed` file at the root of the project.
    files_index = Path(CHANGED_FILES_INDEX)
    if not files_index.exists():
        # Manual workflow dispatches intentionally omit the changed-file
        # index and request the full-repository audit.
        logging.debug(
            "no changed files index present. This is "
            "a manual full IWYU run. Will analyze the entire codebase.")
        return [Path(MARKER_FORCE_GLOBAL_RUN)]
    paths = []
    with open(files_index) as files_index:
        for line in files_index.readlines():
            line = line.strip()
            if not line:
                continue
            paths.append(Path(line))
    return paths


def is_bounded_global_path(path: Path) -> bool:
    return path.name == "CMakeLists.txt" or (
        path in BOUNDED_GLOBAL_PATHS or any(
            parent in BOUNDED_GLOBAL_PATHS
            for parent in path.parents
        )
    )


def get_enforced_files(changed_files: list[Path]) -> set[Path] | None:
    """Return PR-owned paths whose suggestions should fail the check.

    Manual runs return ``None`` so every full-baseline suggestion remains
    blocking.  Global PR configuration changes also enforce the deterministic
    representative set.
    """
    if Path(MARKER_FORCE_GLOBAL_RUN) in changed_files:
        return None
    enforced = set(changed_files)
    if any(is_bounded_global_path(path) for path in changed_files):
        enforced.update(BOUNDED_GLOBAL_FILES)
    return enforced


def get_affected_files(changed_files: list[Path]) -> list[Path]:
    # Only an explicit manual run requests the repository-wide baseline.
    # Global configuration changes in pull requests use a small deterministic
    # cross-section so the workflow cannot pass without analyzing any TU.
    bounded_global_change = None
    for changed in changed_files:
        if changed == Path(MARKER_FORCE_GLOBAL_RUN):
            print(
                "File %s requests the manual IWYU baseline so "
                "we will analyze all files" % changed)
            return generate_global_file_list()
        if is_bounded_global_path(changed):
            bounded_global_change = changed

    # Now, build-scripts/get_affected_files.py generates a list of
    # transitively affected files given a list of directly changed files.
    # This is exactly what we need.
    # Except, it requires the list of changed files to be supplied
    # to it via a file on disk, not via command-line.
    # And, if you think about it, we already have the list of changed
    # files on disk. That's `./files_changed`. So just reuse that.
    # Yes, this violates the function signature. But it is a bit less code.
    out = subprocess.run(
        [GET_AFFECTED_FILES_SCRIPT,
         "--changed-files-list", CHANGED_FILES_INDEX],
        capture_output=True, encoding="utf-8")
    if out.returncode != 0:
        print("get_affected_files.py returned with error code %d"
              % out.returncode,
              file=sys.stderr)
        print("stdout:\n  %s" % out.stdout, file=sys.stderr)
        print("stderr:\n  %s" % out.stderr, file=sys.stderr)
        sys.exit(1)
    out_paths = []
    for line in out.stdout.splitlines():
        line = line.strip()
        if not line:
            continue
        out_paths.append(Path(line))
    if bounded_global_change is not None:
        print(
            "File %s affects global IWYU configuration; adding the "
            "bounded representative set" % bounded_global_change)
        out_paths = list(dict.fromkeys(
            out_paths + BOUNDED_GLOBAL_FILES
        ))
    return out_paths


# List of all non-third-party .cpp files in the codebase.
# Equivalent to linux `find src/ tests/ -maxdepth 1 -name '*.cpp'`
def generate_global_file_list() -> list[Path]:
    paths = []
    for d in [Path("src"), Path("tests")]:
        for item in os.listdir(d):
            p = d / item
            if p.is_file() and p.suffix == ".cpp":
                paths.append(p)
    paths.sort()
    return paths


# Exclude all the files we have, well, excluded
# This is equivalent to Linux ` | grep -v -f tools/iwyu/bad_files.txt `
def filter_analyzable_files(in_files: list[Path]) -> list[Path]:
    blacklist = []
    with open(BLACKLIST_PATH, "r") as bad_files:
        for line in bad_files.readlines():
            line = line.strip()
            if line.startswith("#") or not line:
                continue
            blacklist.append(line)

    analyzable_paths = []
    for p in in_files:
        if p.suffix != ".cpp":
            continue  # because IWYU does not work on .h files
        p_str = str(p.as_posix())
        fails = any((pattern in p_str) for pattern in blacklist)
        if not fails:
            analyzable_paths.append(p)
    return analyzable_paths


def parse_suggestion_path(line: str, root: Path) -> Path | None:
    for marker in (" should add these lines:",
                   " should remove these lines:"):
        if marker not in line:
            continue
        raw_path = line.split(marker, 1)[0]
        candidate = Path(raw_path)
        if not candidate.is_absolute():
            candidate = root / candidate
        try:
            return candidate.resolve().relative_to(root)
        except ValueError:
            return None
    return None


def effective_iwyu_status(
        raw_status: int,
        fix_status: int,
        suggestion_files: set[Path],
        enforced_files: set[Path] | None,
) -> int:
    # IWYU is invoked with --error=0, so a non-zero process result is a real
    # compiler/driver failure rather than an include suggestion.  Never allow
    # path filtering to suppress that failure.
    if raw_status != 0:
        return raw_status
    if fix_status != 0:
        return fix_status
    if enforced_files is None:
        return 1 if suggestion_files else 0
    return 1 if suggestion_files & enforced_files else 0


def run_iwyu_on(
        iwyu_tool_path: str,
        files: list[Path],
        enforced_files: set[Path] | None,
) -> int:
    argslist = [iwyu_tool_path]
    argslist.extend(str(f) for f in files)
    argslist.extend(["-p", "build", "--jobs", "4"])
    argslist.extend(["--"])
    cdda_root = Path(__file__).resolve().parent.parent
    mapping_path = cdda_root / "tools/iwyu/cata.imp"
    argslist.extend([
        "-Xiwyu", "--mapping_file=%s" % mapping_path,
        "-Xiwyu", "--cxx17ns",
        "-Xiwyu", "--comment_style=long",
        "-Xiwyu", "--max_line_length=1000",
        # Suggestions are classified below by their owning path.  Reserving
        # non-zero subprocess results for real compiler/driver errors prevents
        # iwyu_tool.py's parallel exit-code aggregation from hiding failures.
        "-Xiwyu", "--error=0"])

    fix_args = ["fix_includes.py", "--nosafe_headers", "--reorder"]

    print("::group::IWYU full output")
    print("Running: ")
    print_long_list(argslist)
    print("Piping output to: %s " % " ".join(fix_args))
    flush_both()
    # start the process, consume its stdout, leave stderr be
    iwyu_proc = subprocess.Popen(
        argslist,
        stdout=subprocess.PIPE,
        encoding="utf-8",
    )
    fix_proc = subprocess.Popen(
        fix_args,
        stdin=subprocess.PIPE,
        encoding="utf-8",
    )
    problem_lines = []
    fix_lines = []
    suggestion_files = set()
    while True:
        line = iwyu_proc.stdout.readline()
        if line == '':
            break  # IWYU finished and closed the pipe
        fix_lines.append(line)
        suggestion_path = parse_suggestion_path(line, cdda_root)
        if suggestion_path is not None:
            suggestion_files.add(suggestion_path)
        line = line.strip()
        if "#includes/fwd-decls are correct" not in line:
            print(line)
            if line:
                problem_lines.append(line)
            elif len(problem_lines) > 0 and len(problem_lines[-1]) != 0:
                # Only push empty lines if the previous line is not empty.
                problem_lines.append(line)
    iwyu_proc.wait()
    print("Applying fixes to files.")
    fix_proc.communicate("\n".join(fix_lines))
    fix_proc.wait()
    flush_both()
    status = effective_iwyu_status(
        iwyu_proc.returncode,
        fix_proc.returncode,
        suggestion_files,
        enforced_files,
    )
    if fix_proc.returncode != 0:
        print("fix_includes.py returned ", fix_proc.returncode)
    elif (iwyu_proc.returncode == 0 and status == 1 and
          enforced_files is not None and suggestion_files):
        relevant_suggestions = suggestion_files & enforced_files
        if relevant_suggestions:
            print("Blocking IWYU suggestions touch PR-owned files:")
            print_long_list(sorted(relevant_suggestions))
    if (iwyu_proc.returncode == 0 and status == 0 and
            enforced_files is not None and suggestion_files):
        print(
            "Ignoring pre-existing IWYU suggestions limited to "
            "untouched files:")
        print_long_list(sorted(suggestion_files))
    print("Raw IWYU return code ", iwyu_proc.returncode)
    print("Effective return code ", status)
    print("::endgroup::")

    # remove the matcher to prevent double-posting the annotations
    print("::remove-matcher owner=gcc-problem-matcher::")
    print("\n")
    if problem_lines:
        print("Problems found:")
        for line in problem_lines:
            print(line)
    elif status == 0:
        print("No issues found!")
    else:
        print("No suggestions provided, but the process still failed somehow?")

    return status


# GHA truncates each line to 1024 characters.
# Work around that by splitting long line into several shorter ones.
def print_long_list(things: list):
    all_lines = []
    line = ""
    for thing in things:
        thing = str(thing)
        if len(line) + len(thing) > 1000:
            all_lines.append(line)
            line = ""
        line = "%s %s" % (line, thing)
    all_lines.append(line)
    for line in all_lines:
        print("  %s" % line)


def flush_both():
    sys.stdout.flush()
    sys.stderr.flush()


if __name__ == '__main__':
    main()
