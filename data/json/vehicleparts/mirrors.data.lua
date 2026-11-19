local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "wing_mirror",
    name = ccb.content.text("wing mirror"),
    categories = { "other" },
    color = "light_cyan",
    broken_color = "dark_gray",
    damage_modifier = 10,
    durability = 20,
    description = ccb.content.text("A small mirror, mounted outside the vehicle.  If you see the mirror, your vision is expanded as though you were standing where the mirror is."),
    folded_volume = "500 ml",
    item = "mirror",
    location = "structure",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "100 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "100 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    flags = { "VISION", "PROTRUSION", "UNMOUNT_ON_DAMAGE" },
    breaks_into = { { item = "glass_shard", count = { 0, 16 } } },
    variants = {
        { id = "left", label = "Left", symbols = "o", broken_symbols = "*" },
        { id = "right", label = "Right", symbols = "o", broken_symbols = "*" },
    },
}

ccb.content.define_vehicle_part {
    id = "inboard_mirror",
    name = ccb.content.text("inboard mirror"),
    categories = { "other" },
    color = "light_cyan",
    broken_color = "dark_gray",
    damage_modifier = 10,
    durability = 30,
    description = ccb.content.text("A small mirror, mounted inside the vehicle.  If you see the mirror, your vision is expanded as though you were standing where the mirror is."),
    folded_volume = "250 ml",
    item = "mirror",
    location = "on_windshield",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "100 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "100 s",
            using_requirements = { { "vehicle_screw", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "20 s",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    flags = { "VISION" },
    breaks_into = { { item = "glass_shard", count = { 0, 16 } } },
    variants = { { symbols = "o", broken_symbols = "*" } },
}
