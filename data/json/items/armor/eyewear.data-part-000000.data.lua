local ccb = require("ccb")

ccb.content.define_item {
    id = "eclipse_glasses",
    name = ccb.content.plural_text("eclipse glasses", "eclipse glasses"),
    description = ccb.content.text("A pair of cardboard-framed glasses with UV and IR-filtered lenses topped with a layer of aluminum coating.  They allow safe viewing of extremely bright and harmful sources of light, like the sun during a solar eclipse."),
    mass = "27 g",
    volume = "18 ml",
    price = "25 USD",
    survival_price = "10 cent",
    materials = {
        { id = "cardboard", portions = 90 },
        { id = "plastic", portions = 9 },
        { id = "aluminum", portions = 1 },
    },
    symbol = "[",
    looks_like = "sunglasses",
    color = "light_gray",
    qualities = { { id = "GLARE", level = 1 } },
    flags = { "SUN_GLASSES" },
    armor = {
        thickness = 1,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 80, covers = { "eyes" }, rigid_only = true } },
    },
}

ccb.content.define_item {
    id = "eyepatch_leather",
    category = "armor",
    name = ccb.content.plural_text("leather eyepatch", "leather eyepatches"),
    description = ccb.content.text("A patch of black leather to cover an eye, with a string to keep it from falling off.  If wearing this doesn't make you feel a pirate, nothing will."),
    mass = "50 g",
    volume = "100 ml",
    price = "5 USD",
    survival_price = "50 cent",
    materials = { "leather" },
    symbol = "[",
    looks_like = "glasses_safety",
    color = "light_gray",
    flags = { "WATER_FRIENDLY", "SKINTIGHT" },
    armor = {
        thickness = 1,
        portions = { { encumbrance = 30, coverage = 50, covers = { "eyes" }, rigid_only = true } },
    },
}

ccb.content.define_item {
    id = "fitover_sunglasses",
    name = ccb.content.plural_text("fit-over sunglasses", "fit-over sunglasses"),
    description = ccb.content.text("A pair of fit-over sunglasses designed to be worn over a pair of corrective glasses.  Good for keeping the glare out of your eyes."),
    mass = "45 g",
    volume = "250 ml",
    price = "50 USD",
    survival_price = "50 cent",
    materials = { "glass", "plastic" },
    symbol = "[",
    looks_like = "sunglasses",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "SUN_GLASSES", "VARSIZE", "FRAGILE" },
    armor = {
        thickness = 1,
        environmental_protection = 1,
        portions = { { encumbrance = 1, coverage = 90, covers = { "eyes" }, rigid_only = true } },
    },
}

ccb.content.define_item {
    id = "glasses_bal",
    category = "armor",
    name = ccb.content.plural_text("ballistic glasses", "ballistic glasses"),
    description = ccb.content.text("Modern tactical eyewear that protects from small projectiles and fragments.  Provides excellent protection from environmental dangers."),
    mass = "184 g",
    volume = "250 ml",
    price = "75 USD",
    survival_price = "5 USD",
    materials = { "hard_plastic_transp", "nylon" },
    symbol = "[",
    looks_like = "glasses_safety",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "SUN_GLASSES", "SKINTIGHT" },
    armor = {
        warmth = 5,
        thickness = 3,
        environmental_protection = 4,
        portions = { { encumbrance = 5, coverage = 100, covers = { "eyes" }, rigid_only = true } },
    },
}
