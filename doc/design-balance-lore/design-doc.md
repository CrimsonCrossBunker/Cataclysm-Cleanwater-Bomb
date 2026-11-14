<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `design-overview`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/design/overview/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/design/overview/
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

- [Design - Design Doc Overview](#design---design-doc-overview)
  - [About this Page](#about-this-page)
    - [How to Understand the Design Docs](#how-to-understand-the-design-docs)
  - [Design Overview](#design-overview)
  - [Table of Contents](#table-of-contents)
      - [Game Design and Balance](#game-design-and-balance)
      - [Lore and Setting](#lore-and-setting)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Design - Design Doc Overview

## About this Page

This is the Cataclysm: DDA design document.  It is meant for designer-end planning and goal unity for an open ended project.  It is not meant to be a user facing document!  In other words, **spoiler alert**.  Do not read this document if you have no intention of contributing to the project and do not want your play experience spoiled.

### How to Understand the Design Docs

These documents are, as much as possible, split into two broad categories: **Lore** and **Design**.  Not everything splits perfectly along these lines.  Documents flagged with "design" in the title can be assumed to contain fewer spoilers about the story of the game, and are intended to guide and inspire contributors for individual additions as well as to help new and old contributors, and the occasional curious player with no intent to contribute, to understand the overarching plan for the project over the years to come: what game are we trying to make, and how will it play.  Most of this stuff is unlikely to change over time, aside from being clarified and expanded as needed.

Pages flagged with "lore" in the title are a different beast.  These pages describe a general intent for how the story of the game *may* come to be shaped.  This lore is described in detail so that contributors wishing to expand NPCs, dialogue, lab snippets, and more can be on the same page in general.  However, the specifics of how lore is added to the game by contributors can change the nature of the story over time: in specific, if someone has a great idea that fits the game well and improves design space or gameplay, we will often adjust the details of the background lore to make room for it.  As such, the lore documents may contain information that conflicts with recent additions to the game, or recent statements by developers, or even with each other.  The ultimate arbiter of the lore is the word of Kevin, which trumps anything in game or in these documents.  Other developers similarly often overrule what is written in here, and if errors are spotted, feel free to request an update to the design docs.  **Players choosing to read lore docs should be aware of this**.  I do not recommend using them to guide your understanding of the game, they tell a different story than the one we want to face survivors.

## Design Overview

Cataclysm: Dark Days Ahead DDA is a turn-based survival RPG set in an expansive post-apocalyptic game world based on our own. Explore, fight and survive against a broad variety of challenges, from zombies and otherworldly menaces to bad weather and wound infection.

The core tenet of Dark Days Ahead game design and balance is that if it works in reality, it should work in the game.  Scavenge and craft makeshift weapons, improvise shelter, outmaneuver enemies, find, repair and drive vehicles.  Deal with monsters using your brains, melee weapons, firearms, traps, explosives, other monsters, fire, and if all else fails, a truck or two.  This grounding results in sometimes unexpected inversions of gaming tropes, where storage capacity of clothing is more important than armor, or weight of highly effective gear outweighs its effectiveness.

Gameplay should focus on an open, unguided sandbox where the challenges presented to the player are believable within the game world and do not feel as if they were built just to be challenges.  The player should feel like an observer and influencer in a world that would continue to live and exist without their impact.  There are several modes of gameplay, from wandering the wastes and exploring ruins as a lone survivor or part of a small team, to vehicle design and base construction, to maintaining and growing a faction of fellow survivors.

There is no single antagonist nor storyline to DDA: the narrative should feel like "protagonist vs. the world", primarily.  The principle enemies of the game are zombies and other monsters, but can also include hostile human factions.  We encourage the addition of storylines within factions and among NPCs in game, but these should not become the story of the *game*, just of that faction.

## Table of Contents

#### Game Design and Balance
* [User Experience](./design-user-experience.md)
* [Gameplay](./design-gameplay.md)
* [Game Balance](./design-balance.md)

#### Lore and Setting
* [Story and Narrative Overview](./lore.md)
* [Technology](./technology.md)
* [Background](./lore-background.md) - provides more information on the timeline of events leading up to the Cataclysm
* [Factions](./lore-factions.md) - in-depth discussion of in-game factions and how they should affect gameplay