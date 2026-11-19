local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "light_orichalcum_frame",
    copy_from = "frame_orichalcum",
    looks_like = "orichalcum_frame",
    name = ccb.content.text("light orichalcum frame"),
    item = "light_orichalcum_frame",
    durability = 600,
    description = ccb.content.text("A slimmed magical metal framework.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size."),
    breaks_into = "light_orichalcum_frame_break",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "17 m",
            using_requirements = { { "welding_standard", 8 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "8 m",
            using_requirements = "vehicle_weld_removal",
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "4 m",
            using_requirements = { { "welding_standard", 4 } },
        },
    },
    damage_reduction = { all = 30 },
}

ccb.content.define_vehicle_part {
    id = "folding_orichalcum_frame",
    copy_from = "frame_orichalcum",
    name = ccb.content.text("foldable orichalcum frame"),
    item = "fold_orichalcum_frame",
    durability = 250,
    description = ccb.content.text("A light metal framework, designed to fold.  Other vehicle components can be mounted on it.  If all the frames and components of a vehicle are foldable, the vehicle can be folding into a small package and picked up as a normal item."),
    folded_volume = "5 L",
    breaks_into = { { item = "orichalcum_lump", count = { 0, 2 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 2 }, { "spellcraft", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
        removal = {
            skills = { { "mechanics", 2 }, { "spellcraft", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 }, { "spellcraft", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 5 } },
        },
    },
    damage_reduction = { all = 12 },
}

ccb.content.define_vehicle_part {
    id = "frame_orichalcum",
    copy_from = "frame_abstract",
    name = ccb.content.text("orichalcum frame"),
    item = "orichalcum_frame",
    looks_like = "orichalcum_frame",
    durability = 2000,
    description = ccb.content.text("An expensive magical metal framework.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size."),
    breaks_into = "orichalcum_frame_break",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "20 m",
            using_requirements = { { "welding_standard", 10 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = "vehicle_weld_removal",
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "welding_standard", 5 } },
        },
    },
    damage_reduction = { all = 50 },
}
