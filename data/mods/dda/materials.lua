local ccb = require("ccb")
local content = ccb.content

-- Native material definitions
do
local definition = content.Material {
    id = "thermo_resin",
    name = ccb.content.text("Thermoplastic Resin"),
    salvaged_into = "thermo_resin_chunk",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("gouged"),
    chip_resistance = 8,
    repair_difficulty = 4,
    density = 1.0,
    specific_heat_liquid = 1.25,
    specific_heat_solid = 1.25,
    latent_heat = 18,
}
definition:resistance("bash", 4)
definition:resistance("cut", 5)
definition:resistance("acid", 10)
definition:resistance("heat", 6)
definition:resistance("bullet", 3)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0.1, 2, 0.001)
definition:burn(2, false, 0, 0.4, 3, 0.003)
definition:burn(3, false, 0, 1, 5, 0.008)
content.add(definition)
end
do
local definition = content.Material {
    id = "epoxy",
    name = ccb.content.text("Epoxy"),
    salvaged_into = "epoxy_chunk",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("gouged"),
    chip_resistance = 8,
    density = 1.0,
    specific_heat_liquid = 1.25,
    specific_heat_solid = 1.25,
    latent_heat = 18,
}
definition:resistance("bash", 4)
definition:resistance("cut", 5)
definition:resistance("acid", 10)
definition:resistance("heat", 6)
definition:resistance("bullet", 3)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0.1, 5, 0.001)
definition:burn(2, false, 0, 0.2, 8, 0.006)
definition:burn(3, false, 0, 0.6, 15, 0.02)
content.add(definition)
end
do
local definition = content.Material {
    id = "fiberglass",
    name = ccb.content.text("Fiberglass Laminate"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("gouged"),
    chip_resistance = 9,
    density = 1.8,
    specific_heat_liquid = 1.25,
    specific_heat_solid = 1.25,
    latent_heat = 18,
}
definition:resistance("bash", 4)
definition:resistance("cut", 5)
definition:resistance("acid", 10)
definition:resistance("heat", 6)
definition:resistance("bullet", 3)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0.1, 5, 0.001)
definition:burn(2, false, 0, 0.2, 8, 0.006)
definition:burn(3, false, 0, 0.6, 15, 0.02)
content.add(definition)
end
do
local definition = content.Material {
    id = "carbonfiber",
    copy_from = "fiberglass",
    name = ccb.content.text("Carbon Fiber Composite"),
    chip_resistance = 10,
    density = 1.55,
    conductive = true,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "pseudo_fuel",
    name = ccb.content.text("Pseudo Fuel"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("gouged"),
    chip_resistance = 0,
    density = 1,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:fuel(1000, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "battery",
    copy_from = "pseudo_fuel",
    name = ccb.content.text("Battery"),
}
definition:fuel(1000, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "wind",
    copy_from = "pseudo_fuel",
    name = ccb.content.text("Wind"),
}
definition:fuel(1, "t_null", true)
content.add(definition)
end
do
local definition = content.Material {
    id = "sunlight",
    copy_from = "pseudo_fuel",
    name = ccb.content.text("Sunlight"),
}
definition:fuel(1, "t_null", true)
content.add(definition)
end
do
local definition = content.Material {
    id = "animal",
    copy_from = "pseudo_fuel",
    name = ccb.content.text("Animal"),
}
definition:fuel(1, "t_null", true)
content.add(definition)
end
do
local definition = content.Material {
    id = "muscle",
    copy_from = "pseudo_fuel",
    name = ccb.content.text("Muscle"),
}
definition:fuel(1, "t_null", true)
content.add(definition)
end
do
local definition = content.Material {
    id = "metabolism",
    copy_from = "pseudo_fuel",
    name = ccb.content.text("Metabolism"),
}
definition:fuel(1, "t_null", true)
content.add(definition)
end
do
local definition = content.Material {
    id = "alcohol",
    name = ccb.content.text("Alcohol"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1.0,
    specific_heat_liquid = 4,
    specific_heat_solid = 2,
    latent_heat = 310,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 150, 0, 1)
definition:burn(2, false, 0, 300, 0, 2)
definition:burn(3, false, 0, 450, 0, 3)
definition:fuel(15600, "t_null", false)
definition:fuel_explosion(5, 10, 0.2, true, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "paint",
    name = ccb.content.text("Paint"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1.3,
    specific_heat_liquid = 4,
    specific_heat_solid = 2,
    latent_heat = 310,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, -1, 0, 0.01)
definition:burn(2, false, 0, -1, 0, 0.01)
definition:burn(3, false, 0, -1, 0, 0.01)
definition:fuel(15600, "t_null", false)
definition:fuel_explosion(5, 10, 0.2, true, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "isopropyl",
    name = ccb.content.text("Isopropyl Alcohol"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 0.786,
    specific_heat_liquid = 2.4,
    specific_heat_solid = 2.3,
    latent_heat = 666,
    freezing_point = -89,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 150, 0, 1)
definition:burn(2, false, 0, 300, 0, 2)
definition:burn(3, false, 0, 450, 0, 3)
definition:fuel(24700, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "alien_liquid",
    name = ccb.content.text("Non-Newtonian Fluid"),
    repaired_with = "water",
    bash_damage_verb = ccb.content.text("ripples"),
    cut_damage_verb = ccb.content.text("passed through"),
    chip_resistance = 10,
    breathability = 5,
    repair_difficulty = 0,
    density = 1,
    specific_heat_liquid = 4.186,
    specific_heat_solid = 2.108,
    latent_heat = 333,
    soft = true,
    conductive = true,
}
definition:resistance("bash", 8)
definition:resistance("cut", 0)
definition:resistance("acid", 8)
definition:resistance("heat", 4)
definition:resistance("bullet", 4)
definition:damage_adjective(1, ccb.content.text("agitated"))
definition:damage_adjective(2, ccb.content.text("thinned"))
definition:damage_adjective(3, ccb.content.text("culled"))
definition:damage_adjective(4, ccb.content.text("eradicated"))
content.add(definition)
end
do
local definition = content.Material {
    id = "alien_resin",
    name = ccb.content.text("Resin"),
    salvaged_into = "resin_chunk",
    repaired_with = "resin_chunk",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("gouged"),
    chip_resistance = 12,
    density = 1.5,
    specific_heat_liquid = 1.8,
    specific_heat_solid = 1.8,
    latent_heat = 50,
}
definition:resistance("bash", 8)
definition:resistance("cut", 12)
definition:resistance("acid", 20)
definition:resistance("heat", 8)
definition:resistance("bullet", 10)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "aluminum",
    name = ccb.content.text("Aluminum"),
    repaired_with = "welding_wire_alloy",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 10,
    repair_difficulty = 5,
    density = 2.7,
    specific_heat_liquid = 1.18,
    specific_heat_solid = 0.91,
    latent_heat = 398,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 2)
definition:resistance("acid", 4)
definition:resistance("heat", 2)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(2, ccb.content.text("bent"))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("destroyed"))
content.add(definition)
end
do
local definition = content.Material {
    id = "bone",
    name = ccb.content.text("Bone"),
    repaired_with = "bone",
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 8,
    repair_difficulty = 3,
    wind_resistance = 90,
    density = 1.4,
    specific_heat_liquid = 1.2,
    specific_heat_solid = 1.2,
    latent_heat = 200,
    rotting = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 3)
definition:resistance("acid", 7)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("calcium", 2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0, 0, 0.0003)
definition:burn(2, false, 250, 0.2, 3, 0.01)
definition:burn(3, false, 250, 0.35, 5, 0.02)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "cyber_bone",
    copy_from = "bone",
    name = ccb.content.text("Bone-like material"),
    repair_difficulty = 9,
    density = 5,
}
definition:resistance("bash", 8)
definition:resistance("cut", 11)
definition:resistance("acid", 7)
definition:resistance("heat", 2)
definition:resistance("bullet", 8)
content.add(definition)
end
do
local definition = content.Material {
    id = "cyber_wood",
    copy_from = "wood",
    name = ccb.content.text("Wood-like material"),
    repair_difficulty = 9,
    density = 5,
}
definition:resistance("bash", 7)
definition:resistance("cut", 13)
definition:resistance("acid", 12)
definition:resistance("heat", 2)
definition:resistance("bullet", 4)
content.add(definition)
end
do
local definition = content.Material {
    id = "brass",
    name = ccb.content.text("Brass"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 15,
    repair_difficulty = 4,
    density = 8.8,
    specific_heat_liquid = 0.49,
    specific_heat_solid = 0.39,
    latent_heat = 205,
    conductive = true,
}
definition:resistance("bash", 3)
definition:resistance("cut", 4)
definition:resistance("acid", 16)
definition:resistance("heat", 2)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "bronze",
    name = ccb.content.text("Bronze"),
    repaired_with = "scrap_bronze",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 15,
    repair_difficulty = 4,
    density = 8.8,
    conductive = true,
}
definition:resistance("bash", 4)
definition:resistance("cut", 5)
definition:resistance("acid", 1)
definition:resistance("heat", 2)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap_bronze", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "alien_carapace",
    name = ccb.content.text("Carapace"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("gouged"),
    chip_resistance = 15,
    density = 10,
    specific_heat_liquid = 1.8,
    specific_heat_solid = 1.8,
    latent_heat = 50,
}
definition:resistance("bash", 8)
definition:resistance("cut", 12)
definition:resistance("acid", 20)
definition:resistance("heat", 1)
definition:resistance("bullet", 10)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "fancy_bronze",
    name = ccb.content.text("Thessalonian Bronze"),
    repaired_with = "scrap_bronze",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 15,
    repair_difficulty = 4,
    density = 8.8,
    conductive = true,
}
definition:resistance("bash", 5)
definition:resistance("cut", 5)
definition:resistance("acid", 5)
definition:resistance("heat", 2)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap_bronze", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "budget_steel",
    name = ccb.content.text("Budget Steel"),
    repaired_with = "scrap",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 11,
    repair_difficulty = 2,
    density = 8.0,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 6)
