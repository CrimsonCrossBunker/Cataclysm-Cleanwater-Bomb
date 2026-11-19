local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_cunning",
    copy_from = "mon_zombie",
    name = ccb.content.plural_text("zombie", "zombies"),
    looks_like = "mon_zombie",
    description = ccb.content.text("A human body, skin a sickly grayish color, moving with a slow shuffling motion.  It occasionally looks at its surroundings with more focus than its peers; could it be remembering something?"),
    upgrade = false,
    categories = { "CLASSIC" },
    pathing = { max_distance = 30, avoid_traps = true, avoid_sharp = true },
    inheritance = {
        add = { flags = { "CAN_OPEN_DOORS", "PATH_AVOID_DANGER", "PATH_AVOID_FALL" } },
        remove = { flags = { "CLUMSY_ATTACKS" } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_fat",
    copy_from = "mon_zombie_fat",
    inheritance = { remove = { flags = { "UNBREAKABLE_MORALE", "WARM" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_soldier",
    copy_from = "mon_zombie_soldier",
    inheritance = { remove = { flags = { "UNBREAKABLE_MORALE", "WARM" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_cop",
    copy_from = "mon_zombie_cop",
    inheritance = { remove = { flags = { "UNBREAKABLE_MORALE", "WARM" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_crawler",
    copy_from = "mon_zombie_crawler",
    inheritance = { remove = { flags = { "UNBREAKABLE_MORALE", "WARM" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_child",
    copy_from = "mon_zombie_child",
    inheritance = { remove = { flags = { "UNBREAKABLE_MORALE", "WARM" } } },
}
