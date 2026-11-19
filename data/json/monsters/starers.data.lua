local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_starer_axe",
    description = ccb.content.text("A horribly burned human, reeking of charred meat.  Their flesh has mended into a leathery shell, and the pupils of their wide-open eyes are dilated and the iris and sclera are bloodshot.  Somehow they still breathe, in deep, ragged gulps."),
    copy_from = "mon_starer_pipe",
    attacks = { { id = "feral_weapon_axe" } },
    death = { drops = "starer_death_drops_axe" },
}