definition:resistance("cut", 6)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "cardboard",
    name = ccb.content.text("Cardboard"),
    salvaged_into = "cardboard",
    repaired_with = "cardboard",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 0,
    repair_difficulty = 0,
    density = 2,
    specific_heat_liquid = 1.34,
    specific_heat_solid = 1.34,
    latent_heat = 333,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 1)
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
do
local definition = content.Material {
    id = "ceramic",
    name = ccb.content.text("Ceramic"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 20,
    density = 4.5,
    specific_heat_liquid = 1,
    specific_heat_solid = 1,
    latent_heat = 333,
}
definition:resistance("bash", 1)
definition:resistance("cut", 2)
definition:resistance("acid", 10)
definition:resistance("heat", 10)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("chipped"))
definition:damage_adjective(2, ccb.content.text("cracked"))
definition:damage_adjective(3, ccb.content.text("split"))
definition:damage_adjective(4, ccb.content.text("broken"))
content.add(definition)
end
do
local definition = content.Material {
    id = "yrax_quartz",
    name = ccb.content.text("Quartz"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 2000,
    density = 4.5,
    specific_heat_liquid = 1,
    specific_heat_solid = 1,
    latent_heat = 333,
}
definition:resistance("bash", 4)
definition:resistance("cut", 8)
definition:resistance("acid", 14)
definition:resistance("heat", 14)
definition:resistance("bullet", 6)
definition:damage_adjective(1, ccb.content.text("chipped"))
definition:damage_adjective(2, ccb.content.text("cracked"))
definition:damage_adjective(3, ccb.content.text("resonating"))
definition:damage_adjective(4, ccb.content.text("fractal"))
content.add(definition)
end
do
local definition = content.Material {
    id = "damaged_ceramic",
    copy_from = "ceramic",
    name = ccb.content.text("Compromised Ceramic"),
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 10)
definition:resistance("heat", 10)
definition:resistance("bullet", 0.8)
content.add(definition)
end
do
local definition = content.Material {
    id = "hyperweave_off",
    name = ccb.content.text("Inert Hyperweave"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 20,
    breathability = 4,
    density = 8,
    specific_heat_liquid = 1,
    specific_heat_solid = 1,
    latent_heat = 333,
    soft = true,
}
definition:resistance("bash", 3)
definition:resistance("cut", 5)
definition:resistance("acid", 10)
definition:resistance("heat", 10)
definition:resistance("bullet", 6)
definition:damage_adjective(1, ccb.content.text("chipped"))
definition:damage_adjective(2, ccb.content.text("cracked"))
definition:damage_adjective(3, ccb.content.text("split"))
definition:damage_adjective(4, ccb.content.text("broken"))
content.add(definition)
end
do
local definition = content.Material {
    id = "hyperweave_on",
    name = ccb.content.text("Charged Hyperweave"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 20,
    breathability = 4,
    density = 20,
    specific_heat_liquid = 1,
    specific_heat_solid = 1,
    latent_heat = 333,
    soft = true,
}
definition:resistance("bash", 6)
definition:resistance("cut", 10)
definition:resistance("acid", 10)
definition:resistance("heat", 10)
definition:resistance("bullet", 12)
definition:damage_adjective(1, ccb.content.text("chipped"))
definition:damage_adjective(2, ccb.content.text("cracked"))
definition:damage_adjective(3, ccb.content.text("split"))
definition:damage_adjective(4, ccb.content.text("broken"))
content.add(definition)
end
do
local definition = content.Material {
    id = "chitin",
    name = ccb.content.text("Hardened Chitin"),
    salvaged_into = "chitin_piece",
    repaired_with = "chitin_piece",
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 14,
    breathability = 3,
    repair_difficulty = 5,
    wind_resistance = 90,
    density = 1.45,
    specific_heat_liquid = 4.186,
    specific_heat_solid = 2.108,
    latent_heat = 333,
}
definition:resistance("bash", 2.5)
definition:resistance("cut", 3)
definition:resistance("acid", 6)
definition:resistance("heat", 2.5)
definition:resistance("bullet", 1.4)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0, 0, 0.0001)
definition:burn(2, false, 200, 0.2, 3, 0.005)
definition:burn(3, false, 200, 0.35, 5, 0.015)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "acidchitin",
    name = ccb.content.text("Biosilicified Chitin"),
    salvaged_into = "acidchitin_piece",
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 7,
    breathability = 3,
    repair_difficulty = 5,
    wind_resistance = 90,
    density = 1.45,
    specific_heat_liquid = 4.186,
    specific_heat_solid = 2.108,
    latent_heat = 333,
}
definition:resistance("bash", 1)
definition:resistance("cut", 6)
definition:resistance("acid", 20)
definition:resistance("heat", 4)
definition:resistance("bullet", 1.2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0, 0, 0.0001)
definition:burn(2, false, 200, 0.2, 3, 0.001)
definition:burn(3, false, 200, 0.35, 5, 0.05)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "chitin_light",
    name = ccb.content.text("Light Chitin"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 10,
    breathability = 3,
    wind_resistance = 90,
    density = 1.45,
    specific_heat_liquid = 4.186,
    specific_heat_solid = 2.108,
    latent_heat = 333,
}
definition:resistance("bash", 1.4)
definition:resistance("cut", 3)
definition:resistance("acid", 4)
definition:resistance("heat", 2)
definition:resistance("bullet", 0.9)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0, 0, 0.0001)
definition:burn(2, false, 200, 0.2, 3, 0.005)
definition:burn(3, false, 200, 0.35, 5, 0.015)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "sclerotin_light",
    copy_from = "chitin_light",
    name = ccb.content.text("Light Sclerotin"),
    chip_resistance = 18,
    breathability = 2,
    density = 1.8,
}
definition:resistance("bash", 4)
definition:resistance("cut", 6)
definition:resistance("acid", 8)
definition:resistance("heat", 2)
definition:resistance("bullet", 1.8)
content.add(definition)
end
do
local definition = content.Material {
    id = "hair",
    copy_from = "sclerotin_light",
    name = ccb.content.text("Hair"),
    chip_resistance = 11,
    breathability = 3,
    density = 1.4,
    soft = true,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "sclerotin",
    copy_from = "chitin_light",
    name = ccb.content.text("Hardened Sclerotin"),
    chip_resistance = 22,
    breathability = 2,
    density = 1.9,
}
definition:resistance("bash", 5.2)
definition:resistance("cut", 7)
definition:resistance("acid", 9)
definition:resistance("heat", 2)
definition:resistance("bullet", 2.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "clay",
    name = ccb.content.text("Clay"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 6,
    density = 1.6,
    specific_heat_liquid = 1,
    specific_heat_solid = 1,
    latent_heat = 333,
}
definition:resistance("bash", 2)
definition:resistance("cut", 3)
definition:resistance("acid", 6)
definition:resistance("heat", 3)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("chipped"))
definition:damage_adjective(2, ccb.content.text("scratched"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("ceramic_shard", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "porcelain",
    name = ccb.content.text("Porcelain"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 6,
    density = 1.6,
    specific_heat_liquid = 1,
    specific_heat_solid = 1,
    latent_heat = 333,
}
definition:resistance("bash", 2)
definition:resistance("cut", 3)
definition:resistance("acid", 6)
definition:resistance("heat", 3)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("chipped"))
definition:damage_adjective(2, ccb.content.text("scratched"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "copper",
    name = ccb.content.text("Copper"),
    repaired_with = "scrap_copper",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 10,
    repair_difficulty = 3,
    density = 8.96,
    specific_heat_liquid = 0.49,
    specific_heat_solid = 0.39,
    latent_heat = 205,
    conductive = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 3)
definition:resistance("acid", 0)
definition:resistance("heat", 3)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("copper", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "copper_nickel",
    name = ccb.content.text("Cupronickel"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 10,
    repair_difficulty = 3,
    density = 8.95,
    specific_heat_liquid = 0.49,
    specific_heat_solid = 0.39,
    latent_heat = 230,
    conductive = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 3)
definition:resistance("acid", 0)
definition:resistance("heat", 3)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "cotton",
    name = ccb.content.text("Cotton Blend"),
    salvaged_into = "cotton_patchwork",
    repaired_with = "cotton_patchwork",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 6,
    breathability = 2,
    repair_difficulty = 1,
    wind_resistance = 70,
    density = 0.5,
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
definition:burn(1, false, 0, 0.05, 1, 0.015)
definition:burn(2, false, 0, 0.1, 1, 0.04)
definition:burn(3, false, 0, 0.2, 1, 0.06)
content.add(definition)
end
do
local definition = content.Material {
    id = "cotton_quilted",
    copy_from = "cotton",
    name = ccb.content.text("Quilted Cotton"),
    repaired_with = "null",
    wind_resistance = 75,
}
definition:resistance("bash", 2)
definition:resistance("cut", 2)
definition:resistance("acid", 3)
definition:resistance("heat", 0)
definition:resistance("bullet", 1.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "cotton_quilted_salted",
    copy_from = "cotton",
    name = ccb.content.text("Salt Hardened Quilted Cotton"),
    repaired_with = "null",
}
definition:resistance("bash", 3)
definition:resistance("cut", 3)
definition:resistance("acid", 5)
definition:resistance("heat", 2)
definition:resistance("bullet", 1.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "denim",
    name = ccb.content.text("Denim"),
    salvaged_into = "denim_patch",
    repaired_with = "denim_patch",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 7,
    breathability = 2,
    repair_difficulty = 2,
    wind_resistance = 75,
    density = 1.6,
    specific_heat_liquid = 0.02,
    specific_heat_solid = 0.02,
    latent_heat = 205,
    soft = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 2.25)
definition:resistance("acid", 4)
definition:resistance("heat", 0)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 0, 1, 1, 0.02)
definition:burn(2, false, 0, 2, 1, 0.04)
definition:burn(3, false, 0, 3, 1, 0.06)
content.add(definition)
end
do
local definition = content.Material {
    id = "canvas",
    name = ccb.content.text("Canvas"),
    salvaged_into = "canvas_patch",
    repaired_with = "canvas_patch",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 8,
    breathability = 1,
    repair_difficulty = 2,
    wind_resistance = 85,
    density = 1.6,
    specific_heat_liquid = 0.02,
    specific_heat_solid = 0.02,
    latent_heat = 205,
    soft = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 2.5)
definition:resistance("acid", 4)
definition:resistance("heat", 0)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 0, 1, 1, 0.02)
definition:burn(2, false, 0, 2, 1, 0.04)
definition:burn(3, false, 0, 3, 1, 0.06)
content.add(definition)
end
do
local definition = content.Material {
    id = "canvas_quilted",
    copy_from = "canvas",
    name = ccb.content.text("Quilted Canvas"),
    repaired_with = "null",
    wind_resistance = 90,
}
definition:resistance("bash", 2)
definition:resistance("cut", 3)
definition:resistance("acid", 4)
definition:resistance("heat", 0)
definition:resistance("bullet", 2)
content.add(definition)
end
do
local definition = content.Material {
    id = "canvas_quilted_2",
    copy_from = "canvas_quilted",
    name = ccb.content.text("Quilted Canvas"),
    repaired_with = "null",
}
content.add(definition)
end
do
local definition = content.Material {
    id = "diamond",
    name = ccb.content.text("Diamond"),
    bash_damage_verb = ccb.content.text("chipped"),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 100,
    density = 3.53,
    specific_heat_liquid = 0.52,
    specific_heat_solid = 0.52,
    latent_heat = 5200,
}
definition:resistance("bash", 5)
definition:resistance("cut", 5)
definition:resistance("acid", 10)
definition:resistance("heat", 3)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("chipped"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "gemstone",
    name = ccb.content.text("Gemstone"),
    bash_damage_verb = ccb.content.text("chipped"),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 100,
    density = 4.7,
    specific_heat_liquid = 0.52,
    specific_heat_solid = 0.52,
    latent_heat = 5200,
}
definition:resistance("bash", 5)
definition:resistance("cut", 5)
definition:resistance("acid", 10)
definition:resistance("heat", 3)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("chipped"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "egg",
    name = ccb.content.text("Egg"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 1,
    density = 1.1,
    specific_heat_liquid = 3.63,
    specific_heat_solid = 1.95,
    latent_heat = 252,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 1)
definition:resistance("heat", 1)
definition:resistance("bullet", 0)
definition:vitamin("calcium", 0.5)
definition:vitamin("iron", 0.5)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("crushed"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "flesh",
    name = ccb.content.text("Flesh"),
    bash_damage_verb = ccb.content.text("bruised"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 2,
    density = 1.1,
    specific_heat_liquid = 3.7,
    specific_heat_solid = 2.15,
    latent_heat = 260,
    rotting = true,
    soft = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 1)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("calcium", 0.1)
definition:vitamin("iron", 1.3)
definition:damage_adjective(1, ccb.content.text("bruised"))
definition:damage_adjective(2, ccb.content.text("mutilated"))
definition:damage_adjective(3, ccb.content.text("badly mutilated"))
definition:damage_adjective(4, ccb.content.text("thoroughly mutilated"))
definition:burn(1, false, 200, 0.05, 1, 0.001)
definition:burn(2, false, 500, 0.1, 3, 0.002)
definition:burn(3, false, 1000, 0.2, 10, 0.004)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "drug_filler",
    copy_from = "powder",
    name = ccb.content.text("Drug filler"),
}
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
content.add(definition)
end
do
local definition = content.Material {
    id = "gutskin",
    name = ccb.content.text("Gutskin"),
    repaired_with = "leather",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 2,
    repair_difficulty = 1,
    density = 1.1,
    specific_heat_liquid = 3.7,
    specific_heat_solid = 2.15,
    latent_heat = 260,
    soft = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 1)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 200, 0.02, 1, 0.001)
definition:burn(2, false, 500, 0.05, 2, 0.002)
definition:burn(3, false, 1000, 0.1, 3, 0.004)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "freshclay",
    name = ccb.content.text("Fresh Clay"),
    bash_damage_verb = ccb.content.text("squished"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 4,
    density = 1.76,
    specific_heat_liquid = 4.186,
    specific_heat_solid = 2.108,
    latent_heat = 333,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 4)
definition:resistance("heat", 3)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn_product("ceramic_shard", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "fruit",
    name = ccb.content.text("Fruit Matter"),
    bash_damage_verb = ccb.content.text("bruised"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 1,
    density = 1.1,
    specific_heat_liquid = 3.9,
    specific_heat_solid = 1.9,
    latent_heat = 290,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 2)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("vitC", 2)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "fur",
    name = ccb.content.text("Fur"),
    salvaged_into = "fur",
    repaired_with = "fur",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 8,
    breathability = 1,
    repair_difficulty = 3,
    density = 1.1,
    specific_heat_liquid = 0.02,
    specific_heat_solid = 0.02,
    latent_heat = 333,
    soft = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 2)
definition:resistance("acid", 3)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 0, 0.6, 1, 0.02)
definition:burn(2, false, 0, 1, 1, 0.04)
definition:burn(3, false, 0, 1, 1, 0.06)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "faux_fur",
    name = ccb.content.text("Faux Fur"),
    salvaged_into = "faux_fur",
    repaired_with = "faux_fur",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 7,
    breathability = 1,
    repair_difficulty = 3,
    density = 1.1,
    specific_heat_liquid = 0.02,
    specific_heat_solid = 0.02,
    latent_heat = 333,
    soft = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 2)
