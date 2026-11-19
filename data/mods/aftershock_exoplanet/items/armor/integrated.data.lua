local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_cranial_padding",
    category = "armor",
    name = ccb.content.plural_text("cranial padding", "cranial padding"),
    description = ccb.content.text("Internal bladders of cerebrospinal fluid better protect your brain from trauma and concussions."),
    mass = "300 g",
    volume = "200 ml",
    price = "0 cent",
    survival_price = "0 cent",
    materials = { "afs_plastic_armor" },
    symbol = ";",
    color = "brown",
    flags = {
        "INTEGRATED",
        "ALLOWS_NATURAL_ATTACKS",
        "UNBREAKABLE",
        "PERSONAL",
        "WATER_FRIENDLY",
        "PADDED",
    },
    armor = {
        warmth = 2,
        portions = {
            {
                materials = { { id = "afs_plastic_armor", coverage = 100, thickness = 1 } },
                covers = { "head" },
                coverage = 60,
                encumbrance = 5,
            },
        },
    },
}
