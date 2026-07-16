#!/usr/bin/env bash

set -euo pipefail

if [ ! -d lang/po ]; then
    if [ -d ../lang/po ]; then
        cd ..
    else
        echo "Error: Could not find lang/po subdirectory."
        exit 1
    fi
fi

if (( $# < 1 || $# > 2 )); then
    echo "Usage: $0 <language> [output.po]"
    echo "Example: $0 zh_CN /tmp/zh_CN-untranslated.po"
    exit 1
fi

language="$1"
source_po="lang/po/${language}.po"
template="lang/po/cataclysm-dda.pot"
output="${2:-/tmp/${language}-untranslated.po}"

if [ ! -f "$source_po" ]; then
    echo "Error: Translation file not found: $source_po"
    exit 1
fi
if [ ! -f "$template" ]; then
    echo "Error: Translation template not found: $template"
    exit 1
fi

workdir=$(mktemp -d)
trap 'rm -rf "$workdir"' EXIT

# Merge first so newly extracted source strings also appear in the result.
msgmerge --quiet --no-fuzzy-matching "$source_po" "$template" \
    -o "$workdir/merged.po"
msgfmt -c -o /dev/null "$workdir/merged.po"

# gettext treats fuzzy translations separately from untranslated messages.
# Clear their text so both groups can be handed out as unfinished work.
msgattrib "$workdir/merged.po" --untranslated --no-obsolete --force-po \
    -o "$workdir/untranslated.po"
msgattrib "$workdir/merged.po" --only-fuzzy --clear-fuzzy --empty --no-obsolete --force-po \
    -o "$workdir/fuzzy.po"

mkdir -p "$(dirname "$output")"
msgcat --use-first "$workdir/untranslated.po" "$workdir/fuzzy.po" |
    msguniq --no-wrap -o "$output"
msgfmt -c -o /dev/null "$output"

count=$(msgattrib "$output" --untranslated --no-obsolete |
    awk '/^msgid( |$)/ { total++ } END { print ( total > 0 ? total - 1 : 0 ) }')
echo "Exported ${count} unfinished messages to ${output}"