definition:resistance("acid", 4)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 0, 0.6, 1, 0.02)
definition:burn(2, false, 0, 1, 1, 0.04)
definition:burn(3, false, 0, 1, 1, 0.06)
content.add(definition)
end
do
local definition = content.Material {
    id = "lvl4ballisticglass",
    name = ccb.content.text("Ballistic Glass"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 0,
    density = 2.0,
    specific_heat_liquid = 0.2,
    specific_heat_solid = 0.2,
    latent_heat = 100,
}
definition:resistance("bash", 5)
definition:resistance("cut", 10)
definition:resistance("acid", 10)
definition:resistance("heat", 3)
definition:resistance("bullet", 9)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0, 0, 0)
definition:burn(2, false, 0, 0, 0, 0)
definition:burn(3, false, 5000, 0, 0, 1000)
definition:burn_product("glass_shard", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "glass",
    name = ccb.content.text("Glass"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 0,
    repair_difficulty = 7,
    density = 2.5,
    specific_heat_liquid = 0.2,
    specific_heat_solid = 0.2,
    latent_heat = 100,
}
definition:resistance("bash", 3)
definition:resistance("cut", 4)
definition:resistance("acid", 10)
definition:resistance("heat", 3)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0, 0, 0)
definition:burn(2, false, 0, 0, 0, 0)
definition:burn(3, false, 5000, 0, 0, 1000)
definition:burn_product("glass_shard", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "crystal",
    name = ccb.content.text("Crystal"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 0,
    density = 3.1,
    specific_heat_liquid = 0.2,
    specific_heat_solid = 0.2,
    latent_heat = 100,
}
definition:resistance("bash", 3)
definition:resistance("cut", 4)
definition:resistance("acid", 10)
definition:resistance("heat", 3)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0, 0, 0)
definition:burn(2, false, 0, 0, 0, 0)
definition:burn(3, false, 5000, 0, 0, 1000)
definition:burn_product("glass_shard", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "gold",
    name = ccb.content.text("Gold"),
    repaired_with = "gold_small",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 8,
    repair_difficulty = 5,
    density = 19.32,
    specific_heat_liquid = 0.15,
    specific_heat_solid = 0.13,
    latent_heat = 63,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 10)
