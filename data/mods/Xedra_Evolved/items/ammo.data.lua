local ccb = require("ccb")

-- Make silver-steel or some kind of changeling metal.
ccb.content.define_item {
    id = "throwing_knives",
    symbol = ";",
    color = "light_gray",
    name = ccb.content.plural_text("throwing knife", "throwing knives"),
    description = ccb.content.text("A thin and flat knife made for throwing.  Its ineffective cutting edge and odd shape make it unsuitable for use as a tool."),
    category = "spare_parts",
    materials = { "lc_steel" },
    flags = { "TRADER_AVOID", "NPC_THROWN" },
    volume = "100 ml",
    mass = "460 g",
    qualities = { { id = "CUT", level = 1 } },
    melee_damage = { bash = 1, cut = 10 },
    ammunition = {
        type = "throwing_knives",
        damage = { type = "stab", amount = 7 },
        range = 10,
        dispersion = 14,
        loudness = 0,
        recovery_chance = 99,
        effects = { "NON_FOULING" },
    },
}

ccb.content.define_item {
    id = "moon_tears_fasteners",
    category = "spare_parts",
    name = ccb.content.text("moon tears fastener"),
    description = ccb.content.text("A pin-shaped piece of moon tears and dreamdross.  It can be used to repair items made of moon tears."),
    mass = "4 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "2 USD 50 cent",
    materials = { "moon_tears" },
    symbol = "=",
    color = "cyan",
    stack_size = 100,
    ammunition = {
        count = 100,
        type = "moon_tears_fasteners",
        loudness = 0,
        range = 3,
        damage = { type = "bullet", amount = 1, penetration = 1 },
        dispersion = 180,
        effects = { "NON_FOULING", "HURT_WHEN_WIELDED" },
    },
}

ccb.content.define_item {
    id = "moon_tear_chain_link",
    category = "spare_parts",
    price = "1 USD 50 cent",
    survival_price = "50 cent",
    name = ccb.content.text("moon tear chain link"),
    symbol = "=",
    color = "light_gray",
    description = ccb.content.text("Small metal rings, suitable for constructing chainmail, made from moon tears."),
    materials = { "moon_tears" },
    volume = "250 ml",
    mass = "1 g",
    ammunition = { type = "components", count = 150 },
}

ccb.content.define_item {
    id = "9x21mm",
    name = ccb.content.plural_text("9x21mm Gyurza SP-10 (7N29)", "9x21mm Gyurza SP-10 (7N29)"),
    description = ccb.content.text("The 9×21mm Gyurza (Гюрза, Russian for 'blunt-nosed viper') round is a Russian handgun round designed to defeat body armor that was developed by TsNIITochMash for its SR-1 Vektor semi-automatic pistol and SR-2 Veresk submachine gun.  The 7N29 AP loading fires a 6.7 g (103 gr) bullet at 410 m/s (1,300 ft/s) with 560 J (410 ft⋅lb) of muzzle energy, and will reportedly penetrate two 1.2 mm titanium plates, plus 30 layers of Kevlar, at 50 m (160 ft).  The disadvantage of the rounds is that high impact velocities are needed for them to work effectively, so the bullets are relatively light to maximize their muzzle velocity.  This means they will lose velocity relatively quickly, limiting their effective range."),
    mass = "6700 mg",
    volume = "115 ml",
    price = "2 USD 50 cent",
    survival_price = "10 USD",
    flags = { "IRREPLACEABLE_CONSUMABLE" },
    materials = { "brass", "powder" },
    symbol = "=",
    color = "red",
    stack_size = 50,
    ammunition = {
        count = 50,
        type = "9x21mm",
        casing = "9x21mm_casing",
        range = 12,
        damage = { type = "bullet", amount = 24, penetration = 16 },
        dispersion = 80,
        recoil = 500,
        effects = { "COOKOFF" },
    },
}

ccb.content.define_item {
    id = "aetheric_charge",
    name = ccb.content.plural_text("aetheric charge", "aetheric charge"),
    description = ccb.content.text("Charged ether pulled out of the void between all things."),
    price = "10 USD",
    survival_price = "10 USD",
    materials = { "forged_dreamstuff" },
    symbol = "=",
    color = "light_blue",
    phase = "gas",
    flags = { "ZERO_WEIGHT" },
    ammunition = { type = "aetheric_charge", range = 12, count = 1, recoil = 900, effects = { "IGNITE" } },
}

ccb.content.define_item {
    id = "grappler_sinew",
    category = "spare_parts",
    price = "0 cent",
    survival_price = "25 cent",
    name = ccb.content.text("elastic sinew"),
    symbol = "=",
    color = "light_red",
    looks_like = "thread",
    description = ccb.content.text("An extremely elastic sinew cut from a corpse, usable as a makeshift slinky."),
    materials = { "flesh" },
    volume = "250 ml",
    mass = "1 g",
    stack_size = 200,
    ammunition = { type = "thread", count = 10 },
}

ccb.content.define_item {
    id = "runner_sinew",
    category = "spare_parts",
    price = "0 cent",
    survival_price = "25 cent",
    name = ccb.content.text("springy sinew"),
    symbol = "=",
    color = "light_red",
    looks_like = "thread",
    description = ccb.content.text("An tightly wound sinew cut from a corpse, usable as thread."),
    materials = { "flesh" },
    volume = "250 ml",
    mass = "1 g",
    stack_size = 200,
    ammunition = { type = "thread", count = 10 },
}

ccb.content.define_item {
    id = "underdeveloped_sinew",
    category = "spare_parts",
    price = "0 cent",
    survival_price = "25 cent",
    name = ccb.content.text("underdeveloped sinew"),
    symbol = "=",
    color = "light_red",
    looks_like = "thread",
    description = ccb.content.text("An short and tightly elastic sinew cut from a corpse, usable as thread."),
    materials = { "flesh" },
    volume = "250 ml",
    mass = "1 g",
    stack_size = 200,
    ammunition = { type = "thread", count = 10 },
}

ccb.content.define_item {
    id = "glamour_charge",
    name = ccb.content.plural_text("glamour charge", "glamour charge"),
    description = ccb.content.text("Power used to fuel hedge magic."),
    price = "10 USD",
    survival_price = "10 USD",
    symbol = "=",
    color = "magenta",
    flags = { "ZERO_WEIGHT" },
    ammunition = { type = "glamour_charge" },
}

ccb.content.define_item {
    id = "xedra_time_charge",
    name = ccb.content.plural_text("collected time", "collected time"),
    description = ccb.content.text("Stored time."),
    price = "10 USD",
    survival_price = "10 USD",
    symbol = "=",
    color = "light_gray",
    flags = { "ZERO_WEIGHT" },
    ammunition = { type = "xedra_time_charge" },
}
