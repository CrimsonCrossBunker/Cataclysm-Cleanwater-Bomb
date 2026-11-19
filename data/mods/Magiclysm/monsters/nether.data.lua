local ccb = require("ccb")

-- These and below monsters are so the nethermancer summons are on the mi-go's side.
ccb.content.define_monster {
    id = "mon_flying_polyp_migo",
    copy_from = "mon_flying_polyp",
    name = ccb.content.plural_text("flying polyp", "flying polyps"),
    default_faction = "mi-go_summon",
    species = { "NETHER", "SUMMONED_CREATURE" },
}

ccb.content.define_monster {
    id = "mon_hunting_horror_migo",
    copy_from = "mon_hunting_horror",
    name = ccb.content.plural_text("hunting horror", "hunting horrors"),
    default_faction = "mi-go_summon",
    species = { "NETHER", "SUMMONED_CREATURE" },
}

ccb.content.define_monster {
    id = "mon_unseen_hunter_migo",
    copy_from = "mon_unseen_hunter",
    name = ccb.content.plural_text("unseen hunter", "unseen hunters"),
    default_faction = "mi-go_summon",
    species = { "NETHER", "SUMMONED_CREATURE" },
}

ccb.content.define_monster {
    id = "mon_yugg_migo",
    copy_from = "mon_yugg",
    name = ccb.content.plural_text("yugg", "yuggs"),
    default_faction = "mi-go_summon",
    species = { "NETHER", "SUMMONED_CREATURE" },
}

ccb.content.define_monster {
    id = "mon_gelatin_migo",
    copy_from = "mon_gelatin",
    name = ccb.content.plural_text("amoebic mold", "amoebic molds"),
    default_faction = "mi-go_summon",
    species = { "NETHER", "SUMMONED_CREATURE" },
}

ccb.content.define_monster {
    id = "mon_flaming_eye_migo",
    copy_from = "mon_flaming_eye",
    name = ccb.content.plural_text("flaming eye", "flaming eyes"),
    default_faction = "mi-go_summon",
    species = { "NETHER", "SUMMONED_CREATURE" },
}

ccb.content.define_monster {
    id = "mon_kreck_migo",
    copy_from = "mon_kreck",
    name = ccb.content.plural_text("kreck", "krecks"),
    default_faction = "mi-go_summon",
    species = { "NETHER", "SUMMONED_CREATURE" },
}