definition:resistance("heat", 3)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("gold_small", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "hflesh",
    name = ccb.content.text("Human Flesh"),
    bash_damage_verb = ccb.content.text("bruised"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 2,
    density = 1.1,
    specific_heat_liquid = 3.7,
    specific_heat_solid = 2.15,
    latent_heat = 260,
    rotting = true,
    soft = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 1)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("calcium", 0.1)
definition:vitamin("iron", 1.3)
definition:damage_adjective(1, ccb.content.text("bruised"))
definition:damage_adjective(2, ccb.content.text("mutilated"))
definition:damage_adjective(3, ccb.content.text("badly mutilated"))
definition:damage_adjective(4, ccb.content.text("thoroughly mutilated"))
definition:burn(1, false, 200, 0.05, 1, 0.001)
definition:burn(2, false, 500, 0.1, 3, 0.002)
definition:burn(3, false, 1000, 0.2, 10, 0.004)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "honey",
    name = ccb.content.text("Honey"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1.45,
    specific_heat_liquid = 2.03,
    specific_heat_solid = 2.03,
    latent_heat = 57,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 1)
definition:resistance("heat", 1)
definition:resistance("bullet", 0)
definition:vitamin("iron", 0.2)
definition:vitamin("vitC", 0.1)
definition:vitamin("calcium", 0.1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "sugar",
    name = ccb.content.text("Sugar"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1.59,
    specific_heat_liquid = 1.2,
    specific_heat_solid = 1.2,
    latent_heat = 124,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 150, 6, 1)
definition:burn(2, false, 0, 300, 6, 2)
definition:burn(3, false, 0, 450, 6, 3)
content.add(definition)
end
do
local definition = content.Material {
    id = "hydrocarbons",
    name = ccb.content.text("Hydrocarbons"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 0.7,
    specific_heat_liquid = 0.5,
    specific_heat_solid = 0.5,
    latent_heat = 518,
    freezing_point = -40,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 300, 6, 1)
definition:burn(2, false, 0, 600, 6, 2)
definition:burn(3, false, 0, 900, 6, 3)
content.add(definition)
end
do
local definition = content.Material {
    id = "diesel",
    copy_from = "hydrocarbons",
    name = ccb.content.text("Diesel"),
    density = 0.85,
    freezing_point = -20,
}
definition:fuel(35800, "t_diesel_pump", false)
definition:fuel_explosion(20, 1000, 0.2, false, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "jp8",
    copy_from = "hydrocarbons",
    name = ccb.content.text("JP8"),
    density = 0.84,
    freezing_point = -47,
}
definition:fuel(34700, "t_jp8_pump", false)
definition:fuel_explosion(20, 1000, 0.2, false, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "avgas",
    copy_from = "hydrocarbons",
    name = ccb.content.text("Avgas Fuel"),
    density = 0.69,
    freezing_point = -58,
}
definition:fuel(45800, "t_avgas_pump", false)
definition:fuel_explosion(20, 1000, 0.2, false, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "biodiesel",
    copy_from = "hydrocarbons",
    name = ccb.content.text("Biodiesel"),
    density = 0.875,
    freezing_point = -10,
}
definition:fuel(29600, "t_null", false)
definition:fuel_explosion(20, 1000, 0.2, false, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "gasoline",
    copy_from = "hydrocarbons",
    name = ccb.content.text("Gasoline"),
    density = 0.75,
    freezing_point = -60,
}
definition:fuel(34200, "t_gas_pump", false)
definition:fuel_explosion(2, 5, 1, true, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "lamp_oil",
    copy_from = "hydrocarbons",
    name = ccb.content.text("Kerosene"),
    density = 0.81,
    freezing_point = -47,
}
definition:fuel(26000, "t_null", false)
definition:fuel_explosion(5, 10, 0.2, true, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "crude_lamp_oil",
    copy_from = "hydrocarbons",
    name = ccb.content.text("Crude lamp oil"),
    density = 0.81,
}
definition:fuel(24000, "t_null", false)
definition:fuel_explosion(5, 10, 0.2, true, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "motor_oil",
    copy_from = "hydrocarbons",
    name = ccb.content.text("Motor Oil"),
    density = 0.95,
    freezing_point = -30,
}
definition:fuel(26000, "t_null", false)
definition:fuel_explosion(5, 10, 0.2, true, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "crude_oil",
    copy_from = "hydrocarbons",
    name = ccb.content.text("Crude oil"),
    density = 0.8,
}
definition:fuel(38000, "t_null", false)
definition:fuel_explosion(5, 10, 0.2, true, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "iflesh",
    name = ccb.content.text("Insect Flesh"),
    bash_damage_verb = ccb.content.text("bruised"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 2,
    density = 1.1,
    specific_heat_liquid = 3.7,
    specific_heat_solid = 2.15,
    latent_heat = 260,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 1)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("calcium", 1)
definition:vitamin("iron", 1.3)
definition:damage_adjective(1, ccb.content.text("bruised"))
definition:damage_adjective(2, ccb.content.text("mutilated"))
definition:damage_adjective(3, ccb.content.text("badly mutilated"))
definition:damage_adjective(4, ccb.content.text("thoroughly mutilated"))
definition:burn(1, false, 200, 0, 1, 0.001)
definition:burn(2, false, 500, 0.2, 3, 0.002)
definition:burn(3, false, 1000, 0.35, 5, 0.004)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "iron",
    name = ccb.content.text("Cast iron"),
    repaired_with = "scrap_cast_iron",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 15,
    repair_difficulty = 2,
    density = 7.3,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 247,
    conductive = true,
}
definition:resistance("bash", 4)
definition:resistance("cut", 4)
definition:resistance("acid", 5)
definition:resistance("heat", 3)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap_cast_iron", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "junk",
    name = ccb.content.text("Junk Food"),
    bash_damage_verb = ccb.content.text("smashed"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 2,
    density = 1.1,
    specific_heat_liquid = 3.3,
    specific_heat_solid = 2.05,
    latent_heat = 220,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 2)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "bread",
    name = ccb.content.text("Bread"),
    bash_damage_verb = ccb.content.text("smashed"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 0,
    density = 0.2,
    specific_heat_liquid = 3.3,
    specific_heat_solid = 2.05,
    latent_heat = 220,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "foodplace_foodstuff",
    copy_from = "junk",
    name = ccb.content.text("Foodplace's Delicious Foodstuff"),
}
content.add(definition)
end
do
local definition = content.Material {
    id = "kevlar",
    name = ccb.content.text("Kevlar"),
    salvaged_into = "kevlar_patch",
    repaired_with = "kevlar_patch",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 7,
    breathability = 3,
    repair_difficulty = 4,
    density = 1.4,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 3)
definition:resistance("acid", 5)
definition:resistance("heat", 40)
definition:resistance("bullet", 2)
definition:resistance("stab", 5)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, true, 0, 0, 0, 0)
definition:burn(2, true, 0, 0, 0, 0)
definition:burn(3, true, 0, 0, 0, 0)
content.add(definition)
end
do
local definition = content.Material {
    id = "kevlar_layered",
    name = ccb.content.text("Ballistic Kevlar"),
    salvaged_into = "sheet_kevlar_layered",
    repaired_with = "sheet_kevlar_layered",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 20,
    breathability = 2,
    repair_difficulty = 4,
    density = 1.4,
    sheet_thickness = 4.4,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
}
definition:resistance("bash", 1.5)
definition:resistance("cut", 2)
definition:resistance("acid", 5)
definition:resistance("heat", 40)
definition:resistance("bullet", 5)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, true, 0, 0, 0, 0)
definition:burn(2, true, 0, 0, 0, 0)
definition:burn(3, true, 0, 0, 0, 0)
content.add(definition)
end
do
local definition = content.Material {
    id = "kevlar_rigid",
    name = ccb.content.text("Rigid Kevlar"),
    salvaged_into = "rigid_kevlar_plate",
    repaired_with = "rigid_kevlar_plate",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 20,
    repair_difficulty = 5,
    density = 1.4,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
}
definition:resistance("bash", 3)
definition:resistance("cut", 4)
definition:resistance("acid", 5)
definition:resistance("heat", 40)
definition:resistance("bullet", 5)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, true, 0, 0, 0, 0)
definition:burn(2, true, 0, 0, 0, 0)
definition:burn(3, true, 0, 0, 0, 0)
content.add(definition)
end
do
local definition = content.Material {
    id = "lead",
    name = ccb.content.text("Lead"),
    repaired_with = "lead",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 8,
    density = 11.342,
    specific_heat_liquid = 0.13,
    specific_heat_solid = 0.14,
    latent_heat = 23,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 8)
definition:resistance("heat", 3)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("lead", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "leather",
    name = ccb.content.text("Leather"),
    salvaged_into = "leather",
    repaired_with = "leather",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 10,
    breathability = 1,
    repair_difficulty = 3,
    wind_resistance = 90,
    density = 1.1,
    specific_heat_liquid = 1.5,
    specific_heat_solid = 1.5,
    latent_heat = 273,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 3)
definition:resistance("acid", 4)
definition:resistance("heat", 2)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 200, 0.05, 1, 0.001)
definition:burn(2, false, 500, 0.1, 3, 0.002)
definition:burn(3, false, 1000, 0.2, 10, 0.004)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "leather_treated",
    name = ccb.content.text("Treated Leather"),
    salvaged_into = "leather",
    repaired_with = "leather",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 10,
    repair_difficulty = 3,
    density = 1.1,
    specific_heat_liquid = 1.5,
    specific_heat_solid = 1.5,
    latent_heat = 273,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 3)
definition:resistance("acid", 5)
definition:resistance("heat", 2)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 200, 0.05, 1, 0.001)
definition:burn(2, false, 500, 0.1, 3, 0.002)
definition:burn(3, false, 1000, 0.2, 10, 0.004)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "leather_arthropod",
    name = ccb.content.text("Epicuticle"),
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 10,
    breathability = 2,
    wind_resistance = 90,
    density = 2,
    specific_heat_liquid = 1.5,
    specific_heat_solid = 1.5,
    latent_heat = 273,
    soft = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 2)
definition:resistance("acid", 6)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 200, 0.05, 1, 0.001)
definition:burn(2, false, 500, 0.1, 3, 0.002)
definition:burn(3, false, 1000, 0.2, 10, 0.004)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "lycra",
    name = ccb.content.text("Lycra"),
    salvaged_into = "lycra_patch",
    repaired_with = "lycra_patch",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 6,
    breathability = 4,
    repair_difficulty = 3,
    density = 1.2,
    specific_heat_liquid = 1.7,
    specific_heat_solid = 1.7,
    latent_heat = 27,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 9)
definition:resistance("heat", 2)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 0, 0.05, 1, 0.01)
definition:burn(2, false, 0, 0.05, 2, 0.03)
definition:burn(3, false, 0, 0.15, 5, 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "milk",
    name = ccb.content.text("Dairy"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1.1,
    specific_heat_liquid = 3.89,
    specific_heat_solid = 1.81,
    latent_heat = 293,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 1)
definition:resistance("bullet", 0)
definition:vitamin("calcium", 1.5)
definition:vitamin("iron", 0.1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, -100, 1, 1)
definition:burn(2, false, 0, -50, 2, 1)
definition:burn(3, false, 0, -10, 2, 2)
content.add(definition)
end
do
local definition = content.Material {
    id = "neoprene",
    name = ccb.content.text("Neoprene"),
    salvaged_into = "neoprene",
    repaired_with = "neoprene",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 5,
    repair_difficulty = 3,
    density = 1.25,
    specific_heat_liquid = 1.1,
    specific_heat_solid = 1.1,
    latent_heat = 273,
    soft = true,
}
definition:resistance("bash", 1.5)
definition:resistance("cut", 1)
definition:resistance("acid", 4)
definition:resistance("heat", 3)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 1, 0.001, 3, 0.001)
definition:burn(2, false, 5, 0.001, 3, 0.002)
definition:burn(3, false, 0, 0.003, 3, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "nomex",
    name = ccb.content.text("Nomex"),
    salvaged_into = "nomex",
    repaired_with = "nomex",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 8,
    breathability = 4,
    repair_difficulty = 4,
    wind_resistance = 90,
    density = 1.05,
    specific_heat_liquid = 1.2,
    specific_heat_solid = 1.2,
    latent_heat = 273,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 5)
