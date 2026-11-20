local ccb = require("ccb")
local content = ccb.content

-- Native damage-type definitions
do
local definition = content.DamageType {
    id = "xe_cold_iron_cut_damage",
    name = ccb.content.text("cold iron cut"),
    skill = "cutting",
    magic_color = "light_gray",
    bash_conversion_factor = 0.75,
    melee_crit_dmg_mult = 0.25,
    melee_crit_dmg_mult_per_skill = 0.02,
    melee_crit_armor_mult = 0.75,
    melee_crit_armor_penetration = 5,
    physical = true,
}
definition:derived("cut", 1)
definition:immune_character_flag("IRONSWORN")
definition:immune_monster_flag("IRONWROUGHT")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "xe_cold_iron_bash_damage",
    name = ccb.content.text("cold iron bash"),
    skill = "bashing",
    magic_color = "light_gray",
    bash_conversion_factor = 1.0,
    melee_crit_dmg_mult = 0.5,
    melee_crit_armor_mult = 0.5,
    physical = true,
}
definition:derived("bash", 1)
definition:immune_character_flag("IRONSWORN")
definition:immune_monster_flag("IRONWROUGHT")
content.add(definition)
end
do
local definition = content.DamageType {
    id = "xe_cold_iron_stab_damage",
    name = ccb.content.text("cold iron stab"),
    skill = "stabbing",
    magic_color = "light_gray",
    bash_conversion_factor = 0.6,
    melee_crit_dmg_mult_per_skill = 0.1,
    melee_crit_armor_mult = 0.66,
    physical = true,
}
definition:derived("stab", 1)
definition:immune_character_flag("IRONSWORN")
definition:immune_monster_flag("IRONWROUGHT")
content.add(definition)
end
-- Native damage-info order definitions
do
local definition = content.DamageInfoOrder {
    id = "xe_cold_iron_cut_damage",
    display = "detailed",
    verb = ccb.content.text("cutting"),
}
definition:section("bionic", 999999, false)
definition:section("protection", 999999, false)
definition:section("pet_protection", 999999, false)
definition:section("melee", 999999, false)
definition:section("ablative", 999999, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "xe_cold_iron_bash_damage",
    display = "detailed",
    verb = ccb.content.text("bashing"),
}
definition:section("bionic", 999999, false)
definition:section("protection", 999999, false)
definition:section("pet_protection", 999999, false)
definition:section("melee", 999999, false)
definition:section("ablative", 999999, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "xe_cold_iron_stab_damage",
    display = "detailed",
    verb = ccb.content.text("piercing"),
}
definition:section("bionic", 999999, false)
definition:section("protection", 999999, false)
definition:section("pet_protection", 999999, false)
definition:section("melee", 999999, false)
definition:section("ablative", 999999, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "xe_shadow_damage",
    display = "detailed",
    verb = ccb.content.text("umbrous"),
}
definition:section("bionic", 999903, false)
definition:section("protection", 999903, false)
definition:section("pet_protection", 999903, false)
definition:section("melee", 999903, false)
definition:section("ablative", 999903, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "withering_damage",
    display = "detailed",
    verb = ccb.content.text("withering"),
}
definition:section("bionic", 999905, false)
definition:section("protection", 999905, false)
definition:section("pet_protection", 999905, false)
definition:section("melee", 999905, false)
definition:section("ablative", 999905, false)
content.add(definition)
end
