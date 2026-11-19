local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_tazer_hack",
    copy_from = "base_drone",
    name = ccb.content.plural_text("taser hack", "taser hacks"),
    description = ccb.content.text("An automated drone, this small quadcopter robot appears to have a taser strapped to the front.  While extremely fast, it is very fragile."),
    difficulty_adjustment = 10,
    speed = 350,
    color = "cyan",
    revert_item = "bot_tazer_hack",
    attacks = { { reference = "TAZER", cooldown = 5 } },
    armor = { cut = 2, bullet = 1 },
    death = { outcome = { corpse = "BROKEN" } },
}
