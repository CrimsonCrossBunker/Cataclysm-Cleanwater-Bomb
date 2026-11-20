local ccb = require("ccb")
local content = ccb.content

-- Native damage-info order definitions
do
local definition = content.DamageInfoOrder {
    id = "psychic_damage",
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
