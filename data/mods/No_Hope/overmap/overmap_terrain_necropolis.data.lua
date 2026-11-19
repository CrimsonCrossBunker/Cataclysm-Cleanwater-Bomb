local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    abstract = "generic_necropolis_surface_building",
    name = ccb.content.text("city building"),
    symbol = "^",
    see_cost = "high",
    monster_density = 2,
    flags = { "SIDEWALK", "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = {
        "necropolis_a_1", "necropolis_a_18", "necropolis_a_27", "necropolis_a_3", "necropolis_a_36",
        "necropolis_a_4", "necropolis_a_45", "necropolis_a_72", "necropolis_a_73", "necropolis_a_80",
        "necropolis_a_81", "necropolis_a_9",
    },
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("field"),
    symbol = ".",
    color = "brown",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_2",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("house"),
    symbol = "v",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_10",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("house"),
    symbol = ">",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_a_54", "necropolis_a_63" },
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("house"),
    symbol = "<",
    color = "light_green",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_5",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("abandoned store"),
    symbol = ">",
    color = "h_dark_gray",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_necropolis_road",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("road"),
    color = "dark_gray",
    extras = "road",
    flags = { "SHOULD_NOT_SPAWN" },
}

ccb.content.define_overmap_terrain {
    id = {
        "necropolis_a_19", "necropolis_a_56", "necropolis_a_58", "necropolis_a_60", "necropolis_a_61",
        "necropolis_a_76",
    },
    copy_from = "generic_necropolis_road",
    name = ccb.content.text("lot"),
    symbol = "O",
}

ccb.content.define_overmap_terrain {
    id = {
        "necropolis_a_11", "necropolis_a_62", "necropolis_a_59", "necropolis_a_53", "necropolis_a_50",
        "necropolis_a_47", "necropolis_a_31", "necropolis_a_15",
    },
    copy_from = "generic_necropolis_road",
    symbol = "│",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_a_6", "necropolis_a_77" },
    copy_from = "generic_necropolis_road",
    symbol = "│",
    delete = { flags = { "SIDEWALK" } },
}

ccb.content.define_overmap_terrain {
    id = {
        "necropolis_a_21", "necropolis_a_23", "necropolis_a_25", "necropolis_a_39", "necropolis_a_42",
        "necropolis_a_43", "necropolis_a_66", "necropolis_a_67", "necropolis_a_69", "necropolis_a_70",
    },
    copy_from = "generic_necropolis_road",
    symbol = "─",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_64",
    copy_from = "generic_necropolis_road",
    symbol = "─",
    delete = { flags = { "SIDEWALK" } },
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_20",
    copy_from = "generic_necropolis_road",
    symbol = "└",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_a_22", "necropolis_a_41" },
    copy_from = "generic_necropolis_road",
    symbol = "┬",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_a_24", "necropolis_a_40", "necropolis_a_65" },
    copy_from = "generic_necropolis_road",
    symbol = "┴",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_26",
    copy_from = "generic_necropolis_road",
    symbol = "┐",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_44",
    copy_from = "generic_necropolis_road",
    symbol = "┤",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_68",
    copy_from = "generic_necropolis_road",
    symbol = "┼",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_71",
    copy_from = "generic_necropolis_road",
    symbol = "┘",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_a_7", "necropolis_a_8" },
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("pump station"),
    symbol = "P",
    color = "red",
    extend = { flags = { "KNOWN_DOWN" } },
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_12",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("gardening store"),
    symbol = "<",
    color = "light_green_yellow",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_13",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("salon"),
    symbol = "S",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_a_14", "necropolis_a_35", "necropolis_a_38" },
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("crater"),
    symbol = "O",
    color = "red",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_16",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("police station"),
    symbol = "<",
    color = "h_yellow",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_17",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("police station"),
    symbol = "v",
    color = "h_yellow",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_a_28", "necropolis_a_29" },
    name = ccb.content.text("grocery store"),
    copy_from = "generic_necropolis_surface_building",
    color = "green",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_30",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("park"),
    symbol = "O",
    color = "green",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_a_32", "necropolis_a_33" },
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("church"),
    symbol = "C",
    color = "light_red",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_34",
    name = ccb.content.text("pawn shop"),
    copy_from = "generic_necropolis_surface_building",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_37",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("furniture store"),
    symbol = ">",
    color = "i_brown",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_46",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("clothing store"),
    symbol = ">",
    color = "blue",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_a_48", "necropolis_a_49", "necropolis_a_55", "necropolis_a_57" },
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("motel"),
    symbol = "m",
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_51",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("restaurant"),
    symbol = "<",
    color = "pink",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_52",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("bank"),
    symbol = "$",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_74",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("bar"),
    color = "i_magenta",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_75",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("fast food restaurant"),
    color = "yellow_magenta",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_78",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("gas station"),
    color = "light_blue",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_a_79",
    copy_from = "generic_necropolis_surface_building",
    name = ccb.content.text("garage"),
    symbol = "O",
    color = "white",
}

ccb.content.define_overmap_terrain {
    abstract = "generic_necropolis_underground",
    name = ccb.content.text("underground"),
    color = "yellow",
    see_cost = "opaque",
    monster_density = 2,
    flags = { "SHOULD_NOT_SPAWN" },
}

