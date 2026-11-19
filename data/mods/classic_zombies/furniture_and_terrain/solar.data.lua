local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "solar_panel",
    categories = { "energy" },
    color = "yellow",
    broken_color = "yellow",
    damage_modifier = 10,
    durability = 20,
    epower = "33 W",
    item = "solar_panel",
    location = "on_roof",
    requirements = {
        install = {
            skills = { { "electronics", 2 }, { "fabrication", 2 } },
            duration = "30 m",
            using_requirements = {
                { "vehicle_wrench_2", 1 },
                { "drilling_standard", 20 },
                { "vehicle_bolt_install_simple", 1 },
            },
        },
        removal = {
            skills = { { "electronics", 1 } },
            duration = "10 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "electronics", 6 } },
            duration = "50 m",
            using_requirements = { { "vehicle_screw", 1 }, { "solar_panel", 1 }, { "soldering_standard", 8 } },
        },
    },
    flags = { "SOLAR_PANEL" },
    breaks_into = {
        { item = "lc_steel_lump", count = { 2, 4 } },
        { item = "lc_steel_chunk", count = { 2, 4 } },
        { item = "scrap", count = { 2, 4 } },
        { item = "solar_cell", count = { 1, 4 } },
    },
    variants = { { symbols = "#", broken_symbols = "x" } },
}
