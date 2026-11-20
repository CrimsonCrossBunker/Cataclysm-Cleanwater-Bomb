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
-- Native damage-info order definitions
do
local definition = content.DamageInfoOrder {
    id = "afs_plasma",
    display = "basic",
    verb = ccb.content.text("melting", { context = "damage_type" }),
}
definition:section("bionic", 407, true)
definition:section("protection", 307, true)
definition:section("pet_protection", 307, true)
definition:section("melee", 407, true)
definition:section("ablative", 307, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "afs_laser",
    display = "basic",
    verb = ccb.content.text("melting", { context = "damage_type" }),
}
definition:section("bionic", 393, true)
definition:section("protection", 293, true)
definition:section("pet_protection", 293, true)
definition:section("melee", 393, true)
definition:section("ablative", 293, true)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "afs_heat_melee",
    display = "detailed",
    verb = ccb.content.text("melting", { context = "damage_type" }),
}
definition:section("bionic", 200, true)
definition:section("protection", 200, false)
definition:section("pet_protection", 200, false)
definition:section("melee", 200, true)
definition:section("ablative", 200, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "afs_toxin_pierce",
    display = "detailed",
    verb = ccb.content.text("shooting"),
}
definition:section("bionic", 407, false)
definition:section("protection", 307, false)
definition:section("pet_protection", 307, false)
definition:section("melee", 407, true)
definition:section("ablative", 307, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "afs_toxin_bullet",
    display = "detailed",
    verb = ccb.content.text("shooting"),
}
definition:section("bionic", 401, false)
definition:section("protection", 301, false)
definition:section("pet_protection", 301, false)
definition:section("melee", 401, false)
definition:section("ablative", 301, false)
content.add(definition)
end
if not content.is_mod_active("mindovermatter") then
local definition = content.DamageInfoOrder {
    id = "psi_telekinetic_damage",
    display = "detailed",
    verb = ccb.content.text("buffeting"),
}
definition:section("bionic", 999899, false)
definition:section("protection", 999899, false)
definition:section("pet_protection", 999899, false)
definition:section("melee", 999899, false)
definition:section("ablative", 999899, false)
content.add(definition)
end
if not content.is_mod_active("mindovermatter") then
local definition = content.DamageInfoOrder {
    id = "psi_telepathic_damage",
    display = "detailed",
    verb = ccb.content.text("mindblasting"),
}
definition:section("bionic", 999900, false)
definition:section("protection", 999900, false)
definition:section("pet_protection", 999900, false)
definition:section("melee", 999900, false)
definition:section("ablative", 999900, false)
content.add(definition)
end
