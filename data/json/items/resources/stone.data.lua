local ccb = require("ccb")

ccb.content.define_item {
    id = "rock_flaking",
    symbol = "*",
    color = "light_gray",
    name = ccb.content.text("flaking rock"),
    description = ccb.content.text("A rock the size of a baseball which chips in a semi-predictable way if struck, leaving a sharp edge.  Makes a decent melee weapon, and is also good for throwing at enemies."),
    category = "spare_parts",
    materials = { "stone" },
    flags = { "TRADER_AVOID", "NPC_THROWN", "SLING_PROJECTILE" },
    mass = "657 g",
    volume = "250 ml",
    length = "8 cm",
    accuracy = { grip = "none", length = "hand", surface = "any", balance = "neutral" },
    melee_damage = { bash = 7 },
    ammunition = {
        type = "rock",
        damage = { type = "stab", amount = 7 },
        range = 10,
        dispersion = 14,
        loudness = 0,
        recovery_chance = 98,
        effects = { "NON_FOULING" },
    },
}

ccb.content.define_item {
    id = "flint",
    copy_from = "rock_flaking",
    name = ccb.content.text("flint"),
    description = ccb.content.text("A chunk of flint, the kind of rock that can make sparks if stuck against high-carbon steel.  It also chips in a semi-predictable way if struck, leaving a sharp edge."),
    ammunition = {},
}
