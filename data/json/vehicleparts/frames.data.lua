local ccb = require("ccb")

ccb.content.define_vehicle_part {
    abstract = "frame_abstract",
    location = "structure",
    durability = 400,
    description = ccb.content.text("A metal framework.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size."),
    breaks_into = "ig_vp_frame",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "20 m",
            using_requirements = { { "welding_standard", 10 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "10 m",
            using_requirements = "vehicle_weld_removal",
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "5 m",
            using_requirements = { { "repair_welding_standard", 1 } },
        },
    },
    flags = { "MOUNTABLE", "INITIAL_PART" },
    categories = { "hull" },
    damage_reduction = { all = 20 },
    variants = {
        { id = "horizontal", label = "Horizontal", symbols = "──│───│─", broken_symbols = "#" },
        { id = "horizontal_front", label = "Front Horizontal", symbols = "──│───│─", broken_symbols = "#" },
        { id = "horizontal_rear", label = "Rear Horizontal", symbols = "──│───│─", broken_symbols = "#" },
        { id = "horizontal_2", label = "Thick Horizontal", symbols = "━━┃━━━┃━", broken_symbols = "#" },
        {
            id = "horizontal_2_front",
            label = "Front Thick Horizontal",
            symbols = "━━┃━━━┃━",
            broken_symbols = "#",
        },
        { id = "vertical", label = "Vertical", symbols = "│\\─/│\\─/", broken_symbols = "#" },
        { id = "vertical_left", label = "Left Vertical", symbols = "│\\─/│\\─/", broken_symbols = "#" },
        { id = "vertical_right", label = "Right Vertical", symbols = "│\\─/│\\─/", broken_symbols = "#" },
        { id = "vertical_T_left", label = "Left T Joint", symbols = "│\\─/│\\─/", broken_symbols = "#" },
        { id = "vertical_T_right", label = "Right T Joint", symbols = "│\\─/│\\─/", broken_symbols = "#" },
        { id = "vertical_2", label = "Thick Vertical", symbols = "┃┃━┃┃┃━┃", broken_symbols = "#" },
        { id = "vertical_2_left", label = "Left Thick Vertical", symbols = "┃┃━┃┃┃━┃", broken_symbols = "#" },
        { id = "vertical_2_right", label = "Right Thick Vertical", symbols = "┃┃━┃┃┃━┃", broken_symbols = "#" },
        { id = "cover", label = "Cover", symbols = "^^<vvv>^", broken_symbols = "#" },
        { id = "cross", label = "Cross", symbols = "┼X┼X┼X┼X", broken_symbols = "#" },
        { id = "ne", label = "Front Right", symbols = "┐┐┌└└└┘┐", broken_symbols = "#" },
        { id = "nw", label = "Front Left", symbols = "┌┌└┘┘┘┐┌", broken_symbols = "#" },
        { id = "se", label = "Rear Right", symbols = "┘┘┐┌┌┌└┘", broken_symbols = "#" },
        { id = "sw", label = "Rear Left", symbols = "└└┘┐┐┐┌└", broken_symbols = "#" },
    },
}

