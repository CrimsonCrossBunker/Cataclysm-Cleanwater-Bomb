local ccb = require("ccb")

ccb.content.define_item {
    id = "broken_claygolem_dm",
    symbol = "x",
    color = "brown",
    name = ccb.content.plural_text("broken clay golem", "broken clay golems"),
    category = "other",
    description = ccb.content.text("A broken clay golem, looking like a piece of post-modern art.  Could be smashed for clay."),
    price = "100 USD",
    materials = { "clay" },
    mass = "122 kg",
    volume = "120 L",
    accuracy = -3,
    flags = { "TRADER_AVOID", "NO_REPAIR" },
    melee_damage = { bash = 4, cut = 4 },
}

ccb.content.define_item {
    id = "broken_plasticgolem_dm",
    symbol = "x",
    color = "light_gray",
    name = ccb.content.plural_text("broken plastic golem", "broken plastic golems"),
    category = "other",
    description = ccb.content.text("A broken plastic golem, like a giant action figure chewed up by an equally giant puppy.  You could smash it up into recycled plastic bits."),
    price = "1 USD",
    materials = { "plastic" },
    mass = "70 kg",
    volume = "150 L",
    accuracy = -3,
    flags = { "TRADER_AVOID", "NO_REPAIR" },
    melee_damage = { bash = 4, cut = 4 },
}

ccb.content.define_item {
    id = "broken_stonegolem_dm",
    symbol = "x",
    color = "light_gray",
    name = ccb.content.plural_text("broken stone golem", "broken stone golems"),
    category = "other",
    description = ccb.content.text("A broken stone golem, not that much different from a big boulder.  Could be smashed for stone."),
    price = "100 USD",
    materials = { "stone" },
    mass = "162 kg",
    volume = "120 L",
    accuracy = -3,
    flags = { "TRADER_AVOID", "NO_REPAIR" },
    melee_damage = { bash = 4, cut = 4 },
}

ccb.content.define_item {
    id = "broken_irongolem_dm",
    symbol = "x",
    color = "dark_gray",
    name = ccb.content.plural_text("broken iron golem", "broken iron golems"),
    category = "other",
    description = ccb.content.text("A broken iron golem, with all iron you would possibly ever need.  Could be smashed for iron."),
    price = "1 kUSD",
    materials = { "iron" },
    mass = "875 kg",
    volume = "120 L",
    accuracy = -5,
    flags = { "TRADER_AVOID", "NO_REPAIR" },
    melee_damage = { bash = 30 },
}
