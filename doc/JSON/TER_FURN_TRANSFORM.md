<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Moved / 已迁移**
>
> Stable document ID / 稳定文档 ID: `json.terrain-furniture-transforms`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/terrain-furniture-transforms/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/terrain-furniture-transforms/
> Moved date / 迁移日期: `2026-08-02`
> Last in-repository commit / 仓库内最后适用 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> The maintained documentation now lives in CCB-Docs.
> This in-repository body is no longer maintained. The historical body is retained through `2027-02-02` and may then be removed; this bilingual entry banner remains permanently.
> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。
<!-- CCB-DOC-MOVED-END -->
# Terrain and Furniture Transforms

A `ter_furn_transform` is a type of json object that allows you to specify a transformation of a "tile" from one type to another.  Tile in this context can refer to field, furniture, terrain or trap.

```jsonc
[
  {
    "type": "ter_furn_transform",
    "id": "example",
    "terrain": [
      {
        "result": "t_dirt",
        "valid_terrain": [ "t_sand" ],
        "message": "sandy!",
        "message_good": true
      }
    ]
  }
]
```

The example above turns `terrain` "sand" into "dirt". It does so by comparing the direct terrain IDs.

If, however, we wanted to turn sand into "dirt or grass" we can do:

```jsonc
"terrain": [
  {
    "result": [ "t_dirt", "t_grass" ],
    "valid_terrain": [ "t_sand" ],
    "message": "sandy!"
  }
]
```

`message_good` is optional and defaults to true.  The example chooses either dirt or grass at a 1:1 ratio, which can be modified to a 4:1 ratio:

```jsonc
"terrain": [
  {
    "result": [ [ "t_dirt", 4 ], "t_grass" ],
    "valid_terrain": [ "t_sand" ],
    "message": "sandy!"
  }
]
```

As you can see, you can mix and match arrays with weights with single strings.  Each single string has a weight of 1.

All of the above applies to `fields`, `furniture`, and `traps` as well.

```jsonc
"field": [
  { "result": "fd_null", "valid_field": [ "fd_fire" ], "message": "The fires suddenly vanishes!", "message_good": true }
],
"furniture": [
  {
    "result": [ [ "f_null", 4 ], "f_chair" ],
    "valid_furniture": [ "f_hay", "f_woodchips" ],
    "message": "I need a chair"
  }
]
```

You can also use flags instead of specific IDs for furniture, terrain and traps.

```jsonc
"terrain": [
  {
    "result": "t_dirt",
    "valid_flags": [ "DIGGABLE" ],
    "message": "digdug"
  }
]
```

A `ter_furn_transform` can have field, furniture, terrain, and trap fields.  It treats them separately, so no "if dirt, add chair".


## How to use

`ter_furn_transform` can be declared by [effect on conditions](EFFECT_ON_CONDITION.md#u_transform_radiusnpc_transform_radius), [mapgen](MAPGEN.md#apply-mapgen-transformation-with-ter_furn_transforms), and spells (see the spell effects at [MAGIC.md](MAGIC.md#spell-effects).)
