#!/usr/bin/env python3
"""Regenerate Translate Complex Dialogue from ordered JSON and Lua topics.

Place a single-line --~ explanation before the literal inside ccb.content.text().
Use --~ compact: explanation to append the gloss on the same line.
"""

import argparse
import ast
import json
from pathlib import Path
import re
import sys

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
from lang.string_extractor.write_text import is_tag  # noqa: E402
from tools.lua_api.extract_translations import (  # noqa: E402
    _content_definition_tables, _dialogue_tables, _lua_tokens,
)

STEMS = ("exodii_merchant_talk", "exodii_merchant_talk_exodization",
         "exodii_merchant_missions", "exodii_merchant_talk_netherum_labyrinth")
INPUT = Path("data/json/npcs/exodii")
OUTPUT = Path("data/mods/translate-dialogue")


def translation_parts(original, explanation, compact):
    if compact:
        return [original, " [TRANSLATE: ", explanation, "]"]
    return [original, '"\n\n[TRANSLATE:] "', explanation]


def transform_dynamic_line(line):
    if isinstance(line, list):
        return [transform_dynamic_line(value) for value in line]
    if isinstance(line, dict):
        if "str" in line and "//~" in line:
            return {"concatenate": translation_parts(
                line["str"], line["//~"], line.get("//") == "mod_update_script_compact"
            )}
        return {key: transform_dynamic_line(value) for key, value in line.items()}
    return line


def literal(text):
    return json.dumps(text, ensure_ascii=False)


def lua_line(line, indent="    "):
    """Emit static lines; complex native conditions keep their source representation."""
    if isinstance(line, str):
        constructor = "text_without_extraction" if is_tag(line) else "text"
        return f"ccb.content.{constructor}({literal(line)})"
    if isinstance(line, list):
        field, parts = "choices", line
    elif isinstance(line, dict) and set(line) == {"concatenate"}:
        field, parts = "joined", line["concatenate"]
    else:
        return None
    children = [lua_line(part, indent + "    ") for part in parts]
    if None in children:
        return None
    return "{ " + field + " = {\n" + "".join(
        indent + "    " + child + ",\n" for child in children
    ) + indent + "} }"


def lua_topic(ids, line):
    return f"ccb.content.define_dialogue_topic {{\n    id = {ids},\n    line = {line},\n}}"


def json_topics(path):
    for topic in json.loads(path.read_text(encoding="utf-8")):
        if topic.get("type") != "talk_topic" or "dynamic_line" not in topic:
            continue
        line = transform_dynamic_line(topic["dynamic_line"])
        if line == topic["dynamic_line"] and "TRANSLATE:" not in json.dumps(line):
            continue
        ids = topic["id"]
        converted = lua_line(line)
        if converted is None:
            yield False, ids, {"id": ids, "type": "talk_topic", "dynamic_line": line}
        else:
            key = literal(ids) if isinstance(ids, str) else "{ " + ", ".join(map(literal, ids)) + " }"
            yield True, ids, lua_topic(key, converted)


def field_end(tokens, start):
    """Find the delimiter of a field containing a Lua expression."""
    depth = 0
    for index in range(start, len(tokens)):
        token = tokens[index].value
        if depth == 0 and token in {",", ";", "}"}:
            return index
        depth += token in {"{", "[", "("}
        depth -= token in {"}", "]", ")"}
    raise ValueError("unterminated dialogue field")


