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

ccb.content.define_item {
    id = "xe_oneiric_hammer",
    name = "Oneiric Hammer",
    description = "The platonic embodiment of a blacksmiths hammer.  This hammer is necessary to forge or repair items made of forged dreamstuff.",
    symbol = "/",
    color = "brown",
    mass = "1337 g",
    volume = "1250 ml",
    price = "0 cent",
    flags = {
        "NONCONDUCTIVE",
        "BELT_CLIP",
        "TRADER_AVOID",
        "UNBREAKABLE_MELEE",
        "NO_REPAIR",
        "NO_SALVAGE",
        "MAGIC_FOCUS",
    },
    materials = { "dreamstuff" },
    melee_damage = { bash = 30 },
    pockets = {
        {
            kind = "MAGAZINE",
            ammunition = { scrap_dreamdross = 100 },
        },
    },
    qualities = {
        { id = "DREAM_HAMMER", level = 1 },
    },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            skill = "deduction",
            tool_quality = 0,
            move_cost = 100,
            cost_scaling = 0.1,
            materials = { "forged_dreamstuff", "moon_tears", "moon_tears_fine_chain" },
        },
    },
    tool = { charges_per_use = 1 },
    artifact = {
        enchantments = { "ITEM_ENCH_Xedra_Evolved_xe_oneiric_hammer_0" },
    },
    subtype_order = { "tool", "artifact" },
}

ccb.content.define_item {
    id = "winch_stone",
    name = ccb.content.plural_text("constructed winch", "constructed winches"),
    description = "A small token that floats near your right hand.  It pulls you to determined coordinates when you command it.",
    symbol = "*",
    color = "dark_gray",
    mass = "1 g",
    volume = "1 ml",
    max_worn = 1,
    flags = {
        "SINGLE_USE",
        "TRADER_AVOID",
        "AURA",
        "SEMITANGIBLE",
        "OVERSIZE",
        "NO_TAKEOFF",
        "NONCONDUCTIVE",
        "UNBREAKABLE",
        "ALLOWS_NATURAL_ATTACKS",
    },
    materials = { "dreamstuff" },
    armor = {
        portions = {
            {
                covers = { "hand_r" },
                coverage = 0,
                encumbrance = 0,
            },
        },
    },
}
