local ccb = require("ccb")

ccb.content.define_item {
    id = "flask_hip",
    category = "clothing",
    name = ccb.content.plural_text("hip flask", "hip flasks"),
    looks_like = "2lcanteen",
    description = ccb.content.text("A 250 mL metal flask with a hinged screw-on lid, commonly used to discreetly transport alcohol."),
    ascii_picture = "flask_hip",
    mass = "270 g",
    volume = "650 ml",
    length = "13 cm",
    price = "40 USD",
    survival_price = "10 cent",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "neutral" },
    materials = { "steel" },
    symbol = ")",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = true,
            watertight = true,
            capacity = "250 ml",
            max_item_volume = "17 ml",
            mass_limit = "1 kg",
        },
    },
    qualities = { { id = "BOIL", level = 1 } },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY", "COLLAPSE_CONTENTS" },
    melee_damage = { bash = 3 },
    armor = {
        sided = true,
        portions = {
            {
                materials = { { id = "iron", coverage = 100, thickness = 1.0 } },
                coverage = 2,
                covers = { "leg_l", "leg_r" },
                subparts = { "leg_hip_r", "leg_hip_l" },
            },
        },
    },
    use_actions = { "HEAT_LIQUID_ITEMS" },
}
