local ccb = require("ccb")

ccb.content.define_item {
    id = "egg_dragonfly_tame",
    name = ccb.content.text("tame dragonfly egg"),
    copy_from = "egg_dragonfly",
    description = ccb.content.text("The still-wet egg of a mutated dragonfly.  This one has been carefully tended for.  The dragonfly inside seems more timid and calmer upon touch."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_dragonfly_naiad_friendly", chance = 100 } } },
}

ccb.content.define_item {
    id = "egg_mantis_tame",
    name = ccb.content.text("tame mantis egg"),
    copy_from = "egg_mantis",
    description = ccb.content.text("Praying mantis eggs glued to each other inside a strange-looking case.  These ones have been carefully tended for.  The mantis inside seems more timid and calmer upon touch."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_mantis_nymph_friendly", chance = 100 } } },
}

ccb.content.define_item {
    id = "egg_lady_bug_tame",
    name = ccb.content.text("tame ladybug egg"),
    copy_from = "egg_lady_bug",
    description = ccb.content.text("A ladybug egg.  You can see a translucent, happy looking larva inside.  This one has been carefully tended for.  The larva inside seems more timid and calmer upon touch."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_lady_bug_larva_friendly", chance = 100 } } },
}

ccb.content.define_item {
    id = "egg_antlion_tame",
    name = ccb.content.text("tame antlion egg"),
    copy_from = "egg_antlion",
    description = ccb.content.text("A large, white antlion egg.  This one has been carefully tended for.  The larva inside seems more timid and calmer upon touch."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_antlion_larva_friendly", chance = 100 } } },
}

ccb.content.define_item {
    id = "egg_cicada_tame",
    name = ccb.content.text("tame cicada egg"),
    copy_from = "egg_cicada",
    description = ccb.content.text("The egg of a cicada.  This one has been carefully tended for.  The cicada inside seems more timid and calmer upon touch."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_cicada_nymph_friendly", chance = 100 } } },
}

ccb.content.define_item {
    id = "egg_water_beetle_tame",
    name = ccb.content.text("tame water beetle egg"),
    copy_from = "egg_water_beetle",
    description = ccb.content.text("The egg of a water beetle.  This one has been carefully tended for.  The larva inside seems more timid and calmer upon touch."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_diving_larva_friendly", chance = 100 } } },
}

ccb.content.define_item {
    id = "egg_water_bug_tame",
    name = ccb.content.text("tame water scorpion egg"),
    copy_from = "egg_water_bug",
    description = ccb.content.text("The egg of a water scorpion.  This one has been carefully tended for.  The water scorpion inside seems more timid and calmer upon touch."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_water_scorpion_larva_friendly", chance = 100 } } },
}

ccb.content.define_item {
    id = "egg_centipede_tame",
    name = ccb.content.text("tame centipede egg"),
    copy_from = "egg_centipede",
    description = ccb.content.text("The egg of a centipede.  This one has been carefully tended for.  The centipede larva inside seems more timid and calmer upon touch."),
    comestible = {},
    inheritance = { add = { rot_spawn = { monster = "mon_centipede_larva_friendly", chance = 100 } } },
}
