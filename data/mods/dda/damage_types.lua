local ccb = require("ccb")
local content = ccb.content

-- Native damage-type definitions
do
local definition = content.DamageType {
    id = "bash",
    name = ccb.content.text("bash", { context = "damage_type" }),
    skill = "bashing",
    magic_color = "magenta",
    bash_conversion_factor = 1.0,
    melee_crit_dmg_mult = 0.5,
    melee_crit_armor_mult = 0.5,
    melee_only = true,
    physical = true,
    monster_difficulty = true,
    material_required = true,
}
definition:immune_character_flag("BASH_IMMUNE")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "cut",
    name = ccb.content.text("cut", { context = "damage_type" }),
    skill = "cutting",
    magic_color = "light_gray",
    bash_conversion_factor = 0.75,
    melee_crit_dmg_mult = 0.25,
    melee_crit_dmg_mult_per_skill = 0.02,
    melee_crit_armor_mult = 0.75,
    melee_crit_armor_penetration = 5,
    melee_only = true,
    physical = true,
    monster_difficulty = true,
    edged = true,
    material_required = true,
}
definition:immune_character_flag("CUT_IMMUNE")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "stab",
    name = ccb.content.text("pierce", { context = "damage_type" }),
    skill = "stabbing",
    magic_color = "light_red",
    bash_conversion_factor = 0.6,
    melee_crit_dmg_mult_per_skill = 0.1,
    melee_crit_armor_mult = 0.66,
    melee_only = true,
    physical = true,
    monster_difficulty = true,
    edged = true,
}
definition:derived("cut", 0.8)
definition:immune_character_flag("STAB_IMMUNE")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "bullet",
    name = ccb.content.text("ballistic", { context = "damage_type" }),
    magic_color = "light_red",
    bash_conversion_factor = 0.5,
    physical = true,
    monster_difficulty = true,
    material_required = true,
}
definition:immune_character_flag("BULLET_IMMUNE")
definition:immune_monster_flag("BULLETPROOF")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "acid",
    name = ccb.content.text("acid", { context = "damage_type" }),
    magic_color = "light_green",
    physical = false,
    environmental = true,
    material_required = true,
}
definition:derived("cut", 0.5)
definition:immune_character_flag("ACID_IMMUNE")
definition:immune_monster_flag("ACIDPROOF")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "electric",
    name = ccb.content.text("electric", { context = "damage_type" }),
    magic_color = "light_blue",
    physical = false,
}
definition:immune_character_flag("ELECTRIC_IMMUNE")
definition:immune_monster_flag("ELECTRIC")
definition:immune_monster_flag("ELECTRIC_FIELD")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "heat",
    name = ccb.content.text("fire", { context = "damage_type" }),
    magic_color = "red",
    physical = false,
    environmental = true,
    material_required = true,
}
definition:immune_character_flag("HEAT_IMMUNE")
definition:immune_monster_flag("FIREPROOF")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "cold",
    name = ccb.content.text("cold", { context = "damage_type" }),
    magic_color = "white",
    physical = false,
}
definition:immune_character_flag("COLD_IMMUNE")
definition:immune_monster_flag("COLDPROOF")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "biological",
    name = ccb.content.text("biological", { context = "damage_type" }),
    magic_color = "green",
    bash_conversion_factor = 0.0,
    physical = false,
    no_resist = true,
}
definition:immune_character_flag("BIO_IMMUNE")
definition:immune_monster_flag("BIOLOGICALPROOF")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "pure",
    name = ccb.content.text("pure", { context = "damage_type" }),
    magic_color = "dark_gray",
    physical = false,
    no_resist = true,
}
content.add(definition)
end
