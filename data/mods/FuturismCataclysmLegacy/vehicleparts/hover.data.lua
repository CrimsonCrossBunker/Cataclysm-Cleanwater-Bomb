local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "fcl_geomagnetic_hover_wheel",
    item = "fcl_geomagnetic_hover_wheel",
    description = ccb.content.text("A stress wheel, purported to exploit geomagnetic induction effects, enables a vehicle to hover in near-ground suspension at a height slightly above the ground.  As one of this century's latest commercialized levitation applications, it clearly cannot rival the rumored secret military project capable of levitating flight."),
    location = "under",
    looks_like = "wheel",
    categories = { "movement" },
    color = "light_gray",
    durability = 800,
    damage_modifier = 50,
    breaks_into = {
        { item = "mc_steel_chunk", count = { 3, 6 } },
        { item = "scrap", count = { 2, 3 } },
        { item = "e_scrap", count = { 15, 30 } },
        { item = "alloy_sheet", count = { 0, 2 } },
    },
    rolling_resistance = 0.6,
    wheel_terrain_modifiers = {
        { flag = "FLAT", move_override = 0, move_penalty = 4 },
        { flag = "ROAD", move_override = 0, move_penalty = 2 },
    },
    contact_area = 640,
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 100 }, { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 3 } },
            duration = "15 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = {
                { "welding_standard", 20 },
                { "soldering_standard", 10 },
                { "repair_welding_superalloy", 1 },
                { "vehicle_repair_electronics", 2 },
            },
        },
    },
    flags = { "WHEEL", "STABLE", "SELF_JACK", "VARIABLE_SIZE", "TRACKED", "TRAP_PROOF" },
    damage_reduction = { all = 8, cut = 10, stab = 5 },
    variants = { { symbols = "0", broken_symbols = "x" } },
}
