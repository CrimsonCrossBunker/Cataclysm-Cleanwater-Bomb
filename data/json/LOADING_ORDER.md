<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Moved / 已迁移**
>
> Stable document IDs and last commits / 稳定文档 ID 与最后 commit:
> - `legacy.data-json-loading-order`: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> - `legacy.doc-json-json-loading-order`: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/loading-order/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/loading-order/
> Moved date / 迁移日期: `2026-08-02`
> The maintained documentation now lives in CCB-Docs.
> This in-repository body is no longer maintained. The historical body is retained through `2027-02-02` and may then be removed; this bilingual entry banner remains permanently.
> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。
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
