local ccb = require("ccb")

-- Simple wallowing, likes to create deep pits and lay in them.
ccb.content.define_monster {
    id = "mon_odd_megafrog",
    name = ccb.content.plural_text("gargantuan toad", "gargantuan toads"),
    description = ccb.content.text("This toad is of truly enormous stature, larger than many cars.  You can't help but wonder if it could fit as many people inside."),
    copy_from = "mon_proxy_megafrog",
    armor = { bash = 18, cut = 18, bullet = 12, electric = 4 },
    zombify_into = "mon_toad_wart",
    reproduction = { offspring = { egg = "egg_odd_bigfrog" }, count = 32, interval = 20 },
    inheritance = { add = { flags = { "POISON" } } },
}
