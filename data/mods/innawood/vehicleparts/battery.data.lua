local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "battery_car_clay",
    name = ccb.content.text("clay car battery"),
    item = "battery_car_clay",
    fuel_type = "battery",
    categories = { "energy" },
    color = "yellow",
    broken_color = "red",
    durability = 12,
    description = ccb.content.text("A battery for storing electrical power, and discharging it to power electrical devices built into the vehicle.  Contained in a clay shell."),
    folded_volume = "6250 ml",
    breaks_into = {
        { item = "chem_sulphuric_acid", count = { 6, 9 } },
        { item = "lead", count = { 2200, 1800 } },
        { item = "ceramic_shard", count = { 1, 3 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "50 s",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        removal = {
            skills = { { "mechanics", 0 } },
            duration = "50 s",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "600 s",
            using_requirements = { { "soldering_standard", 5 } },
        },
    },
    damage_reduction = { bash = 10 },
    variants = { { symbols = "o", broken_symbols = "#" } },
}