-- welds would likely occur along the circumference of the pipe, where they screw into the fittings - that's 8 ends for 4 pipes, about 5 cm each. repairing is more expensive than installing unlike most welds.
ccb.content.define_vehicle_part {
    id = "folding_frame",
    copy_from = "frame_abstract",
    item = "foldframe",
    durability = 50,
    description = ccb.content.text("A light metal framework, designed to fold.  Other vehicle components can be mounted on it.  If all the frames and components of a vehicle are foldable, the vehicle can be folding into a small package and picked up as a normal item."),
    folded_volume = "2500 ml",
    folding_time = "1 minute",
    unfolding_time = "1 minute",
    breaks_into = { { item = "lc_steel_chunk", count = { 0, 2 } }, { item = "scrap", count = { 1, 2 } } },
    requirements = {
        install = {
            skills = { { "mechanics", 2 } },
            duration = "20 m",
            using_requirements = { { "welding_standard", 40 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "vehicle_weld_removal", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "10 m",
            using_requirements = { { "repair_welding_standard", 6 } },
        },
    },
    damage_reduction = { all = 10 },
}

ccb.content.define_vehicle_part {
    id = "folding_wooden_frame",
    copy_from = "frame_abstract",
    item = "foldwoodframe",
    color = "brown",
    broken_color = "brown",
    durability = 15,
    description = ccb.content.text("A light wooden framework, designed to fold.  Other vehicle components can be mounted on it.  If all the frames and components of a vehicle are foldable, the vehicle can be folding into a small package and picked up as a normal item."),
    folded_volume = "3750 ml",
    folding_time = "1 minute",
    unfolding_time = "1 minute",
    breaks_into = { { item = "splinter", count = { 0, 6 } }, { item = "nail", charges = { 1, 15 } } },
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "fabrication", 1 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    damage_reduction = { all = 3 },
}

-- assuming about 50 cm square for a frame's welds (200 cm total) plus 50 cm per damage quadrant for repair
ccb.content.define_vehicle_part {
    id = "frame",
    copy_from = "frame_abstract",
    item = "frame",
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_standard", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "15 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 1 } },
            duration = "9 m",
            using_requirements = { { "repair_welding_lc_steel", 5 } },
        },
    },
}

