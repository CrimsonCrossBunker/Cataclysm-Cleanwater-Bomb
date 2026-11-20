local ccb = require("ccb")
local content = ccb.content

-- Native material definitions
do
local definition = content.Material {
    id = "mag_awakened_water",
    copy_from = "water",
    name = ccb.content.text("Awakened Water"),
}
content.add(definition)
end
do
local definition = content.Material {
    id = "arcane_skin",
    name = ccb.content.text("Arcane Skin"),
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 15,
    breathability = 5,
    density = 10,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
    soft = true,
}
definition:resistance("bash", 14)
definition:resistance("cut", 18)
definition:resistance("acid", 4)
definition:resistance("heat", 20)
definition:resistance("bullet", 14)
definition:resistance("electric", 2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "black_dragon_hide",
    name = ccb.content.text("Black Dragon Hide"),
    repaired_with = "black_dragon_tanned_hide",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    breathability = 1,
    repair_difficulty = 4,
    density = 0.625,
    latent_heat = 333,
    soft = true,
}
definition:resistance("bash", 3)
definition:resistance("cut", 7)
definition:resistance("acid", 40)
definition:resistance("heat", 1)
definition:resistance("bullet", 6)
definition:resistance("electric", 2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("ripped"))
definition:damage_adjective(4, ccb.content.text("shredded"))
definition:burn(1, false, 0, 0, 0, 0)
definition:burn(2, false, 100, 1, 1, 1)
definition:burn(3, false, 0, 2, 4, 2)
content.add(definition)
end
do
local definition = content.Material {
    id = "black_dragon_scales",
    name = ccb.content.text("Black Dragon Scale"),
    repaired_with = "dragon_black_scale",
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 35,
    breathability = 2,
    repair_difficulty = 6,
    density = 5.0667,
    latent_heat = 533,
}
definition:resistance("bash", 8)
definition:resistance("cut", 9)
definition:resistance("acid", 40)
definition:resistance("heat", 4)
definition:resistance("bullet", 8)
definition:resistance("electric", 3)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("marked"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 0, 0, 0, 0)
definition:burn(2, false, 0, 0, 0, 0)
definition:burn(3, false, 100, 1, 1, 1)
content.add(definition)
end
do
local definition = content.Material {
    id = "parabolan_wool",
    name = ccb.content.text("Parabolan Wool"),
    salvaged_into = "parabolan_felt_patch",
    repaired_with = "parabolan_felt_patch",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 12,
    breathability = 4,
    repair_difficulty = 3,
    density = 0.96,
    specific_heat_liquid = 0.02,
    specific_heat_solid = 0.02,
    latent_heat = -50,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 3)
