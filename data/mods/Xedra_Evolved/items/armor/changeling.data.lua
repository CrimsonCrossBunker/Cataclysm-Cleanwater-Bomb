local ccb = require("ccb")

ccb.content.define_item {
    id = "gown_gossamer_boann_unique",
    name = ccb.content.plural_text("aegis gown", "aegis gowns"),
    copy_from = "gown_gossamer",
    looks_like = "gown_gossamer",
    inheritance = { add = { flags = { "RELIC_PINK" } } },
    subtype_order = { "armor", "artifact" },
    armor = {},
    artifact = { enchantments = { "ITEM_ENCH_Xedra_Evolved_gown_gossamer_boann_unique_0" } },
}

ccb.content.define_item {
    id = "banner_thunderous_rush",
    name = ccb.content.plural_text("banner of thunderous rush", "banners of thunderous rush"),
    description = "A back mounted flag identifying the loyalties of troops.  The heraldry on this banner is of lightning striking a tower that is falling.",
    symbol = "[",
    color = "green",
    looks_like = "state_flag",
    mass = "633 g",
    volume = "2 L",
    price = "39 USD",
    survival_price = "5 USD",
    flags = { "BELTED" },
    materials = { "fae_cotton" },
    armor = {
        thickness = 2,
        warmth = 6,
        portions = {
            {
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
                coverage = 60,
                encumbrance = { 2, 25 },
            },
        },
    },
    artifact = {
        enchantments = {
            { has = "WORN", condition = "ALWAYS", id = "thunder_rush" },
        },
    },
    subtype_order = { "armor", "artifact" },
}
