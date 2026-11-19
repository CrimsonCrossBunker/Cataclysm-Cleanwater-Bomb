local ccb = require("ccb")

ccb.content.define_item {
    id = "glowstick_juice",
    name = ccb.content.plural_text("glowstick juice", "glowstick juice"),
    symbol = "~",
    description = ccb.content.text("A mix of blue dye, base catalyst, and diphenyl oxalate used in glowsticks."),
    volume = "1 ml",
    mass = "1 mg",
    color = "white",
    flags = { "TRADER_AVOID" },
    ammunition = { type = "glowstick_juice" },
}

ccb.content.define_item {
    id = "quill_ink",
    name = ccb.content.plural_text("quill ink", "quill ink"),
    symbol = "~",
    description = ccb.content.text("Ink made from a variety of sources for use in quill style pens."),
    volume = "1 ml",
    mass = "1 mg",
    color = "dark_gray",
    looks_like = "permanent_ink",
    flags = { "TRADER_AVOID" },
    phase = "liquid",
    ammunition = { type = "quill_ink" },
}

ccb.content.define_item {
    id = "black_pen_ink",
    name = ccb.content.plural_text("black pen ink", "black pen ink"),
    symbol = "~",
    description = ccb.content.text("Carbon black pigment infused with polymers, stabilizers, and water to help the ink flow properly."),
    volume = "1 ml",
    mass = "1 mg",
    color = "dark_gray",
    looks_like = "permanent_ink",
    flags = { "TRADER_AVOID" },
    phase = "liquid",
    ammunition = { type = "black_pen_ink" },
}

ccb.content.define_item {
    id = "blue_pen_ink",
    name = ccb.content.plural_text("blue pen ink", "blue pen ink"),
    symbol = "~",
    description = ccb.content.text("Prussian blue, crystal violet, and phthalocyanine blue pigments infused with polymers, stabilizers, and water to help the ink flow properly."),
    volume = "1 ml",
    mass = "1 mg",
    color = "blue",
    looks_like = "permanent_ink",
    flags = { "TRADER_AVOID" },
    phase = "liquid",
    ammunition = { type = "blue_pen_ink" },
}

ccb.content.define_item {
    id = "green_pen_ink",
    name = ccb.content.plural_text("green pen ink", "green pen ink"),
    symbol = "~",
    description = ccb.content.text("Chlorophyll pigment infused with polymers, stabilizers, and water to help the ink flow properly."),
    volume = "1 ml",
    mass = "1 mg",
    color = "green",
    looks_like = "permanent_ink",
    flags = { "TRADER_AVOID" },
    phase = "liquid",
    ammunition = { type = "green_pen_ink" },
}

ccb.content.define_item {
    id = "red_pen_ink",
    name = ccb.content.plural_text("red pen ink", "red pen ink"),
    symbol = "~",
    description = ccb.content.text("Eosin dye infused with polymers, stabilizers, and water to help the ink flow properly."),
    volume = "1 ml",
    mass = "1 mg",
    color = "red",
    looks_like = "permanent_ink",
    flags = { "TRADER_AVOID" },
    phase = "liquid",
    ammunition = { type = "red_pen_ink" },
}

ccb.content.define_item {
    id = "airgun_pellet_target",
    price = "5 USD",
    survival_price = "50 cent",
    name = ccb.content.text("air rifle target pellet"),
    symbol = "=",
    color = "light_gray",
    looks_like = "pebble",
    description = ccb.content.text("A tin of small cone-shaped pellets meant to be used in an air rifle.  Suitable for plinking."),
    materials = { "steel" },
    volume = "200ml",
    mass = "1 g",
    stack_size = 200,
    ammunition = {
        type = "airgun_pellet",
        damage = { type = "bullet", amount = 2 },
        dispersion = 100,
        count = 500,
        loudness = 9,
        effects = { "NOGIB", "NON_FOULING" },
    },
}

ccb.content.define_item {
    id = "airgun_pellet_hunting",
    price = "5 USD",
    survival_price = "50 cent",
    name = ccb.content.text("air rifle hunting pellet"),
    symbol = "=",
    color = "light_gray",
    looks_like = "pebble",
    description = ccb.content.text("A tin of small cone-shaped pellets meant to be used in an air rifle.  Suitable for hunting small game."),
    materials = { "steel" },
    volume = "200ml",
    mass = "1 g",
    stack_size = 200,
    ammunition = {
        type = "airgun_pellet",
        damage = { type = "bullet", amount = 4 },
        dispersion = 100,
        count = 500,
        loudness = 9,
        effects = { "NOGIB", "NON_FOULING" },
    },
}
