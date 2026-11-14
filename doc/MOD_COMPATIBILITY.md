<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `mod-compatibility`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/modding/compatibility/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/modding/compatibility/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
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
