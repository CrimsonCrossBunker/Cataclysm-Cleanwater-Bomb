local ccb = require("ccb")

ccb.content.define_item {
    id = "integrated_homullus_electrohack",
    name = ccb.content.plural_text("net spider's touch", "net spider's touch"),
    description = ccb.content.text("With but a touch, you can override the circuits of electronics and grant yourself access."),
    mass = "0 g",
    volume = "0 ml",
    symbol = "=",
    color = "white",
    looks_like = "spiral_stone",
    flags = {
        "TRADER_AVOID", "NO_DROP", "PADDED", "PERSONAL", "SEMITANGIBLE", "NO_SALVAGE", "ZERO_WEIGHT",
        "NO_UNLOAD", "NO_RELOAD", "INTEGRATED", "MAGICAL",
    },
    max_worn = 1,
    qualities = { { id = "HACK", level = 3 } },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
}
