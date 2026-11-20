import functools
import os
import sys
from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path
from typing import Generator

import click
import orjson

from bundled_mod_metadata import literal_metadata


def find_files(
    paths: list[Path], extensions: tuple[str], include_mods=False
) -> Generator[str, None, None]:
    """Recursively search :paths: for files that have :extensions:.

    Skip mod directories unless requested. Yield their metadata before data files.
    """
    for path in paths:
        if os.path.isdir(path):
            for dirpath, dirnames, filenames in os.walk(path):
                metadata = next((name for name in ("modinfo.json", "mod.lua")
                                 if name in filenames), None)
                if metadata:
                    if not include_mods:
                        dirnames.clear()
                        continue
                    filenames.remove(metadata)
                    yield os.path.join(dirpath, metadata)

                for filename in filenames:
                    _, ext = os.path.splitext(filename)
                    if ext in extensions:
                        yield os.path.join(dirpath, filename)
        else:
            if path.suffix in extensions:
                yield path


@functools.total_ordering
@dataclass(init=True, repr=True)
class Mutation:
    id_: str
    name: str
    categories: list[str]
    description: str
    mod: str
    copied: bool = False

    def __lt__(self, other) -> bool:
        if not isinstance(other, Mutation):
            return NotImplemented
        return self.name.lower() < other.name.lower()


def write_mutations(mutations: list[Mutation], filename: Path) -> None:
    categories = defaultdict(list)

    for mut in mutations:
        if mut.categories != "NONE":
            for cat in mut.categories:
                categories[cat].append(mut)
        else:
            categories["NONE"].append(mut)

    # Sort categories alphabetically
    categories = dict(sorted(categories.items()))

    # Sort mutations alphabetically in categories
    for mutations in categories.values():
        mutations.sort()

        # Sort each mutation's categories alphabetically
        for mut in mutations:
            mut.categories.sort()

    with open(filename, "w", encoding="utf-8") as fd:
        # Write table of contents
        fd.write("# Table of Contents\n")
        fd.write("- Categories\n")
        for category in categories.keys():
            fd.write(
                f'  - [{category}](#{category.replace(" ", "-").lower()})\n'
            )
        fd.write("\n\n")

        # Write mutations
        for category, mutations in categories.items():
            fd.write(f"## {category}\n")
            for mut in mutations:
                fd.write(f"### {mut.name}\n")
                fd.write(f"src: `{mut.mod}`\n")
                fd.write(f"id: `{mut.id_}` \n")
                fd.write(f'categories: `{"`, `".join(mut.categories)}`\n')
                fd.write(f"Description: {mut.description}\n")
            fd.write("\n\n")


def extract_mutations(file: Path, mod: str = "ccb") -> list[Mutation]:
    """Extract mutations from :file:."""

    with open(file, "rb") as fd:
        jfile = orjson.loads(fd.read())

    if not isinstance(jfile, list):
        return []

    if len(jfile) == 0:
        return []

    mutations = []

    for jo in jfile:
        if not isinstance(jo, dict):
            continue

        if jo.get("type") != "mutation":
            continue

        mutation = Mutation(
            id_=jo.get("id"),
            name="",
            categories=jo.get(
                "category", jo.get("extend", {}).get("category", ["NONE"])
            ),
            description=jo.get("description"),
            mod=mod,
        )

        name = jo.get("name")
        if isinstance(name, dict):
            name = name.get("str")
        elif name is None and jo.get("copy-from"):
            name = "SHOULD_BE_COPIED_FROM"
            mutation.copied = True
        elif not isinstance(name, str):
            click.echo(
                f"Invalid mutation name: {name} in file: {file}", err=True
            )
            sys.exit()

        mutation.name = name
        mutations.append(mutation)

    return mutations


@dataclass(init=True, repr=True)
class Mod:
    id_: str
    mutations: list[Mutation]
    dependencies: list[str]


