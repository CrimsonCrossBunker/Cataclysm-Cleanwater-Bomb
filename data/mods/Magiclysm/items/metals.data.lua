local ccb = require("ccb")

-- Density 7.60g/cm³ ~ 1.9kg/250ml @ 1000g/unit ~ stack 2 and formed as a solid ingot so 100% of this
ccb.content.define_item {
    id = "orichalcum_lump",
    category = "spare_parts",
    name = ccb.content.plural_text("lump of orichalcum", "lumps of orichalcum"),
    description = ccb.content.text("A lump of raw orichalcum.  Needs to be reformed into an ingot to be useful."),
    mass = "1000 g",
    volume = "250 ml",
    price = "25 USD",
    accuracy = -4,
    stack_size = 2,
    materials = { "orichalcum_metal" },
    symbol = ",",
    color = "light_green",
    qualities = { { id = "HAMMER", level = 1 } },
    melee_damage = { bash = 12 },
    ammunition = { type = "components" },
}

-- Density 7.60g/cm³ ~ 1.9kg/250ml @ 250g/unit ~ stack 8 but misshapen so only 50% of this
ccb.content.define_item {
    id = "orichalcum_sliver",
    category = "spare_parts",
    name = ccb.content.plural_text("sliver of orichalcum", "slivers of orichalcum"),
    description = ccb.content.text("A sliver of orichalcum broken from a larger piece.  Needs to be reformed into an ingot to be useful."),
    mass = "250 g",
    volume = "250 ml",
    price = "10 USD",
    stack_size = 4,
    materials = { "orichalcum_metal" },
    symbol = ",",
    color = "light_green",
    qualities = { { id = "CUT", level = 1 } },
    melee_damage = { bash = 8 },
    ammunition = { type = "components" },
}

ccb.content.define_item {
    id = "mithril_lump",
    category = "spare_parts",
    name = ccb.content.plural_text("lump of mithril", "lumps of mithril"),
    description = ccb.content.text("A lump of raw mithril.  Needs to be reformed into an ingot to be useful."),
    mass = "332 g",
    volume = "250 ml",
    price = "25 USD",
    accuracy = -4,
    stack_size = 2,
    materials = { "mithril_metal" },
    symbol = ",",
    color = "light_blue",
    qualities = { { id = "HAMMER", level = 1 } },
    melee_damage = { bash = 12 },
    ammunition = { type = "components" },
}