-- xxx Bookmark for necropolis sewers
ccb.content.define_overmap_terrain {
    id = {
        "necropolis_b_1", "necropolis_b_10", "necropolis_b_13", "necropolis_b_14", "necropolis_b_16",
        "necropolis_b_18", "necropolis_b_19", "necropolis_b_2", "necropolis_b_27", "necropolis_b_3",
        "necropolis_b_30", "necropolis_b_32", "necropolis_b_33", "necropolis_b_36", "necropolis_b_4",
        "necropolis_b_45", "necropolis_b_52", "necropolis_b_55", "necropolis_b_60", "necropolis_b_61",
        "necropolis_b_63", "necropolis_b_72", "necropolis_b_73", "necropolis_b_74", "necropolis_b_75",
        "necropolis_b_76", "necropolis_b_80", "necropolis_b_81", "necropolis_b_9",
    },
    copy_from = "generic_necropolis_underground",
    name = ccb.content.text("solid earth"),
    looks_like = "solid_earth",
    symbol = "#",
    color = "brown",
}

-- xxx Bookmark for necropolis sewers
ccb.content.define_overmap_terrain {
    id = {
        "necropolis_c_19", "necropolis_c_46", "necropolis_c_55", "necropolis_c_73", "necropolis_d_10",
        "necropolis_d_37", "necropolis_d_73", "necropolis_d_8",
    },
    copy_from = "generic_necropolis_underground",
    name = ccb.content.text("solid rock"),
    looks_like = "empty_rock",
    symbol = "%",
    color = "dark_gray",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_b_28", "necropolis_b_37" },
    copy_from = "generic_necropolis_underground",
    name = ccb.content.text("cavern"),
    symbol = "0",
    color = "light_gray",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_b_29",
    copy_from = "generic_necropolis_underground",
    name = ccb.content.text("sewer?"),
    symbol = "┼",
    color = "green",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_b_34", "necropolis_b_54" },
    copy_from = "generic_necropolis_underground",
    name = ccb.content.text("basement"),
    symbol = "O",
    color = "dark_gray",
}

ccb.content.define_overmap_terrain {
    id = {
        "necropolis_b_11", "necropolis_b_12", "necropolis_b_15", "necropolis_b_17", "necropolis_b_20",
        "necropolis_b_21", "necropolis_b_22", "necropolis_b_23", "necropolis_b_24", "necropolis_b_25",
        "necropolis_b_26", "necropolis_b_31", "necropolis_b_35", "necropolis_b_38", "necropolis_b_39",
        "necropolis_b_40", "necropolis_b_41", "necropolis_b_42", "necropolis_b_43", "necropolis_b_44",
        "necropolis_b_46", "necropolis_b_47", "necropolis_b_48", "necropolis_b_49", "necropolis_b_5",
        "necropolis_b_50", "necropolis_b_51", "necropolis_b_53", "necropolis_b_56", "necropolis_b_57",
        "necropolis_b_58", "necropolis_b_59", "necropolis_b_6", "necropolis_b_62", "necropolis_b_64",
        "necropolis_b_65", "necropolis_b_66", "necropolis_b_67", "necropolis_b_68", "necropolis_b_69",
        "necropolis_b_7", "necropolis_b_70", "necropolis_b_71", "necropolis_b_77", "necropolis_b_78",
        "necropolis_b_79", "necropolis_b_8",
    },
    copy_from = "generic_necropolis_underground",
    name = ccb.content.text("sewer"),
    symbol = "┼",
    color = "green",
}

ccb.content.define_overmap_terrain {
    id = {
        "necropolis_c_22", "necropolis_c_24", "necropolis_c_28", "necropolis_c_30", "necropolis_c_31",
        "necropolis_c_32", "necropolis_c_33", "necropolis_c_34", "necropolis_c_35", "necropolis_c_36",
        "necropolis_c_37", "necropolis_c_41", "necropolis_c_45", "necropolis_c_49", "necropolis_c_50",
        "necropolis_c_54", "necropolis_c_56", "necropolis_c_57", "necropolis_c_58", "necropolis_c_59",
        "necropolis_c_60", "necropolis_c_61", "necropolis_c_62", "necropolis_c_63", "necropolis_d_11",
        "necropolis_d_12", "necropolis_d_13", "necropolis_d_14", "necropolis_d_15", "necropolis_d_16",
        "necropolis_d_18", "necropolis_d_24", "necropolis_d_26", "necropolis_d_40", "necropolis_d_45",
        "necropolis_d_47", "necropolis_d_51", "necropolis_d_53", "necropolis_d_60", "necropolis_d_62",
        "necropolis_d_69", "necropolis_d_70", "necropolis_d_71", "necropolis_d_72", "necropolis_d_74",
        "necropolis_d_76", "necropolis_d_79", "necropolis_d_81",
    },
    copy_from = "generic_necropolis_underground",
    name = ccb.content.text("Vault - Passage"),
    symbol = "┼",
    color = "white",
}

