local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_dragon_bird_pred",
    looks_like = "helmet_dino_pred",
    name = ccb.content.text("dragon-bird skull helmet"),
    description = ccb.content.text("The top part of a dragon-bird skull, equipped with leather straps to secure it on your head.  Every inch of the skull has been carved with a maze of fine, intertwined symbols."),
    mass = "1 kg",
    volume = "3 L",
    price = "14 USD",
    survival_price = "2 USD",
    materials = { "leather", "bone" },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY" },
    armor = {
        thickness = 3,
        portions = { { encumbrance_modifiers = { "IMBALANCED" }, coverage = 85, covers = { "head" } } },
    },
}
