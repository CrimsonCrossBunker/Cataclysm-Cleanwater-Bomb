local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_void_spider_maw",
    name = "hanging maw",
    description = "An explosion of glistening fangs, itself a small fragment of a greater horror.",
    copy_from = "mon_void_spider",
    default_faction = "nether",
    symbol = "w",
    hp = 15,
    melee_skill = 3,
    melee_dice = 5,
    melee_sides = 5,
    armor = {
        bash = 10,
        cut = 12,
        bullet = 15,
        electric = 3,
        stab = 18,
        acid = 15,
    },
    melee_damage = {
        { type = "bash", amount = 5, penetration = 28 },
    },
    attacks = {
        { reference = "void_spider_bite", cooldown = 1 },
    },
    death = {
        outcome = { corpse = "NO_CORPSE", message = "", on_death = "w16b_mon_die_dda_d5ced7e2cd06" },
    },
    inheritance = {
        add = {
            flags = { "QUIETDEATH" },
        },
        remove = {
            flags = { "ALWAYS_SEES_YOU" },
        },
        scale = { speed = 1.2, dodge = 0.25, vision_day = 2 },
    },
}

ccb.content.define_monster {
    id = "mon_void_spider_limb",
    name = "hanging limb",
    description = "Strands of shadow snap from their ordained positions, briefly reaching out before recoiling back into the darkness.",
    copy_from = "mon_void_spider",
    default_faction = "nether",
    symbol = "/",
    hp = 15,
    melee_skill = 3,
    melee_dice = 3,
    melee_sides = 2,
    armor = {
        bash = 5,
        cut = 6,
        bullet = 6,
        electric = 3,
        stab = 7,
        acid = 15,
    },
    attacks = {},
    death = {
        outcome = { corpse = "NO_CORPSE", message = "", on_death = "w16b_mon_die_dda_d5ced7e2cd06" },
    },
    inheritance = {
        add = {
            flags = { "QUIETDEATH" },
        },
        remove = {
            flags = { "ALWAYS_SEES_YOU" },
        },
        scale = { speed = 1.2, dodge = 0.25, vision_day = 2 },
    },
}