ccb.content.define_overmap_terrain {
    id = {
        "necropolis_c_1", "necropolis_c_10", "necropolis_c_11", "necropolis_c_12", "necropolis_c_3",
        "necropolis_c_4",
    },
    name = ccb.content.text("Vault - Barracks"),
    symbol = "B",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_c_2",
    name = ccb.content.text("Vault - Armory"),
    symbol = "A",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = {
        "necropolis_c_5", "necropolis_c_15", "necropolis_c_16", "necropolis_c_6", "necropolis_c_7",
        "necropolis_c_8", "necropolis_d_6", "necropolis_d_7",
    },
    name = ccb.content.text("Vault - Hospital"),
    symbol = "H",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_c_9",
    name = ccb.content.text("Vault - Jail"),
    symbol = "J",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_c_13", "necropolis_c_14" },
    name = ccb.content.text("Vault - Offices"),
    symbol = "O",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_c_17", "necropolis_c_18", "necropolis_c_26", "necropolis_c_27" },
    name = ccb.content.text("Vault - Police Station"),
    symbol = "P",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_c_20", "necropolis_c_29" },
    name = ccb.content.text("Vault - Entrance"),
    symbol = "E",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_c_21",
    name = ccb.content.text("Vault - Utilities"),
    symbol = "U",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_c_23",
    name = ccb.content.text("Vault - Communications"),
    symbol = "C",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_c_25",
    name = ccb.content.text("Vault - Courthouse"),
    symbol = "C",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_c_38", "necropolis_c_39", "necropolis_c_47", "necropolis_c_48" },
    name = ccb.content.text("Vault - Motor Pool"),
    symbol = "M",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_c_40",
    name = ccb.content.text("Vault - Visitor Center"),
    symbol = "V",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_c_42", "necropolis_c_43", "necropolis_c_44" },
    name = ccb.content.text("Vault - Control"),
    symbol = "X",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_c_51", "necropolis_c_52", "necropolis_c_53" },
    name = ccb.content.text("Vault - Cafeteria"),
    symbol = "C",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = {
        "necropolis_c_64", "necropolis_c_65", "necropolis_c_66", "necropolis_c_67", "necropolis_c_74",
        "necropolis_c_75", "necropolis_c_76", "necropolis_c_77", "necropolis_c_78", "necropolis_c_79",
    },
    name = ccb.content.text("Vault - School"),
    symbol = "S",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = {
        "necropolis_c_68", "necropolis_c_69", "necropolis_c_70", "necropolis_c_71", "necropolis_c_72",
        "necropolis_c_80", "necropolis_c_81",
    },
    name = ccb.content.text("Vault - Labs"),
    symbol = "L",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_d_1", "necropolis_d_2" },
    name = ccb.content.text("Vault - Robotics Bay"),
    symbol = "R",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_d_3", "necropolis_d_4", "necropolis_d_5", "necropolis_d_54", "necropolis_d_63" },
    name = ccb.content.text("Vault - Slum Housing"),
    symbol = "h",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_d_9", "necropolis_d_17" },
    name = ccb.content.text("Vault - Suites"),
    symbol = "h",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = {
        "necropolis_d_19", "necropolis_d_20", "necropolis_d_25", "necropolis_d_28", "necropolis_d_29",
        "necropolis_d_46", "necropolis_d_55", "necropolis_d_56", "necropolis_d_64", "necropolis_d_65",
    },
    name = ccb.content.text("Vault - Living Bays"),
    symbol = "h",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = {
        "necropolis_d_21", "necropolis_d_22", "necropolis_d_23", "necropolis_d_30", "necropolis_d_31",
        "necropolis_d_32", "necropolis_d_33", "necropolis_d_42", "necropolis_d_43", "necropolis_d_44",
        "necropolis_d_48", "necropolis_d_49", "necropolis_d_50", "necropolis_d_57", "necropolis_d_58",
        "necropolis_d_59", "necropolis_d_34", "necropolis_d_35", "necropolis_d_66", "necropolis_d_67",
        "necropolis_d_68",
    },
    name = ccb.content.text("Vault - Housing"),
    symbol = "h",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_d_27", "necropolis_d_36" },
    name = ccb.content.text("Vault - Transition Bay"),
    symbol = "T",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_d_38", "necropolis_d_39" },
    -- not a period
    name = ccb.content.text("Vault - Maint. Bay"),
    symbol = "M",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_d_41",
    name = ccb.content.text("Vault - Quartermasters"),
    symbol = "Q",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_d_52",
    name = ccb.content.text("Vault - Kitchen"),
    symbol = "K",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_d_61",
    name = ccb.content.text("Vault - Conference Room"),
    symbol = "C",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_d_75",
    name = ccb.content.text("Vault - Library"),
    symbol = "L",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = { "necropolis_d_77", "necropolis_d_78" },
    name = ccb.content.text("Vault - Light Industry"),
    symbol = "I",
    copy_from = "generic_necropolis_underground",
}

ccb.content.define_overmap_terrain {
    id = "necropolis_d_80",
    name = ccb.content.text("Vault - Gym"),
    symbol = "G",
    copy_from = "generic_necropolis_underground",
}
