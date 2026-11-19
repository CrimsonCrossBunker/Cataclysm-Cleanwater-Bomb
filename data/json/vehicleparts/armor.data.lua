local ccb = require("ccb")

-- 4 cm x 80 cm rebars arranged in a # or //// pattern. Half the surface area is welded (40 cm per rebar)
ccb.content.define_vehicle_part {
    id = "rebar_plate",
    item = "rebar_plate",
    description = ccb.content.text("Several interlocked rods of rebar serving as makeshift armor, allowing for light and effective reinforcement of vehicle sections."),
    location = "armor",
    categories = { "warfare" },
    color = "dark_gray",
    durability = 150,
    folded_volume = "1 L",
    breaks_into = { { item = "rebar", count = { 1, 2 } }, { item = "scrap", count = { 4, 8 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "welding_standard", 160 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "7 m",
            using_requirements = { { "repair_welding_rebar", 1 } },
        },
    },
    flags = { "ARMOR" },
    damage_reduction = { all = 10, cut = 45, stab = 45 },
    variants = { { symbols = "X", broken_symbols = "*" } },
}

-- 1 m x 1 m sq metal plate + 3 9 cm springs ~= 400 cm weld or so, 50 cm per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "spring_plate",
    item = "spring_plate",
    description = ccb.content.text("A makeshift combination of springs and scrap that protects a particular section of a vehicle from the shock of impacts.  The springs can absorb a surprising amount of damage."),
    location = "damping",
    categories = { "warfare" },
    color = "dark_gray",
    broken_color = "dark_gray",
    durability = 340,
    bonus = 50,
    breaks_into = { { item = "scrap", count = { 1, 5 } }, { item = "spring", count = { 0, 4 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "70 m",
            using_requirements = { { "welding_standard", 400 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "20 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_standard", 5 } },
        },
    },
    flags = { "SHOCK_ABSORBER" },
    damage_reduction = { all = 25 },
    variants = { { symbols = "X", broken_symbols = "*" } },
}
