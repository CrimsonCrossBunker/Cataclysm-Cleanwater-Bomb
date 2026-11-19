local ccb = require("ccb")

ccb.content.define_item {
    id = "glasses_eye",
    name = ccb.content.plural_text("eyeglasses", "eyeglasses"),
    description = ccb.content.text("A pair of glasses for the near-sighted.  The concave lenses diffuse the sunlight, rendering them useless for starting fires."),
    mass = "30 g",
    volume = "250 ml",
    price = "79 USD",
    survival_price = "5 USD",
    materials = { "glass", "plastic" },
    symbol = "[",
    looks_like = "sunglasses",
    color = "cyan",
    flags = { "WATER_FRIENDLY", "FIX_NEARSIGHT", "FRAGILE", "SKINTIGHT" },
    variant_kind = "generic",
    variants = {
        {
            id = "glasses_eye_round",
            name = ccb.content.plural_text("round eyeglasses", "round eyeglasses"),
            description = ccb.content.text("This pair has rounded lenses."),
            weight = 10,
            append = true,
        },
        {
            id = "glasses_eye_square",
            name = ccb.content.plural_text("square eyeglasses", "square eyeglasses"),
            description = ccb.content.text("This pair has square lenses."),
            weight = 20,
            append = true,
        },
        {
            id = "glasses_eye_aviator",
            name = ccb.content.plural_text("aviator eyeglasses", "aviator eyeglasses"),
            description = ccb.content.text("This pair has aviator-styled lenses."),
            weight = 5,
            append = true,
        },
    },
    armor = {
        thickness = 1,
        environmental_protection = 1,
        portions = { { coverage = 75, covers = { "eyes" }, rigid_only = true } },
    },
}

-- DDA monocle is optical-grade.  Costume ones go for about $10.
ccb.content.define_item {
    id = "glasses_monocle",
    name = ccb.content.text("monocle"),
    description = ccb.content.text("An essential article of the gentleman's apparel.  Also corrects near-sightedness.  The concave lens diffuses the sunlight, rendering it useless for starting fires."),
    mass = "16 g",
    volume = "5 ml",
    price = "40 USD",
    survival_price = "50 cent",
    materials = { "glass", "plastic" },
    symbol = "[",
    looks_like = "glasses_eye",
    color = "cyan",
    flags = { "FIX_NEARSIGHT", "FRAGILE", "SKINTIGHT" },
    armor = {
        thickness = 1,
        environmental_protection = 1,
        portions = { { coverage = 20, covers = { "eyes" }, rigid_only = true } },
    },
}
