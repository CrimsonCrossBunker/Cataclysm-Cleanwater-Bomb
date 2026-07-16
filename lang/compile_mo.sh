#!/usr/bin/env bash

set -euo pipefail
shopt -s nullglob

if [ ! -d lang/po ]
then
    if [ -d ../lang/po ]
    then
        cd ..
    else
        echo "Error: Could not find lang/po subdirectory."
        exit 1
    fi
fi

# Check output dir here
# Backward compatibility
LOCALE_DIR="${LOCALE_DIR:-lang/mo}"

# compile .mo file for each specified language
if (( $# > 0 )) && [ "$1" != "all" ]
then
    for n in "$@"
    do
        f="lang/po/${n}.po"
        if [ ! -f "$f" ]; then
            echo "Error: Translation file not found: $f"
            exit 1
        fi
        mkdir -p "$LOCALE_DIR/${n}/LC_MESSAGES"
        msgfmt -c -f -o "$LOCALE_DIR/${n}/LC_MESSAGES/cataclysm-dda.mo" "$f"
    done
else
    # if nothing specified, compile .mo file for every .po file in lang/po
    po_files=( lang/po/*.po )
    if (( ${#po_files[@]} == 0 )); then
        echo "Error: No translation PO files found."
        exit 1
    fi
    for f in "${po_files[@]}"
    do
        n=$(basename "$f" .po)
        mkdir -p "$LOCALE_DIR/${n}/LC_MESSAGES"
        msgfmt -c -f -o "$LOCALE_DIR/${n}/LC_MESSAGES/cataclysm-dda.mo" "$f"
    done
fi