ccb.content.define_vehicle_part {
    id = "frame_wood",
    copy_from = "frame_abstract",
    item = "frame_wood",
    color = "brown",
    broken_color = "brown",
    durability = 150,
    description = ccb.content.text("A wooden framework.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size.  Wood and nail construction means it can be constructed and added to the vehicle without welding tools."),
    breaks_into = { { item = "splinter", count = { 7, 9 } }, { item = "nail", charges = { 5, 10 } } },
    requirements = {
        install = {
            skills = { { "fabrication", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_nail_install", 1 } },
        },
        removal = {
            skills = { { "fabrication", 1 } },
            duration = "15 m",
            using_requirements = { { "vehicle_nail_removal", 1 } },
        },
        repair = {
            skills = { { "fabrication", 2 } },
            duration = "30 m",
            using_requirements = { { "adhesive", 2 } },
        },
    },
    damage_reduction = { all = 5 },
}

ccb.content.define_vehicle_part {
    id = "frame_wood_deck",
    copy_from = "frame_abstract",
    item = "frame_wood_deck",
    looks_like = "frame_wood",
    folded_volume = "2500 ml",
    folding_time = "0 seconds",
    unfolding_time = "0 seconds",
    categories = { "hull" },
    durability = 100,
    description = ccb.content.text("A small skateboard frame made of thin layers of wood glued together.  Other skateboard components can be mounted on it."),
    power = "360 W",
    muscle_power_factor = 60,
    fuel_type = "muscle",
    m2c = 45,
    breaks_into = { { item = "splinter", count = { 3, 5 } } },
    requirements = {
        install = { skills = { { "fabrication", 0 } }, duration = "0 m" },
        removal = { skills = { { "fabrication", 0 } }, duration = "0 m" },
        repair = {
            skills = { { "fabrication", 0 } },
            duration = "5 m",
            using_requirements = { { "adhesive", 1 } },
        },
    },
    extend = {
        flags = {
            "MOUNTABLE",
            "INITIAL_PART",
            "SEAT",
            "NONBELTABLE",
            "SEAT_REQUIRES_BALANCE",
            "BOARDABLE",
            "ENGINE",
            "E_STARTS_INSTANTLY",
            "MUSCLE_LEGS",
            "CONTROLS",
        },
    },
    damage_reduction = { all = 2 },
}

ccb.content.define_vehicle_part {
    id = "frame_wood_light",
    copy_from = "frame_abstract",
    item = "frame_wood_light",
    color = "brown",
    broken_color = "brown",
    durability = 100,
    description = ccb.content.text("A small frame made of a few pieces of wood, held together by rope.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size.  Wood and rope constructions means it can be constructed and added to the vehicle without welding tools or nails."),
    breaks_into = { { item = "splinter", count = { 3, 5 } }, { item = "string_36", count = { 10, 15 } } },
    requirements = {
        install = {
            skills = { { "fabrication", 0 } },
            duration = "10 m",
            using_requirements = { { "rope_natural_short", 1 } },
        },
        repair = {
            skills = { { "fabrication", 0 } },
            duration = "5 m",
            using_requirements = { { "adhesive", 1 } },
        },
        removal = { duration = "5 m" },
    },
    damage_reduction = { all = 4 },
}

-- doubled weld costs and bolts over standard frames for redundant fail points
ccb.content.define_vehicle_part {
    id = "hdframe",
    copy_from = "frame_abstract",
    item = "hdframe",
    color = "dark_gray",
    durability = 760,
    description = ccb.content.text("A large, reinforced steel frame, used in military vehicle construction.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size.  Increased mass makes it more resistant to damage in collisions."),
    breaks_into = "ig_vp_hdframe",
    requirements = {
        install = {
            skills = { { "mechanics", 3 } },
            duration = "120 m",
            using_requirements = { { "welding_standard", 400 }, { "vehicle_bolt_install", 4 } },
        },
        removal = {
            skills = { { "mechanics", 1 } },
            duration = "30 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 3 } },
            duration = "18 m",
            using_requirements = { { "repair_welding_lc_steel", 10 } },
        },
    },
    damage_reduction = { all = 30 },
}

-- assuming about 50 cm square for a frame's welds
ccb.content.define_vehicle_part {
    id = "xlframe",
    copy_from = "frame_abstract",
    item = "xlframe",
    durability = 150,
    description = ccb.content.text("A small, lightweight frame made from pipework.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size."),
    breaks_into = {
        { item = "material_aluminium_ingot", count = { 1, 4 } },
        { item = "scrap_aluminum", count = { 3, 10 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_alloys", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "9 m",
            using_requirements = { { "repair_welding_alloys", 5 } },
        },
    },
    damage_reduction = { all = 7 },
}

-- assuming about 50 cm square for a frame's welds
ccb.content.define_vehicle_part {
    id = "foldxlframe",
    copy_from = "frame_abstract",
    name = ccb.content.text("foldable extra-light frame"),
    item = "foldxlframe",
    durability = 150,
    description = ccb.content.text("A small, lightweight frame made from pipework.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size.  If all the frames and components of a vehicle are foldable, the vehicle can be folding into a small package and picked up as a normal item."),
    folded_volume = "2500 ml",
    breaks_into = {
        { item = "material_aluminium_ingot", count = { 1, 4 } },
        { item = "scrap_aluminum", count = { 3, 10 } },
    },
    requirements = {
        install = {
            skills = { { "mechanics", 1 } },
            duration = "60 m",
            using_requirements = { { "welding_alloys", 200 }, { "vehicle_bolt_install", 2 } },
        },
        removal = {
            skills = { { "mechanics", 2 } },
            duration = "10 m",
            using_requirements = { { "vehicle_weld_removal", 1 }, { "vehicle_wrench_2", 1 } },
        },
        repair = {
            skills = { { "mechanics", 2 } },
            duration = "9 m",
            using_requirements = { { "repair_welding_alloys", 5 } },
        },
    },
    damage_reduction = { all = 7 },
}

ccb.content.define_vehicle_part {
    id = "frame_concrete_mix",
    copy_from = "frame_abstract",
    item = "frame_concrete_mix",
    durability = 150,
    folded_volume = "10 L",
    breaks_into = { { item = "lc_steel_chunk", count = { 1, 4 } }, { item = "scrap", count = { 5, 25 } } },
    extend = { flags = { "NO_INSTALL_HIDDEN", "CABLE_PORTS" } },
    damage_reduction = { all = 7 },
}
