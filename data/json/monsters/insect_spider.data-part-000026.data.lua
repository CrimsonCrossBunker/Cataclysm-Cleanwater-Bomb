local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_ant_acid_small",
    name = ccb.content.plural_text("oversized acidic ant", "oversized acidic ants"),
    description = ccb.content.text("A dog-sized mutant brown ant with a swollen abdomen that ends with a small orifice at the tip.  Glistening liquid drips out periodically."),
    copy_from = "mon_ant_acid",
    volume = "30 L",
    mass = "40 kg",
    zombify_into = "mon_meat_cocoon_small",
    upgrade = { grow_at_age = 30, monster = "mon_ant_acid" },
    inheritance = { scale = { hp = 0.5, speed = 1.1, morale = 0.67, melee_sides = 0.67 } },
}
