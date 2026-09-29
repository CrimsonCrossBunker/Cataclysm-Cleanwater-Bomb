#!/usr/bin/env python3
"""Extract literal Platform text with GNU xgettext; never execute Lua."""
from __future__ import annotations

import argparse
from dataclasses import dataclass, field
from pathlib import Path
import subprocess
import sys
import tempfile

KEYWORDS = (
    "ccb.services.translate:1,1t",
    "ccb.services.translate:1,2c,2t",
    "ccb.services.translate_plural:1,2,3t",
    "ccb.services.translate_plural:1,2,4c,4t",
    "ccb.content.text:1,1t",
    "ccb.content.text:1,2c,2t",
    "ccb.content.plural_text:1,2,2t",
    "ccb.content.plural_text:1,2,3c,3t",
    "ccb.lua_api_dialogue_translation:1",
    "ccb.lua_api_dialogue_translation:1,2c,2t",
)
_DIALOGUE_EXTRACTOR = "ccb.lua_api_dialogue_translation"
_DIALOGUE_FIELDS = {
    "text_translation": "text",
    "false_text_translation": "false_text",
    "dynamic_line_translation": "dynamic_line",
}
HEADER = (
    'msgid ""\nmsgstr ""\n'
    '"Content-Type: text/plain; charset=UTF-8\\n"\n'
    '"Content-Transfer-Encoding: 8bit\\n"\n\n'
)


@dataclass(frozen=True)
class _LuaToken:
    kind: str
    value: str
    start: int
    end: int


@dataclass
class _LuaTable:
    token_index: int
    base_delimiters: int
    base_blocks: int
    expecting_field: bool = True
    has_non_key_field: bool = False
    fields: dict[str, list[int]] = field(default_factory=dict)
    end_token_index: int | None = None


def _long_bracket_end(source: str, start: int) -> int | None:
    """Return the end of a Lua long-bracket string or comment."""
    if start >= len(source) or source[start] != "[":
        return None
    cursor = start + 1
    while cursor < len(source) and source[cursor] == "=":
        cursor += 1
    if cursor >= len(source) or source[cursor] != "[":
        return None
    closing = "]" + source[start + 1:cursor] + "]"
    end = source.find(closing, cursor + 1)
    return len(source) if end < 0 else end + len(closing)


def _lua_tokens(source: str) -> list[_LuaToken]:
    """Tokenize Lua strings, identifiers and punctuation without executing it."""
    tokens = []
    cursor = 0
    while cursor < len(source):
        character = source[cursor]
        if character.isspace():
            cursor += 1
            continue
        if source.startswith("--", cursor):
            comment_start = cursor + 2
            long_end = _long_bracket_end(source, comment_start)
            if long_end is not None:
                cursor = long_end
            else:
                newline = source.find("\n", comment_start)
                cursor = len(source) if newline < 0 else newline
            continue
        if character in "\"'":
            end = cursor + 1
            while end < len(source):
                current = source[end]
                if current == "\\":
                    end += 2
                elif current == character:
                    end += 1
                    break
                elif current in "\r\n":
                    break
                else:
                    end += 1
            if end <= len(source) and source[end - 1:end] == character:
                raw = source[cursor:end]
                tokens.append(_LuaToken("string", raw, cursor, end))
                cursor = end
            else:
                # Invalid Lua will be diagnosed by xgettext. Stop so malformed
                # text cannot create a guessed table-field association.
                break
            continue
        if character == "[":
            long_end = _long_bracket_end(source, cursor)
            if long_end is not None:
                raw = source[cursor:long_end]
                tokens.append(_LuaToken("string", raw, cursor, long_end))
                cursor = long_end
                continue
        if character.isalpha() or character == "_":
            end = cursor + 1
            while end < len(source) and (
                    source[end].isalnum() or source[end] == "_"):
                end += 1
            raw = source[cursor:end]
            tokens.append(_LuaToken("identifier", raw, cursor, end))
            cursor = end
            continue
        tokens.append(_LuaToken("symbol", character, cursor, cursor + 1))
        cursor += 1
    return tokens


