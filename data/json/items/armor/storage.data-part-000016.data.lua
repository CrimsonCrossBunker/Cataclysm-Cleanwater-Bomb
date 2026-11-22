local ccb = require("ccb")

ccb.content.define_item {
    id = "petpack",
    name = "petpack",
    description = "Before the Cataclysm this would allow your four-legged friend to see the world, now it's used to shield them from the world.",
    symbol = "[",
    color = "blue",
    looks_like = "backpack",
    mass = "900 g",
    volume = "36750 ml",
    price = "79 USD",
    survival_price = "2 USD 50 cent",
    flags = { "BELTED", "WATERPROOF" },
    materials = { "nylon", "plastic" },
    properties = { creature_size_capacity = "SMALL" },
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "35 L",
            mass_limit = "16 kg",
            max_item_length = "45 cm",
            moves = 300,
            rigid = true,
        },
    },
    use_actions = { "CAPTURE_MONSTER_ACT" },
    armor = {
        thickness = 2,
        warmth = 8,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_front" },
                coverage = 100,
                encumbrance = 35,
            },
        },
    },
}
