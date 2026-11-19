local ccb = require("ccb")

ccb.content.define_item {
    id = "enchanted_pirate_blouse",
    name = ccb.content.plural_text("enchanted parabolan wool blouse", "enchanted parabolan wool blouse"),
    description = ccb.content.text("A loose silvery iridescent blouse in a style most often associated with pirates and renfaires.  It shimmers as you look at it.  Made of parabolan wool, it sometimes dimly shows reflections of things here and not.  This particular one has piratical flairs and glitters with enchantment."),
    looks_like = "dress_shirt",
    mass = "360 g",
    volume = "750 ml",
    price = "2 kUSD",
    symbol = "[",
    color = "brown",
    materials = { "parabolan_wool" },
    flags = {
        "VARSIZE",
        "WATER_FRIENDLY",
        "RAINPROOF",
        "STURDY",
        "TRADER_KEEP_EQUIPPED",
        "COSPLAY_COSTUME",
    },
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = {
            { encumbrance = 1, coverage = 95, covers = { "torso" } },
            { encumbrance = 1, coverage = 85, covers = { "arm_r", "arm_l" } },
        },
        thickness = 0.5,
    },
    artifact = { enchantments = { "ench_parabolan_blouse" } },
}

ccb.content.define_item {
    id = "parabolan_enchanted_breeches",
    name = ccb.content.plural_text("enchanted parabolan wool breeches", "enchanted parabolan wool breeches"),
    description = ccb.content.text("A well-made pair of old-fashioned pants, made of silvery iridescent material.  Comfortable, but lacks pockets.  It shimmers as you look at it.  Made of parabolan wool, it sometimes dimly shows reflections of things here and not.  This particular one has piratical flairs and glitters with enchantment."),
    mass = "312 g",
    volume = "1750 ml",
    price = "4 kUSD 900 USD",
    survival_price = "500 USD",
    materials = { "parabolan_wool" },
    symbol = "[",
    looks_like = "pants",
    color = "brown",
    flags = {
        "VARSIZE",
        "WATER_FRIENDLY",
        "RAINPROOF",
        "STURDY",
        "TRADER_KEEP_EQUIPPED",
        "COSPLAY_COSTUME",
    },
    subtype_order = { "armor", "artifact" },
    armor = {
        portions = { { encumbrance = 2, coverage = 95, covers = { "leg_l", "leg_r" } } },
        thickness = 0.5,
    },
    artifact = { enchantments = { "ITEM_ENCH_Magiclysm_parabolan_enchanted_breeches_0" } },
}
