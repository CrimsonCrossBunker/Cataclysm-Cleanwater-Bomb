local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_xedra_scarlet_sea",
    name = ccb.content.plural_text("zombie explorer", "zombie explorers"),
    description = ccb.content.text("You see a human - or, at least, what was a human - wearing some sort of armored spacesuit.  The interlocking plates of reflective metal have been stained a faint yellowish-red, most prominently in the joints."),
    copy_from = "mon_zombie_scientist",
    armor = { electric = 3, bash = 30, cut = 30, bullet = 40 },
    death = { drops = "xedra_scarlet_sea_set" },
}
