local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "ap_standing_pyrokinetic_lamp",
    name = ccb.content.text("standing matrix lamp"),
    item = "standing_pyrokinetic_lamp",
    variants = { { symbols = "*", broken_symbols = "-" } },
    categories = { "lighting" },
    color = "red",
    broken_color = "green",
    durability = 20,
    description = ccb.content.text("An lamp enhanced with matrix technology."),
    bonus = 150,
    damage_modifier = 10,
    epower = "-4 W",
    looks_like = "ap_standing_lamp",
    breaks_into = {
        { item = "cable", count = { 1, 2 } },
        { item = "lc_steel_chunk", count = { 0, 2 } },
        { item = "scrap", count = { 1, 2 } },
    },
    flags = { "CIRCLE_LIGHT", "APPLIANCE", "ENABLED_DRAINS_EPOWER", "CTRL_ELECTRONIC" },
    requirements = { removal = { duration = "6 m" } },
}
