<!-- CCB-DOC-MOVED-START -->
> [!IMPORTANT] **Migration in progress / 迁移中**
>
> Stable document ID / 稳定文档 ID: `json.wounds`
> 中文: https://crimsoncrossbunker.github.io/CCB-Docs/reference/json/wounds/
> English: https://crimsoncrossbunker.github.io/CCB-Docs/en/reference/json/wounds/
> Migration start date / 开始迁移日期: `2026-08-02`
> Source commit referenced by the last migration record / 上次迁移记录参考 commit: `0378ca2b84303cf614c617c9d9eaa50138cd21ff`
> CCB-Docs is still a work in progress; the links above are migration targets.
> CCB-Docs 仍在整理中；上方链接为迁移目标。
> Updates to this in-repository body are optional for now, and no comprehensive revision is currently planned. Developers may update it as needed. Some content has not been checked against the current CCB implementation; consult the relevant source code when using or updating it. Documentation may be updated alongside new or changed features. The retained body will serve as a reference for later documentation migration and reorganization, which may rewrite or omit the original text.
> 本仓库正文暂不列入必须更新项，暂不安排全面整理，是否更新由开发者按实际需要决定。部分内容尚未按当前 CCB 实现核实，使用和更新时应检查相关源码。新增或改动功能时，可同步更新相关文档。保留正文将作为后续文档迁移与整理的参考来源，后续整理不保证原文保留。
<!-- CCB-DOC-MOVED-END -->
# Wounds

Wound is a type, that affects specific bodyparts. It's similar in this to effects, but it can be applied only on specific bodyparts, and their ability to be aided/repaired using wound_fix

### wound

```jsonc
  {
    "id": "scratch",
    "type": "wound",
    "name": { "str": "scratch", "str_pl": "scratches" },
    "description": "Foobar.",
    "weight": 10, // weight of a wound, determines the chance of this specific wound to be picked when limb takes damage. Default 1
    "limit": 2, // limits amount of wounds of this type you can get per limb
    "damage_types": [ "cut", "bash" ], // only taking these type of damage can apply wound. Mandatory
    "damage_required": [ 1, 1000 ], // smallest and highest damage that is required for this wound to be applied. Mandatory
    "pain": [ 1, 10 ], // when wound is applied, it would give character this random amount of pain rolled between this two numbers. Default 0
    "healing_time": [ "2 hours", "25 days" ], // how long this wound need time to be fully healed. Rolled randomly when applied, supposed to be adjusted by wound_fix.
            // Default infinite duration
    "wound_progression": [ { "id": "deep_scratch", "chance": 10 } ], // taking damage on bodypart with this limb may worsen it. chance is range from 0% to 100%
    "limb_scores": [ { "score": "lift", "value": 0.25 } ], // if wounded part has this limb score, it will be decreased by this amount
    "whitelist_body_part_types": [ "leg", "arm" ], // if used, this wound can be applied only at bodyparts of this type. Possible values are: head, torso, sensor, mouth, arm, hand, leg, foot, wing, tail, other
    "blacklist_body_part_types": [ "torso", "sensor" ], // if used, this wound cannot be applied on bodyparts of this type.
    "whitelist_bp_with_flag": "LIMB_UPPER", // only body parts with this flag can receive the wound.
    "blacklist_bp_with_flag": "BIONIC_LIMB", // Bodyparts with this flag cannot receive this wound.
  }
```

### Thermal wounds

`thermal_blister` and `thermal_burn` are two grades of the same injury. They
are stored on the affected main body part. A worse burn replaces a blister;
another hit of the same or a lower grade does not restart healing.
The EOC and Lua add-wound operations and `wound_fix.wounds_added` use the
same rule for these two IDs. Specify the contact body part when adding, and
query or remove the wound on its main part. A blocked or same-grade
application does not announce an injury.

Sustained overheating uses the **current temperature of the exposed part**,
not the ambient temperature or its equilibrium target. Heat armor, bark and
heatsinks raise the exposure threshold. This path does not roll `WOUND_CHANCE`.
Only simulated turns count toward exposure. Recalculating temperature again in
the same turn, advancing the calendar without simulation, or reloading a save
does not add exposure. An off-map NPC does not catch up on burns when it returns.
Fire effects replayed during NPC activation can still deal their normal HP
damage, but are not new live hits for temperature impulses or contact burns.
Once a thermal wound is cured or fully heals, continued overheating must build
a fresh dose before causing another injury. `NO_NPC_FOOD` does not disable
temperature changes, drying, or heat exposure for active NPCs.

A direct hit instead uses heat damage remaining after armor and immunity:
4–11 points can blister and 12 or more can burn. A mixed-damage hit rolls
`WOUND_CHANCE` once for both a contact burn and an ordinary wound.
Both heat and cold damage also change the struck part's current temperature,
without replacing the normal HP damage.
If an attack names a standard limb that the character has replaced,
its actual replacement supplies the heat or cold armor and receives the
temperature change; the thermal wound is stored on its resolved main part.
Pain immunity suppresses burn pain, not the wound or its local penalties.
The whole-character effects `pain_relief` and `pain_ceiling` affect perceived
pain only. After painkillers, `pain_ceiling` caps the pain at its intensity;
`pain_relief` then subtracts from that perceived amount, down to zero. Neither changes base
pain, wound severity, or healing progress. Removing an effect reveals the pain
that remains at that time.

Whole-character effects flagged `THERMAL_PAIN_RELIEF` subtract their intensity
from the thermal component alone, before painkillers and the effects above.
Different sources stack, but cannot suppress more than the remaining thermal
pain, even after the wounds heal. `POWERED_THERMAL_PAIN_RELIEF` acts the same
way, but only while a functioning bionic grants that flag. If shutdown or
removal of an implant (including its parent) ends that relief, the character
reacts to the pain that returns, not the nominal intensity of the effect.

`THERMAL_PAIN_CEILING` caps perceived pain at the whole-character effect's
intensity, but only by masking thermal pain. If nonthermal pain alone exceeds
the ceiling after painkillers, it remains felt in full. The strictest active
thermal ceiling applies, before `pain_ceiling` and `pain_relief`.

`HEAT_IMMUNE` prevents both sources of burn. `THERMAL_BURN_PROTECTION`
prevents only new burns and upgrades; it does not nullify heat damage,
freeze body temperature, or heal existing wounds.

### wound_fix

Wound fix is a way for wounds to be treated

```jsonc
  {
    "id": "bandage_the_bleeding",
    "type": "wound_fix",
    "name": "bandage the bleeding",
    "description": "Foobar.",
    "time": "2 hours", // how long it takes to apply this wound fix
    "skills": { "mechanics": 1 }, // skills required to apply fix
    "wounds_removed": [ "scratch" ], // wounds removed when this fix is applied
    "wounds_added": [ "scratch" ], // wounds added when fix is applied
    "success_msg": "Tada.",
    "mod_hp": 10, // if used, the HP of bodypart will be healed by this amount when wound fix is used; negative number will damage the limb instead 
    "requirements": [ [ "gun_cleaning", 1 ] ], // requirements that dictate tools and materials needed to apply this fix
    "proficiencies": [
      {
        "proficiency": "prof_wound_care", // id of prof required
        "time_save": 0.9, // multiplies the would fix time by this amount; default 1.0
        "is_mandatory": true  // if true, lacking this prof would prevent you from using this wound fix
      }
    ]
  }
```