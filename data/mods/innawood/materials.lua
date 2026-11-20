local ccb = require("ccb")
local content = ccb.content

-- Native material definitions
do
local definition = content.Material {
    id = "fibercloth",
    name = ccb.content.text("Fibercloth"),
    salvaged_into = "fibercloth_patchwork",
    repaired_with = "fibercloth_patchwork",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 6,
    breathability = 2,
    repair_difficulty = 1,
    wind_resistance = 70,
    density = 1.6,
    specific_heat_liquid = 0.02,
    specific_heat_solid = 0.02,
    latent_heat = 205,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 3)
definition:resistance("heat", 0)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 200, 0.6, 1, 0.025)
definition:burn(2, false, 825, 1.2, 1, 0.05)
definition:burn(3, false, 0, 1.8, 1, 0.075)
definition:burn_product("ash", 0.013)
content.add(definition)
end
