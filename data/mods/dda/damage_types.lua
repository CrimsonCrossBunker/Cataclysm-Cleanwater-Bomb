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
-- Native damage-info order definitions
do
local definition = content.DamageInfoOrder {
    id = "bash",
    display = "detailed",
    verb = ccb.content.text("bashing"),
}
definition:section("bionic", 100, true)
definition:section("protection", 100, true)
definition:section("pet_protection", 100, true)
definition:section("melee", 100, true)
definition:section("ablative", 100, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "cut",
    display = "detailed",
    verb = ccb.content.text("cutting"),
}
definition:section("bionic", 200, true)
definition:section("protection", 200, true)
definition:section("pet_protection", 200, true)
definition:section("melee", 200, true)
definition:section("ablative", 200, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "stab",
    display = "detailed",
    verb = ccb.content.text("piercing"),
}
definition:section("bionic", 300, true)
definition:section("protection", 400, true)
definition:section("pet_protection", 400, false)
definition:section("melee", 300, true)
definition:section("ablative", 400, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "bullet",
    display = "detailed",
    verb = ccb.content.text("shooting"),
}
definition:section("bionic", 400, true)
definition:section("protection", 300, true)
definition:section("pet_protection", 300, true)
definition:section("melee", 400, false)
definition:section("ablative", 300, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "acid",
    display = "basic",
    verb = ccb.content.text("corroding"),
}
definition:section("bionic", 500, true)
definition:section("protection", 800, true)
definition:section("pet_protection", 500, true)
definition:section("melee", 500, false)
definition:section("ablative", 500, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "electric",
    display = "detailed",
    verb = ccb.content.text("shocking"),
}
definition:section("bionic", 600, true)
definition:section("protection", 700, true)
definition:section("pet_protection", 700, false)
definition:section("melee", 600, false)
definition:section("ablative", 600, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "heat",
    display = "basic",
    verb = ccb.content.text("burning"),
}
definition:section("bionic", 700, true)
definition:section("protection", 900, true)
definition:section("pet_protection", 600, true)
definition:section("melee", 700, false)
definition:section("ablative", 700, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "cold",
    display = "detailed",
    verb = ccb.content.text("freezing"),
}
definition:section("bionic", 800, true)
definition:section("protection", 500, true)
definition:section("pet_protection", 800, false)
definition:section("melee", 800, false)
definition:section("ablative", 800, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "biological",
    display = "detailed",
}
definition:section("bionic", 900, true)
definition:section("protection", 600, true)
definition:section("pet_protection", 900, false)
definition:section("melee", 900, false)
definition:section("ablative", 900, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "pure",
    display = "none",
}
definition:section("bionic", 999999, false)
definition:section("protection", 999999, false)
definition:section("pet_protection", 999999, false)
definition:section("melee", 999999, false)
definition:section("ablative", 999999, false)
content.add(definition)
end
