<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `json.faction-missions`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/faction-missions/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/faction-missions/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
<!-- CCB-DOC-MOVED-END -->
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
- [Overview](#overview)
- [Faction Missions](#faction-missions)
<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Overview

Faction Camps (aka basecamps) can send NPC followers on missions to perform some actions.

Those missions are currently mostly hardcoded, but we have begun moving them into JSON, starting
with their descriptions.

# Faction Mission JSON Object

| Field | Required? | Description |
| ----- | --------- | ----------- |
| `"type"` | yes | Must be `"faction_mission"` |
| `"id"` | yes | Unique identifier for the mission, often `"camp_something"` |
| `"name"` | yes | Short name for identifying the mission in a list or header |
| `"desc"` | yes | Longer description of the mission |
| `"skill"` | no | Skill checked and/or trained by performing the mission |
| `"items_label"` | no | First word in "Foo possibilities:" header for list of possible items |
| `"items_possibilities"` | no | Array of names of possible items returned from the mission |
| `"effects"` | no | Array of descriptions of what the mission accomplishes |
| `"risk"` | no | One of `"NONE"`, `"VERY_LOW"`, `"LOW"`, `"MEDIUM"`, `"HIGH"`, `"VERY_HIGH"` |
| `"difficulty"` | no | One of `"NONE"`, `"VERY_LOW"`, `"LOW"`, `"MEDIUM"`, `"HIGH"`, `"VERY_HIGH"` |
| `"activity"` | no | Exercise level, see [Player Activity](../PLAYER_ACTIVITY.md#json-properties) |
| `"time"` | no | Description of how long the mission takes |
| `"positions"` | no | Number of NPCs that can perform this mission at once |
| `"footer"` | no | Text to display at the bottom of the entire description |

## Example

```json
  {
    "type": "faction_mission",
    "id": "camp_gathering",
    "name": "Gathering",
    "desc": "Send a companion to gather materials for the next camp upgrade.",
    "skill": "survival",
    "items_label": "Gathering",
    "items_possibilities": [ "stout branches", "withered plants", "splintered wood" ],
    "risk": "VERY_LOW",
    "activity": "LIGHT_EXERCISE",
    "time": "3 Hours, Repeated",
    "positions": 3
  },
```