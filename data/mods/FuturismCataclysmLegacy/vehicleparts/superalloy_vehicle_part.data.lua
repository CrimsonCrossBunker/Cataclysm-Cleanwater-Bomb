local ccb = require("ccb")

ccb.content.define_vehicle_part {
    id = "plating_superalloy",
    categories = { "warfare" },
    copy_from = "plating_superalloy",
    delete = { flags = { "SHOCK_RESISTANT" } },
    extend = { flags = { "SHOCK_IMMUNE" } },
}

ccb.content.define_vehicle_part {
    id = "ram_alloy",
    categories = { "warfare" },
    copy_from = "ram_alloy",
    delete = { flags = { "SHOCK_RESISTANT" } },
    extend = { flags = { "SHOCK_IMMUNE" } },
}

ccb.content.define_vehicle_part {
    id = "fcl_superalloy_stowboard",
    copy_from = "hdstowboard",
    name = ccb.content.text("superalloy stow board"),
    default_tint_color = "Traffic white",
    item = "alloy_plate",
    durability = 480,
    bonus = 50,
    proportional = { size = 1.4 },
    damage_reduction = { all = 30 },
    extend = { flags = { "SHOCK_RESISTANT" } },
    breaks_into = { { item = "scrap", count = { 6, 18 } }, { item = "alloy_sheet", count = { 4, 8 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "100 m",
            using_requirements = { { "welding_standard", 40 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_superalloy", 1 }, { "repair_welding_standard", 4 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "fcl_superalloy_board",
    copy_from = "hdboard",
    name = ccb.content.text("superalloy board"),
    default_tint_color = "Traffic white",
    item = "alloy_plate",
    durability = 640,
    bonus = 50,
    damage_reduction = { all = 30 },
    extend = { flags = { "SHOCK_RESISTANT" } },
    breaks_into = { { item = "scrap", count = { 6, 18 } }, { item = "alloy_sheet", count = { 4, 8 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "100 m",
            using_requirements = { { "welding_standard", 40 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "24 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_superalloy", 1 }, { "repair_welding_standard", 4 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "fcl_superalloy_quarterpanel",
    copy_from = "hdhalfboard",
    name = ccb.content.text("superalloy quarterpanel"),
    default_tint_color = "Traffic white",
    item = "alloy_plate",
    durability = 640,
    bonus = 50,
    damage_reduction = { all = 30 },
    extend = { flags = { "SHOCK_RESISTANT" } },
    breaks_into = { { item = "scrap", count = { 6, 18 } }, { item = "alloy_sheet", count = { 4, 8 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "100 m",
            using_requirements = { { "welding_standard", 40 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "24 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_superalloy", 1 }, { "repair_welding_standard", 4 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "fcl_superalloy_roof",
    copy_from = "hdroof",
    name = ccb.content.text("superalloy roof"),
    default_tint_color = "Traffic white",
    item = "alloy_plate",
    durability = 1400,
    bonus = 50,
    damage_reduction = { all = 45 },
    extend = { flags = { "SHOCK_RESISTANT" } },
    breaks_into = { { item = "scrap", count = { 6, 18 } }, { item = "alloy_sheet", count = { 4, 8 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "50 m",
            using_requirements = { { "welding_standard", 300 }, { "vehicle_bolt_install", 3 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_superalloy", 1 }, { "repair_welding_standard", 5 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "fcl_superalloy_door",
    copy_from = "hddoor",
    name = ccb.content.text("superalloy door"),
    default_tint_color = "Traffic white",
    item = "fcl_superalloy_frame",
    durability = 840,
    bonus = 50,
    damage_reduction = { all = 45 },
    extend = { flags = { "SHOCK_RESISTANT" } },
    breaks_into = { { item = "scrap", count = { 6, 18 } }, { item = "alloy_sheet", count = { 4, 8 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_superalloy", 1 }, { "repair_welding_standard", 3 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "fcl_superalloy_opaque_door",
    copy_from = "hddoor_opaque",
    name = ccb.content.text("superalloy opaque door"),
    default_tint_color = "Traffic white",
    item = "fcl_superalloy_frame",
    durability = 924,
    bonus = 50,
    damage_reduction = { all = 45 },
    extend = { flags = { "SHOCK_RESISTANT" } },
    breaks_into = { { item = "scrap", count = { 6, 18 } }, { item = "alloy_sheet", count = { 4, 8 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_superalloy", 1 }, { "repair_welding_standard", 3 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "fcl_superalloy_hatch",
    copy_from = "hdhatch",
    name = ccb.content.text("superalloy hatch"),
    default_tint_color = "Traffic white",
    item = "fcl_superalloy_frame",
    durability = 1260,
    bonus = 50,
    damage_reduction = { all = 45 },
    extend = { flags = { "SHOCK_RESISTANT" } },
    breaks_into = { { item = "scrap", count = { 6, 18 } }, { item = "alloy_sheet", count = { 4, 8 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "80 m",
            using_requirements = { { "welding_standard", 160 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "50 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_superalloy", 1 }, { "repair_welding_standard", 3 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "fcl_superalloy_opaque_hatch",
    copy_from = "hdhatch_opaque",
    name = ccb.content.text("superalloy opaque hatch"),
    default_tint_color = "Traffic white",
    item = "fcl_superalloy_frame",
    durability = 1400,
    bonus = 50,
    damage_reduction = { all = 45 },
    extend = { flags = { "SHOCK_RESISTANT" } },
    breaks_into = { { item = "scrap", count = { 6, 18 } }, { item = "alloy_sheet", count = { 4, 8 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "80 m",
            using_requirements = { { "welding_standard", 160 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "50 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_superalloy", 1 }, { "repair_welding_standard", 3 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "fcl_superalloy_trunk_door",
    copy_from = "hddoor_trunk",
    name = ccb.content.text("superalloy trunk door"),
    default_tint_color = "Traffic white",
    item = "fcl_superalloy_frame",
    durability = 1050,
    bonus = 50,
    damage_reduction = { all = 45 },
    extend = { flags = { "SHOCK_RESISTANT" } },
    breaks_into = { { item = "scrap", count = { 6, 18 } }, { item = "alloy_sheet", count = { 4, 8 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_superalloy", 1 }, { "repair_welding_standard", 3 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "fcl_superalloy_frame",
    copy_from = "hdframe",
    name = ccb.content.text("superalloy frame"),
    default_tint_color = "Traffic white",
    item = "fcl_superalloy_frame",
    durability = 1080,
    bonus = 50,
    damage_reduction = { all = 45 },
    extend = { flags = { "SHOCK_RESISTANT" } },
    breaks_into = { { item = "scrap", count = { 6, 18 } }, { item = "alloy_sheet", count = { 4, 8 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 4 } },
            duration = "120 m",
            using_requirements = { { "welding_standard", 400 }, { "vehicle_bolt_install", 4 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 5 } },
            duration = "18 m",
            using_requirements = { { "repair_welding_superalloy", 1 }, { "repair_welding_standard", 9 } },
        },
    },
}
