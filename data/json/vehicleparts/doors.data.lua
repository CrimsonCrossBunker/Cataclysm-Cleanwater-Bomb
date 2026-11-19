local ccb = require("ccb")

-- 30 cm of weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "door",
    breaks_into = "ig_vp_frame",
    broken_color = "cyan",
    categories = { "hull" },
    color = "cyan",
    damage_modifier = 80,
    damage_reduction = { all = 20 },
    description = ccb.content.text("A door.  Has a window so you can see out of it, even when closed."),
    durability = 225,
    flags = {
        "CARGO",
        "CARGO_PASSABLE",
        "OBSTACLE",
        "OPENABLE",
        "BOARDABLE",
        "WINDOW_MOUNTABLE",
        "DOOR",
        "LOCKABLE_DOOR",
        "HUGE_OK",
    },
    item = "frame",
    location = "center",
    looks_like = "t_door_metal_c",
    name = ccb.content.text("door"),
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_lc_steel", 3 } },
        },
    },
    size = "2500 ml",
    variant_bases = { { id = "full", label = "Full" } },
    variants = {
        { id = "front", label = "Front", symbols = "+", broken_symbols = "&" },
        { id = "front_left", label = "Front Left", symbols = "+", broken_symbols = "&" },
        { id = "front_right", label = "Front Right", symbols = "+", broken_symbols = "&" },
        { id = "left", label = "Left", symbols = "+", broken_symbols = "&" },
        { id = "right", label = "Right", symbols = "+", broken_symbols = "&" },
        { id = "rear", label = "Rear", symbols = "+", broken_symbols = "&" },
        { id = "vertical_left", label = "Left Vertical", symbols = "+", broken_symbols = "&" },
        { id = "vertical_right", label = "Right Vertical", symbols = "+", broken_symbols = "&" },
        { id = "horizontal_front", label = "Front Horizontal", symbols = "+", broken_symbols = "&" },
        { id = "horizontal_2", label = "Thick Horizontal", symbols = "+", broken_symbols = "&" },
        { id = "horizontal_rear", label = "Rear Horizontal", symbols = "+", broken_symbols = "&" },
        { id = "ne", label = "Front Right", symbols = "+", broken_symbols = "&" },
        { id = "nw", label = "Front Left", symbols = "+", broken_symbols = "&" },
        { id = "se", label = "Rear Right", symbols = "+", broken_symbols = "&" },
        { id = "sw", label = "Rear Left", symbols = "+", broken_symbols = "&" },
        { id = "wheel_left", label = "Wheel Left", symbols = "+", broken_symbols = "&" },
        { id = "wheel_right", label = "Wheel Right", symbols = "+", broken_symbols = "&" },
    },
}

ccb.content.define_vehicle_part {
    copy_from = "door",
    id = "cloth_flap_door",
    name = ccb.content.text("cloth flap door"),
    description = ccb.content.text("A cloth sheet that can be fastened into a closed position to act as a door."),
    item = "sheet",
    durability = 15,
    folded_volume = "2500 ml",
    breaks_into = "ig_vp_cloth",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "10 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "fabrication", 2 } },
            duration = "5 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "5 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    damage_reduction = { all = 0, bash = 3 },
    delete = { flags = { "LOCKABLE_DOOR", "WINDOW_MOUNTABLE" } },
}

ccb.content.define_vehicle_part {
    copy_from = "cloth_flap_door",
    id = "cloth_curtain_door",
    looks_like = "door",
    name = ccb.content.text("cloth curtain door"),
    description = ccb.content.text("A cloth sheet that can be slid into a closed position to act as a door."),
}

ccb.content.define_vehicle_part {
    id = "door_opaque",
    copy_from = "door",
    description = ccb.content.text("A door.  Solid construction means you can't see through it when closed."),
    durability = 240,
    name = ccb.content.text("opaque door"),
    extend = { flags = { "OPAQUE" } },
    delete = { flags = { "WINDOW_MOUNTABLE" } },
    variant_bases = { { id = "full", label = "Full" } },
}

-- 40 cm of weld per quadrant of damage
ccb.content.define_vehicle_part {
    id = "hddoor",
    copy_from = "door",
    breaks_into = "ig_vp_hdframe",
    damage_reduction = { all = 30 },
    description = ccb.content.text("A strong door.  Has a window so you can see out of it, even when closed."),
    durability = 600,
    item = "hdframe",
    name = ccb.content.text("heavy-duty door"),
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_lc_steel", 4 } },
        },
    },
    variant_bases = { { id = "full", label = "Full" } },
}

ccb.content.define_vehicle_part {
    id = "hddoor_opaque",
    copy_from = "hddoor",
    description = ccb.content.text("A strong door.  Solid construction means you can't see through it when closed."),
    durability = 660,
    looks_like = "door_opaque",
    name = ccb.content.text("heavy-duty opaque door"),
    extend = { flags = { "OPAQUE" } },
    delete = { flags = { "WINDOW_MOUNTABLE" } },
    variant_bases = { { id = "full", label = "Full" } },
}

ccb.content.define_vehicle_part {
    id = "door_internal",
    copy_from = "door_opaque",
    damage_modifier = 75,
    description = ccb.content.text("An interior door.  Solid construction means you can't see through it when closed."),
    name = ccb.content.text("internal door"),
}

-- 30 cm of weld per quadrant of damage, 4x that to install
ccb.content.define_vehicle_part {
    id = "hatch",
    copy_from = "door",
    description = ccb.content.text("A strong door.  A window lets you see through it when closed."),
    durability = 420,
    name = ccb.content.text("hatch"),
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "70 m",
            using_requirements = { { "welding_standard", 120 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "40 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_lc_steel", 3 } },
        },
    },
    size = "37500 ml",
    extend = { flags = { "LOCKABLE_CARGO", "MULTISQUARE", "COVERED" } },
}

