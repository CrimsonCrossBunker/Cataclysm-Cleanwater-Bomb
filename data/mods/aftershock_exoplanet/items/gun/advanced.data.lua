local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "robogun_base",
    abstract = true,
    name = ccb.content.text_without_extraction("base robogun"),
    description = ccb.content.text_without_extraction("This is a pseudo item for monster attacks.  If you see this, it's a bug."),
    materials = { "steel", "plastic" },
    symbol = "(",
    color = "magenta",
    mass = "5 kg",
    volume = "2500 ml",
    price = "0 cent",
    flags = { "NEVER_JAMS", "TRADER_AVOID" },
    gun = { reload_noise_volume = 10, durability = 10, reload_time = 100 },
}

ccb.content.define_item {
    id = "irradiant_gun",
    copy_from = "robogun_base",
    name = ccb.content.text("mounted 1kg plasma railgun"),
    inheritance = { add = { flags = { "NO_TURRET" } } },
    gun = {
        damage = { type = "bullet", amount = 2500, penetration = 400 },
        effects = { "PLASMA", "EMP", "LOW_RANGE_VAPORIZATION" },
        skill = "rifle",
        range = 40,
        energy_drain = "0 kJ",
    },
}

ccb.content.define_item {
    id = "railgun",
    copy_from = "hk_g80",
    name = ccb.content.text("integral railgun"),
    pockets = { { kind = "MAGAZINE", ammunition = { metal_rail = 100 } } },
    inheritance = { add = { flags = { "NO_TURRET" } } },
    gun = {
        ammunition = { "metal_rail" },
        skill = "rifle",
        modes = {
            { id = "DEFAULT", label = ccb.content.text("semi-auto"), quantity = 1 },
            { rpm = 900, quantity = 2 },
        },
        effects = { "TRAIL" },
    },
}