definition:resistance("heat", 20)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, true, 0, 0, 0, 0)
definition:burn(2, true, 0, 0, 0, 0)
definition:burn(3, true, 0, 0, 0, 0)
content.add(definition)
end
do
local definition = content.Material {
    id = "null",
    name = ccb.content.text("Unknown"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1,
    specific_heat_liquid = 4.186,
    specific_heat_solid = 2.108,
    latent_heat = 333,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 1)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
content.add(definition)
end
do
local definition = content.Material {
    id = "oil",
    name = ccb.content.text("Oil"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1.0,
    specific_heat_liquid = 2,
    specific_heat_solid = 1.8,
    latent_heat = 200,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 300, 3, 1)
definition:burn(2, false, 0, 600, 6, 2)
definition:burn(3, false, 0, 900, 9, 3)
content.add(definition)
end
do
local definition = content.Material {
    id = "beeswax",
    name = ccb.content.text("Beeswax"),
    salvaged_into = "wax",
    repaired_with = "wax",
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 0.97,
    specific_heat_liquid = 2.9,
    specific_heat_solid = 3.7,
    latent_heat = 210,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0.1, 1, 0.001)
definition:burn(2, false, 0, 0.4, 1, 0.003)
definition:burn(3, false, 0, 1, 2, 0.008)
content.add(definition)
end
do
local definition = content.Material {
    id = "paraffin_wax",
    name = ccb.content.text("Paraffin Wax"),
    salvaged_into = "wax_paraffin",
    repaired_with = "wax_paraffin",
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 0.86,
    specific_heat_liquid = 2.9,
    specific_heat_solid = 3.7,
    latent_heat = 210,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 150, 0, 1)
definition:burn(2, false, 0, 300, 0, 2)
definition:burn(3, false, 0, 450, 0, 3)
content.add(definition)
end
do
local definition = content.Material {
    id = "paper",
    name = ccb.content.text("Paper"),
    salvaged_into = "paper",
    repaired_with = "paper",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 0,
    density = 1.2,
    specific_heat_liquid = 1.34,
    specific_heat_solid = 1.34,
    latent_heat = 333,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 1)
definition:resistance("heat", 0)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 0, 1.1, 1, 0.025)
definition:burn(2, false, 0, 2.2, 1, 0.05)
definition:burn(3, false, 0, 3.3, 1, 0.075)
definition:burn_product("ash", 0.013)
content.add(definition)
end
do
local definition = content.Material {
    id = "dry_plant",
    name = ccb.content.text("Dry Plant"),
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 0,
    density = 1.2,
    specific_heat_liquid = 1.34,
    specific_heat_solid = 1.34,
    latent_heat = 333,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 1)
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
do
local definition = content.Material {
    id = "plastic",
    name = ccb.content.text("Plastic"),
    salvaged_into = "plastic_chunk",
    repaired_with = "plastic_chunk",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("gouged"),
    chip_resistance = 6,
    repair_difficulty = 3,
    wind_resistance = 90,
    density = 1.0,
    specific_heat_liquid = 1.6,
    specific_heat_solid = 1.6,
    latent_heat = 50,
}
definition:resistance("bash", 2)
definition:resistance("cut", 2)
definition:resistance("acid", 9)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0.1, 2, 0.001)
definition:burn(2, false, 0, 0.4, 3, 0.003)
definition:burn(3, false, 0, 1, 5, 0.008)
content.add(definition)
end
do
local definition = content.Material {
    id = "hard_plastic_transp",
    copy_from = "plastic",
    name = ccb.content.text("Transparent Impact Resistant Plastic"),
    repair_difficulty = 4,
    density = 1.2,
}
definition:resistance("bash", 4)
definition:resistance("cut", 3)
definition:resistance("acid", 9)
definition:resistance("heat", 1)
definition:resistance("bullet", 1.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "composite_transp",
    copy_from = "plastic",
    name = ccb.content.text("Transparent Bullet Resistant Composite"),
    repair_difficulty = 5,
}
definition:resistance("bash", 5)
definition:resistance("cut", 4)
definition:resistance("acid", 9)
definition:resistance("heat", 1)
definition:resistance("bullet", 2)
content.add(definition)
end
do
local definition = content.Material {
    id = "plastic_pad",
    name = ccb.content.text("Plastic Padding"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("gouged"),
    chip_resistance = 6,
    repair_difficulty = 5,
    wind_resistance = 90,
    density = 1.0,
    specific_heat_liquid = 1.6,
    specific_heat_solid = 1.6,
    latent_heat = 50,
}
definition:resistance("bash", 1)
definition:resistance("cut", 0.5)
definition:resistance("acid", 9)
definition:resistance("heat", 1)
definition:resistance("bullet", 0.5)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0.1, 2, 0.001)
definition:burn(2, false, 0, 0.4, 3, 0.003)
definition:burn(3, false, 0, 1, 5, 0.008)
content.add(definition)
end
do
local definition = content.Material {
    id = "rdx",
    copy_from = "plastic",
    name = ccb.content.text("RDX"),
    density = 1.806,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "tnt",
    copy_from = "plastic",
    name = ccb.content.text("TNT"),
    density = 1.654,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "styrofoam",
    name = ccb.content.text("Styrofoam"),
    salvaged_into = "material_styrofoam_chunk",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("gouged"),
    chip_resistance = 0,
    repair_difficulty = 3,
    wind_resistance = 99,
    density = 0.15,
    specific_heat_liquid = 1.13,
    specific_heat_solid = 1.13,
    latent_heat = 50,
}
definition:resistance("bash", 2)
definition:resistance("cut", 2)
definition:resistance("acid", 9)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 200, 0.3, 1, 0.25)
definition:burn(2, false, 825, 0.6, 1, 0.5)
definition:burn(3, false, 0, 0.9, 1, 0.75)
content.add(definition)
end
do
local definition = content.Material {
    id = "powder",
    name = ccb.content.text("Powder"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1,
    specific_heat_liquid = 1.5,
    specific_heat_solid = 1.2,
    latent_heat = 10,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 10, 2, 10)
definition:burn(2, false, 0, 10, 2, 10)
definition:burn(3, false, 0, 10, 2, 10)
content.add(definition)
end
do
local definition = content.Material {
    id = "dense_powder",
    copy_from = "powder",
    name = ccb.content.text("Powder"),
    density = 10,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "powder_nonflam",
    name = ccb.content.text("Powder"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1,
    specific_heat_liquid = 1.5,
    specific_heat_solid = 1.2,
    latent_heat = 10,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 0)
definition:resistance("heat", 20)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
content.add(definition)
end
do
local definition = content.Material {
    id = "dense_powder_nonflam",
    copy_from = "powder_nonflam",
    name = ccb.content.text("Powder"),
    density = 10,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "salt",
    name = ccb.content.text("Salt"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 2.16,
    specific_heat_liquid = 0.88,
    specific_heat_solid = 0.92,
    latent_heat = 10,
    soft = false,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 0)
definition:resistance("heat", 20)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
content.add(definition)
end
do
local definition = content.Material {
    id = "mercury",
    name = ccb.content.text("Mercury"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 8,
    density = 13.53,
    specific_heat_liquid = 0.1395,
    specific_heat_solid = 0.1419,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 8)
definition:resistance("heat", 3)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
content.add(definition)
end
do
local definition = content.Material {
    id = "silver",
    name = ccb.content.text("Silver"),
    repaired_with = "silver_small",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 8,
    repair_difficulty = 5,
    density = 10.49,
    specific_heat_liquid = 0.28,
    specific_heat_solid = 0.23,
    latent_heat = 105,
    conductive = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 3)
definition:resistance("acid", 10)
definition:resistance("heat", 3)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("silver_small", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "platinum",
    name = ccb.content.text("Platinum"),
    repaired_with = "platinum_small",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 8,
    repair_difficulty = 5,
    density = 21.45,
    specific_heat_liquid = 0.18,
    specific_heat_solid = 0.13,
    latent_heat = 114,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 10)
definition:resistance("heat", 3)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("platinum_small", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "rubber",
    name = ccb.content.text("Rubber"),
    salvaged_into = "rubber_tire_chunk",
    repaired_with = "plastic_chunk",
    bash_damage_verb = ccb.content.text("stressed"),
    cut_damage_verb = ccb.content.text("slashed"),
    chip_resistance = 8,
    repair_difficulty = 3,
    density = 1.6,
    specific_heat_liquid = 0.4,
    specific_heat_solid = 0.13,
    latent_heat = 165,
    soft = false,
}
definition:resistance("bash", 5)
definition:resistance("cut", 1)
definition:resistance("acid", 5)
definition:resistance("heat", 2)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("worn"))
definition:damage_adjective(2, ccb.content.text("stressed"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("ruined", { context = "adjective" }))
definition:burn(1, false, 100, 1, 3, 0.1)
definition:burn(2, false, 0, 1, 3, 0.2)
definition:burn(3, false, 0, 1, 4, 0.3)
content.add(definition)
end
do
local definition = content.Material {
    id = "butyl_rubber",
    copy_from = "rubber",
    name = ccb.content.text("malleable rubber"),
    repaired_with = "chunk_rubber",
    bash_damage_verb = ccb.content.text("mangled"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 5,
    density = 1.2,
    soft = true,
}
definition:damage_adjective(1, ccb.content.text("compromised"))
definition:damage_adjective(2, ccb.content.text("mangled"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("ruined", { context = "adjective" }))
content.add(definition)
end
do
local definition = content.Material {
    id = "vinyl",
    name = ccb.content.text("Vinyl"),
    salvaged_into = "plastic_sheet",
    repaired_with = "plastic_sheet",
    bash_damage_verb = ccb.content.text("stressed"),
    cut_damage_verb = ccb.content.text("slashed"),
    chip_resistance = 5,
    repair_difficulty = 3,
    density = 1.4,
    specific_heat_liquid = 0.4,
    specific_heat_solid = 0.13,
    latent_heat = 165,
    soft = true,
}
definition:resistance("bash", 3)
definition:resistance("cut", 1)
definition:resistance("acid", 5)
definition:resistance("heat", 2)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("worn"))
definition:damage_adjective(2, ccb.content.text("stressed"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("ruined", { context = "adjective" }))
definition:burn(1, false, 100, 1, 3, 0.1)
definition:burn(2, false, 0, 1, 3, 0.2)
definition:burn(3, false, 0, 1, 4, 0.3)
content.add(definition)
end
do
local definition = content.Material {
    id = "slime",
    name = ccb.content.text("Slime"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("gouged"),
    chip_resistance = 0,
    density = 1,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "lc_steel",
    name = ccb.content.text("Low Carbon Steel"),
    repaired_with = "lc_steel_chunk",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 17,
    repair_difficulty = 3,
    density = 8.0,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 6)
definition:resistance("cut", 6)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 4.5)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "mc_steel",
    name = ccb.content.text("Medium Carbon Steel"),
    repaired_with = "mc_steel_chunk",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 18,
    repair_difficulty = 4,
    density = 8.0,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 7)
definition:resistance("cut", 7)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 4.5)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "hc_steel",
    name = ccb.content.text("High Carbon Steel"),
    repaired_with = "hc_steel_chunk",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 18,
    repair_difficulty = 5,
    density = 8.0,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 10)
definition:resistance("cut", 10)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 6.5)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "ch_steel",
    name = ccb.content.text("Hardened Carbon Steel"),
    repaired_with = "mc_steel_chunk",
    bash_damage_verb = ccb.content.text("dented"),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    repair_difficulty = 6,
    density = 8.0,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 10)
definition:resistance("cut", 10)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 6.5)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented"))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "qt_steel",
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
definition:resistance("bash", 11)
definition:resistance("cut", 11)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 7.5)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "exodii_ceramic",
    name = ccb.content.text("Exodii Ceramic"),
    repaired_with = "exodii_ceramic_patch",
    bash_damage_verb = ccb.content.text("chipped"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 15,
    repair_difficulty = 10,
    density = 6.5,
    specific_heat_liquid = 0.6,
    specific_heat_solid = 0.4,
    latent_heat = 273,
    conductive = false,
}
definition:resistance("bash", 15)
definition:resistance("cut", 20)
definition:resistance("acid", 12)
definition:resistance("heat", 5)
definition:resistance("bullet", 12)
definition:damage_adjective(1, ccb.content.text("chipped"))
definition:damage_adjective(2, ccb.content.text("cracked"))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "budget_steel_chain",
    name = ccb.content.text("Budget Steel Chain"),
    repaired_with = "scrap",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 11,
    breathability = 3,
    repair_difficulty = 2,
    density = 8,
    sheet_thickness = 1.2,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
    uncomfortable = true,
    conductive = true,
}
definition:resistance("bash", 3)
definition:resistance("cut", 6)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "lc_steel_chain",
    name = ccb.content.text("Low Carbon Steel Chain"),
    repaired_with = "lc_chain_link",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 17,
    breathability = 3,
    repair_difficulty = 2,
    density = 8,
    sheet_thickness = 1.2,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
    uncomfortable = true,
    conductive = true,
}
definition:resistance("bash", 3)
definition:resistance("cut", 6)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 4)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "mc_steel_chain",
    name = ccb.content.text("Medium Carbon Steel Chain"),
    repaired_with = "mc_chain_link",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 18,
    breathability = 3,
    repair_difficulty = 2,
    density = 8,
    sheet_thickness = 1.2,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
    uncomfortable = true,
    conductive = true,
}
definition:resistance("bash", 3.5)
definition:resistance("cut", 7)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 4)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "hc_steel_chain",
    name = ccb.content.text("High Carbon Steel Chain"),
    repaired_with = "hc_chain_link",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 18,
    breathability = 3,
    repair_difficulty = 2,
    density = 8,
    sheet_thickness = 1.2,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
    uncomfortable = true,
    conductive = true,
}
definition:resistance("bash", 5)
definition:resistance("cut", 9)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 5)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "ch_steel_chain",
    name = ccb.content.text("Case Hardened Carbon Steel Chain"),
    repaired_with = "ch_chain_link",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    breathability = 3,
    repair_difficulty = 2,
    density = 8,
    sheet_thickness = 1.2,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
    uncomfortable = true,
    conductive = true,
}
definition:resistance("bash", 5)
definition:resistance("cut", 10)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 6)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "qt_steel_chain",
    name = ccb.content.text("Tempered Carbon Steel Chain"),
    repaired_with = "mc_chain_link",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    breathability = 3,
    repair_difficulty = 2,
    density = 8,
    sheet_thickness = 1.2,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
    uncomfortable = true,
    conductive = true,
}
definition:resistance("bash", 5.5)
definition:resistance("cut", 11)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 7)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "steel",
    name = ccb.content.text("Steel"),
    repaired_with = { "steel_chunk", "lc_steel_chunk", "mc_steel_chunk", "hc_steel_chunk", "ch_steel_chunk", "qt_steel_chunk" },
    repaired_with_name = ccb.content.text("any steel chunk"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    repair_difficulty = 4,
    density = 8,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 6)