def lua_topics(path):
    source = path.read_text(encoding="utf-8")
    if "--~" not in source:
        return
    tokens = _lua_tokens(source)
    tables = _dialogue_tables(tokens)
    for table in _content_definition_tables(tokens, tables, "define_dialogue_topic"):
        if "line" not in table.fields:
            continue
        start, = table.fields["line"]
        stop = field_end(tokens, start)
        line = source[tokens[start].start:tokens[stop - 1].end]
        edits = []
        for index in range(start, stop - 7):
            if [t.value for t in tokens[index:index + 6]] != ["ccb", ".", "content", ".", "text", "("]:
                continue
            first = tokens[index + 6]
            if first.kind != "string":
                continue
            note = source[tokens[index + 5].end:first.start].strip()
            if not note.startswith("--~ "):
                continue
            explanation = note.removeprefix("--~ ")
            compact = explanation.startswith("compact: ")
            if compact:
                explanation = explanation.removeprefix("compact: ")
            close = index + 7
            while close < stop and tokens[close].value != ")":
                close += 1
            if close == stop or "\n" in explanation:
                raise ValueError(f"{path}: invalid translation note near {first.value}")
            original = "ccb.content.text(" + source[first.start:tokens[close].end]
            parts = translation_parts(original, explanation, compact)
            wrapped = [original] + ["ccb.content.text(" + json.dumps(s, ensure_ascii=False) + ")"
                                    for s in parts[1:]]
            line_start = source.rfind("\n", 0, tokens[index].start) + 1
            indent = re.match(r"[ \t]*", source[line_start:tokens[index].start])[0]
            replacement = "{ joined = {\n" + "".join(
                indent + "    " + part + ",\n" for part in wrapped
            ) + indent + "} }"
            edits.append((tokens[index].start - tokens[start].start,
                          tokens[close].end - tokens[start].start, replacement))
        if edits:
            for begin, end, replacement in reversed(edits):
                line = line[:begin] + replacement + line[end:]
            id_start, = table.fields["id"]
            topic_id = source[tokens[id_start].start:tokens[field_end(tokens, id_start) - 1].end]
            ids = [ast.literal_eval(t.value) for t in tokens[id_start:field_end(tokens, id_start)]
                   if t.kind == "string"]
            if not ids:
                raise ValueError(f"{path}: translated dialogue needs literal topic IDs")
            yield True, ids, lua_topic(topic_id, line)


def fragments(directory, stem):
    pattern = re.compile(re.escape(stem) + r"(?:\.data-part-(\d{6}))?(\.json|\.data\.lua)")
    result = []
    for path in directory.glob(stem + ".*"):
        match = pattern.fullmatch(path.name)
        if match:
            lua = match[2] == ".data.lua"
            number = int(match[1]) if match[1] else (1000000 if lua else -1)
            result.append((number, lua, path))
    return sorted(result)


def render(stem):
    sources = fragments(INPUT, stem)
    if not sources:
        raise FileNotFoundError(INPUT / stem)
    # Distinct topic lines are independent. Within a pair JSON loads first, then
    # Lua; start another pair when a later JSON line overrides an earlier Lua line.
    groups = [[[], []]]
    lua_ids = set()
    for _, source_lua, path in sources:
        topics = lua_topics(path) if source_lua else json_topics(path)
        for lua, ids, value in topics:
            if isinstance(ids, str):
                ids = [ids]
            if not lua and lua_ids.intersection(ids):
                lua_ids.clear()
                groups.append([[], []])
            groups[-1][lua].append(value)
            if lua:
                lua_ids.update(ids)
    parts = [(lua, values) for pair in groups for lua, values in enumerate(pair) if values]
    for index, (lua, values) in enumerate(parts):
        suffix = ".data.lua" if lua else ".json"
        numbered = (index != len(parts) - 1 if lua else index != 0)
        part = f".data-part-{index:06}" if numbered else ""
        if lua:
            content = 'local ccb = require("ccb")\n'
            if any("predicates." in s for s in values):
                content += "local predicates = ccb.content.dialogue_predicates\n"
            content += "\n" + "\n\n".join(values) + "\n"
        else:
            content = json.dumps(values, indent=2, ensure_ascii=False) + "\n"
        yield OUTPUT / (stem + part + suffix), content


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="report stale output without writing")
    args = parser.parse_args()
    expected = dict(pair for stem in STEMS for pair in render(stem))
    current = {path for stem in STEMS for _, _, path in fragments(OUTPUT, stem)}
    stale = current - expected.keys()
    changes = {path: text for path, text in expected.items()
               if path not in current or path.read_text(encoding="utf-8") != text}
    for path in sorted(stale | changes.keys()):
        print(path)
    if args.check:
        return bool(stale or changes)
    for path, text in changes.items():
        path.write_text(text, encoding="utf-8")
    for path in stale:
        path.unlink()
    return 0


if __name__ == "__main__":
    sys.exit(main())
