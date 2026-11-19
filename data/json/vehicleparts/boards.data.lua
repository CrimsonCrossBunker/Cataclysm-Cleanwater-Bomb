local ccb = require("ccb")

ccb.content.define_vehicle_part {
    abstract = "base_board_abstract",
    location = "center",
    categories = { "hull" },
    flags = { "OBSTACLE", "NO_ROOF_NEEDED" },
    variants = {
        { id = "horizontal", label = "Horizontal", symbols = "──│───│─", broken_symbols = "#" },
        { id = "horizontal_2", label = "Thick Horizontal", symbols = "━━┃━━━┃━", broken_symbols = "#" },
        { id = "vertical", label = "Vertical", symbols = "│\\─/│\\─/", broken_symbols = "#" },
        { id = "vertical_2", label = "Thick Vertical", symbols = "┃┃━┃┃┃━┃", broken_symbols = "#" },
        { id = "ne", label = "Front Right", symbols = "┐┐┌└└└┘┐", broken_symbols = "#" },
        { id = "nw", label = "Front Left", symbols = "┌┌└┘┘┘┐┌", broken_symbols = "#" },
        { id = "se", label = "Rear Right", symbols = "┘┘┐┌┌┌└┘", broken_symbols = "#" },
        { id = "sw", label = "Rear Left", symbols = "└└┘┐┐┐┌└", broken_symbols = "#" },
        { id = "cross", label = "Cross", symbols = "┼X┼X┼X┼X", broken_symbols = "#" },
        { id = "cover", label = "Cover", symbols = "^^<vvv>^", broken_symbols = "#" },
        { id = "cover_left", label = "Cover Left", symbols = "──│───│─", broken_symbols = "#" },
        { id = "cover_right", label = "Cover Right", symbols = "──│───│─", broken_symbols = "#" },
        { id = "horizontal_front", label = "Front Horizontal", symbols = "──│───│─", broken_symbols = "#" },
        { id = "hatch_wheel_left", label = "Hatchback Wheel Left", symbols = "└└┘┐┐┐┌└", broken_symbols = "#" },
        {
            id = "hatch_wheel_right",
            label = "Hatchback Wheel Right",
            symbols = "┘┘┐┌┌┌└┘",
            broken_symbols = "#",
        },
        { id = "horizontal_rear", label = "Rear Horizontal", symbols = "──│───│─", broken_symbols = "#" },
        {
            id = "horizontal_2_front",
            label = "Front Thick Horizontal",
            symbols = "━━┃━━━┃━",
            broken_symbols = "#",
        },
        {
            id = "horizontal_2_rear",
            label = "Rear Thick Horizontal",
            symbols = "━━┃━━━┃━",
            broken_symbols = "#",
        },
        { id = "nw_edge", label = "Front Left Corner", symbols = "┌┌└┘┘┘┐┌", broken_symbols = "#" },
        { id = "ne_edge", label = "Front Right Corner", symbols = "┐┐┌└└└┘┐", broken_symbols = "#" },
        { id = "vertical_left", label = "Left Vertical", symbols = "│\\─/│\\─/", broken_symbols = "#" },
        { id = "vertical_right", label = "Right Vertical", symbols = "│\\─/│\\─/", broken_symbols = "#" },
        { id = "vertical_T_left", label = "Left T Joint", symbols = "[\\-/[\\-/", broken_symbols = "#" },
        { id = "vertical_T_right", label = "Right T Joint", symbols = "]\\-/]\\-/", broken_symbols = "#" },
        { id = "vertical_2_left", label = "Left Thick Vertical", symbols = "┃┃━┃┃┃━┃", broken_symbols = "#" },
        { id = "vertical_2_right", label = "Right Thick Vertical", symbols = "┃┃━┃┃┃━┃", broken_symbols = "#" },
        { id = "wheel_left", label = "Wheel Left", symbols = "│\\─/│\\─/", broken_symbols = "#" },
        { id = "wheel_right", label = "Wheel Right", symbols = "│\\─/│\\─/", broken_symbols = "#" },
    },
}

-- 1 m square sheet, assume 200 cm weld, 50 cm weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    abstract = "board_abstract",
    copy_from = "base_board_abstract",
    item = "sheet_metal",
    durability = 120,
    breaks_into = "ig_vp_sheet_metal",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "40 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_lc_steel", 5 } },
        },
    },
    damage_reduction = { all = 7 },
}

ccb.content.define_vehicle_part {
    id = "board",
    copy_from = "board_abstract",
    name = ccb.content.text("board"),
    description = ccb.content.text("A metal wall.  Keeps zombies outside the vehicle and prevents people from seeing through it."),
    extend = { flags = { "OPAQUE", "FULL_BOARD" } },
}

ccb.content.define_vehicle_part {
    id = "halfboard",
    copy_from = "board_abstract",
    name = ccb.content.text("quarterpanel"),
    description = ccb.content.text("A half-height metal wall.  Keeps zombies outside the vehicle but allows people to see over it."),
    proportional = { durability = 0.8 },
    extend = { flags = { "HALF_BOARD" } },
}

ccb.content.define_vehicle_part {
    abstract = "clothboard_abstract",
    copy_from = "base_board_abstract",
    item = "sheet",
    broken_color = "dark_gray",
    durability = 15,
    folded_volume = "3750 ml",
    breaks_into = "ig_vp_cloth",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "5 m",
            using_requirements = { { "vehicle_nail_install", 1 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "fabrication", 2 } },
            duration = "1 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "1 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    damage_reduction = { all = 0, bash = 3 },
}

