local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_solar_spirit_triffid_summon",
    copy_from = "mon_solar_spirit",
    looks_like = "mon_solar_spirit",
    default_faction = "triffid",
    aggression = 15,
    species = { "NATURE_SPIRIT", "SUMMONED_CREATURE" },
}

ccb.content.define_monster {
    id = "mon_vinebeast_summon",
    copy_from = "mon_vinebeast",
    species = { "PLANT", "SUMMONED_CREATURE" },
    death = {
        outcome = {
            message = ccb.content.text("The %s rots into nothingness in moments."),
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_shadow_summon",
    copy_from = "mon_shadow",
    species = { "NETHER", "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
    inheritance = { remove = { attacks = { "DISAPPEAR" } } },
}

ccb.content.define_monster {
    id = "mon_xe_kreck_summoned",
    copy_from = "mon_kreck",
    species = { "NETHER", "SUMMONED_CREATURE" },
    categories = { "XE_CLASSIC" },
}

ccb.content.define_monster { id = "mon_shifter_non_player", copy_from = "mon_shifter", default_faction = "nightmares" }

ccb.content.define_monster { id = "mon_shifter_feral", copy_from = "mon_shifter", default_faction = "zombie" }

ccb.content.define_monster { id = "mon_ophanim_non_player", copy_from = "mon_ophanim", default_faction = "nightmares" }

ccb.content.define_monster { id = "mon_duplicator_non_player", copy_from = "mon_duplicator", default_faction = "nightmares" }
