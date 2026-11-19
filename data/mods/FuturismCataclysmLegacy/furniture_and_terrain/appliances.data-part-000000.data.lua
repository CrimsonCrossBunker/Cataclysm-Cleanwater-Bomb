local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "ap_solar_panel_v3",
    name = ccb.content.text("small quantum solar panel"),
    flags = { "SOLAR_PANEL", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A small quantum solar panel, mounted on a frame and ready to power other appliances."),
    copy_from = "solar_panel_v3",
    proportional = { epower = 1.2 },
    requirements = { removal = { duration = "3 m", using_requirements = { { "vehicle_wrench_2", 1 } } } },
    variants = { { symbols = "#", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_reinforced_solar_panel_v3",
    color = "yellow",
    flags = { "SOLAR_PANEL", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A reinforced quantum solar panel, mounted on a frame and ready to power other appliances."),
    copy_from = "reinforced_solar_panel_v3",
    proportional = { epower = 1.2 },
    requirements = { removal = { duration = "3 m", using_requirements = { { "vehicle_wrench_2", 1 } } } },
    variants = { { symbols = "#", broken_symbols = "x" } },
}

-- 4 times from 4 more panels, 1.2 times as is done for other standing solar appliances
ccb.content.define_vehicle_part {
    id = "ap_ground_solar_panel_v3",
    copy_from = "solar_panel_v3",
    flags = { "SOLAR_PANEL", "OBSTACLE", "APPLIANCE" },
    item = "ground_solar_panel_v3",
    proportional = { epower = 4.8 },
    requirements = {
        install = {},
        removal = { duration = "3 m", using_requirements = { { "vehicle_wrench_2", 1 } } },
        repair = {
            skills = { { "electronics", 8 } },
            duration = "150 m",
            using_requirements = {
                { "vehicle_screw", 1 },
                { "solar_panel_v3", 4 },
                { "soldering_standard", 64 },
            },
        },
    },
    breaks_into = {
        { item = "mc_steel_lump", count = { 8, 16 } },
        { item = "mc_steel_chunk", count = { 8, 16 } },
        { item = "scrap", count = { 8, 16 } },
        { item = "solar_cell_v3", count = { 8, 32 } },
    },
    variants = { { symbols = "#", broken_symbols = "x" } },
}

ccb.content.define_vehicle_part {
    id = "ap_reinforced_ground_solar_panel_v3",
    color = "yellow",
    flags = { "SOLAR_PANEL", "OBSTACLE", "APPLIANCE" },
    description = ccb.content.text("A reinforced quantum solar panel array, mounted on a frame and ready to power other appliances."),
    copy_from = "ap_ground_solar_panel_v3",
    item = "reinforced_ground_solar_panel_v3",
    proportional = { epower = 0.95 },
    durability = 450,
    requirements = {
        install = {},
        removal = { duration = "3 m", using_requirements = { { "vehicle_wrench_2", 1 } } },
        repair = {
            skills = { { "electronics", 8 } },
            duration = "150 m",
            using_requirements = {
                { "vehicle_screw", 1 },
                { "solar_panel_v3", 4 },
                { "soldering_standard", 64 },
                { "repair_welding_standard", 4 },
            },
        },
    },
    breaks_into = {
        { item = "mc_steel_lump", count = { 16, 28 } },
        { item = "mc_steel_chunk", count = { 16, 28 } },
        { item = "scrap", count = { 16, 28 } },
        { item = "solar_cell_v3", count = { 8, 32 } },
    },
    damage_reduction = { all = 10 },
    variants = { { symbols = "#", broken_symbols = "x" } },
}
