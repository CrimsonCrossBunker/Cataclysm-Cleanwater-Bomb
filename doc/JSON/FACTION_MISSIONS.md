<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Moved / 已迁移**
>
> Stable document ID / 稳定文档 ID: `json.faction-missions`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/faction-missions/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/faction-missions/
> Moved date / 迁移日期: `2026-08-02`
> Last in-repository commit / 仓库内最后适用 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> The maintained documentation now lives in CCB-Docs.
> This in-repository body is no longer maintained. The historical body is retained through `2027-02-02` and may then be removed; this bilingual entry banner remains permanently.
> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。
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