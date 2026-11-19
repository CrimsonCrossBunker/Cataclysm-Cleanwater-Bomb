local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_soldier_lixa_police",
    copy_from = "mon_zombie_soldier",
    looks_like = "mon_zombie_soldier",
    name = ccb.content.plural_text("military police zombie", "military police zombies"),
    description = ccb.content.text("Once a soldier, it is dressed head to toe in combat gear and carries itself rather steadily for a zombie.  Over its uniform is a vest reading \"military police\"."),
    death = { drops = "mon_zombie_soldier_lixa_police_death_drops" },
}
