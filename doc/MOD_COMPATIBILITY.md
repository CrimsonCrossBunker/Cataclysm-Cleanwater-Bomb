<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Moved / 已迁移**
>
> Stable document ID / 稳定文档 ID: `mod-compatibility`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/modding/compatibility/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/modding/compatibility/
> Moved date / 迁移日期: `2026-08-02`
> Last in-repository commit / 仓库内最后适用 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> The maintained documentation now lives in CCB-Docs.
> This in-repository body is no longer maintained. The historical body is retained through `2027-02-02` and may then be removed; this bilingual entry banner remains permanently.
> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。
<!-- CCB-DOC-MOVED-END -->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
*Contents*

- [Mod Compatibility](#mod-compatibility)
  - [Summary](#summary)
  - [Guide](#guide)
  - [Limitations](#limitations)
  - [Technical Summary](#technical-summary)
    - [Developers](#developers)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Mod Compatibility

## Summary

Mods are capable of dynamically loading directories based on if other mods are loaded in the world.  This will prevent file contents within the mod_interactions folder from being read unless they are part of a folder named after a loaded mod's id.

## Guide

In order to dynamically load mod content, files must be placed within subdirectories named after other mod ids within the mod_interactions folder.

Example:
Mod 1: Mind Over Matter (id:mindovermatter)
Mod 2: Xedra Evolved (id:xedra_evolved)

If Xedra wishes to load a file only when Mind Over Matter is active: mom_compat_data.json, it must be located as such:
Xedra_Evolved/mod_interactions/mindovermatter/mom_compat_data.json

Files located within the mod_interactions folders are always loaded after other mod content for every mod is loaded.

## Limitations

Multi-mod interaction folders are not supported (ie. "mindovermatter/xedra_evolved").

## Technical Summary

When mods are loaded, they are loaded while ignoring every file that is within the "mod_interactions" folder.  After all mods are finished loading then the mod_interaction folder content is loaded is the same order as the initial mods.  Within the mod interaction folders, only folders with names matching loaded mod ids (case sensitive) will be loaded.

### Developers

When a definition from the mod interaction folder is loaded, the src is saved as a combination of the base mod id, a hashtag, and the interaction mod id.  For example a combined id may be "xedra_evolved#mindovermatter".
