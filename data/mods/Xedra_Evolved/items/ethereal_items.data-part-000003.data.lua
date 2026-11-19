local ccb = require("ccb")

ccb.content.define_item {
    id = "magic_light",
    category = "tools",
    name = ccb.content.text("magic light"),
    description = ccb.content.text("A magical light source that will light up a small area."),
    mass = "1 g",
    materials = { "dreamstuff" },
    volume = "250 ml",
    price = "1 cent",
    symbol = ",",
    color = "light_green",
    light = 300,
    flags = { "AURA", "SEMITANGIBLE", "UNBREAKABLE", "ALLOWS_NATURAL_ATTACKS" },
    melee_damage = { bash = 8 },
    armor = { portions = { { covers = { "head" } } } },
}

ccb.content.define_item {
    id = "water_pocket",
    name = ccb.content.text("water pocket"),
    description = ccb.content.text("A large pouch of churning water on your back, containing a sealed air bubble.  It shifts and adjusts itself to minimize encumbrance."),
    mass = "0 kg",
    volume = "0 L",
    price = "0 cent",
    materials = { "water" },
    symbol = "[",
    color = "green",
    pockets = {
        {
            kind = "CONTAINER",
            capacity = "25 L",
            mass_limit = "75 kg",
            moves = 60,
            watertight = true,
            airtight = true,
        },
    },
    flags = {
        "BELTED", "TRADER_AVOID", "WATERPROOF", "STURDY", "OVERSIZE", "NO_TAKEOFF", "NO_REPAIR",
        "NO_SALVAGE", "ZERO_WEIGHT",
    },
    max_worn = 1,
    armor = {
        thickness = 0.1,
        portions = { { encumbrance = { 5, 10 }, coverage = 40, covers = { "torso" } } },
    },
}
