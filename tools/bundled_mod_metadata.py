"""Read literal packaging fields from a shipped mod.lua without running it."""

import json
import os
from pathlib import Path
import sys

from lua_api.extract_translations import _dialogue_tables, _lua_tokens


def literal_metadata(path: Path) -> dict:
    tokens = _lua_tokens(path.read_text(encoding="utf-8"))
    values = [token.value for token in tokens]
    for table in _dialogue_tables(tokens).values():
        start = table.token_index
        if (values[max(0, start - 4):start] != ["return", "ccb", ".", "ModDefinition"]
                or table.end_token_index != len(tokens) - 1):
            continue
        result = {}
        for field in ("id", "dependencies", "obsolete"):
            indices = table.fields.get(field, [])
            if len(indices) != 1:
                continue
            i = indices[0]
            end = i + 1
            if field == "dependencies" and values[i] == "{":
                end = values.index("}", i + 1) + 1
                literals = values[i + 1:end - 1]
                if literals[-1:] == [","]:
                    literals.pop()
                if any(t != "," for t in literals[1::2]):
                    continue
                value = "[" + "".join(literals) + "]"
            else:
                value = values[i]
            if end >= len(values) or values[end] not in (",", ";", "}"):
                continue
            try:
                parsed = json.loads(value)
            except ValueError:
                continue
            if ((field == "id" and isinstance(parsed, str))
                    or (field == "obsolete" and isinstance(parsed, bool))
                    or (field == "dependencies" and isinstance(parsed, list)
                        and all(isinstance(dep, str) for dep in parsed))):
                result[field] = parsed
        return result
    return {}


def obsolete_roots(root: Path):
    for directory in sorted(root.iterdir()):
        if not directory.is_dir():
            continue
        legacy = directory / "modinfo.json"
        metadata = directory / "mod.lua"
        obsolete = False
        if legacy.is_file():
            content = json.loads(legacy.read_text(encoding="utf-8-sig"))
            entries = content if isinstance(content, list) else [content]
            obsolete = any(entry.get("obsolete") for entry in entries
                           if entry.get("type") == "MOD_INFO")
        if metadata.is_file():
            fields = literal_metadata(metadata)
            if fields.get("id") == "dev:default":
                continue
            obsolete = fields.get("obsolete", obsolete)
        if obsolete:
            yield directory


if __name__ == "__main__":
    for path in obsolete_roots(Path(sys.argv[1])):
        sys.stdout.buffer.write(os.fsencode(path) + b"\0")
