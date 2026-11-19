local ccb = require("ccb")

ccb.content.define_item {
    id = "mag_wildwood",
    abstract = true,
    name = ccb.content.plural_text("abstract wildwood doodad", "abstract wildwood doodads"),
    description = ccb.content.text("A generic wildwood doodad used"),
    materials = { "wood", "veggy" },
    symbol = "x",
    color = "light_green",
    max_worn = 1,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = { warmth = 0 },
}
