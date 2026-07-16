#!/usr/bin/env bash

set -euo pipefail
shopt -s nullglob

# Sometimes PO files pulled from Transifex are not accepted by GNU gettext, for example
#   lang/po/hu.po:430257: 'msgid' and 'msgstr' entries do not both begin with '\n'
#   lang/po/hu.po:534682: 'msgid' and 'msgstr' entries do not both end with '\n'
#   lang/po/hu.po:534692: 'msgid' and 'msgstr' entries do not both end with '\n'
#
# PO/POT files are intentionally ignored by git in this repository, so checking
# `git diff` only ever inspected tracked placeholders.  Validate every PO pulled
# from Transifex instead, and remove invalid languages from the build artifact.

function discard_po() {
    echo "::warning file=$1::Discarding invalid translation"
    rm -f -- "$1"
}

po_files=( lang/po/*.po )
if (( ${#po_files[@]} == 0 )); then
    echo "::error::No translation PO files were pulled from Transifex"
    exit 1
fi

for i in "${po_files[@]}"; do
    msgfmt -c -o /dev/null "$i" || discard_po "$i"
done

remaining=( lang/po/*.po )
if (( ${#remaining[@]} == 0 )); then
    echo "::error::All pulled translations were invalid"
    exit 1
fi
