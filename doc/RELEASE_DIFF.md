<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Moved / 已迁移**
>
> Stable document ID / 稳定文档 ID: `legacy.doc-release-diff`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/maintenance/releases/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/maintenance/releases/
> Moved date / 迁移日期: `2026-08-02`
> Last in-repository commit / 仓库内最后适用 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> The maintained documentation now lives in CCB-Docs.
> This in-repository body is no longer maintained. The historical body is retained through `2027-02-02` and may then be removed; this bilingual entry banner remains permanently.
> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。
<!-- CCB-DOC-MOVED-END -->
# Release Diff
A section we have added to the changelog is the json entity diff.
This enumerates the json entity types that have been added to the game since the last release.

To generate this diff:

Check out the previous release:
```
git checkout 0.E
```
Generate lists of json entities with jq:
```
jq -s -f tools/json_tools/jq/enumerate_json_entities.jq $(find data/json -name "*.json" | grep -v obsolete) > json_types_0.E
jq -s -f tools/json_tools/jq/enumerate_json_entities.jq $(find data/mods -name "*.json" | grep -v obsolete) > json_mod_types_0.E
```

Check out current master:
```
git checkout master
```
Generate lists of json entities with jq:
```
jq -s -f tools/json_tools/jq/enumerate_json_entities.jq $(find data/json -name "*.json" | grep -v obsolete) > json_types_0.F
jq -s -f tools/json_tools/jq/enumerate_json_entities.jq $(find data/mods -name "*.json" | grep -v obsolete) > json_mod_types_0.F
```

Generate diffs between the corresponding enumerations capturing the type headers and just the added entity ids.
```
diff -U 10000 json_types_0.E json_types_0.F | grep "\(^.  \"type\"\)\|\(^+ \+\".*\",\)" > json_types_diff_0.E_to_0.F
diff -U 10000 json_mod_types_0.E json_mod_types_0.F | grep "\(^.  \"type\"\)\|\(^+ \+\".*\",\)" > json_mod_types_diff_0.E_to_0.F
```

Run this goofy script to just list the type headers and append the count of added entities after each line.
```
paste <(cut json_types_diff_0.E_to_0.F -d : -f 3) <(cut -d : -f 1 json_types_diff_0.E_to_0.F | awk 'NR == 1{old = $1; next} {print $1 - old - 1; old = $1}') > json_types_diff_0.E_to_0.F_with_counts
paste <(cut json_mod_types_diff_0.E_to_0.F -d : -f 3) <(cut -d : -f 1 json_mod_types_diff_0.E_to_0.F | awk 'NR == 1{old = $1; next} {print $1 - old - 1; old = $1}') > json_mod_types_diff_0.E_to_0.F_with_counts
```

Then reformat into a human-readable summary.
