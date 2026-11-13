<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `json-item-variants`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/json/item-variants/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/json/item-variants/
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

- [Variants](#variants)
  - [What variants cannot do](#what-variants-cannot-do)
  - [Issues](#issues)
  - [Criteria](#criteria)
  - [Guns and drugs](#guns-and-drugs)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Variants

Variants, added in [#51613](https://github.com/CleverRaven/Cataclysm-DDA/pull/51613) and [#46814](https://github.com/CleverRaven/Cataclysm-DDA/pull/46814) are CDDAs solution to allowing the same item have different names. It's used in guns to have generic or specific names changeable with a setting, or in items such as clothing to have lots of different colors without having a bunch of essentially duplicate entries for an item. They can be weighted, meaning different variants have a different chance of showing up when the base item is spawned. They're a great way to add extra variety to the game at a low cost to both effort, and file sizes. The information on how variants are defined shares the same doc as snippets, [here](../JSON/JSON_INFO.md#snippets).  This doc aims to provide contributors with a good idea of what is, and isn't acceptable as variants.

Do note that for some items, such as newspapers where the description changes and the name does not, [snippets](../JSON/JSON_INFO.md#snippets) may be better. There's also snippets in the form of conditional names, which can allow what are essentially variants in a more nuanced way, such as changing the name of an item depending on crafting materials, instead of a bunch of crafting recipes for different variants.  

## What variants cannot do

Variants cannot change any stat of an item, besides the name, description, color, sprite, and symbol. They're nothing more than an aesthetic change and have no impact on gameplay. 

## Issues

As cool as variants are, sometimes issues can arise if there are too many variants of an item with nothing to reign them in. As an example, condoms had a few joke flavors that didn't make sense. This then snowballed into other items having variants that were nothing more than jokes, such as chewing gum having fart, cat hairball, and zombie flavors. Another issue is that more variants complicate translating, making an already difficult job even more difficult.

## Criteria 

Variants should add meaningful variety to CDDA. They should be distinct from other variants and also be reasonably attainable in the real world, and not be overly specific or detailed. There isn't any hard number on the amount of variants that are acceptable, as it can vary greatly from item to item. 

Don't be overzealous with joke variants, one joke variant alone is not likely to be accepted, and multiple joke variants are even less likely.

## Guns and drugs

The way guns and drugs use variants is a bit different from other variants, as they use variants to have different names depending on options. This is to provide alternate titles for people who may be more or less familiar with common names of these items. For the way guns use please see the extensive guidelines at [GUN_NAMING_AND_INCLUSION.md](../GUN_NAMING_AND_INCLUSION.md), and for drugs follow this [example](https://github.com/CleverRaven/Cataclysm-DDA/blob/cdda-experimental-2025-02-02-1030/data/json/items/comestibles/med.json#L1579-L1601) with Prozac/antidepressants. 