definition:resistance("acid", 5)
definition:resistance("heat", 0)
definition:resistance("bullet", 10)
definition:resistance("electric", 3)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 1250, 1, 1, 1)
definition:burn(2, false, 0, 1, 1, 2)
definition:burn(3, false, 0, 1, 1, 5)
content.add(definition)
end
do
local definition = content.Material {
    id = "parabolan_wool_quilted",
    copy_from = "parabolan_wool",
    name = ccb.content.text("Quilted Parabolan Wool"),
    repaired_with = "null",
}
definition:resistance("bash", 2)
definition:resistance("cut", 6)
definition:resistance("acid", 5)
definition:resistance("heat", 0)
definition:resistance("bullet", 15)
definition:resistance("electric", 3)
content.add(definition)
end
do
local definition = content.Material {
    id = "demon_chitin",
    name = ccb.content.text("Demon Chitin"),
    salvaged_into = "demon_chitin_piece",
    repaired_with = "demon_chitin_flux",
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 10,
    breathability = 1,
    repair_difficulty = 8,
    density = 0.356,
    specific_heat_liquid = 4.186,
    specific_heat_solid = 2.108,
    latent_heat = 333,
}
definition:resistance("bash", 1)
definition:resistance("cut", 10)
definition:resistance("acid", 3)
definition:resistance("heat", 18)
definition:resistance("bullet", 8)
definition:resistance("electric", 2)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, false, 1250, 0, 1, 1)
definition:burn(2, false, 0, 1, 3, 1)
definition:burn(3, false, 0, 1, 5, 5)
content.add(definition)
end
do
local definition = content.Material {
    id = "orichalcum_metal",
    name = ccb.content.text("Orichalcum"),
    repaired_with = "orichalcum_ingot",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 40,
    repair_difficulty = 7,
    density = 8,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
}
definition:resistance("bash", 13)
definition:resistance("cut", 20)
definition:resistance("acid", 7)
definition:resistance("heat", 3)
definition:resistance("bullet", 16)
definition:resistance("electric", 0)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn_product("scrap_bronze", 1)
content.add(definition)
end
do
local definition = content.Material {
    id = "mithril_metal",
    name = ccb.content.text("Mithril"),
    repaired_with = "mithril_ingot",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 40,
    repair_difficulty = 7,
    density = 2.7,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
}
definition:resistance("bash", 13)
definition:resistance("cut", 20)
definition:resistance("acid", 10)
definition:resistance("heat", 10)
definition:resistance("bullet", 16)
definition:resistance("electric", 10)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "crimsonite_metal",
    name = ccb.content.text("Crimsonite"),
    repaired_with = "crimsonite_ingot",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 40,
    repair_difficulty = 7,
    density = 9,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 1000,
    conductive = true,
}
definition:resistance("bash", 7)
definition:resistance("cut", 15)
definition:resistance("acid", 3)
definition:resistance("heat", 75)
definition:resistance("bullet", 16)
definition:resistance("electric", 0)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "glassteel",
    name = ccb.content.text("Glassteel"),
    repaired_with = "scrap",
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 30,
    repair_difficulty = 5,
    density = 2.5,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
}
definition:resistance("bash", 10)
definition:resistance("cut", 6)
definition:resistance("acid", 6)
definition:resistance("heat", 0)
definition:resistance("bullet", 19)
definition:resistance("electric", 10)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "magical_material",
    copy_from = "cotton",
    name = ccb.content.text("Magical Material"),
    repaired_with = "null",
}
content.add(definition)
end
do
local definition = content.Material {
    id = "dragon_blood",
    name = ccb.content.text("Dragon blood"),
    bash_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    cut_damage_verb = ccb.content.text("damaged", { context = "verb" }),
    chip_resistance = 0,
    density = 1,
    specific_heat_liquid = 0.5,
    specific_heat_solid = 0.5,
    latent_heat = 518,
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
definition:burn(1, false, 0, 300, 6, 1)
definition:burn(2, false, 0, 600, 6, 2)
definition:burn(3, false, 0, 900, 6, 3)
definition:fuel(50000, "t_null", false)
definition:fuel_explosion(20, 1000, 0.2, true, 0.1)
content.add(definition)
end
do
local definition = content.Material {
    id = "blood",
    copy_from = "blood",
    name = ccb.content.text("Blood"),
}
definition:fuel(1, "t_null", false)
content.replace(definition)
end
do
local definition = content.Material {
    id = "hblood",
    copy_from = "hblood",
    name = ccb.content.text("Human blood"),
}
definition:fuel(1, "t_null", false)
content.replace(definition)
end
do
local definition = content.Material {
    id = "blood_tainted",
    copy_from = "blood",
    name = ccb.content.text("Tainted blood"),
}
definition:fuel(5, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "alumentum",
    copy_from = "charcoal",
    name = ccb.content.text("Alumentum"),
}
definition:fuel(150000, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "crystallized_mana",
    copy_from = "stone",
    name = ccb.content.text("Crystallized mana"),
}
definition:fuel(1000, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "mana",
    copy_from = "pseudo_fuel",
    name = ccb.content.text("Mana"),
}
definition:fuel(500000, "t_null", true)
content.add(definition)
end
do
local definition = content.Material {
    id = "concentrated_mana",
    name = ccb.content.text("Concentrated Mana"),
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 15,
    density = 2,
    soft = true,
}
definition:resistance("bash", 8)
definition:resistance("cut", 13)
definition:resistance("acid", 12)
definition:resistance("heat", 20)
definition:resistance("bullet", 7)
definition:resistance("electric", 20)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
content.add(definition)
end
