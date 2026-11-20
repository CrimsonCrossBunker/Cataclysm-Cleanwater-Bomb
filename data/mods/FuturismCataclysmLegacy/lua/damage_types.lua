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