ccb.content.define_vehicle_part {
    id = "clothboard",
    copy_from = "clothboard_abstract",
    name = ccb.content.text("cloth board"),
    description = ccb.content.text("A cloth wall.  Keeps zombies outside the vehicle and prevents people from seeing through it."),
    extend = { flags = { "OPAQUE", "FULL_BOARD" } },
}

ccb.content.define_vehicle_part {
    abstract = "cloth_halfboard",
    copy_from = "clothboard_abstract",
    name = ccb.content.text("cloth quarterpanel"),
    description = ccb.content.text("A half-height cloth wall.  Keeps zombies outside the vehicle but allows people to see over it."),
    proportional = { durability = 0.8 },
    extend = { flags = { "HALF_BOARD" } },
}

-- 1 m square sheet, assume 200 cm weld, 50 cm weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "stowboard",
    copy_from = "base_board_abstract",
    name = ccb.content.text("stow board"),
    item = "sheet_metal",
    color = "white",
    durability = 80,
    description = ccb.content.text("A metal wall with a storage locker.  Keeps zombies outside the vehicle and prevents people from seeing through it."),
    size = "62500 ml",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "100 m",
            using_requirements = { { "welding_standard", 40 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_lc_steel", 5 } },
        },
    },
    extend = {
        categories = { "cargo" },
        flags = { "OPAQUE", "CARGO", "COVERED", "FULL_BOARD", "LOCKABLE_CARGO" },
    },
    damage_reduction = { all = 7 },
}

ccb.content.define_vehicle_part {
    id = "hdstowboard",
    copy_from = "stowboard",
    name = ccb.content.text("heavy-duty stow board"),
    item = "steel_plate",
    color = "brown",
    broken_color = "dark_gray",
    proportional = { durability = 4.15, size = 0.76 },
    damage_reduction = { all = 20 },
}

-- steel plating doesn't have a defined length so assume 200 cm weld like regular board, 50 cm weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    abstract = "hdboard_abstract",
    copy_from = "base_board_abstract",
    item = "steel_plate",
    color = "dark_gray",
    durability = 450,
    description = ccb.content.text("A strong metal wall.  Keeps zombies outside the vehicle and prevents people from seeing through it."),
    breaks_into = "ig_vp_steel_plate",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "100 m",
            using_requirements = { { "welding_standard", 40 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "24 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_lc_steel", 5 } },
        },
    },
    damage_reduction = { all = 20 },
}

ccb.content.define_vehicle_part {
    id = "hdboard",
    copy_from = "hdboard_abstract",
    name = ccb.content.text("heavy-duty board"),
    extend = { flags = { "OPAQUE", "FULL_BOARD" } },
}

ccb.content.define_vehicle_part {
    id = "hdhalfboard",
    copy_from = "hdboard_abstract",
    name = ccb.content.text("heavy-duty quarterpanel"),
    description = ccb.content.text("A half-height strong metal wall.  Keeps zombies outside the vehicle but allows people to see over it."),
    proportional = { durability = 0.8 },
    extend = { flags = { "HALF_BOARD" } },
}

ccb.content.define_vehicle_part {
    abstract = "woodboard_abstract",
    copy_from = "base_board_abstract",
    item = "wood_plate",
    color = "brown",
    broken_color = "brown",
    durability = 100,
    breaks_into = "ig_vp_wood_plate",
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "fabrication", 2 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "10 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    damage_reduction = { all = 5 },
}

ccb.content.define_vehicle_part {
    id = "woodboard",
    copy_from = "woodboard_abstract",
    name = ccb.content.text("wooden board"),
    description = ccb.content.text("A wooden wall.  Keeps zombies outside the vehicle and prevents people from seeing through it."),
    extend = { flags = { "OPAQUE", "FULL_BOARD" } },
}

ccb.content.define_vehicle_part {
    id = "woodhalfboard",
    copy_from = "woodboard_abstract",
    name = ccb.content.text("wooden quarterpanel"),
    description = ccb.content.text("A half-height wooden wall.  Keeps zombies outside the vehicle but allows people to see over it."),
    proportional = { durability = 0.8 },
    extend = { flags = { "HALF_BOARD" } },
}

-- 60 cm pipe, assume 120 cm weld, 30 weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "xlhalfboard",
    copy_from = "base_board_abstract",
    name = ccb.content.text("extra-light quarterpanel"),
    item = "pipe",
    looks_like = "halfboard",
    durability = 70,
    description = ccb.content.text("A half-height thin metal wall.  Keeps zombies outside the vehicle but allows people to see over it."),
    breaks_into = { { item = "pipe", probability = 50 } },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "20 m",
            using_requirements = { { "welding_standard", 120 }, { "vehicle_bolt_install", 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 3 } },
        },
    },
    extend = { flags = { "HALF_BOARD" } },
    damage_reduction = { all = 5 },
}

-- 110 cm block, so 1/4 that, 30 cm weld per damage quadrant to repair
ccb.content.define_vehicle_part {
    id = "counterweight",
    copy_from = "base_board_abstract",
    looks_like = "hdhalfboard",
    item = "counterweight",
    color = "dark_gray",
    durability = 600,
    name = ccb.content.text("counterweight"),
    description = ccb.content.text("A half-height heavy metal wall.  Commonly used in forklifts to balance them when lifting heavy things."),
    breaks_into = "ig_vp_hdframe",
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "30 m",
            qualities = { { id = "WRENCH", level = 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 3 } },
        },
    },
    damage_reduction = { all = 20 },
    extend = { flags = { "HALF_BOARD" } },
}
