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

All files here in data/json are read eventually, but the order in which they're
read can be important for objects with dependencies on other kinds of objects
(e.g. recipes depend on skills). Ensuring the proper loading order will prevent
surprises that, most often, manifest as crash-to-desktop with segfault (a very
bad thing).

The way Cataclysm finds and loads json files is by running a breadth-first
search in the tree data/json/. This means `data/json/whatever.json` will
**always** be read before `data/json/subdir/whatever.json`. This tells us how to
ensure dependency loading order.

For instance, if you have scenarios that depend on professions that depend on
skills, you'll want a directory structure such as the following:

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

## Same-depth loading order ##

Note that, when files (or directories) are at the same depth
(i.e. all in `data/json/`), they will be read in lexical order, which is
more or less equivalent to alphabetical order for file names that use only
ascii characters. For UTF-8 or otherwise non-ascii file names, the names will be
ordered by codepoint.
