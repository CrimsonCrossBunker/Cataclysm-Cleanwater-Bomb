local ccb = require("ccb")

ccb.content.define_item {
    id = "iso_bolt_blackwood_bodkin",
    name = ccb.content.text("blackwood bolt"),
    symbol = "=",
    color = "light_gray",
    description = ccb.content.text("A bodkin bolt expertly carved from blessed blackwood.  Traces of its former power still linger."),
    copy_from = "bolt_wood_bodkin",
    inheritance = { offset = { dispersion = -40 } },
    ammunition = {
        damage = { type = "stab", constant_damage_multiplier = 1.75 },
        range = 4,
        recovery_chance = 100,
    },
}