definition:resistance("cut", 6)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 3)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "plut_cell",
    name = ccb.content.text("Energetic Nanocompound"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    density = 20.0,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 6)
definition:resistance("cut", 6)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 3)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:fuel(10000, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "plutonium",
    name = ccb.content.text("Plutonium"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 1,
    density = 19.84,
    specific_heat_liquid = 0.13,
    specific_heat_solid = 0.13,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "uran_cell",
    name = ccb.content.text("Uranium cell"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    density = 19.0,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 6)
definition:resistance("cut", 6)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 3)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:fuel(10000, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "hydrogen_cell",
    name = ccb.content.text("Pressurized Hydrogen"),
    repaired_with = "null",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    density = 30,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 6)
definition:resistance("cut", 6)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 3)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:fuel(4000000, "t_null", false)
definition:fuel_explosion(2, 2, 1, true, 0.15)
content.add(definition)
end
do
local definition = content.Material {
    id = "gas",
    name = ccb.content.text("Gas"),
    repaired_with = "null",
    bash_damage_verb = ccb.content.text("ripples"),
    cut_damage_verb = ccb.content.text("passed through"),
    chip_resistance = 0,
    density = 30,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("agitated"))
definition:damage_adjective(2, ccb.content.text("thinned"))
definition:damage_adjective(3, ccb.content.text("culled"))
definition:damage_adjective(4, ccb.content.text("eradicated"))
content.add(definition)
end
do
local definition = content.Material {
    id = "nitrogen",
    copy_from = "gas",
    name = ccb.content.text("Nitrogen"),
}
content.add(definition)
end
do
local definition = content.Material {
    id = "oxygen",
    copy_from = "gas",
    name = ccb.content.text("Oxygen"),
}
content.add(definition)
end
do
local definition = content.Material {
    id = "hydrogen",
    copy_from = "gas",
    name = ccb.content.text("Hydrogen"),
}
content.add(definition)
end
do
local definition = content.Material {
    id = "stone",
    name = ccb.content.text("Stone"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 20,
    density = 2.8,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
}
definition:resistance("bash", 6)
definition:resistance("cut", 6)
definition:resistance("acid", 8)
definition:resistance("heat", 3)
definition:resistance("bullet", 3)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("pebble", 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "rhodonite",
    copy_from = "stone",
    name = ccb.content.text("Rhodonite"),
    density = 3.7,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "zincite",
    copy_from = "stone",
    name = ccb.content.text("Zincite"),
    density = 5.68,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "slaked_lime",
    copy_from = "stone",
    name = ccb.content.text("Slaked Lime"),
    density = 2.34,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "quicklime",
    copy_from = "stone",
    name = ccb.content.text("Quicklime"),
    density = 3.34,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "cement",
    copy_from = "stone",
    name = ccb.content.text("Cement"),
    density = 1.44,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "monolith",
    name = ccb.content.text("Monolith"),
    bash_damage_verb = ccb.content.text("agitated"),
    cut_damage_verb = ccb.content.text("agitated"),
    chip_resistance = 100,
    density = 28,
    specific_heat_liquid = 0.52,
    specific_heat_solid = 0.52,
    latent_heat = 5200,
}
definition:resistance("bash", 160)
definition:resistance("cut", 200)
definition:resistance("acid", 100)
definition:resistance("heat", 100)
definition:resistance("bullet", 160)
definition:damage_adjective(1, ccb.content.text("resonating"))
definition:damage_adjective(2, ccb.content.text("cascading"))
definition:damage_adjective(3, ccb.content.text("unraveling"))
definition:damage_adjective(4, ccb.content.text("fractal"))
content.add(definition)
end
do
local definition = content.Material {
    id = "ballistic_shield",
    name = ccb.content.text("Ballistic Barrier"),
    bash_damage_verb = ccb.content.text("agitated"),
    cut_damage_verb = ccb.content.text("agitated"),
    chip_resistance = 100,
    breathability = 5,
    density = 1,
    specific_heat_liquid = 0.52,
    specific_heat_solid = 0.52,
    latent_heat = 5200,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 100)
definition:damage_adjective(1, ccb.content.text("resonating"))
definition:damage_adjective(2, ccb.content.text("cascading"))
definition:damage_adjective(3, ccb.content.text("unraveling"))
definition:damage_adjective(4, ccb.content.text("fractal"))
content.add(definition)
end
do
local definition = content.Material {
    id = "monolith_heavy",
    name = ccb.content.text("Monolith"),
    bash_damage_verb = ccb.content.text("agitated"),
    cut_damage_verb = ccb.content.text("agitated"),
    chip_resistance = 100,
    density = 400,
    specific_heat_liquid = 0.52,
    specific_heat_solid = 0.52,
    latent_heat = 5200,
}
definition:resistance("bash", 160)
definition:resistance("cut", 200)
definition:resistance("acid", 100)
definition:resistance("heat", 100)
definition:resistance("bullet", 160)
definition:damage_adjective(1, ccb.content.text("resonating"))
definition:damage_adjective(2, ccb.content.text("cascading"))
definition:damage_adjective(3, ccb.content.text("unraveling"))
definition:damage_adjective(4, ccb.content.text("fractal"))
definition:burn_product("pebble", 1)
content.add(definition)
end
do
local definition = content.Material {
    id = "anomaly",
    copy_from = "monolith",
    name = ccb.content.text("Anomalous Material"),
    density = 10000,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "superalloy",
    name = ccb.content.text("Superalloy"),
    repaired_with = "alloy_sheet",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    repair_difficulty = 7,
    density = 1.8,
    specific_heat_liquid = 0.88,
    specific_heat_solid = 0.44,
    latent_heat = 320,
    conductive = true,
}
definition:resistance("bash", 13)
definition:resistance("cut", 13)
definition:resistance("acid", 22)
definition:resistance("heat", 14)
definition:resistance("bullet", 7.5)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "carbide",
    name = ccb.content.text("Layered Carbide"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    breathability = 5,
    density = 16.0,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
}
definition:resistance("bash", 6)
definition:resistance("cut", 6)
definition:resistance("acid", 30)
definition:resistance("heat", 30)
definition:resistance("bullet", 5)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "nylon",
    name = ccb.content.text("Synthetic Fabric"),
    salvaged_into = "nylon",
    repaired_with = "nylon",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 7,
    breathability = 3,
    repair_difficulty = 2,
    density = 1.15,
    specific_heat_liquid = 1.7,
    specific_heat_solid = 1.7,
    latent_heat = 42,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 9)
