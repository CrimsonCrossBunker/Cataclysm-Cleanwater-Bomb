local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "ap_battery_car_clay",
    name = ccb.content.text("clay car grid battery"),
    categories = { "energy" },
    looks_like = "clay_hydria",
    location = "structure",
    color = "light_cyan",
    flags = { "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A clay car battery wired into a static power grid."),
    item = "battery_car_clay",
    breaks_into = { { item = "ceramic_shard", count = { 1, 3 } }, { item = "lead", count = { 200, 1000 } } },
    durability = 120,
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "B", broken_symbols = "#" } },
}

ccb.content.define_vehicle_part {
    id = "ap_battery_clay_array",
    name = ccb.content.text("clay grid battery array"),
    categories = { "energy" },
    looks_like = "f_crate_o",
    location = "structure",
    color = "light_cyan",
    flags = { "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A clay battery array wired into a static power grid."),
    item = "battery_clay_array",
    breaks_into = {
        { item = "ceramic_shard", count = { 4, 12 } },
        { item = "lead", count = { 800, 4000 } },
        { item = "2x4", count = { 1, 4 } },
        { item = "nail", count = { 2, 6 } },
    },
    durability = 120,
    requirements = { removal = { duration = "6 m" } },
    variants = { { symbols = "B", broken_symbols = "#" } },
}
