local ccb = require("ccb")

ccb.content.define_item {
    id = "case_violin",
    name = ccb.content.text("violin case"),
    description = ccb.content.text("Useful to carry your precious musical instrument around protected from any harm."),
    mass = "2800 g",
    volume = "10500 ml",
    price = "240 USD",
    survival_price = "50 cent",
    accuracy = { grip = "none", length = "long", surface = "any", balance = "clumsy" },
    materials = { "plastic", "steel", "leather" },
    symbol = "&",
    looks_like = "briefcase",
    color = "dark_gray",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = true,
            capacity = "10 L",
            mass_limit = "20 kg",
            max_item_length = "65 cm",
            moves = 200,
        },
    },
    flags = { "OVERSIZE", "BELTED", "RESTRICT_HANDS", "WATER_FRIENDLY" },
    melee_damage = { bash = 5 },
    armor = {
        sided = true,
        thickness = 5,
        portions = { { encumbrance = 30, coverage = 10, covers = { "arm_l", "arm_r", "hand_l", "hand_r" } } },
    },
}