ccb.content.define_vehicle_part {
    id = "hatch_opaque",
    copy_from = "hatch",
    description = ccb.content.text("A strong door.  Solid construction means you can't see through it when closed."),
    durability = 450,
    looks_like = "door_opaque",
    name = ccb.content.text("opaque hatch"),
    extend = { flags = { "OPAQUE" } },
    delete = { flags = { "WINDOW_MOUNTABLE" } },
}

-- 40 cm of weld per quadrant of damage, 4x that to install
ccb.content.define_vehicle_part {
    id = "hdhatch",
    copy_from = "hatch",
    breaks_into = "ig_vp_hdframe",
    damage_reduction = { all = 30 },
    description = ccb.content.text("A very strong door.  A window lets you see through it when closed."),
    durability = 900,
    item = "hdframe",
    name = ccb.content.text("heavy-duty hatch"),
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "80 m",
            using_requirements = { { "welding_standard", 160 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "50 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 4 } },
            duration = "8 m",
            using_requirements = { { "repair_welding_lc_steel", 4 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "hdhatch_opaque",
    copy_from = "hdhatch",
    description = ccb.content.text("A very strong door.  Solid construction means you can't see through it when closed."),
    durability = 1000,
    looks_like = "hatch_opaque",
    name = ccb.content.text("heavy-duty opaque hatch"),
    extend = { flags = { "OPAQUE" } },
    delete = { flags = { "WINDOW_MOUNTABLE" } },
}

-- 30 cm of weld per quadrant of damage, 4x that to install
ccb.content.define_vehicle_part {
    id = "hatchback_trunk",
    copy_from = "hatch",
    description = ccb.content.text("A fold up door covering trunk space.  A window lets you see through it when closed."),
    durability = 420,
    name = ccb.content.text("hatchback trunk"),
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "70 m",
            using_requirements = { { "welding_standard", 120 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "40 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_lc_steel", 3 } },
        },
    },
    size = "125000 ml",
    extend = { flags = { "LOCKABLE_CARGO", "MULTISQUARE", "COVERED" } },
}

ccb.content.define_vehicle_part {
    id = "door_wood",
    copy_from = "door",
    name = ccb.content.text("wooden door"),
    looks_like = "t_door_c",
    color = "brown",
    broken_color = "brown",
    damage_modifier = 75,
    durability = 160,
    size = "0 ml",
    item = "frame_wood",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    breaks_into = { { item = "splinter", count = { 7, 9 } } },
    extend = { flags = { "SIMPLE_PART" } },
    delete = { flags = { "CARGO", "CARGO_PASSABLE", "LOCKABLE_DOOR" } },
    damage_reduction = { all = 8 },
}

ccb.content.define_vehicle_part {
    id = "door_wood_opaque",
    copy_from = "door_wood",
    name = ccb.content.text("opaque wooden door"),
    durability = 170,
    description = ccb.content.text("A door.  Solid construction means you can't see through it when closed."),
    extend = { flags = { "OPAQUE" } },
    delete = { flags = { "WINDOW_MOUNTABLE" } },
    damage_reduction = { all = 12 },
}

ccb.content.define_vehicle_part {
    id = "door_trunk",
    copy_from = "hatch",
    name = ccb.content.text("trunk door"),
    durability = 150,
    size = "0 ml",
    description = ccb.content.text("A short door.  You can always see over it, open or closed."),
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_lc_steel", 2 } },
        },
    },
    extend = { flags = { "LOW_FINAL_AIR_DRAG", "SIMPLE_PART", "NO_ROOF_NEEDED" } },
    delete = { flags = { "CARGO", "CARGO_PASSABLE", "COVERED", "LOCKABLE_CARGO", "WINDOW_MOUNTABLE" } },
}

ccb.content.define_vehicle_part {
    id = "hddoor_trunk",
    copy_from = "door_trunk",
    name = ccb.content.text("heavy-duty trunk door"),
    durability = 750,
    description = ccb.content.text("A strong, short door.  You can always see over it, open or closed."),
    item = "hdframe",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_lc_steel", 4 } },
        },
    },
    breaks_into = "ig_vp_hdframe",
    delete = { flags = { "NO_ROOF_NEEDED" } },
    damage_reduction = { all = 30 },
}

ccb.content.define_vehicle_part {
    id = "door_shutter",
    copy_from = "hatch",
    name = ccb.content.text("shutter door"),
    size = "0 ml",
    durability = 95,
    description = ccb.content.text("A strong door.  Solid construction means you can't see through it when closed."),
    item = "sheet_metal",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "60 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            using_requirements = { { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "60 m",
            using_requirements = { { "repair_welding_lc_steel", 2 } },
        },
    },
    breaks_into = "ig_vp_sheet_metal",
    extend = { flags = { "OPAQUE", "SIMPLE_PART" } },
    delete = { flags = { "CARGO", "CARGO_PASSABLE", "COVERED", "LOCKABLE_CARGO", "WINDOW_MOUNTABLE" } },
    damage_reduction = { all = 7 },
}

ccb.content.define_vehicle_part {
    id = "door_sliding",
    copy_from = "door_trunk",
    name = ccb.content.text("sliding door"),
    looks_like = "door",
    description = ccb.content.text("A door.  A window lets you see through it when closed."),
    breaks_into = "ig_vp_frame",
    extend = { flags = { "WINDOW_MOUNTABLE" } },
    delete = { flags = { "LOW_FINAL_AIR_DRAG", "NO_ROOF_NEEDED" } },
}
