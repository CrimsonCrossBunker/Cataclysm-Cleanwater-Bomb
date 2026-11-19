local ccb = require("ccb")

ccb.content.define_item {
    id = "yoke_harness",
    name = ccb.content.plural_text("yoke and harness", "yokes and harnesses"),
    category = "veh_parts",
    description = ccb.content.text("A bar and harness to attach a sufficiently large creature to a wheeled vehicle, allowing them to pull it along."),
    mass = "1000 g",
    volume = "3750 ml",
    price = "480 USD",
    survival_price = "7 USD 50 cent",
    accuracy = { grip = "solid", length = "short", surface = "any", balance = "uneven" },
    materials = { "leather", "wood" },
    symbol = "H",
    color = "yellow",
    looks_like = "foldframe",
    melee_damage = { bash = 3 },
    wheel = { diameter = 8, width = 4 },
}

-- calculating weight: yoke_harness (1000 g) + frame (20 000 g) + scrap (50 g)x35 OR steel_lump(1000 g)x5 + pipe(1250 g)x2 + chain(3628)x2. Total 1: 32506 g. Total 2: 35756 g. With rounding and fudge factor: 35000 g. Previus eyeballed guess before doing any of this math was 30000 g.
ccb.content.define_item {
    id = "yoke_harness_heavyduty",
    name = ccb.content.plural_text("reinforced yoke and harness", "reinforced yokes and harnesses"),
    category = "veh_parts",
    description = ccb.content.text("Heavy steel beams and harness to attach a sufficiently large creature to a wheeled vehicle, allowing them to pull it along, reinforced to withstand the rigors of the apocalypse and ill-advised off-roading.  You would still need separate armor for said creature to wear."),
    mass = "35000 g",
    volume = "20 L",
    price = "600 USD",
    survival_price = "10 USD",
    accuracy = { grip = "solid", length = "short", surface = "any", balance = "clumsy" },
    materials = { "leather", "lc_steel" },
    symbol = "H",
    color = "light_gray",
    looks_like = "yoke_harness",
    melee_damage = { bash = 15 },
    wheel = { diameter = 8, width = 4 },
}
