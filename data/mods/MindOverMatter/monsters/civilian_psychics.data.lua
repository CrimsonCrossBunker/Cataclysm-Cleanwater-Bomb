local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_civilian_vitakinetic",
    name = ccb.content.plural_text("confused curer", "confused curers"),
    description = ccb.content.text("This person mutters to themselves, glancing to and fro with bloodshot eyes.  They seem remarkably unscathed for someone in the midst of the apocalypse."),
    pathing = { max_distance = 30, open_doors = false, avoid_traps = false, avoid_sharp = false },
    hp = 90,
    speed = 90,
    symbol = "@",
    color = "green",
    difficulty_adjustment = 0,
    copy_from = "mon_civilian_clairsentient",
    regenerates = 5,
    vision_day = 10,
    vision_night = 1,
    dodge = 1,
    upgrade = { half_life = 8, monster = "mon_feral_human_vita" },
    attacks = { { reference = "PARROT_AT_DANGER", cooldown = 10 } },
}
