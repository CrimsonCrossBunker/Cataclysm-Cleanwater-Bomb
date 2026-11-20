local ccb = require("ccb")
local content = ccb.content

-- Native material definitions
do
local definition = content.Material {
    id = "fae_fur",
    name = ccb.content.text("Glimmer Fur"),
    salvaged_into = "fur",
    repaired_with = "fur",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 8,
    breathability = 1,
    repair_difficulty = 4,
    density = 12,
    specific_heat_liquid = 0.02,
    specific_heat_solid = 0.02,
    latent_heat = 333,
    soft = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 2)
definition:resistance("acid", 3)
definition:resistance("heat", 1)
definition:resistance("bullet", 6)
definition:resistance("electric", 2)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
definition:burn(1, false, 1250, 1, 3, 1)
definition:burn(2, false, 0, 1, 5, 2)
definition:burn(3, false, 0, 1, 10, 4)
content.add(definition)
end
do
local definition = content.Material {
    id = "fae_blood",
    copy_from = "blood",
    name = ccb.content.text("Fae Blood"),
}
definition:vitamin("calcium", 0.1)
definition:vitamin("iron", 1.3)
definition:vitamin("underhill_essence", 5)
definition:burn(1, false, 0, -100, 1, 1)
definition:burn(2, false, 0, -50, 2, 1)
definition:burn(3, false, 0, -10, 2, 2)
definition:fuel(1, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "fae_flesh",
    name = ccb.content.text("Fae Beast Flesh"),
    bash_damage_verb = ccb.content.text("bruised"),
    cut_damage_verb = ccb.content.text("sliced"),
    chip_resistance = 2,
    density = 1.1,
    specific_heat_liquid = 3.7,
    specific_heat_solid = 2.15,
    latent_heat = 260,
    rotting = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 1)
definition:resistance("heat", 1)
definition:resistance("bullet", 1)
definition:resistance("electric", 1)
definition:vitamin("calcium", 0.1)
definition:vitamin("iron", 1.3)
definition:vitamin("underhill_essence", 10)
definition:damage_adjective(1, ccb.content.text("bruised"))
definition:damage_adjective(2, ccb.content.text("mutilated"))
definition:damage_adjective(3, ccb.content.text("badly mutilated"))
definition:damage_adjective(4, ccb.content.text("thoroughly mutilated"))
definition:burn(1, false, 2500, 1, 1, 1)
definition:burn(2, false, 10000, 2, 3, 2)
definition:burn(3, false, 0, 3, 10, 3)
content.add(definition)
end
if not content.is_mod_active("magiclysm") then
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
    id = "moon_tears",
    name = ccb.content.text("Moon Tears"),
    repaired_with = "moon_tear_ingot",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 40,
    repair_difficulty = 4,
    density = 13,
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
    id = "tezcatlipocas_blood",
    name = ccb.content.text("Tezcatlipoca's blood"),
    repaired_with = "forged_dreamstuff_ingot",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 40,
    repair_difficulty = 4,
    density = 13,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 773,
}
definition:resistance("bash", 8)
definition:resistance("cut", 20)
definition:resistance("acid", 6)
definition:resistance("bullet", 9)
definition:resistance("electric", 10)
definition:resistance("heat", 30)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "moon_tears_fine_chain",
    name = ccb.content.text("Moon Tears Fine Chain"),
    repaired_with = "moon_tear_chain_link",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 40,
    breathability = 3,
    repair_difficulty = 5,
    density = 13,
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
    id = "fae_cotton",
    name = ccb.content.text("gossamer"),
    salvaged_into = "gossamer_patchwork",
    repaired_with = "gossamer_patchwork",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 6,
    breathability = 3,
    repair_difficulty = 4,
    wind_resistance = 70,
    density = 1.05,
    specific_heat_liquid = 0.02,
    specific_heat_solid = 0.02,
    latent_heat = 205,
    soft = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 3)
