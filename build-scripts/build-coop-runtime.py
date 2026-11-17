#!/usr/bin/env python3
"""Build the pinned co-op C ABI library beside the game."""
import argparse
import filecmp
import os
from pathlib import Path
import shutil
import subprocess
import sys


def resolve_cargo(requested):
    executable = shutil.which(requested)
    if executable:
        return executable
    if requested == 'cargo':
        homes = [os.environ.get('CARGO_HOME')]
        for home in (os.environ.get('USERPROFILE'), os.environ.get('HOME')):
            if home:
                homes.append(str(Path(home) / '.cargo'))
        homes.append(str(Path.home() / '.cargo'))
        for home in homes:
            if home:
                executable = shutil.which(str(Path(home) / 'bin' / 'cargo'))
                if executable:
                    return executable
    raise SystemExit(
        f'Cargo executable not found: {requested}. Install Rust with rustup, '
        'add its bin directory to PATH, or set CARGO to the full cargo executable path.'
    )


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cargo', default='cargo')
    parser.add_argument('--target', default='')
    parser.add_argument('--profile', choices=('dev',
                        'release'), default='release')
    parser.add_argument('--target-dir', type=Path, required=True)
    parser.add_argument('--library-dir', type=Path, required=True)
    parser.add_argument('--jobs', type=int, default=2)
    parser.add_argument('--offline', action='store_true')
    parser.add_argument('--cargo-config', action='append', default=[])
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[1]
    command = [resolve_cargo(args.cargo),
               'build',
               '--locked',
               '--manifest-path',
               str(root / 'rust/coop_ecs/Cargo.toml'),
               '--target-dir',
               str(args.target_dir.resolve()),
               '--profile',
               args.profile,
               '-j',
               str(args.jobs)]
    if args.target:
        command += ['--target', args.target]
    if args.offline:
        command += ['--offline']
    for config in args.cargo_config:
        command += ['--config', config]
    subprocess.run(command, check=True)
    platform = args.target or sys.platform
    name = (
        'ccb_bevy_ecs_coop.dll'
        if 'windows' in platform or platform == 'win32' else
        'libccb_bevy_ecs_coop.dylib'
        if 'darwin' in platform or 'apple' in platform else
        'libccb_bevy_ecs_coop.so'
    )
    source = args.target_dir / args.target / \
        ('debug' if args.profile == 'dev' else 'release') / name
    if not source.is_file():
        raise SystemExit(f'Cargo did not produce expected runtime: {source}')
    args.library_dir.mkdir(parents=True, exist_ok=True)
    destination = args.library_dir / name
    if not destination.is_file() or not filecmp.cmp(
            source, destination, shallow=False):
        shutil.copy2(source, destination)
    print(destination.resolve())


if __name__ == '__main__':
    main()
