<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `legacy.doc-release-diff`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/maintenance/releases/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/maintenance/releases/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
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
