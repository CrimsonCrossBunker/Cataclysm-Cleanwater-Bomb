local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_swat_ca",
    copy_from = "mon_zombie_swat",
    looks_like = "mon_zombie_swat",
    name = ccb.content.plural_text("ERT zombie", "ERT zombies"),
    description = ccb.content.text("This armored zombie wears the battered insignia of a Canadian police Emergency Response Team."),
    death = { drops = "mon_zombie_swat_death_drops-ca" },
}

ccb.content.define_monster {
    id = "mon_zombie_swat_mx",
    copy_from = "mon_zombie_swat",
    looks_like = "mon_zombie_swat",
    name = ccb.content.plural_text("FERI zombie", "FERI zombies"),
    description = ccb.content.text("This armored zombie once served in the Mexican National Guard's Fuerza Especial de Reacción e Intervención."),
    death = { drops = "mon_zombie_swat_death_drops-mx" },
}

ccb.content.define_monster {
    id = "mon_zombie_marine_ca",
    copy_from = "mon_zombie_marine",
    looks_like = "mon_zombie_marine",
    name = ccb.content.plural_text("naval boarding party zombie", "naval boarding party zombies"),
    description = ccb.content.text("The torn combat uniform on this corpse identifies it as a former member of a Royal Canadian Navy boarding party."),
    upgrade = { half_life = 152, monster = "mon_zombie_marine_upgrade_ca" },
    death = { drops = "mon_zombie_marine_death_drops-ca" },
}

ccb.content.define_monster {
    id = "mon_zombie_marine_mx",
    copy_from = "mon_zombie_marine",
    looks_like = "mon_zombie_marine",
    name = ccb.content.plural_text("Mexican marine zombie", "Mexican marine zombies"),
    description = ccb.content.text("An insignia on the remains of this corpse's uniform marks it as an infantry member of the Armada de México."),
    upgrade = { half_life = 152, monster = "mon_zombie_marine_upgrade_mx" },
    death = { drops = "mon_zombie_marine_death_drops-mx" },
}

ccb.content.define_monster {
    id = "mon_zombie_marine_upgrade_ca",
    copy_from = "mon_zombie_marine_upgrade",
    looks_like = "mon_zombie_marine_upgrade",
    name = ccb.content.plural_text("bestial stalker", "bestial stalkers"),
    description = ccb.content.text("This clawed creature stalks on all fours, dragging scraps of a Royal Canadian Navy combat uniform."),
    upgrade = false,
    death = { drops = "mon_zombie_marine_death_drops-ca" },
}

ccb.content.define_monster {
    id = "mon_zombie_marine_upgrade_mx",
    copy_from = "mon_zombie_marine_upgrade",
    looks_like = "mon_zombie_marine_upgrade",
    name = ccb.content.plural_text("bestial stalker", "bestial stalkers"),
    description = ccb.content.text("This clawed creature stalks on all fours, dragging scraps of a Mexican naval infantry uniform."),
    upgrade = false,
    death = { drops = "mon_zombie_marine_death_drops-mx" },
}
