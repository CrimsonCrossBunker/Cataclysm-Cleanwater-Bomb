local ccb = require("ccb")
local content = ccb.content

-- Native damage-type definitions
do
local definition = content.DamageType {
    id = "afs_plasma",
    name = ccb.content.text("plasma", { context = "damage_type" }),
    magic_color = "pink",
    bash_conversion_factor = 0.4,
    physical = true,
}
definition:derived("heat", 0.4)
content.add(definition)
end
do
local definition = content.DamageType {
    id = "afs_laser",
    name = ccb.content.text("laser", { context = "damage_type" }),
    magic_color = "red",
    bash_conversion_factor = 0.4,
    physical = true,
}
definition:derived("heat", 1)
content.add(definition)
end
do
local definition = content.DamageType {
    id = "afs_heat_melee",
    name = ccb.content.text("heat", { context = "damage_type" }),
    skill = "cutting",
    magic_color = "red",
    bash_conversion_factor = 0.7,
    melee_crit_dmg_mult = 0.25,
    melee_crit_dmg_mult_per_skill = 0.02,
    melee_crit_armor_mult = 0.75,
    melee_crit_armor_penetration = 5,
    melee_only = true,
    physical = true,
    monster_difficulty = true,
    edged = true,
}
definition:derived("heat", 1)
definition:immune_character_flag("CUT_IMMUNE")
content.add(definition)
end
