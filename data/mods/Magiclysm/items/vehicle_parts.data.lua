local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "bulette_plate",
    name = ccb.content.text("bulette plating"),
    categories = { "warfare" },
    color = "light_gray",
    broken_color = "light_gray",
    durability = 800,
    item = "bulette_plate",
    location = "armor",
    flags = { "ARMOR" },
    breaks_into = { { item = "leather", count = { 1, 2 } } },
    damage_reduction = { all = 12 },
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "1600 s",
            using_requirements = { { "rope_natural", 2 } },
        },
    },
    variants = { { symbols = ")", broken_symbols = ")" } },
}
