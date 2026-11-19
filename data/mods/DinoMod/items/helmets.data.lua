local ccb = require("ccb")

ccb.content.define_item {
    id = "helmet_dino",
    name = ccb.content.text("dinosaur skull helmet"),
    description = ccb.content.text("The top part of a dinosaur skull, equipped with leather straps to secure it on your head.  Every inch of the skull has been carved with a maze of fine, intertwined symbols."),
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

ccb.content.define_item {
    id = "helmet_ceratopsian",
    name = ccb.content.text("spiky dinosaur skull helmet"),
    description = ccb.content.text("The top part of a spiky dinosaur skull, equipped with leather straps to secure it on your head.  Every inch of the skull has been carved with a maze of fine, intertwined symbols."),
    mass = "1 kg",
    volume = "3 L",
    price = "14 USD",
    survival_price = "2 USD",
    materials = { "leather", "bone" },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY" },
    qualities = { { id = "COOK", level = 1 } },
    armor = {
        thickness = 3,
        portions = { { encumbrance_modifiers = { "IMBALANCED" }, coverage = 85, covers = { "head" } } },
    },
}

ccb.content.define_item {
    id = "helmet_dino_pred",
    name = ccb.content.text("dinosaur predator skull helmet"),
    description = ccb.content.text("The top part of a dinosaur skull, equipped with leather straps to secure it on your head.  Every inch of the skull has been carved with a maze of fine, intertwined symbols."),
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
