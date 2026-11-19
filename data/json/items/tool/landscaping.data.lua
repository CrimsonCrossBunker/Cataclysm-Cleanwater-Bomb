local ccb = require("ccb")

ccb.content.define_item {
    id = "sickle",
    name = ccb.content.plural_text("sickle", "sickles"),
    description = ccb.content.text("An old-fashioned farming tool for cutting tall grass.  Despite being a massive curved blade on a handle, it is incredibly awkward to use for anything but its intended purpose."),
    mass = "907 g",
    volume = "1250 ml",
    length = "50 cm",
    price = "38 USD",
    survival_price = "2 USD 50 cent",
    accuracy = { grip = "solid", length = "short", surface = "line", balance = "uneven" },
    materials = { "ch_steel", "wood" },
    symbol = "/",
    color = "light_gray",
    qualities = { { id = "CUT", level = 1 }, { id = "GRASS_CUT", level = 2 }, { id = "BUTCHER", level = 7 } },
    techniques = { "WBLOCK_1" },
    flags = { "DURABLE_MELEE" },
    weapon_categories = { "SHORT_SWORDS" },
    melee_damage = { bash = 3, cut = 20 },
    tool = {},
}
