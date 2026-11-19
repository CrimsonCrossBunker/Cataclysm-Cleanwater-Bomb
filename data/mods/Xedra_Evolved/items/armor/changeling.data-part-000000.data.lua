local ccb = require("ccb")

ccb.content.define_item {
    id = "banner_dark_forest",
    name = ccb.content.plural_text("banner of the dark forest", "banners of the dark forest"),
    description = ccb.content.text("A back mounted flag identifying the loyalties of troops.  The heraldry on this banner is of a dark and gloomy forest with red eyes staring out from between the trees."),
    mass = "633 g",
    volume = "2 L",
    price = "39 USD",
    survival_price = "5 USD",
    materials = { "fae_cotton" },
    symbol = "[",
    looks_like = "state_flag",
    color = "green",
    flags = { "BELTED" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 6,
        thickness = 2,
        portions = {
            {
                encumbrance = { 2, 25 },
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_banner_dark_forest_0" } },
}

ccb.content.define_item {
    id = "banner_butterfly_knight",
    name = ccb.content.plural_text("banner of the butterfly knight", "banners of the butterfly knight"),
    description = ccb.content.text("A back mounted flag identifying the loyalties of troops.  The heraldry on this banner is of a brilliantly colored butterfly in flight, ridden by a knight in armor.  The knight is striking down a foe with a scythe while the butterfly appears to have bitten the head off a different opponent."),
    mass = "633 g",
    volume = "2 L",
    price = "39 USD",
    survival_price = "5 USD",
    materials = { "fae_cotton" },
    symbol = "[",
    looks_like = "state_flag",
    color = "green",
    flags = { "BELTED" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 6,
        thickness = 2,
        portions = {
            {
                encumbrance = { 2, 25 },
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_banner_butterfly_knight_0" } },
}

ccb.content.define_item {
    id = "banner_angry_darkness",
    name = ccb.content.plural_text("banner of the angry darkness", "banners of the angry darkness"),
    description = ccb.content.text("A back mounted flag identifying the loyalties of troops.  The heraldry on this banner is of, well you aren't quite sure.  It's a dark cloud, or blackness.  You feel hate radiating from this banner."),
    mass = "633 g",
    volume = "2 L",
    price = "39 USD",
    survival_price = "5 USD",
    materials = { "fae_cotton" },
    symbol = "[",
    looks_like = "state_flag",
    color = "green",
    flags = { "BELTED" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 6,
        thickness = 2,
        portions = {
            {
                encumbrance = { 2, 25 },
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_banner_angry_darkness_0" } },
}

ccb.content.define_item {
    id = "banner_starry_wisdom",
    name = ccb.content.plural_text("banner of starry wisdom", "banners of starry wisdom"),
    description = ccb.content.text("A back mounted flag identifying the loyalties of troops.  The heraldry on this banner is of the night sky shining with ancient wisdom, full of stars."),
    mass = "633 g",
    volume = "2 L",
    price = "39 USD",
    survival_price = "5 USD",
    materials = { "fae_cotton" },
    symbol = "[",
    looks_like = "state_flag",
    color = "green",
    flags = { "BELTED" },
    subtype_order = { "armor", "artifact" },
    armor = {
        warmth = 6,
        thickness = 2,
        portions = {
            {
                encumbrance = { 2, 25 },
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_banner_starry_wisdom_0" } },
}
