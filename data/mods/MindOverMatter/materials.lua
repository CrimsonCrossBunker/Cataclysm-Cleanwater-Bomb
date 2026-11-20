local ccb = require("ccb")
local content = ccb.content

-- Native material definitions
do
local definition = content.Material {
    id = "telekinetic_force",
    name = ccb.content.text("Telekinetic Force"),
    bash_damage_verb = ccb.content.text("rippled"),
    cut_damage_verb = ccb.content.text("pierced"),
    chip_resistance = 6,
    breathability = 5,
    density = 1.5,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
}
definition:resistance("bash", 3)
definition:resistance("cut", 4)
definition:resistance("acid", 4)
definition:resistance("heat", 0)
definition:resistance("bullet", 6)
definition:resistance("electric", 2)
definition:damage_adjective(1, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(2, ccb.content.text("strained"))
definition:damage_adjective(3, ccb.content.text("fractured"))
definition:damage_adjective(4, ccb.content.text("eradicated"))
content.add(definition)
end
do
local definition = content.Material {
    id = "nether_crystal",
    name = ccb.content.text("Netherum Crystal"),
    bash_damage_verb = ccb.content.text("chipped"),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 100,
    density = 15,
    specific_heat_liquid = 0.52,
    specific_heat_solid = 0.52,
    latent_heat = 5200,
}
definition:resistance("bash", 5)
definition:resistance("cut", 5)
definition:resistance("acid", 100)
definition:resistance("heat", 10)
definition:resistance("bullet", 2)
definition:resistance("electric", 100)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("chipped"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "light",
    copy_from = "sunlight",
    name = ccb.content.text("Light"),
}
content.add(definition)
end
do
local definition = content.Material {
    id = "black_liquid",
    name = ccb.content.text("Black liquid"),
    bash_damage_verb = ccb.content.text("ripples"),
    cut_damage_verb = ccb.content.text("passed through"),
    chip_resistance = 10,
    breathability = 1,
    density = 2,
    specific_heat_liquid = 1,
    specific_heat_solid = 0.108,
    latent_heat = 800,
    freezing_point = -460,
    soft = true,
    conductive = false,
}
definition:resistance("bash", 8)
definition:resistance("cut", 0)
definition:resistance("acid", 8)
definition:resistance("heat", 4)
definition:resistance("bullet", 4)
definition:damage_adjective(1, ccb.content.text("bothered"))
definition:damage_adjective(2, ccb.content.text("annoyed"))
definition:damage_adjective(3, ccb.content.text("irritated"))
definition:damage_adjective(4, ccb.content.text("destroyed"))
content.add(definition)
end
do
local definition = content.Material {
    id = "fifth_sun_antiballistic_cloth",
    name = ccb.content.text("ichcayolli"),
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 20,
    breathability = 2,
    density = 1.2,
    sheet_thickness = 1.2,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
}
definition:resistance("bash", 1.5)
definition:resistance("cut", 2)
definition:resistance("acid", 6)
definition:resistance("heat", 2)
definition:resistance("bullet", 5)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
content.add(definition)
end
