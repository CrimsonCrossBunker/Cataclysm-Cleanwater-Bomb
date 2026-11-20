local ccb = require("ccb")
local content = ccb.content

-- Native damage-type definitions
do
local definition = content.DamageType {
    id = "fcl_plasma",
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
    id = "fcl_laser",
    name = ccb.content.text("laser", { context = "damage_type" }),
    magic_color = "red",
    bash_conversion_factor = 0.4,
    physical = true,
}
definition:derived("heat", 0.8)
content.add(definition)
end
-- Native damage-info order definitions
do
local definition = content.DamageInfoOrder {
    id = "fcl_plasma",
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
    id = "fcl_laser",
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
