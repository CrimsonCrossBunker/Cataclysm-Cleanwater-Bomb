local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_prisoner",
    name = ccb.content.plural_text("prisoner zombie", "prisoner zombies"),
    description = ccb.content.text("Apparently this zombie was doing time when the Cataclysm struck.  It wears black and white striped prisoner clothes, and tattoos can be seen on its decaying skin."),
    copy_from = "mon_zombie",
    looks_like = "mon_zombie",
    hp = 90,
    color = "green",
    melee_sides = 4,
    death = { drops = "mon_zombie_prisoner_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_prisoner_brute",
    name = ccb.content.plural_text("prisoner zombie brute", "prisoner zombie brutes"),
    description = ccb.content.text("This muscular zombie wears black and white striped prisoner clothes."),
    copy_from = "mon_zombie_brute",
    looks_like = "mon_zombie_brute",
    death = { drops = "mon_zombie_prisoner_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_prisoner_fat",
    name = ccb.content.plural_text("fat prisoner zombie", "fat prisoner zombies"),
    description = ccb.content.text("This fat zombie wears black and white striped prisoner clothes."),
    copy_from = "mon_zombie_fat",
    looks_like = "mon_zombie_fat",
    death = { drops = "mon_zombie_prisoner_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_prisoner_tough",
    name = ccb.content.plural_text("tough prisoner zombie", "tough prisoner zombies"),
    description = ccb.content.text("This tough-looking zombie wears black and white striped prisoner clothes."),
    copy_from = "mon_zombie_tough",
    looks_like = "mon_zombie_tough",
    death = { drops = "mon_zombie_prisoner_death_drops" },
}
