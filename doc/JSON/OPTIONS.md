<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Moved / 已迁移**
>
> Stable document ID / 稳定文档 ID: `json.options`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/options/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/options/
> Moved date / 迁移日期: `2026-08-02`
> Last in-repository commit / 仓库内最后适用 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> The maintained documentation now lives in CCB-Docs.
> This in-repository body is no longer maintained. The historical body is retained through `2027-02-02` and may then be removed; this bilingual entry banner remains permanently.
> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。
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
"menu options" are displayed in an in-game menu for adjustment, and are intended to be adjusted by plyters to tune the game to their liking. Their use is documented within this menu.
"external options" are mostly intended to be used to expose options to mods that have an impact on the game outside the norm for adjustments we expect players to make, though if you have a text editior you can still have at it. Expected uses for these options are included in their entry in data/core/external_options.json

### Hack for migrating menu options
In the case when a menu option is migrated to an external option, it is desirable to have already-adjusted world or global options take precedence over the new external option.
In this case, leave the hard-coded definition of the option in place in options.cpp, but add the COPT_HIDE flag to the definition to hide it from the menu.  If it is a "world_default" type entry, leave it defined as such.  Then add a redundant entry to data/core/external_options.json with the addition of the "stub": true member, which indicates to the loading code that this entry should not override already-set values.
