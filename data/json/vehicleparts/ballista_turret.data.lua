local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "turret_mount_manual_wood",
    copy_from = "turret_mount",
    name = ccb.content.text("simple wooden turret mount"),
    color = "brown",
    broken_color = "brown",
    durability = 150,
    description = ccb.content.text("A simple hardpoint for mounting a weapon.  Lacks the necessary electronics to support firing remotely or installing turret controls.  If your hands are empty, you can stand on the same tile as a mounted gun and 'f'ire the weapon."),
    item = "frame_wood",
    folded_volume = "7500 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_install", 20 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "15 m",
            using_requirements = { { "nail_any_adhesive", 2 }, { "wood_structural_small", 1 } },
        },
    },
    extend = { flags = { "MANUAL" } },
    breaks_into = { { item = "splinter", count = { 7, 9 } }, { item = "nail", charges = { 5, 10 } } },
}

ccb.content.define_vehicle_part {
    id = "mounted_launcher_ballista",
    copy_from = "turret",
    name = ccb.content.text("mounted ballista"),
    item = "launcher_ballista",
    looks_like = "mounted_huge_crossbow",
    color = "green",
    broken_color = "green",
    breaks_into = {
        { item = "scrap", count = { 10, 20 } },
        { item = "splinter", count = { 12, 24 } },
        { item = "string_36", count = { 5, 10 } },
    },
    requirements = {
        install = { skills = { { "mechanics", 3 }, { "launcher", 1 } } },
        removal = { skills = { { "mechanics", 1 } } },
    },
}

ccb.content.define_vehicle_part {
    id = "mounted_huge_crossbow",
    copy_from = "turret",
    name = ccb.content.text("mounted huge crossbow"),
    item = "huge_crossbow",
    looks_like = "turret_generic",
    color = "green",
    broken_color = "green",
    breaks_into = {
        { item = "scrap", count = { 6, 12 } },
        { item = "splinter", count = { 8, 16 } },
        { item = "string_36", count = { 3, 6 } },
    },
    requirements = {
        install = { skills = { { "mechanics", 2 } } },
        removal = { skills = { { "mechanics", 0 } } },
    },
}
