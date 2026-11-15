<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `json.dimensions`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/dimensions/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/dimensions/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
<!-- CCB-DOC-MOVED-END -->
# Dimensions
Dimensions are defined in `json\region_settings\region_settings\dimensions\dimensions.json` like so:
```json
{
	"type": "dimension",
	"id": "default",
	"region_layout": "default"
}
```

Currently they only specify a [region_layout](REGION_LAYOUT.MD).

Dimensions are stored within a save folder, they are mostly disconnected from the "main" dimension, aka the dimension stored above `/dimensions` folder.
When travelling between them, you aren't travelling as much as you are "switching" which dimension data folder is loaded right now. There's almost no distinction between creating a dimension and loading into it.

By design, you aren't allowed to alter world data of unloaded dimensions. Meaning you can't place down structures in unloaded dimensions, place down NPCs, assign missions requiring a location inside the dimension, you can't even view the unloaded dimensions on an in-game map.

To get around this, we need to do all our world alterations/queries when travelling into the dimension.

Warping player to a dimension `portal_cell`, updating the location they teleported with a portal_cell structure and then teleporting the player inside:
```jsonc
    { "u_location_variable": { "global_val": "cell_loc" }, "z_adjust": 0, "z_override": true },
    { "u_location_variable": { "global_val": "cell_roof_loc" }, "z_adjust": 1, "z_override": true },
    { "u_travel_to_dimension": "portal_cell" },
    { "mapgen_update": "portal_cell_roof", "target_var": { "global_val": "cell_roof_loc" } },
    { "mapgen_update": "portal_cell", "target_var": { "global_val": "cell_loc" } },
    {
    "u_location_variable": { "context_val": "player_teleport_loc" },
    "terrain": "t_floor_warped",
    "target_max_radius": 60
    },
    { "u_teleport": { "context_val": "player_teleport_loc" } }
```

## NPCs

When using `u_travel_to_dimension` EOC, you can choose to take the nearby NPCs with you. In technical terms, When the dimension is being unloaded, the chosen NPCs aren't unloaded and they get to come with you.

Travel to dimension `test`, take any follower within 10 tiles of your avatar with you.
```jsonc
{"u_travel_to_dimension":"test","npc_travel_radius":10,"npc_travel_filter":"follower"}
```
There are also `all` and `enemy` filters you can use.

## Items

When using `u_travel_to_dimension` EOC, you can choose to take the nearby items with you.

Travel to dimension `test`, take any item within 3 tiles of your avatar with you.
```jsonc
{ "u_travel_to_dimension": "test", "item_travel_radius": 3 }
```

If you pass a location variable in `target_location`, the function will use that as the center point for where to get items from and where to place items after the shift.
```jsonc
{ "u_travel_to_dimension": "test", "item_travel_radius": 3, "target_location": { "u_val": "debug_loc" } }
```

All of the items transferred as part of the shift will be placed on the player's location, or `target_location` if set. Any items that do not fit in that tile will spill outwards from that point until all of them can be placed.

## Cleanup

If you want the overworld terrain to be regenerated, you can use the `clear_dimension` EOC function:

```jsonc
{"clear_dimension":"test"}
```

This will delete the dimension's folder inside `/SAVEFOLDER/dimensions/<dimension_id>`.
You can still `u_travel_to_dimension` into it, but the overworld terrain, items, vehicles, monsters, NPCs, faction hubs and all that will be regenerated in different locations.
You can also supply a different `region_type` value when re-generating a dimension, if for some reason you want that.