definition:resistance("heat", 2)
definition:resistance("bullet", 3)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 0, 0.05, 1, 0.01)
definition:burn(2, false, 0, 0.05, 2, 0.03)
definition:burn(3, false, 0, 0.15, 5, 0.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "nylon_2",
    copy_from = "nylon",
    name = ccb.content.text("Synthetic Fabric"),
    repaired_with = "null",
}
content.add(definition)
end
do
local definition = content.Material {
    id = "nylon_quilted",
    copy_from = "nylon",
    name = ccb.content.text("Quilted Nylon"),
    repaired_with = "null",
    wind_resistance = 65,
}
definition:resistance("bash", 1.5)
definition:resistance("cut", 2)
definition:resistance("acid", 9)
definition:resistance("heat", 2)
definition:resistance("bullet", 3)
content.add(definition)
end
do
local definition = content.Material {
    id = "nylon_quilted_2",
    copy_from = "nylon_quilted",
    name = ccb.content.text("Quilted Nylon"),
    repaired_with = "null",
}
content.add(definition)
end
do
local definition = content.Material {
    id = "carpet_pilling",
    copy_from = "nylon",
    name = ccb.content.text("Carpet Pilling"),
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 6)
definition:resistance("heat", 2)
definition:resistance("bullet", 1)
definition:burn(1, false, 0, 1, 1, 0.02)
definition:burn(2, false, 0, 2, 1, 0.04)
definition:burn(3, false, 0, 3, 1, 0.06)
content.add(definition)
end
do
local definition = content.Material {
    id = "unobtanium",
    name = ccb.content.text("Strange Metal"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 10,
    repair_difficulty = 0,
    density = 59,
    specific_heat_liquid = 0.49,
    specific_heat_solid = 0.39,
    latent_heat = 205,
    conductive = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 3)
definition:resistance("acid", 0)
definition:resistance("heat", 3)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "tin",
    name = ccb.content.text("Tin"),
    repaired_with = "tin",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 8,
    repair_difficulty = 4,
    density = 7.27,
    specific_heat_liquid = 0.24,
    specific_heat_solid = 0.21,
    latent_heat = 59,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 2)
definition:resistance("heat", 3)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "veggy",
    name = ccb.content.text("Plant Matter"),
    bash_damage_verb = ccb.content.text("squished"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 2,
    breathability = 4,
    density = 1.1,
    specific_heat_liquid = 3.9,
    specific_heat_solid = 1.9,
    latent_heat = 290,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 2)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("calcium", 0.1)
definition:vitamin("vitC", 0.5)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "tomato",
    name = ccb.content.text("Tomato"),
    bash_damage_verb = ccb.content.text("squished"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 2,
    density = 1.1,
    specific_heat_liquid = 3.9,
    specific_heat_solid = 1.9,
    latent_heat = 290,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 2)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("calcium", 0.1)
