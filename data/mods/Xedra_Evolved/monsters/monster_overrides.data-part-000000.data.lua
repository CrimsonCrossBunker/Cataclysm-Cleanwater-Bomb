local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_tindalos",
    copy_from = "mon_tindalos",
    inheritance = { add = { flags = { "STABILIZED_TIMELINE", "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_hound_tindalos",
    copy_from = "mon_hound_tindalos",
    inheritance = { add = { flags = { "STABILIZED_TIMELINE", "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_lieutenant_shadow",
    copy_from = "mon_lieutenant_shadow",
    inheritance = { add = { flags = { "STABILIZED_TIMELINE", "WITHERINGPROOF", "SHADOW_MONSTER_IMMUNE" } } },
}

ccb.content.define_monster {
    id = "mon_bear_cub",
    copy_from = "mon_bear_cub",
    species = { "MAMMAL", "NIGHT_CREATURE" },
    harvest = "bear_with_skull",
}

ccb.content.define_monster { id = "mon_bear", copy_from = "mon_bear", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster {
    id = "mon_bear_mutant_3headed",
    copy_from = "mon_bear_mutant_3headed",
    species = { "MAMMAL", "NIGHT_CREATURE" },
}

ccb.content.define_monster { id = "mon_wolf", copy_from = "mon_wolf", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_wolf_pup", copy_from = "mon_wolf_pup", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_coyote", copy_from = "mon_coyote", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster {
    id = "mon_coyote_mutant_shark",
    copy_from = "mon_coyote_mutant_shark",
    species = { "MAMMAL", "NIGHT_CREATURE" },
}

ccb.content.define_monster {
    id = "mon_coyote_mutant_venom",
    copy_from = "mon_coyote_mutant_venom",
    species = { "MAMMAL", "NIGHT_CREATURE" },
}

ccb.content.define_monster { id = "mon_big_rat", copy_from = "mon_big_rat", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_pack_rat", copy_from = "mon_pack_rat", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_sewer_rat", copy_from = "mon_sewer_rat", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster {
    id = "mon_black_ratkin",
    copy_from = "mon_black_ratkin",
    species = { "MAMMAL", "NIGHT_CREATURE" },
}

ccb.content.define_monster { id = "mon_black_rat", copy_from = "mon_black_rat", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_bat", copy_from = "mon_bat", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_crow", copy_from = "mon_crow", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster {
    id = "mon_crow_mutant_small",
    copy_from = "mon_crow_mutant_small",
    species = { "MAMMAL", "NIGHT_CREATURE" },
}

ccb.content.define_monster { id = "mon_crow_mutant", copy_from = "mon_crow_mutant", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_fox_red", copy_from = "mon_fox_red", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_fox_gray", copy_from = "mon_fox_gray", species = { "MAMMAL", "NIGHT_CREATURE" } }

ccb.content.define_monster { id = "mon_boar_wild_piglet", copy_from = "mon_boar_wild_piglet", harvest = "pig_with_skull" }

ccb.content.define_monster {
    id = "mon_ant",
    name = ccb.content.plural_text("giant ant", "giant ants"),
    description = ccb.content.text("An enormous red ant covered in chitinous plates.  She possesses a pair of wriggling antennae and vicious-looking mandibles."),
    copy_from = "mon_ant",
    harvest = "giant_ant",
}

ccb.content.define_monster {
    id = "mon_ant_acid",
    name = ccb.content.plural_text("giant acidic ant", "giant acidic ants"),
    description = ccb.content.text("A monstrous brown ant with a swollen abdomen that ends with a small orifice at the tip.  Glistening liquid seems to drip out periodically."),
    copy_from = "mon_ant_acid",
    harvest = "giant_acid_ant",
}

ccb.content.define_monster { id = "mon_zombie_child_base", copy_from = "mon_zombie_child_base", harvest = "zombie_child" }

ccb.content.define_monster { id = "mon_zombie_runner", copy_from = "mon_zombie_runner", harvest = "zombie_runner" }

ccb.content.define_monster {
    id = "mon_broken_cyborg",
    copy_from = "mon_broken_cyborg",
    inheritance = { add = { armor = { withering_damage = 8 } } },
}

ccb.content.define_monster {
    id = "mon_prototype_cyborg",
    copy_from = "mon_prototype_cyborg",
    inheritance = { add = { armor = { withering_damage = 6 } } },
}

ccb.content.define_monster {
    id = "mon_exodii_worker",
    copy_from = "mon_exodii_worker",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_exodii_quad",
    copy_from = "mon_exodii_quad",
    inheritance = { add = { flags = { "WITHERINGPROOF" } } },
}