def _dialogue_tables(tokens: list[_LuaToken]) -> dict[int, _LuaTable]:
    """Read direct named fields from Lua table constructors, skipping blocks."""
    tables: list[_LuaTable] = []
    completed: dict[int, _LuaTable] = {}
    delimiters: list[str] = []
    blocks: list[tuple[str, bool]] = []

    for index, token in enumerate(tokens):
        direct = bool(tables) and (
            len(delimiters) == tables[-1].base_delimiters and
            len(blocks) == tables[-1].base_blocks
        )
        if token.value in (",", ";") and direct:
            tables[-1].expecting_field = True
        elif (direct and tables[-1].expecting_field and
              token.value != "}"):
            if (token.kind == "identifier" and index + 1 < len(tokens) and
                    tokens[index + 1].value == "="):
                tables[-1].fields.setdefault(token.value, []).append(index + 2)
            else:
                tables[-1].has_non_key_field = True
            tables[-1].expecting_field = False

        if token.value == "{":
            tables.append(_LuaTable(index, len(delimiters), len(blocks)))
        elif token.value == "}":
            if tables:
                table = tables.pop()
                table.end_token_index = index
                completed[table.token_index] = table
        elif token.value in ("(", "["):
            delimiters.append(token.value)
        elif token.value in (")", "]") and delimiters:
            delimiters.pop()

        if token.kind == "identifier":
            if token.value in ("function", "if"):
                blocks.append((token.value, False))
            elif token.value in ("for", "while"):
                blocks.append(("loop", True))
            elif token.value == "do":
                if blocks and blocks[-1] == ("loop", True):
                    blocks[-1] = ("loop", False)
                else:
                    blocks.append(("do", False))
            elif token.value == "repeat":
                blocks.append(("repeat", False))
            elif token.value == "end" and blocks:
                blocks.pop()
            elif (token.value == "until" and blocks and
                  blocks[-1][0] == "repeat"):
                blocks.pop()
    return completed


def _dialogue_translation_edits(source: str) -> list[tuple[int, int, str]]:
    """Find literal dialogue fields paired with an explicit translation marker."""
    if not any(marker in source for marker in _DIALOGUE_FIELDS):
        return []
    tokens = _lua_tokens(source)
    tables = _dialogue_tables(tokens)
    edits = []
    for table in tables.values():
        for marker, source_field in _DIALOGUE_FIELDS.items():
            marker_values = table.fields.get(marker, [])
            source_values = table.fields.get(source_field, [])
            if len(marker_values) != 1 or len(source_values) != 1:
                continue
            source_index = source_values[0]
            marker_index = marker_values[0]
            if (source_index >= len(tokens) or marker_index >= len(tokens) or
                    tokens[source_index].kind != "string" or
                    "\n" in tokens[source_index].value or
                    "\r" in tokens[source_index].value or
                    source_index + 1 >= len(tokens) or
                    tokens[source_index + 1].value not in (",", ";", "}") or
                    tokens[marker_index].value != "{"):
                continue
            if (marker == "false_text_translation" and
                    "text_condition" not in table.fields):
                continue

            options = tables.get(marker_index)
            if options is None or options.has_non_key_field:
                continue
            if (options.end_token_index is None or
                    options.end_token_index + 1 >= len(tokens) or
                    tokens[options.end_token_index + 1].value not in
                    (",", ";", "}")):
                continue
            if any(key != "context" for key in options.fields):
                continue
            contexts = options.fields.get("context", [])
            if len(contexts) > 1:
                continue
            context_raw = None
            if contexts:
                context_index = contexts[0]
                if context_index >= len(tokens):
                    continue
                context = tokens[context_index]
                if (context.value == "nil" and context.kind == "identifier" and
                        context_index + 1 < len(tokens) and
                        tokens[context_index + 1].value in (",", ";", "}")):
                    pass
                elif (context.kind == "string" and
                      "\n" not in context.value and
                      "\r" not in context.value and
                      context_index + 1 < len(tokens) and
                      tokens[context_index + 1].value in (",", ";", "}")):
                    context_raw = context.value
                else:
                    # A computed context cannot be reproduced safely in a POT.
                    continue

            message = tokens[source_index]
            args = message.value
            if context_raw is not None:
                args += f", {context_raw}"
            replacement = f"{_DIALOGUE_EXTRACTOR}({args})"
            edits.append((message.start, message.end, replacement))
    return edits


def _rewrite_dialogue_markers(source: str) -> str | None:
    """Rewrite marked literals as an xgettext-only keyword call."""
    edits = _dialogue_translation_edits(source)
    if not edits:
        return None
    rewritten = source
    for start, end, replacement in sorted(edits, reverse=True):
        rewritten = rewritten[:start] + replacement + rewritten[end:]
    return rewritten


