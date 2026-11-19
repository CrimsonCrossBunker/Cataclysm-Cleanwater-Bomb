local ccb = require("ccb")

ccb.content.define_item {
    id = "fireman_belt",
    name = ccb.content.plural_text("firefighter belt", "firefighter belts"),
    description = ccb.content.text("A stout firefighter's belt.  Useful for keeping your bunker gear up, it also doubles as an equipment belt with a reinforced loop for holding a large tool."),
    mass = "210 g",
    volume = "500 ml",
    price = "90 USD",
    survival_price = "7 USD 50 cent",
    materials = { "leather", "steel" },
    symbol = "[",
    looks_like = "holster",
    repair_like = "leather",
    color = "yellow",
    pockets = {
        { capacity = "1 L", mass_limit = "1500 g", moves = 100 },
        {
            volume_encumbrance = 0.5,
            capacity = "2 L",
            mass_limit = "6 kg",
            max_item_length = "90 cm",
            moves = 50,
            allowed_flags = { "BELT_CLIP" },
            holster = true,
            transparent = true,
        },
        {
            holster = true,
            volume_encumbrance = 0.5,
            capacity = "2000 ml",
            mass_limit = "1750 g",
            max_item_length = "70 cm",
            moves = 60,
            description = ccb.content.text("Clipped directly to side of the belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
        {
            holster = true,
            volume_encumbrance = 0.5,
            capacity = "2000 ml",
            mass_limit = "1750 g",
            max_item_length = "70 cm",
            moves = 60,
            description = ccb.content.text("Clipped directly to side of the belt."),
            allowed_flags = { "BELT_CLIP" },
            transparent = true,
        },
    },
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        portions = {
            {
                encumbrance = { 2, 5 },
                coverage = 50,
                covers = { "torso" },
                subparts = { "torso_waist" },
                materials = {
                    { id = "leather", coverage = 100, thickness = 2.5 },
                    { id = "steel", coverage = 10, thickness = 0.5 },
                },
            },
        },
    },
    use_actions = {
        {
            kind = "holster",
            prompt = ccb.content.text("Attach what to belt loop?"),
            message = ccb.content.text("You clip your %s to your %s"),
        },
    },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "judo_belt_abstract",
    abstract = true,
    repair_like = "scarf",
    name = ccb.content.text_without_extraction("judo belt template"),
    description = ccb.content.text_without_extraction("This is a template for judo belts.  If found in a game, it is a bug."),
    mass = "125 g",
    volume = "250 ml",
    price = "10 USD",
    survival_price = "25 cent",
    materials = { "cotton" },
    symbol = "[",
    flags = { "BELTED", "OVERSIZE", "WATER_FRIENDLY" },
    armor = {
        thickness = 2,
        portions = { { encumbrance = 2, coverage = 50, covers = { "torso" }, subparts = { "torso_waist" } } },
    },
}
