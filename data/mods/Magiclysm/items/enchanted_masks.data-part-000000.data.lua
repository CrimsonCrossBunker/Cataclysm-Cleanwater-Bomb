local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "mmask",
    abstract = true,
    category = "armor",
    name = ccb.content.text_without_extraction("magic mask"),
    description = ccb.content.text_without_extraction("A generic magic mask."),
    mass = "442 g",
    volume = "750 ml",
    price = "2 kUSD",
    accuracy = -3,
    materials = { "steel", "leather" },
    symbol = "[",
    color = "dark_gray",
    flags = { "WATER_FRIENDLY", "STURDY" },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        warmth = 10,
        thickness = 2,
        environmental_protection = 1,
        portions = { { encumbrance = 10, coverage = 95, covers = { "eyes", "mouth" }, rigid_only = true } },
    },
}
