<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document IDs and source commits referenced by the last migration record / 稳定文档 ID 与上次迁移记录参考 commit:
> - `legacy.data-json-loading-order`: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> - `legacy.doc-json-json-loading-order`: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/loading-order/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/loading-order/
> Migration start date / 开始迁移日期: `2026-08-02`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
<!-- CCB-DOC-MOVED-END -->
# JSON Loading Order #

Within each loaded data root, CCB reads JSON files in breadth-first order. Files
in the root directory are read before files in its subdirectories. For example,
`data/json/whatever.json` is read before `data/json/subdir/whatever.json` when
`data/json/` is loaded as one root.

File order can matter when a loader needs an object that has already been
loaded. However, some dependencies are resolved later: types using
`generic_factory` defer `copy-from` objects whose parents are not yet available
and retry them during dependency resolution. See [JSON Inheritance](../../doc/JSON/JSON_INHERITANCE.md)
for type-specific behavior. Directory depth alone does not establish that a
dependency is valid.

For example, this directory structure loads skills before professions, then
scenarios; it illustrates file order rather than a required content layout:

```
data/json/
  skills.json
  professions/
    professions.json
    scenarios/
      scenarios.json
```

Which results in a loading order of: `skills.json` then `professions.json` and
then `scenarios.json`.

These rules apply separately to each data root, not to the order in which mods
are loaded. Mod interaction data is excluded from the ordinary mod scan and
loaded separately. Within a JSON array, objects are loaded in array order.
The file traversal is implemented in [filesystem.cpp](../../src/filesystem.cpp);
file loading and mod interactions are handled in [init.cpp](../../src/init.cpp).

## Same-depth loading order ##

Note that, when files (or directories) are at the same depth
(i.e. all in `data/json/`), they will be read in lexical order, which is
more or less equivalent to alphabetical order for file names that use only
ASCII characters. The comparison uses filesystem path ordering, not
locale-aware alphabetical sorting; do not rely on a universal Unicode
codepoint order for non-ASCII names across platforms.
