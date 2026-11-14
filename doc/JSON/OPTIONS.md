<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `json.options`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/options/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/options/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
<!-- CCB-DOC-MOVED-END -->
# Game Options

DDA has a moderately complex system for recording user preferences about the operation of the game, these are called options.  Throughout the game code there are statements of the form get_option<type>( "OPTION_NAME" ), the return values of which are used to adjust the operation of the game.

## Load/override order

The load ordering and override behavior has more accreted than been designed, so it's a bit gnarly.

In main(), we init the option manager and initialize options with hard-coded defaults.
Immediately afterwards we load config/options.json.
In init(), we load json, including data/core/external_options.json.
During world load, we load save/world/worldoptions.json.
Later in world load, we load mods and external options defined there.

The ordering is important, because at each stage, the previous values can be overwritten.

Options must be defined at either the first stage of hardcoded option enumeration or in an external_option json entry. Options not present in one of these two sources, but present in options.json or worldoptions.json are ignored.
config/options.json stores most options, and is persistent across separate game worlds.
save/<world>/worldoptions.json stores just a subset of options that are appropriate to change on a per-world basis, and override options specified in options.json when present.

Options are split into "menu options" and "external options", which are usually separate, but options can be migrated back and forth.
"menu options" are displayed in an in-game menu for adjustment, and are intended to be adjusted by players to tune the game to their liking. Their use is documented within this menu.
"external options" are mostly intended to be used to expose options to mods that have an impact on the game outside the norm for adjustments we expect players to make, though if you have a text editior you can still have at it. Expected uses for these options are included in their entry in data/core/external_options.json

External options that are frequently checked can be cached as variables by declaring them in the cached_options.h and .cpp files. Options that are cached in this way and added to the update_options_cache() function (located around line 4100 of options.cpp) will be used correctly anywhere in the c++ code.

### Hack for migrating menu options
In the case when a menu option is migrated to an external option, it is desirable to have already-adjusted world or global options take precedence over the new external option.
In this case, leave the hard-coded definition of the option in place in options.cpp, but add the COPT_HIDE flag to the definition to hide it from the menu.  If it is a "world_default" type entry, leave it defined as such.  Then add a redundant entry to data/core/external_options.json with the addition of the "stub": true member, which indicates to the loading code that this entry should not override already-set values.