definition:vitamin("vitC", 4)
definition:vitamin("iron", 0.1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "bean",
    name = ccb.content.text("Bean"),
    bash_damage_verb = ccb.content.text("squished"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 2,
    density = 1.1,
    specific_heat_liquid = 3.9,
    specific_heat_solid = 1.9,
    latent_heat = 290,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 2)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("calcium", 0.3)
definition:vitamin("vitC", 0.6)
definition:vitamin("iron", 0.8)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "garlic",
    name = ccb.content.text("Garlic"),
    bash_damage_verb = ccb.content.text("squished"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 2,
    density = 1.1,
    specific_heat_liquid = 3.9,
    specific_heat_solid = 1.9,
    latent_heat = 290,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 2)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("calcium", 1.8)
definition:vitamin("vitC", 5.2)
definition:vitamin("iron", 0.9)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "nut",
    name = ccb.content.text("Nut"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 2,
    density = 1.1,
    specific_heat_liquid = 2.2,
    specific_heat_solid = 2.2,
    latent_heat = 20,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 2)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("calcium", 0.3)
definition:vitamin("iron", 1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "mushroom",
    name = ccb.content.text("Mushroom"),
    bash_damage_verb = ccb.content.text("squished"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 2,
    density = 1.1,
    specific_heat_liquid = 3.9,
    specific_heat_solid = 1.9,
    latent_heat = 290,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 2)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("calcium", 0.4)
definition:vitamin("iron", 4)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "mold",
    copy_from = "mushroom",
    name = ccb.content.text("Mold"),
}
content.add(definition)
end
do
local definition = content.Material {
    id = "yeast",
    copy_from = "mushroom",
    name = ccb.content.text("Yeast"),
}
content.add(definition)
end
do
local definition = content.Material {
    id = "water",
    name = ccb.content.text("Water"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1.0,
    specific_heat_liquid = 4.186,
    specific_heat_solid = 2.108,
    latent_heat = 333,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 1)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, -100, 1, 1)
definition:burn(2, false, 0, -50, 2, 1)
definition:burn(3, false, 0, -10, 2, 2)
content.add(definition)
end
do
local definition = content.Material {
    id = "blood",
    copy_from = "water",
    name = ccb.content.text("Blood"),
    density = 1.06,
}
definition:vitamin("calcium", 0.1)
definition:vitamin("iron", 1.3)
content.add(definition)
end
do
local definition = content.Material {
    id = "hblood",
    copy_from = "blood",
    name = ccb.content.text("Human Blood"),
}
content.add(definition)
end
do
local definition = content.Material {
    id = "acetone",
    name = ccb.content.text("Acetone"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 0.784,
    specific_heat_liquid = 2.14,
    specific_heat_solid = 2.14,
    latent_heat = 50,
    conductive = false,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 1)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 300, 6, 1)
definition:burn(2, false, 0, 600, 6, 2)
definition:burn(3, false, 0, 900, 6, 3)
definition:fuel(35800, "t_diesel_pump", false)
definition:fuel_explosion(20, 1000, 0.2, false, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "acid",
    name = ccb.content.text("acid"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1.83,
    specific_heat_liquid = 1.38,
    specific_heat_solid = 1.38,
    latent_heat = 451,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 1)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
content.add(definition)
end
do
local definition = content.Material {
    id = "wheat",
    name = ccb.content.text("Wheat"),
    bash_damage_verb = ccb.content.text("squished"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 1,
    density = 1.1,
    specific_heat_liquid = 2,
    specific_heat_solid = 2,
    latent_heat = 150,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 1)
definition:resistance("heat", 0)
definition:resistance("bullet", 1)
definition:vitamin("iron", 0.1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "wood",
    name = ccb.content.text("Wood"),
    salvaged_into = "splinter",
    repaired_with = "2x4",
    bash_damage_verb = ccb.content.text("splintered"),
    cut_damage_verb = ccb.content.text("gouged"),
    chip_resistance = 10,
    breathability = 2,
    repair_difficulty = 3,
    density = 0.85,
    specific_heat_liquid = 1.7,
    specific_heat_solid = 1.7,
    latent_heat = 273,
}
definition:resistance("bash", 3)
definition:resistance("cut", 2)
definition:resistance("acid", 4)
definition:resistance("heat", 1)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("chipped"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("splintered"))
definition:burn(1, false, 200, 1, 1, 0.01)
definition:burn(2, false, 825, 2, 1, 0.02)
definition:burn(3, false, 0, 3, 1, 0.03)
definition:burn_product("ash", 0.018)
definition:fuel(1000, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "charcoal",
    copy_from = "wood",
    name = ccb.content.text("Charcoal"),
    repaired_with = "null",
    density = 0.208,
}
definition:burn(1, false, 0, 2, 1, 0.1)
definition:burn(2, false, 0, 4, 1, 0.2)
definition:burn(3, false, 0, 6, 1, 0.3)
definition:fuel(6240, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "coal",
    copy_from = "wood",
    name = ccb.content.text("Coal"),
    repaired_with = "null",
    density = 0.931,
}
definition:burn(1, false, 0, 10, 0.1, 0.1)
definition:burn(2, false, 0, 20, 0.2, 0.2)
definition:burn(3, false, 0, 30, 0.3, 0.3)
definition:fuel(31200, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "wool",
    name = ccb.content.text("Wool"),
    salvaged_into = "felt_patch",
    repaired_with = "felt_patch",
    bash_damage_verb = ccb.content.text("torn"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 6,
    breathability = 4,
    repair_difficulty = 1,
    wind_resistance = 60,
    density = 1.4,
    specific_heat_liquid = 0.02,
    specific_heat_solid = 0.02,
    latent_heat = 273,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 4)
definition:resistance("heat", 0)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 200, 0.6, 1, 0.025)
definition:burn(2, false, 825, 1.2, 1, 0.05)
definition:burn(3, false, 0, 1.8, 1, 0.075)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "wool_quilted",
    copy_from = "wool",
    name = ccb.content.text("Quilted Wool"),
    repaired_with = "null",
    wind_resistance = 65,
}
definition:resistance("bash", 2)
definition:resistance("cut", 2)
definition:resistance("acid", 4)
definition:resistance("heat", 0)
definition:resistance("bullet", 1.5)
content.add(definition)
end
do
local definition = content.Material {
    id = "wool_quilted_2",
    copy_from = "wool_quilted",
    name = ccb.content.text("Quilted Wool"),
    repaired_with = "null",
}
content.add(definition)
end
do
local definition = content.Material {
    id = "feces",
    name = ccb.content.text("Feces"),
    bash_damage_verb = ccb.content.text("squished"),
    cut_damage_verb = ccb.content.text("squished"),
    chip_resistance = 1,
    density = 1.1,
    specific_heat_liquid = 1.7,
    specific_heat_solid = 1.7,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 1)
definition:resistance("heat", 0)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("squished"))
definition:damage_adjective(2, ccb.content.text("squashed"))
definition:damage_adjective(3, ccb.content.text("mashed"))
definition:damage_adjective(4, ccb.content.text("mushed"))
definition:burn(1, false, 1250, 1, 1, 1)
definition:burn(2, false, 2500, 2, 1, 2)
definition:burn(3, false, 0, 2, 1, 3)
content.add(definition)
end
do
local definition = content.Material {
    id = "dried_vegetable",
    name = ccb.content.text("Dried Vegetable"),
    bash_damage_verb = ccb.content.text("bruised"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 1,
    density = 1.1,
    specific_heat_liquid = 2.5,
    specific_heat_solid = 3.5,
    latent_heat = 100,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 2)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("vitC", 2)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "cured_meat",
    name = ccb.content.text("Cured Meat"),
    bash_damage_verb = ccb.content.text("bruised"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 2,
    density = 1.1,
    specific_heat_liquid = 3.16,
    specific_heat_solid = 2.31,
    latent_heat = 190,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 1)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("calcium", 0.1)
definition:vitamin("iron", 1.3)
definition:damage_adjective(1, ccb.content.text("bruised"))
definition:damage_adjective(2, ccb.content.text("mutilated"))
definition:damage_adjective(3, ccb.content.text("badly mutilated"))
definition:damage_adjective(4, ccb.content.text("thoroughly mutilated"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "processed_food",
    name = ccb.content.text("Processed Food"),
    bash_damage_verb = ccb.content.text("smashed"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 2,
    density = 1.1,
    specific_heat_liquid = 3,
    specific_heat_solid = 2,
    latent_heat = 190,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 2)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "cheese",
    name = ccb.content.text("Cheese"),
    bash_damage_verb = ccb.content.text("smashed"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 0,
    density = 1.1,
    specific_heat_liquid = 3,
    specific_heat_solid = 2.7,
    latent_heat = 160,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:vitamin("calcium", 1.5)
definition:vitamin("iron", 0.1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 0, 1, 0.002)
definition:burn(2, false, 0, 0, 3, 0.002)
definition:burn(3, false, 0, 0, 5, 0.005)
content.add(definition)
end
do
local definition = content.Material {
    id = "ice_cream",
    name = ccb.content.text("Ice Cream"),
    bash_damage_verb = ccb.content.text("smashed"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 0,
    density = 1.1,
    specific_heat_liquid = 3.15,
    specific_heat_solid = 2.74,
    latent_heat = 200,
    rotting = true,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, -100, 1, 1)
definition:burn(2, false, 0, -50, 2, 1)
definition:burn(3, false, 0, -10, 2, 2)
content.add(definition)
end
do
local definition = content.Material {
    id = "soil",
    name = ccb.content.text("Soil"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1.5,
    specific_heat_liquid = 1.7,
    specific_heat_solid = 1.7,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 0)
definition:resistance("heat", 20)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
content.add(definition)
end
do
local definition = content.Material {
    id = "sand",
    copy_from = "soil",
    name = ccb.content.text("Sand"),
    density = 1.6,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "zinc",
    name = ccb.content.text("Zinc"),
    repaired_with = "zinc_metal",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 10,
    repair_difficulty = 4,
    density = 7.2,
    specific_heat_liquid = 0.51,
    specific_heat_solid = 0.39,
    latent_heat = 112,
    conductive = true,
}
definition:resistance("bash", 4)
definition:resistance("cut", 3)
definition:resistance("acid", 4)
definition:resistance("heat", 1)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(2, ccb.content.text("bent"))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "propane",
    copy_from = "hydrocarbons",
    name = ccb.content.text("Propane"),
}
definition:fuel(25000, "t_null", false)
definition:fuel_explosion(20, 1000, 0.2, false, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "slag",
    name = ccb.content.text("Slag"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 4,
    specific_heat_liquid = 1.7,
    specific_heat_solid = 1.7,
    latent_heat = 273,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 0)
definition:resistance("heat", 20)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
content.add(definition)
end
do
local definition = content.Material {
    id = "ammonia_hydroxide",
    name = ccb.content.text("Ammonia Hydroxide"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1,
    specific_heat_liquid = 3.13,
    specific_heat_solid = 4.22,
    latent_heat = 332,
    freezing_point = -77.73,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:resistance("electric", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
content.add(definition)
end
do
local definition = content.Material {
    id = "ammonia_liquid",
    name = ccb.content.text("Liquid Ammonia"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1,
    specific_heat_liquid = 3.13,
    specific_heat_solid = 4.22,
    latent_heat = 332,
    freezing_point = -77.73,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:resistance("electric", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:fuel(11500, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "turpentine",
    name = ccb.content.text("Turpentine"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 0.87,
    specific_heat_liquid = 1.72,
    specific_heat_solid = 1.8,
    latent_heat = 293,
    freezing_point = -55,
    conductive = true,
}
definition:resistance("bash", 0)
definition:resistance("cut", 0)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
definition:burn(1, false, 0, 300, 0, 1)
definition:burn(2, false, 0, 600, 0, 2)
definition:burn(3, false, 0, 900, 0, 3)
definition:fuel(34800, "t_null", false)
definition:fuel_explosion(5, 1000, 0.2, false, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "nanotubes",
    name = ccb.content.text("Carbon Lattice"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    breathability = 5,
    density = 3.5,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
}
definition:resistance("bash", 1)
definition:resistance("cut", 4)
definition:resistance("acid", 4)
definition:resistance("heat", 3)
definition:resistance("bullet", 4)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "asbestos",
    name = ccb.content.text("asbestos"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 5,
    density = 2.4,
    specific_heat_liquid = 0.837,
    specific_heat_solid = 0.837,
    latent_heat = 500,
    conductive = false,
}
definition:resistance("bash", 2)
definition:resistance("cut", 5)
definition:resistance("acid", 10)
definition:resistance("heat", 20)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("lightly damaged"))
definition:damage_adjective(2, ccb.content.text("damaged", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("very damaged"))
definition:damage_adjective(4, ccb.content.text("thoroughly damaged"))
content.add(definition)
end
do
local definition = content.Material {
    id = "mut_feather",
    name = ccb.content.text("Mutant Feather"),
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 8,
    breathability = 1,
    wind_resistance = 100,
    density = 0.8,
    specific_heat_liquid = 0.5,
    specific_heat_solid = 0.5,
    latent_heat = 200,
    soft = true,
}
definition:resistance("bash", 0.5)
definition:resistance("cut", 0.1)
definition:resistance("bullet", 0.1)
definition:resistance("acid", 0)
definition:resistance("heat", 0)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 0, 0.6, 1, 0.02)
definition:burn(2, false, 0, 1, 1, 0.04)
definition:burn(3, false, 0, 1, 1, 0.06)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "mut_fur",
    name = ccb.content.text("Mutant Fur"),
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 8,
    breathability = 1,
    density = 1.1,
    specific_heat_liquid = 0.02,
    specific_heat_solid = 0.02,
    latent_heat = 333,
    soft = true,
}
definition:resistance("bash", 0.5)
definition:resistance("cut", 0.31)
definition:resistance("acid", 1)
definition:resistance("heat", 1)
definition:resistance("bullet", 0.25)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 0, 0.6, 1, 0.02)
definition:burn(2, false, 0, 1, 1, 0.04)
definition:burn(3, false, 0, 1, 1, 0.06)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "mut_wood",
    name = ccb.content.text("Mutant Wood"),
    bash_damage_verb = ccb.content.text("splintered"),
    cut_damage_verb = ccb.content.text("gouged"),
    chip_resistance = 10,
    breathability = 2,
    density = 0.85,
    specific_heat_liquid = 1.7,
    specific_heat_solid = 1.7,
    latent_heat = 273,
}
definition:resistance("bash", 3)
definition:resistance("cut", 2)
definition:resistance("acid", 4)
definition:resistance("heat", 1)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("chipped"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("splintered"))
definition:burn(1, false, 200, 1, 1, 0.01)
definition:burn(2, false, 825, 2, 1, 0.02)
definition:burn(3, false, 0, 3, 1, 0.03)
definition:burn_product("ash", 0.018)
definition:fuel(1000, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "mut_bone",
    name = ccb.content.text("Mutant Bone"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 8,
    wind_resistance = 90,
    density = 1.4,
    specific_heat_liquid = 1.2,
    specific_heat_solid = 1.2,
    latent_heat = 200,
    rotting = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 3)
definition:resistance("acid", 7)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:vitamin("calcium", 2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0, 0, 0.0003)
definition:burn(2, false, 250, 0.2, 3, 0.01)
definition:burn(3, false, 250, 0.35, 5, 0.02)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "mut_scales",
    name = ccb.content.text("Mutant Scales"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 8,
    wind_resistance = 75,
    density = 1.2,
    specific_heat_liquid = 1.2,
    specific_heat_solid = 1.2,
    latent_heat = 200,
    soft = true,
}
definition:resistance("bash", 2.2)
definition:resistance("cut", 3.5)
definition:resistance("acid", 7)
definition:resistance("heat", 1)
definition:resistance("bullet", 1.4)
definition:vitamin("calcium", 2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0, 0, 0)
definition:burn(2, false, 250, 0, 1, 1)
definition:burn(3, false, 0, 1, 1, 2)
definition:burn_product("corpse_ash", 0.035)
content.add(definition)
end
do
local definition = content.Material {
    id = "mi-go_flesh",
    copy_from = "flesh",
    name = ccb.content.text("Mi-go Flesh"),
}
content.add(definition)
end
do
local definition = content.Material {
    id = "mi-go_blood",
    copy_from = "water",
    name = ccb.content.text("Mi-go Ichor"),
}
content.add(definition)
end
do
local definition = content.Material {
    id = "mi-go_bone",
    name = ccb.content.text("Mi-go Bone"),
    repaired_with = "bone_mi-go",
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 12,
    repair_difficulty = 7,
    wind_resistance = 90,
    density = 2.0,
    specific_heat_liquid = 1.2,
    specific_heat_solid = 1.2,
    latent_heat = 200,
    rotting = true,
}
definition:resistance("bash", 3)
definition:resistance("cut", 4)
definition:resistance("acid", 10)
definition:resistance("heat", 2)
definition:resistance("bullet", 2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "down_feathers",
    name = ccb.content.text("Down Feathers"),
    salvaged_into = "down_feather",
    repaired_with = "down_feather",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 4,
    breathability = 3,
    repair_difficulty = 4,
    wind_resistance = 80,
    density = 0.01,
    specific_heat_liquid = 0.02,
    specific_heat_solid = 0.02,
    latent_heat = 250,
    soft = true,
}
definition:resistance("bash", 0.5)
definition:resistance("cut", 0.1)
definition:resistance("acid", 4)
definition:resistance("heat", 0)
definition:resistance("bullet", 0)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 200, 0.6, 1, 0.025)
definition:burn(2, false, 825, 1.2, 1, 0.05)
definition:burn(3, false, 0, 1.8, 1, 0.075)
content.add(definition)
end