@click.command()
@click.argument(
    "paths",
    type=click.Path(exists=True, resolve_path=True, path_type=Path),
    nargs=-1,
)
@click.option(
    "-o",
    "--outfile",
    type=click.Path(resolve_path=True, path_type=Path, dir_okay=False),
    default="mutations.md",
    help="""Specify the filepath to write the documentation for DDA to.
    If mods are included, their documentation will be written to the same
    directory.""",
    show_default=True,
)
@click.option(
    "--include-mods / --exclude-mods",
    default=False,
    help="""Include (or exclude) mutations defined in mods.
    A mod is a file which is contained in a subdirectory of a
    directory including a modinfo.json file.""",
    show_default=True,
)
def cli(paths, outfile, include_mods) -> None:
    """Search PATHS for JSON files and generate documentation for mutations."""
    # The entrypoint to the CLI.

    if not include_mods:
        mutations = []

        for file in find_files(paths, (".json",), include_mods=False):
            mutations.extend(extract_mutations(file))

        write_mutations(mutations, outfile)
        click.echo(f"Mutations written to {outfile}")
    else:
        dda = Mod("ccb", [], [])
        mod_stack: list[tuple[Mod, str]] = [(dda, "PLACEHOLDER")]
        mods: dict[str, Mod] = {"ccb": dda}

        def move_stack(
            file, mod_stack: list[tuple[Mod, str]]
        ) -> list[tuple[Mod, str]]:
            if len(mod_stack) == 1:
                return mod_stack
            if mod_stack[-1][1] in Path(file).parents:
                return mod_stack
            else:
                return move_stack(file, mod_stack[:-1])

        for file in find_files(paths, (".json",), include_mods=True):
            if os.path.basename(file) not in ("modinfo.json", "mod.lua"):
                # Move mods who we have recursed out of off the stack.
                mod_stack = move_stack(file, mod_stack)
                mod_stack[-1][0].mutations.extend(
                    extract_mutations(file, mod_stack[-1][0].id_)
                )

            elif os.path.split(os.path.split(file)[0])[1] == "dda":
                # Skip DDA
                continue
            else:
                # Add a new mod to the stack.
                if Path(file).name == "mod.lua":
                    mod_info = literal_metadata(Path(file))
                    mod_info.setdefault("id", Path(file).parent.name)
                    mod_info.setdefault("dependencies", [])
                else:
                    with open(file, "rb") as fd:
                        jfile = orjson.loads(fd.read())
                    mod_info = jfile[0] if isinstance(jfile, list) and jfile else jfile

                if (isinstance(mod_info, dict) and mod_info.get("id")
                        and isinstance(mod_info.get("dependencies"), list)):
                    new_mod = Mod(mod_info["id"], [], [
                        "ccb" if dep == "dda" else dep
                        for dep in mod_info["dependencies"]
                    ])
                    mod_stack.append((new_mod, Path(os.path.dirname(file))))
                    mods[new_mod.id_] = new_mod
                else:
                    click.echo(f"{file} has invalid Mod metadata.")
                    sys.exit()

        # Resolve mutations which use copy-from.
        for id_, mod in mods.items():
            if not mod.dependencies:
                continue

            for mut in (mut for mut in mod.mutations if mut.copied is True):
                for dep in mod.dependencies:
                    if not mods.get(dep):
                        click.echo(
                            f"Mod {mod.id_} is missing dependency {dep}"
                        )
                        continue

                    for m in mods[dep].mutations:
                        if m.id_ == mut.id_:
                            mut.description = m.description
                            mut.name = m.name
                            mut.mod = m.mod

                            if mut.categories != ["NONE"] and m.categories != [
                                "NONE"
                            ]:
                                mut.categories += m.categories
                            elif m.categories != ["NONE"]:
                                mut.categories = m.categories

        for _, mod in mods.items():
            try:
                if not mod.mutations:
                    continue
            except AttributeError:
                breakpoint()

            if mod.id_ == "ccb":
                writepath = outfile
            else:
                writepath = outfile.parent.joinpath(mod.id_ + ".md")

            write_mutations(mod.mutations, writepath)
            click.echo(
                f"Mutations for mod [ {mod.id_} ] written to {writepath}"
            )


if __name__ == "__main__":
    cli()