definition:resistance("acid", 6)
definition:resistance("heat", 2)
definition:resistance("bullet", 3)
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
    id = "elemental_fae_cotton",
    name = ccb.content.text("Elemental gossamer"),
    salvaged_into = "elemental_gossamer_patchwork",
    repaired_with = "elemental_gossamer_patchwork",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 6,
    breathability = 3,
    repair_difficulty = 8,
    wind_resistance = 70,
    density = 2.13,
    specific_heat_liquid = 0.02,
    specific_heat_solid = 0.02,
    latent_heat = 205,
    soft = true,
}
definition:resistance("bash", 2)
definition:resistance("cut", 3)
definition:resistance("acid", 6)
definition:resistance("heat", 2)
definition:resistance("bullet", 3)
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
    id = "obsidian",
    name = ccb.content.text("Obsidian"),
    bash_damage_verb = ccb.content.text("cracked"),
    cut_damage_verb = ccb.content.text("chipped"),
    chip_resistance = 17,
    density = 2.6,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
}
definition:resistance("bash", 4)
definition:resistance("cut", 6)
definition:resistance("acid", 8)
definition:resistance("heat", 3)
definition:resistance("bullet", 3)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("cracked"))
definition:damage_adjective(4, ccb.content.text("shattered"))
definition:burn(1, true, 0, 0, 0, 0)
definition:burn(2, true, 0, 0, 0, 0)
definition:burn(3, true, 0, 0, 0, 0)
content.add(definition)
end
do
local definition = content.Material {
    id = "fae_cotton_quilted",
    copy_from = "fae_cotton",
    name = ccb.content.text("Quilted Gossamer"),
    repaired_with = "null",
    wind_resistance = 75,
}
definition:resistance("bash", 4)
definition:resistance("cut", 6)
definition:resistance("acid", 6)
definition:resistance("heat", 2)
definition:resistance("bullet", 5)
content.add(definition)
end
do
local definition = content.Material {
    id = "shadowstuff",
    name = ccb.content.text("shadowstuff"),
    salvaged_into = "scrap_shadowstuff",
    bash_damage_verb = ccb.content.text("torn"),
    cut_damage_verb = ccb.content.text("bleached"),
    chip_resistance = 18,
    breathability = 5,
    repair_difficulty = 7,
    density = 0.5,
    specific_heat_liquid = 0.49,
    specific_heat_solid = 0.39,
    latent_heat = 205,
    conductive = true,
}
definition:resistance("bash", 4)
definition:resistance("cut", 1)
definition:resistance("acid", 2)
definition:resistance("heat", 7)
definition:resistance("bullet", 5)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "dreamstuff",
    name = ccb.content.text("Dreamdross"),
    salvaged_into = "scrap_dreamdross",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 18,
    breathability = 3,
    repair_difficulty = 5,
    density = 2.2,
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
    id = "forged_dreamstuff",
    name = ccb.content.text("Forged Dreams"),
    salvaged_into = "dreamdross_lump",
    repaired_with = "forged_dreamstuff_ingot",
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 22,
    breathability = 3,
    repair_difficulty = 6,
    density = 3.3,
    specific_heat_liquid = 0.49,
    specific_heat_solid = 0.39,
    latent_heat = 205,
    conductive = true,
}
definition:resistance("bash", 8)
definition:resistance("cut", 9)
definition:resistance("acid", 16)
definition:resistance("heat", 4)
definition:resistance("bullet", 6)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "flesh_roots",
    name = ccb.content.text("Flesh Roots"),
    bash_damage_verb = ccb.content.text("dented", { context = "verb" }),
    cut_damage_verb = ccb.content.text("scratched"),
    chip_resistance = 20,
    breathability = 5,
    density = 3.5,
    specific_heat_liquid = 0.82,
    specific_heat_solid = 0.45,
    latent_heat = 273,
}
definition:resistance("bash", 5)
definition:resistance("cut", 5)
definition:resistance("acid", -1)
definition:resistance("heat", -6)
definition:resistance("bullet", 3)
definition:damage_adjective(1, ccb.content.text("marked"))
definition:damage_adjective(2, ccb.content.text("dented", { context = "adjective" }))
definition:damage_adjective(3, ccb.content.text("smashed"))
definition:damage_adjective(4, ccb.content.text("shattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "vampire_blood",
    copy_from = "blood",
    name = ccb.content.text("Vampire Blood"),
    density = 1.166,
}
definition:burn(1, false, 0, -100, 1, 1)
definition:burn(2, false, 0, -50, 2, 1)
definition:burn(3, false, 0, -10, 2, 2)
definition:fuel(100, "t_null", false)
content.add(definition)
end
do
local definition = content.Material {
    id = "elemental_water",
    name = ccb.content.text("elemental water"),
    bash_damage_verb = ccb.content.text("shaken"),
    cut_damage_verb = ccb.content.text("rippled"),
    chip_resistance = 15,
    density = 2,
    soft = true,
}
definition:resistance("bash", 6)
definition:resistance("cut", 3)
definition:resistance("acid", 20)
definition:resistance("heat", 2)
definition:resistance("bullet", 3)
definition:damage_adjective(1, ccb.content.text("scratched"))
definition:damage_adjective(2, ccb.content.text("cut"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "fruit_heavy",
    copy_from = "fruit",
    name = ccb.content.text("Fruit Matter"),
    density = 11,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "fruit_light",
    copy_from = "fruit",
    name = ccb.content.text("Fruit Matter"),
    density = 0.11,
}
content.add(definition)
end
do
local definition = content.Material {
    id = "paper_fireproof",
    name = ccb.content.text("Fireproof Paper"),
    salvaged_into = "paper",
    repaired_with = "paper",
    bash_damage_verb = ccb.content.text("ripped"),
    cut_damage_verb = ccb.content.text("cut"),
    chip_resistance = 0,
    density = 1.2,
    specific_heat_liquid = 1.34,
    specific_heat_solid = 1.34,
    latent_heat = 1,
    soft = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 1)
definition:resistance("acid", 1)
definition:resistance("heat", 999)
definition:resistance("bullet", 1)
definition:damage_adjective(1, ccb.content.text("ripped"))
definition:damage_adjective(2, ccb.content.text("torn"))
definition:damage_adjective(3, ccb.content.text("shredded"))
definition:damage_adjective(4, ccb.content.text("tattered"))
content.add(definition)
end
do
local definition = content.Material {
    id = "shoggoth_protoplasmic_ooze",
    name = ccb.content.text("Proto-plasmic Ooze"),
    bash_damage_verb = ccb.content.text("ripples"),
    cut_damage_verb = ccb.content.text("passed through"),
    chip_resistance = 10,
    breathability = 5,
    repair_difficulty = 3,
    density = 1.1,
    specific_heat_liquid = 4.186,
    specific_heat_solid = 2.108,
    latent_heat = 333,
    soft = true,
    conductive = true,
}
definition:resistance("bash", 1)
definition:resistance("cut", 3)
definition:resistance("acid", 8)
definition:resistance("heat", 4)
definition:resistance("bullet", 6)
definition:damage_adjective(1, ccb.content.text("agitated"))
definition:damage_adjective(2, ccb.content.text("thinned"))
definition:damage_adjective(3, ccb.content.text("culled"))
definition:damage_adjective(4, ccb.content.text("eradicated"))
content.add(definition)
end
