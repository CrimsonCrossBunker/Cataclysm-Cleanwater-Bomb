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

po_files=( lang/po/*.po )
if (( ${#po_files[@]} == 0 )); then
    echo "Error: No translation PO files found."
    exit 1
fi

mkdir -p lang/stats
find lang/stats -maxdepth 1 -type f -delete

count_messages()
{
    local po_file="$1"
    shift
    msgattrib "$po_file" --no-obsolete "$@" | awk '/^msgid( |$)/ { count++ } END { print ( count > 0 ? count - 1 : 0 ) }'
}

for f in "${po_files[@]}"
do
    n=$(basename "${f}" .po)
    o="lang/po/${n}.po"
    echo "getting stats for ${n}"
    num_translated=$(count_messages "${o}" --translated --no-fuzzy)
    num_untranslated=$(count_messages "${o}" --untranslated)
    num_fuzzy=$(count_messages "${o}" --only-fuzzy)
    printf '{"%s"sv, %d, %d},\n' \
        "${n}" "${num_translated}" "$((num_untranslated + num_fuzzy))" \
        > "lang/stats/${n}"
done

ls lang/stats

mkdir -p src

cat lang/stats/* > src/lang_stats.inc
