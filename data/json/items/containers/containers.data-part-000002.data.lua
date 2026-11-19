local ccb = require("ccb")

ccb.content.define_item {
    id = "canteen",
    category = "clothing",
    name = ccb.content.text("plastic canteen"),
    looks_like = "2lcanteen",
    description = ccb.content.text("A military-style water canteen with a 1.5 liter capacity.  Commonly worn at the hip."),
    ascii_picture = "canteen",
    mass = "155 g",
    volume = "1575 ml",
    length = "20 cm",
    price = "8 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = ")",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = true,
            watertight = true,
            capacity = "1500 ml",
            max_item_volume = "32 ml",
            mass_limit = "3 kg",
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "COLLAPSE_CONTENTS" },
    armor = {
        sided = true,
        portions = {
            {
                encumbrance = 2,
                coverage = 5,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
                materials = { { id = "plastic", coverage = 100, thickness = 2.0 } },
            },
        },
    },
}
