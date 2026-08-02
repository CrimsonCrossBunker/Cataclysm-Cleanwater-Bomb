<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Moved / 已迁移**
>
> Stable document ID / 稳定文档 ID: `json.map-smashing`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/terrain-and-furniture/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/terrain-and-furniture/
> Moved date / 迁移日期: `2026-08-02`
> Last in-repository commit / 仓库内最后适用 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> The maintained documentation now lives in CCB-Docs.
> This in-repository body is no longer maintained. The historical body is retained through `2027-02-02` and may then be removed; this bilingual entry banner remains permanently.
> 本仓库正文不再维护；历史正文至少保留到上述日期，之后可删除，但本双语迁移入口永久保留。
<!-- CCB-DOC-MOVED-END -->
# Smashing

Smashing is a feature that allows dealing damage to furniture, terrain, and fields on the map.

The "hp" for these objects is determined by subtracting the appropriate `str_max` value from the `str_min` value.

When one of these is smashed, the damage types of the characters weapon are applied to the damage profile of the bashed object to determine damage points. For terrain and furniture, this damage is stored, and once enough damage has been done, it will be destroyed. For fields, it is a (damage/hp) chance.

## Damage Profile

A damage profile defines multipliers for converting each damage type into damage dealt in a smash action.

```jsonc
{
  "id": "my_profile",
  "type": "bash_damage_profile",
  "profile": { "bash": 1.0, "cut": 0.5, "stab": 2.0 }
}
```

Damage points are determined by multiplying the damage of each type of the weapon against the multiplier defined in `profile`, subtracting the `str_min`, then summing.

For damage types not specified, the multiplier is determined by the bash conversion factor specified by the damage type.
