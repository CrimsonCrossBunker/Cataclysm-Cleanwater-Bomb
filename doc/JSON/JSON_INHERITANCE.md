<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `json.inheritance`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/inheritance/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/inheritance/
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

- [JSON Inheritance](#json-inheritance)
  - [Examples](#examples)
  - [Support](#support)
  - [Behavior](#behavior)
  - [Guidelines](#guidelines)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# JSON Inheritance

To reduce duplication in the JSON data, it is possible for _some_ JSON `type`s to inherit from existing objects.  Some restraint should be used, see [Guidelines](#guidelines) section.  It is important to note that inheritance is not always completely standard between `type`s.  See the [Behavior](#behavior) section for further details.

## Examples

Items are one of the most common JSON types, so the "subtypes" field splits data into optional chunks. See [the item docs](ITEM.md#subtypes) for an explanation of how it works.

In the following example, `556` ammo is derived from `223` ammo via `copy-from`:

```jsonc
  {
    "id": "223",
    "type": "ITEM",
    "subtypes": [ "AMMO" ],
    "name": { "str_sp": ".223 Remington" },
    "description": ".223 Remington ammunition with a 55gr FMJ-BT bullet, patterned after the M193 loading.  The .223 round has been very popular with civilian shooters for almost a century, finding use in a wide variety of weapons.  The combination of high velocity with a thinly-jacketed, cannelured projectile led to unexpected yaw and fragmentation in soft tissue, increasing this round's performance.",
    "ascii_picture": "223",
    "weight": "12 g",
    "volume": "194 ml",
    "longest_side": "57 mm",
    "price": "2 USD 80 cent",
    "price_postapoc": "9 USD",
    "flags": [ "IRREPLACEABLE_CONSUMABLE" ],
    "material": [ "brass", "lead", "powder" ],
    "//": "`symbol` through `range` omitted for brevity",
    "damage": {
      "damage_type": "bullet",
      "amount": 39,
      "armor_penetration": 2,
      "barrels": [
        "... omitted for brevity"
      ]
    },
    "dispersion": 30,
    "dispersion_modifier": [ { "barrel_length": "337 mm", "dispersion": 30 }, { "barrel_length": "533 mm", "dispersion": 0 } ],
    "recoil": 1500,
    "effects": [ "COOKOFF" ]
  },
  {
    "id": "556",
    "copy-from": "223",
    "type": "ITEM",
    "subtypes": [ "AMMO" ],
    "name": { "str_sp": "5.56 NATO M855" },
    "material": [ "steel", "brass", "lead", "powder" ],
    "description": "5.56x45mm ammunition with a 62gr FMJ bullet containing a steel penetrator.  Originally designed for the M249 FN Minimi, M855 was designed to penetrate steel helmets and light cover at range, sacrificing terminal performance and accuracy in the process.  The limited yaw and fragmentation is worsened with shorter-barreled carbines shooting this round, and optimization of barrel twist for stabilization of the tracer variant of M855 has resulted in lackluster accuracy overall.",
    "ascii_picture": "556",
    "price": "2 USD 90 cent",
    "price_postapoc": "9 USD",
    "flags": [ "IRREPLACEABLE_CONSUMABLE" ],
    "relative": { 
      "damage": { "damage_type": "bullet", "amount": -3, "armor_penetration": 10 }, 
      "dispersion": 20 
    },
    "dispersion_modifier": [ { "barrel_length": "337 mm", "dispersion": 120 }, { "barrel_length": "533 mm", "dispersion": 0 } ],
    "proportional": { "recoil": 1.1 },
    "extend": { "effects": [ "INCENDIARY" ] }
  },
```

For `"type": "ITEM"`, the following rules apply:

* Missing fields, such as `weight`, `volume`, `material` and so on have the same value as the parent.
* Fields explicitly specified replace those of the parent type.  The above example replaces `name`, `description` and `price`.
* Numeric values may be specified `relative` to the parent.  For example `556` has less `damage` but more `armor_penetration` than `223` and will maintain this relationship if the definition for `223` is changed.
  * Note the syntax for fields that support objects: `damage` is still defined as an object for `relative`, with missing fields having the same value as the parent.
* Flags can be added via `extend`.  As an example, you can make it `INCENDIARY`.  Any existing flags specified from `223` are preserved.
* The entry you copied from must be of the same `type` as the item you added or changed.  Not all `type`s are supported, and not all are supported in the same way.  See [Support](#support) and [Behavior](#behavior) below).


Another example.  Reloaded ammo is derived from the factory equivalent but with a 10% penalty to `damage` and `dispersion` and. Additional rules apply:

```jsonc
  {
    "id": "reloaded_556",
    "copy-from": "556",
    "type": "ITEM",
    "subtypes": [ "AMMO" ],
    "name": { "str_sp": "5.56 NATO, reloaded" },
    "proportional": { 
      "price": 0.7, 
      "damage": { "damage_type": "bullet", "amount": 0.9 }, 
      "dispersion": 1.1 
    },
    "extend": { "effects": [ "RECYCLED" ] },
    "delete": { "flags": [ "IRREPLACEABLE_CONSUMABLE" ] }
  },
```

* Chained inheritance is possible.  For example, `reloaded_556` inherits from `556`, which is itself derived from `223`.
* Numeric values may be specified as `proportional` to the parent by via a decimal factor.  Here `reloaded_556` deals 90% of the damage of the factory equivalent with 110% dispersion.
* Flags can be deleted via `delete`.  It is not an error if the deleted flag does not exist in the parent.


Not all `type`s work the same.  For `"type": "MONSTER"`, `relative` uses different fields than `"type": "ITEM"`:

```jsonc
    "//": "MONSTER uses melee_damage, melee_dice and melee_dice_sides.",
    "relative": { 
      "melee_dice": 1, 
      "melee_dice_sides": 5, 
      "melee_damage": [ { "damage_type": "cut", "amount": 2 } ] 
	  },
```

Same as above, now with `proportional`:

```jsonc
    "proportional": { "hp": 1.5, "speed": 1.5, "attack_cost": 1.5, "melee_damage": [ { "damage_type": "cut", "amount": 0.8 } ] },
```


It is possible to define an `abstract` ID that exists only for other objects to inherit from and cannot itself be used in game.  This is done to facilitate maintenance and reduce line count.  In the following condensed example, `magazine_belt` provides values common to all implemented ammo belts:

```jsonc
{
    "abstract": "magazine_belt",
    "type": "ITEM",
    "subtypes": [ "ARMOR", "MAGAZINE" ],
    "name": { "str": "ammo belt" },
    "description": "An ammo belt consisting of metal linkages which disintegrate upon firing.",
    "volume": "0 ml",
    "price": "0 cent",
    "material": [ "steel" ],
    "symbol": "#",
    "color": "light_gray",
    "flags": [ "MAG_BELT", "MAG_DESTROY", "BELTED", "OVERSIZE", "WATER_FRIENDLY", "ZERO_WEIGHT" ],
    "armor": [
      {
        "material": [ { "type": "steel", "covered_by_mat": 100, "thickness": 0.1 } ],
        "encumbrance": 10,
        "coverage": 10,
        "covers": [ "torso" ],
        "specifically_covers": [ "torso_upper" ]
      }
    ]
  }
```

The following additional rules apply:

* Abstract objects still run through the type's loader. Required fields must be supplied or inherited; discarding abstracts after loading does not waive validation. For `ITEM`, `volume` is optional, not an example of a mandatory field that abstracts may omit.
* Missing optional fields are set to the usual defaults for that type.


## Support

The following `type`s currently support inheritance (non-exhaustive list):

```
effect_on_condition
furniture
harvest
ITEM
item_group
material
MONSTER
MONSTER_FACTION
mutation
overmap_terrain
recipe
scenario
SPELL
terrain
uncraft
vehicle_part
vitamin
```
`overmap_special` and `city_building` only partially support `copy-from`
- Mutable specials will extend `check_for_locations_area` if `check_for_locations` is not specified 

To check inheritance support in CCB, follow the registered loader in the current source:
* Find the JSON `type` in [init.cpp](../../src/init.cpp), for example `add( "gate", &gates::load );`.
* Open the implementation of that loader. In [gates.cpp](../../src/gates.cpp), `gates::load` delegates to `gates_data.load( jo, src );`, where `gates_data` is declared as `generic_factory<gate_data> gates_data( "gate type" );`.
* A loader that delegates to `generic_factory::load` uses the inheritance handling in [generic_factory.h](../../src/generic_factory.h). For a type that does not delegate to a factory, inspect its manual `copy-from` handling instead; `item_group` is one such case.
* An include of `generic_factory.h`, or an unrelated factory elsewhere in the same file, does not establish support for the type being checked.
* To check individual modifiers, follow the member's loading code as well. Whole-object inheritance does not guarantee that every member supports the same modifiers.


## Behavior

Support for `copy-from` does not imply support for `extend`, `delete`, `proportional` and `relative` on every member. Some loaders handle these modifiers manually; others use shared readers in [generic_factory.h](../../src/generic_factory.h). The member's loader or reader determines which modifiers work and whether an explicitly supplied value replaces or merges with inherited data.

Check the current CCB source and working examples when behavior is uncertain. The following cases need particular care (non-exhaustive list):
* `item_group` only accepts `copy-from` referring to an already loaded group with the same ID. Add entries under `extend`; it cannot copy from a group with a different ID. See [item group extension](ITEM_SPAWN.md#adding-to-item-groups).
* `monstergroup` does not read `copy-from`. Redefining an existing group with the same ID appends monster entries by default; use `"override": true` to replace the group instead. This behavior is implemented in [mongroup.cpp](../../src/mongroup.cpp).
* `SPELL.flags` preserves inherited flags when omitted and adds to them when explicitly supplied. Its manual loader does not implement `extend`/`delete` for flags. Check the spell's effect as well when changing its behavior; see [magic.cpp](../../src/magic.cpp).
* `material.vitamins` replaces inherited entries when supplied directly. Use `extend` or `delete` to modify inherited entries instead; see [material.cpp](../../src/material.cpp).
* `vitamin` supports `copy-from`; the container fields `flags`, `disease`, `disease_excess` and `decays_into` accept `extend`/`delete`. The optional numeric field `max` accepts `relative` and `proportional`, whereas mandatory `min` and `rate` do not. See [vitamin.cpp](../../src/vitamin.cpp).


## Guidelines

Contributors are encouraged to not overuse `copy-from`, as it can decrease the human readability of the JSON.  Chained inheritance is especially likely to become unwieldy, essentially recreating the level of redundancy we'd like to eliminate.

In general, there are two situations where `copy-from` should be used in the core game:

* Two things are _nearly identical_ variants of each other.
  * If they're pretty much identical (e.g. everything except for their descriptions can be kept, there are only decorative differences, there are no mechanical differences, or in the case of [guns](/doc/GUN_NAMING_AND_INCLUSION.md#difference-threshold) minor value differences), they can be handled as [variants](JSON_INFO.md#snippets) (scroll down to the variant example).
* A group of entities always (not almost always, always) shares some set of properties, then one or two levels of abstracts can set up a very shallow and narrow hierarchy.
