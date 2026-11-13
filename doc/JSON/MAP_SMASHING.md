<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `json.map-smashing`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/terrain-and-furniture/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/terrain-and-furniture/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
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
