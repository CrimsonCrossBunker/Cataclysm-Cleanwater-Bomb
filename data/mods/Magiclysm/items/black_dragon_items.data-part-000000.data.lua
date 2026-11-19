local ccb = require("ccb")

-- Tanning 1 raw hide can get 20 scales as byproduct, those scales should be on the hide before tanning
ccb.content.define_item {
    id = "black_dragon_hide_raw",
    category = "spare_parts",
    name = ccb.content.plural_text("raw black dragon hide", "raw black dragon hide"),
    mass = "10100 g",
    color = "black_white",
    symbol = ",",
    description = ccb.content.text("A carefully folded raw hide harvested from a black dragon.  It is a large enough piece that it is workable to make armor, and with enough scales you could make scale mail."),
    price = "500 USD",
    materials = {
        { id = "black_dragon_hide", portions = 25 },
        { id = "black_dragon_scales", portions = 50 },
        { id = "flesh", portions = 25 },
    },
    flags = { "NO_SALVAGE", "TRADER_AVOID" },
    volume = "4 L",
    comestible = { shelf_life = "3 day", kind = "FOOD", vitamins = { { id = "meat_allergen", amount = 1 } } },
}

ccb.content.define_item {
    id = "boots_black_dragon_scale",
    category = "armor",
    name = ccb.content.plural_text("pair of black dragonscale boots", "pairs of black dragonscale boots"),
    description = ccb.content.text("Boots made of black incredibly durable dragonscale.  Very protective, and surprisingly light."),
    mass = "945 g",
    volume = "3250 ml",
    price = "750 USD",
    materials = { "black_dragon_hide", "black_dragon_scales" },
    symbol = "[",
    color = "black_white",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 7 },
    armor = {
        warmth = 25,
        thickness = 5,
        environmental_protection = 3,
        portions = { { encumbrance = 30, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}

ccb.content.define_item {
    id = "boots_black_dragon_hide",
    category = "armor",
    name = ccb.content.plural_text("pair of black dragonhide boots", "pairs of black dragonhide boots"),
    description = ccb.content.text("Boots made of very durable black dragonhide.  Very protective, and surprisingly light."),
    mass = "655 g",
    volume = "3250 ml",
    price = "500 USD",
    materials = { "black_dragon_hide" },
    symbol = "[",
    color = "black_white",
    flags = { "VARSIZE", "WATERPROOF", "STURDY" },
    melee_damage = { bash = 7 },
    armor = {
        warmth = 20,
        thickness = 3,
        environmental_protection = 3,
        portions = { { encumbrance = 20, coverage = 100, covers = { "foot_l", "foot_r" } } },
    },
}
