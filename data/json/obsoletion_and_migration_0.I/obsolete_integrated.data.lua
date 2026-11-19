local ccb = require("ccb")

-- remover after 0.J
ccb.content.define_item {
    id = "integrated_giant_pincer",
    category = "armor",
    name = ccb.content.plural_text("sclerotin right pincer", "sclerotin right pincer"),
    description = ccb.content.text("A powerful tool for snatching fish or breaking open shells."),
    mass = "900 g",
    volume = "1 L",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "sclerotin" },
    symbol = ",",
    color = "brown",
    qualities = {
        { id = "CUT", level = 1 },
        { id = "BUTCHER", level = -4 },
        { id = "PRY", level = 1 },
        { id = "HAMMER", level = 1 },
    },
    techniques = { "BRUTAL", "WBLOCK_2" },
    flags = { "INTEGRATED", "ALLOWS_NATURAL_ATTACKS", "UNBREAKABLE", "OUTER", "PADDED", "ALLOWS_TALONS" },
    armor = {
        warmth = 10,
        portions = {
            {
                materials = { { id = "sclerotin", coverage = 100, thickness = 6.4 } },
                covers = { "crustacean_pincer_r" },
                coverage = 80,
            },
        },
    },
}
