local ccb = require("ccb")

ccb.content.define_item {
    id = "beam_scatterer",
    copy_from = "beam_scatterer",
    name = ccb.content.plural_text("beam scatterer", "beam scatterers"),
    description = ccb.content.text("A set of optics made to fit on laser weapons, which will diffract the laser beam into several lower powered beams.  This increases point-blank damage, but greatly reduces range."),
    survival_price = "850 USD",
    price = "850 USD",
    gunmod = { damage_modifier = { type = "afs_laser", amount = 10 }, ammo_per_shot_multiplier = 1.2 },
}

ccb.content.define_item {
    id = "focusing_lens",
    copy_from = "focusing_lens",
    name = ccb.content.plural_text("focusing lens", "focusing lenses"),
    description = ccb.content.text("A set of optics to concentrate the laser beam on a smaller focus point.  This increases range and damage output, but complicates targeting."),
    survival_price = "850 USD",
    price = "850 USD",
    gunmod = { damage_modifier = { type = "afs_laser", amount = 3 }, ammo_per_shot_multiplier = 1.2 },
}

ccb.content.define_item {
    id = "electrolaser_conversion",
    copy_from = "electrolaser_conversion",
    name = ccb.content.plural_text("electrolaser conversion", "electrolaser conversions"),
    description = ccb.content.text("A set of high-tech electronics and optics.  This converts a laser pistol into a less-lethal electrolaser capable of stunning targets, at the cost of decreased damage output and increased power consumption."),
    survival_price = "1550 USD",
    price = "1550 USD",
    gunmod = { damage_modifier = { type = "afs_laser", amount = -4 }, ammo_per_shot_multiplier = 1.2 },
}

ccb.content.define_item {
    id = "effective_emitter",
    copy_from = "effective_emitter",
    name = ccb.content.plural_text("effective emitter", "effective emitters"),
    description = ccb.content.text("A set of electronics to optimize emitter workcycle and increase overall energy efficiency.  Decreases power consumption."),
    survival_price = "850 USD",
    price = "850 USD",
    gunmod = { ammo_per_shot_multiplier = 0.9 },
}

ccb.content.define_item {
    id = "high_density_capacitor",
    copy_from = "high_density_capacitor",
    name = ccb.content.plural_text("high density capacitor", "high density capacitors"),
    description = ccb.content.text("A capacitor with a higher energy density increases range and damage, at the cost of doubling power consumption."),
    survival_price = "1550 USD",
    price = "1550 USD",
    gunmod = { damage_modifier = { type = "afs_laser", amount = 6 }, ammo_per_shot_multiplier = 2.0 },
}
