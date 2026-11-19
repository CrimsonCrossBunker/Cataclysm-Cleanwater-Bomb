local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_civilian_telepath",
    name = ccb.content.plural_text("manic mutterer", "manic mutterers"),
    description = ccb.content.text("Holding their head in their hands, they barely seem aware of the world around them, but they still try to escape the zombies.  Looking at them, you feel an eerie sensation like fingers scratching at your mind."),
    pathing = { max_distance = 30, open_doors = false, avoid_traps = false, avoid_sharp = false },
    symbol = "@",
    color = "green",
    difficulty_adjustment = 0,
    vision_day = 10,
    vision_night = 0,
    dodge = 1,
    copy_from = "mon_civilian_clairsentient",
    upgrade = { half_life = 8, monster = "mon_feral_human_teep" },
    attacks = { { reference = "PARROT_AT_DANGER", cooldown = 5 } },
}
