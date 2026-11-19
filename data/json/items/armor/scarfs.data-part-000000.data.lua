local ccb = require("ccb")

ccb.content.define_item {
    id = "cowl_wool",
    name = ccb.content.text("knit cowl"),
    description = ccb.content.text("A snuggly woolen cowl.  It's one of those stylish and bulky cowls you see in fashion magazines."),
    mass = "272 g",
    volume = "2 L",
    price = "20 USD",
    survival_price = "50 cent",
    materials = { "wool" },
    symbol = "[",
    looks_like = "scarf",
    color = "white",
    flags = { "OVERSIZE", "HOOD", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 40,
        thickness = 1,
        environmental_protection = 2,
        portions = { { encumbrance = 20, coverage = 70, covers = { "mouth", "beak", "muzzle" } } },
    },
}

ccb.content.define_item {
    id = "headscarf",
    name = ccb.content.text("headscarf"),
    description = ccb.content.text("A loose cloth worn over the head and around the neck."),
    mass = "70 g",
    volume = "250 ml",
    price = "85 cent",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "scarf",
    color = "yellow",
    flags = { "OVERSIZE", "ALLOWS_NATURAL_ATTACKS", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 0.1,
        environmental_protection = 1,
        portions = { { encumbrance = 4, coverage = 70, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "keffiyeh",
    name = ccb.content.text("keffiyeh"),
    description = ccb.content.text("A type of headdress traditionally used in the Middle East.  It can be used in different ways to protect the head and mouth from the elements."),
    mass = "282 g",
    volume = "564 ml",
    price = "2 USD 50 cent",
    survival_price = "50 cent",
    materials = { "cotton" },
    symbol = "[",
    looks_like = "scarf",
    color = "white",
    flags = { "OVERSIZE", "COLLAR", "ALLOWS_NATURAL_ATTACKS" },
    armor = {
        warmth = 5,
        thickness = 1,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 85, covers = { "head" } } },
    },
}
