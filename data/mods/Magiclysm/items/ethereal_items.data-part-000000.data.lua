local ccb = require("ccb")

ccb.content.define_item {
    id = "stonefist",
    name = ccb.content.plural_text("pair of magical armored stone gauntlets", "pairs of magical armored stone gauntlets"),
    description = ccb.content.text("A magical flexible stonelike substance for protection and attack."),
    mass = "1 g",
    volume = "250 ml",
    length = "20 cm",
    price = "1 cent",
    materials = { "concentrated_mana" },
    symbol = "[",
    color = "light_gray",
    looks_like = "gauntlets_chitin",
    qualities = { { id = "HAMMER", level = 1 } },
    flags = { "STURDY", "DURABLE_MELEE", "NONCONDUCTIVE", "MAGIC_FOCUS", "UNRESTRICTED" },
    max_worn = 1,
    techniques = { "WBLOCK_3" },
    melee_damage = { bash = 20 },
    armor = {
        warmth = 20,
        environmental_protection = 10,
        portions = {
            {
                materials = { { id = "concentrated_mana", coverage = 100, thickness = 3 } },
                encumbrance = 0,
                coverage = 100,
                covers = { "arm_l", "arm_r", "hand_l", "hand_r" },
            },
        },
    },
}
