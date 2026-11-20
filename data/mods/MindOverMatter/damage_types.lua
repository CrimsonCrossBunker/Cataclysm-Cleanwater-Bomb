local ccb = require("ccb")
local content = ccb.content

-- Native damage-info order definitions
do
local definition = content.DamageInfoOrder {
    id = "psi_photokinetic_damage",
    display = "detailed",
    verb = ccb.content.text("dazzling"),
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
do
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
do
local definition = content.DamageInfoOrder {
    id = "psi_teleporter_teleporting_damage",
    display = "detailed",
    verb = ccb.content.text("recalibrating"),
}
definition:section("bionic", 999901, false)
definition:section("protection", 999901, false)
definition:section("pet_protection", 999901, false)
definition:section("melee", 999901, false)
definition:section("ablative", 999901, false)
content.add(definition)
end
do
local definition = content.DamageInfoOrder {
    id = "psi_enervation_damage",
    display = "detailed",
    verb = ccb.content.text("enervating"),
}
definition:section("bionic", 999902, false)
definition:section("protection", 999902, false)
definition:section("pet_protection", 999902, false)
definition:section("melee", 999902, false)
definition:section("ablative", 999902, false)
content.add(definition)
end