def extract(files: list[Path], executable: str = "xgettext") -> str:
    """Keep relative source references and sort the input order."""
    for path in files:
        if path.suffix != ".lua" or not path.is_file():
            raise ValueError(f"expected an existing Lua source file: {path}")
    if not files:
        raise ValueError("at least one Lua source file is required")
    input_files = sorted({str(path) for path in files})
    command = [executable, "--language=Lua", "--from-code=UTF-8", "--keyword=",
               "--force-po", "--no-wrap", "--add-comments=TRANSLATORS:",
               "--output=-"]
    command.extend(f"--keyword={keyword}" for keyword in KEYWORDS)
    command.extend(("--flag=ccb.services.translate:1:pass-lua-format",
                    "--flag=ccb.services.translate_plural:1:pass-lua-format",
                    "--flag=ccb.services.translate_plural:2:pass-lua-format"))
    command.append("--")
    reference_remapping = {}
    try:
        with tempfile.TemporaryDirectory(prefix="ccb-lua-xgettext-") as temp:
            staged_inputs = []
            for index, filename in enumerate(input_files):
                source_path = Path(filename)
                source = source_path.read_text(encoding="utf-8")
                rewritten = _rewrite_dialogue_markers(source)
                if rewritten is None:
                    staged_inputs.append(filename)
                    continue
                staged_path = Path(temp) / f"source-{index}.lua"
                staged_path.write_text(rewritten, encoding="utf-8")
                staged_inputs.append(str(staged_path))
                reference_remapping[str(staged_path)] = filename
            command.extend(staged_inputs)
            try:
                result = subprocess.run(command, capture_output=True, text=True,
                                        encoding="utf-8", check=False)
            except (OSError, UnicodeError) as error:
                raise ValueError(f"cannot run GNU xgettext: {error}") from error
    except (OSError, UnicodeError) as error:
        raise ValueError(f"cannot prepare Lua input files: {error}") from error
    if result.returncode:
        raise ValueError(
            f"xgettext failed ({result.returncode}): {result.stderr.strip()}")
    if result.stderr:
        print(result.stderr.rstrip(), file=sys.stderr)
    # Keep xgettext's UTF-8 header during extraction: --omit-header can lose
    # non-ASCII strings in some gettext versions. Replace only after
    # extraction.
    output_lines = []
    for line in result.stdout.splitlines(keepends=True):
        if line.startswith("#:"):
            for staged_path, source_path in reference_remapping.items():
                line = line.replace(staged_path, source_path)
        output_lines.append(line)
    output = "".join(output_lines)
    header, _, messages = output.partition("\n\n")
    if 'msgid ""\nmsgstr ""' not in header or '"Content-Type:' not in header:
        raise ValueError("xgettext returned an invalid translation template")
    # A header-only output is valid when none of the inputs contains messages.
    return HEADER + messages


def write_template(path: Path, content: str) -> None:
    """Stage output so a failed write preserves the old file."""
    temporary = None
    try:
        with tempfile.NamedTemporaryFile(
                dir=path.parent, prefix=f".{path.name}.",
                suffix=".tmp", delete=False) as stream:
            temporary = Path(stream.name)
            stream.write(content.encode("utf-8"))
        if path.is_file():
            temporary.chmod(path.stat().st_mode & 0o777)
        temporary.replace(path)
    finally:
        if temporary is not None:
            temporary.unlink(missing_ok=True)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("files", nargs="+", type=Path,
                        help="explicit Lua source files")
    parser.add_argument("--output", type=Path,
                        help="POT destination; default is stdout")
    parser.add_argument("--check", action="store_true",
                        help="compare --output without writing")
    parser.add_argument("--xgettext", default="xgettext",
                        help="GNU xgettext executable")
    args = parser.parse_args(argv)
    if args.check and args.output is None:
        parser.error("--check requires --output")
    try:
        if args.output:
            for path in args.files:
                if (args.output.resolve() == path.resolve() or
                        (args.output.exists() and path.exists() and
                         args.output.samefile(path))):
                    raise ValueError(
                        "output must not overwrite an input source")
        content = extract(args.files, args.xgettext)
        if args.check:
            if (not args.output.is_file() or
                    args.output.read_bytes() != content.encode("utf-8")):
                print(
                    f"translation template is out of date: {args.output}",
                    file=sys.stderr)
                return 1
        elif args.output:
            write_template(args.output, content)
        else:
            sys.stdout.write(content)
        return 0
    except (OSError, UnicodeError, ValueError) as error:
        print(f"error: {error}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
