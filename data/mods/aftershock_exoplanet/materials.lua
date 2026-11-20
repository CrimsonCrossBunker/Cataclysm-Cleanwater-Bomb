local ccb = require("ccb")
local content = ccb.content

-- Native material definitions
do
local definition = content.Material {
    id = "afs_steel",
    name = ccb.content.text("Tempered Carbon Steel"),
    repaired_with = "mc_steel_chunk",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    repair_difficulty = 7,
    density = 8.0,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 17)
definition:resistance("cut", 25)
definition:resistance("acid", 7)
definition:resistance("heat", 12)
definition:resistance("bullet", 30)
definition:resistance("afs_plasma", 7)
definition:resistance("electric", 0)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "titanium",
    name = ccb.content.text("Titanium"),
    repaired_with = "afs_scrap_titanium",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    breathability = 0,
    repair_difficulty = 7,
    density = 4.502,
}
definition:resistance("bash", 8)
definition:resistance("cut", 10)
definition:resistance("acid", 5)
definition:resistance("heat", 0)
definition:resistance("bullet", 15)
definition:resistance("afs_plasma", 0)
definition:resistance("electric", 0)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "graphene_weave",
    name = ccb.content.text("Graphene Weave"),
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 10,
    breathability = 3,
    repair_difficulty = 10,
    density = 10,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
}
definition:resistance("bash", 8)
definition:resistance("cut", 10)
definition:resistance("acid", 5)
definition:resistance("heat", 0)
definition:resistance("bullet", 15)
definition:resistance("afs_plasma", 0)
definition:resistance("electric", 0)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("scarred"))
definition:damage_adjective(4, ccb.content.text("broken"))
content.add(definition)
end
do
local definition = content.Material {
    id = "vacuum_carbide",
    name = ccb.content.text("Vacuum-cast Carbide"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 100,
    breathability = 0,
    repair_difficulty = 10,
    density = 18,
}
definition:resistance("bash", 15)
definition:resistance("cut", 20)
definition:resistance("acid", 17)
definition:resistance("heat", 10)
definition:resistance("bullet", 30)
definition:resistance("afs_plasma", 0)
definition:resistance("electric", 0)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "vacuum_carbide_hard",
    name = ccb.content.text("High-density Carbide"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 25,
    breathability = 0,
    repair_difficulty = 10,
    density = 18,
}
definition:resistance("bash", 37)
definition:resistance("cut", 50)
definition:resistance("acid", 17)
definition:resistance("heat", 30)
definition:resistance("bullet", 60)
definition:resistance("afs_plasma", 20)
definition:resistance("electric", 10)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "vacuum_carbide_vehicle",
    name = ccb.content.text("Carbide-composite armor"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 25,
    breathability = 0,
    repair_difficulty = 10,
    density = 18,
}
definition:resistance("bash", 50)
definition:resistance("cut", 70)
definition:resistance("acid", 17)
definition:resistance("heat", 70)
definition:resistance("bullet", 90)
definition:resistance("afs_plasma", 50)
definition:resistance("electric", 25)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "afs_plastic_armor",
    name = ccb.content.text("HDPE"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 4,
    breathability = 0,
    repair_difficulty = 4,
    density = 5,
}
definition:resistance("cut", 5)
definition:resistance("bash", 4)
definition:resistance("bullet", 0)
definition:resistance("acid", 2)
definition:resistance("heat", 0)
definition:resistance("afs_plasma", 0)
definition:resistance("electric", 0)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("scarred"))
definition:damage_adjective(3, ccb.content.text("cut"))
definition:damage_adjective(4, ccb.content.text("ripped"))
content.add(definition)
end
do
local definition = content.Material {
    id = "afs_kevlar",
    name = ccb.content.text("Aramid Fiber"),
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 25,
    breathability = 3,
    repair_difficulty = 4,
    density = 1.4,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
}
definition:resistance("cut", 5)
definition:resistance("bash", 4)
definition:resistance("bullet", 7)
definition:resistance("acid", 2)
definition:resistance("heat", 0)
definition:resistance("afs_plasma", 0)
definition:resistance("electric", 0)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("scarred"))
definition:damage_adjective(3, ccb.content.text("cut"))
definition:damage_adjective(4, ccb.content.text("ripped"))
content.add(definition)
end
do
local definition = content.Material {
    id = "carbide_thermal_weave",
    name = ccb.content.text("Carbide ThermoWeave(c)"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 25,
    breathability = 2,
    repair_difficulty = 10,
    density = 18,
    soft = true,
}
definition:resistance("bash", 8)
definition:resistance("cut", 14)
definition:resistance("acid", 4)
definition:resistance("heat", 30)
definition:resistance("bullet", 15)
definition:resistance("afs_plasma", 20)
definition:resistance("electric", 10)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("scarred"))
definition:damage_adjective(4, ccb.content.text("ripped"))
content.add(definition)
end
do
local definition = content.Material {
    id = "nanoprinted_alloy",
    name = ccb.content.text("Nanoprinted Alloy Mesh"),
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 4,
    breathability = 3,
    repair_difficulty = 9,
    density = 6,
    soft = true,
}
definition:resistance("bash", 15)
definition:resistance("cut", 20)
definition:resistance("acid", 6)
definition:resistance("heat", 10)
definition:resistance("afs_plasma", 0)
definition:resistance("bullet", 30)
definition:resistance("electric", 0)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("scarred"))
definition:damage_adjective(4, ccb.content.text("broken"))
content.add(definition)
end
do
local definition = content.Material {
    id = "riemann_space",
    name = ccb.content.text("Riemann space"),
    bash_damage_verb = ccb.content.text("agitated"),
    cut_damage_verb = ccb.content.text("agitated"),
    chip_resistance = 100,
    breathability = 5,
    density = 1,
    specific_heat_liquid = 0.52,
    specific_heat_solid = 0.52,
    latent_heat = 5200,
    soft = true,
}
definition:resistance("bash", 1000)
definition:resistance("cut", 1000)
definition:resistance("acid", 1000)
definition:resistance("heat", 1000)
definition:resistance("bullet", 1000)
definition:resistance("afs_plasma", 1000)
definition:resistance("electric", 1000)
definition:damage_adjective(1, ccb.content.text("resonating"))
definition:damage_adjective(2, ccb.content.text("cascading"))
definition:damage_adjective(3, ccb.content.text("unraveling"))
definition:damage_adjective(4, ccb.content.text("fractal"))
content.add(definition)
end
do
local definition = content.Material {
    id = "clearcrete",
    name = ccb.content.text("Clearcrete"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 30,
    breathability = 0,
    repair_difficulty = 10,
    density = 40,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
}
definition:resistance("bash", 10)
definition:resistance("cut", 6)
definition:resistance("acid", 6)
definition:resistance("heat", 100)
definition:resistance("bullet", 100)
definition:resistance("afs_plasma", 0)
definition:resistance("electric", 10)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "enamel",
    name = ccb.content.text("Enamel"),
    bash_damage_verb = ccb.content.text("chipped"),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 2,
    breathability = 0,
    repair_difficulty = 7,
    density = 6,
}
definition:resistance("bash", 4)
definition:resistance("cut", 7)
definition:resistance("acid", 2)
definition:resistance("heat", 4)
definition:resistance("bullet", 6)
definition:resistance("afs_plasma", 0)
definition:resistance("electric", 8)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("chipped"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
