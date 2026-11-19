local ccb = require("ccb")

ccb.content.define_item {
    id = "briefcase",
    name = ccb.content.text("briefcase"),
    description = ccb.content.text("Useful for carrying money, documents, or smuggled goods."),
    mass = "1700 g",
    volume = "15750 ml",
    length = "46 cm",
    price = "240 USD",
    survival_price = "50 cent",
    materials = { "plastic" },
    symbol = "[",
    looks_like = "plastic_shopping_bag",
    color = "light_gray",
    pockets = {
        {
            kind = "CONTAINER",
            rigid = true,
            capacity = "15 L",
            mass_limit = "30 kg",
            max_item_length = "50 cm",
            moves = 200,
        },
    },
    flags = { "OVERSIZE", "BELTED", "RESTRICT_HANDS", "WATER_FRIENDLY" },
    accuracy = { grip = "none", length = "long", surface = "any", balance = "clumsy" },
    melee_damage = { bash = 5 },
    armor = {
        sided = true,
        thickness = 2,
        portions = { { encumbrance = 30, coverage = 10, covers = { "arm_l", "arm_r", "hand_l", "hand_r" } } },
    },
}
