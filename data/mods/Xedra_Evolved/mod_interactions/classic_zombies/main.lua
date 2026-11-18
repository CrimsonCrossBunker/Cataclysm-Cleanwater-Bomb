local ccb = require("ccb")
local content = ccb.content

-- Hidden effect, exists to keep track of zombie virus resistance
content.add(content.EffectType {
    id = "effect_xe_ddotd_zombie_virus_resistance",
    name = "",
    description = "",
})

content.upsert_effect_type(content.EffectType {
    id = "effect_vampire_immune_to_classic_zombification",
    name = "",
    description = "",
}
    :removes_effect("zombie_virus")
    :removes_effect("zombie_virus_scratch"))
