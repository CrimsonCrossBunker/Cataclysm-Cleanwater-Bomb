local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "door_window",
    name = ccb.content.text("door window"),
    description = ccb.content.text("A sheet of glass fitted into a vehicle door."),
    item = "glass_sheet",
    location = "on_door",
    categories = { "hull" },
    durability = 50,
    damage_modifier = 70,
    damage_reduction = { all = 2 },
    flags = { "WINDOW", "WINDOW_MOUNT", "FRAGILE_COMPONENTS" },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "15 m",
            using_requirements = { { "adhesive", 2 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
    },
    breaks_into = { { count = { 15, 30 }, item = "glass_shard" } },
    variants = { { symbols = "+", broken_symbols = "+" } },
}

ccb.content.define_vehicle_part {
    id = "strong_door_window",
    name = ccb.content.text("strong door window"),
    description = ccb.content.text("A sheet of tempered glass fitted into a vehicle door."),
    item = "tempered_glass_sheet",
    location = "on_door",
    categories = { "hull" },
    durability = 50,
    damage_modifier = 70,
    damage_reduction = { all = 20 },
    flags = { "WINDOW", "WINDOW_MOUNT", "FRAGILE_COMPONENTS" },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "15 m",
            using_requirements = { { "adhesive", 2 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
    },
    breaks_into = { { count = { 15, 30 }, item = "glass_shard" } },
    variants = { { symbols = "+", broken_symbols = "+" } },
}
