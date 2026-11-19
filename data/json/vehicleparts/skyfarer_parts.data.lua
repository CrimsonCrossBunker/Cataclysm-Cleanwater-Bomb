local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "sail_large",
    copy_from = "sail",
    name = ccb.content.text("large sail"),
    description = ccb.content.text("Sails and rigging fit for a yacht or sloop, about as large as a single person can reasonably crew."),
    categories = { "movement", "operations" },
    durability = 150,
    power = "4000 W",
    item = "sail_large_item",
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_nail_install", 30 } },
        },
        removal = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_nail_removal", 2 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "60 m",
            using_requirements = { { "nail_any_adhesive", 2 }, { "wood_structural_small", 1 } },
        },
    },
    breaks_into = {
        { item = "log", count = { 1, 2 } },
        { item = "splinter", count = { 10, 20 } },
        { item = "sheet", count = { 1, 2 } },
    },
    delete = { flags = { "UNMOUNT_ON_DAMAGE" } },
}

ccb.content.define_vehicle_part {
    id = "seat_wood_light",
    copy_from = "seat_wood",
    name = ccb.content.text("light wooden seat"),
    looks_like = "seat_wood",
    durability = 80,
    item = "frame_wood_light",
    requirements = {
        install = {
            skills = { { "mechanics", 0 } },
            duration = "10 m",
            using_requirements = { { "rope_natural_short", 1 } },
        },
        removal = { skills = { { "mechanics", 0 } }, duration = "5 m", using_requirements = {} },
        repair = {
            skills = { { "mechanics", 0 } },
            duration = "5 m",
            using_requirements = { { "nail_any_adhesive", 1 }, { "vehicle_repair_small_wood", 4 } },
        },
    },
    breaks_into = { { item = "splinter", count = { 3, 5 } }, { item = "string_36", count = { 10, 15 } } },
    damage_reduction = { all = 6 },
}
