local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "fbmh_2_room_1_1",
    result = "fbmh_2_room_1_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build half of a shack with a roof on the northeast side of the camp."),
}
    :camp_blueprint {
        update = "fbmh_2_room_NE_1",
        name = content.text("northeast shack"),
        provides = {
            { id = "fbmh_2_room_NE" },
            { id = "fbmh_2_shack_NE" },
        },
        requires = {
            { id = "fbmh_2" },
        },
        excludes = {
            { id = "fbmh_2_room_NE" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_room_1_2",
    result = "fbmh_2_room_1_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand the shack so we have space for another bed."),
}
    :camp_blueprint {
        update = "fbmh_2_room_NE_2",
        name = content.text("expand northeast shack"),
        provides = {
            { id = "fbmh_2_room_NE" },
        },
        requires = {
            { id = "fbmh_2_room_NE" },
        },
        excludes = {
            { id = "fbmh_2_room_NE", amount = 2 },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_room_1_3",
    result = "fbmh_2_room_1_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should finish the northeast shack."),
}
    :camp_blueprint {
        update = "fbmh_2_room_NE_3",
        name = content.text("finish northeast shack"),
        provides = {
            { id = "fbmh_2_room_NE", amount = 2 },
        },
        requires = {
            { id = "fbmh_2_room_NE", amount = 2 },
        },
        excludes = {
            { id = "fbmh_2_room_NE", amount = 4 },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_room_2",
    result = "fbmh_2_room_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a room north of the center on the east side of the camp."),
}
    :camp_blueprint {
        update = "fbmh_2_room_ENE",
        name = content.text("east north east room"),
        provides = {
            { id = "fbmh_2_room_ENE", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_room_NE", amount = 4 },
        },
        excludes = {
            { id = "fbmh_2_room_ENE" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_room_3",
    result = "fbmh_2_room_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a room south of the center on the east side of the camp."),
}
    :camp_blueprint {
        update = "fbmh_2_room_ESE",
        name = content.text("east south east room"),
        provides = {
            { id = "fbmh_2_room_ESE", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_center_east" },
        },
        excludes = {
            { id = "fbmh_2_room_ESE" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_room_4",
    result = "fbmh_2_room_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a room on the southeast side of the camp."),
}
    :camp_blueprint {
        update = "fbmh_2_room_SE",
        name = content.text("southeast room"),
        provides = {
            { id = "fbmh_2_room_SE", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_room_ESE", amount = 4 },
        },
        excludes = {
            { id = "fbmh_2_room_SE" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_wood_room_5",
    result = "fbmh_2_wood_room_5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a room on the southwest side of the camp."),
}
    :camp_blueprint {
        update = "fbmh_2_room_SW",
        name = content.text("southwest room"),
        provides = {
            { id = "fbmh_2_room_SW", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_room_WSW", amount = 4 },
        },
        excludes = {
            { id = "fbmh_2_room_SW" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_room_6",
    result = "fbmh_2_room_6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a room south of the center on the west side of the camp."),
}
    :camp_blueprint {
        update = "fbmh_2_room_WSW",
        name = content.text("west south west room"),
        provides = {
            { id = "fbmh_2_room_WSW", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_center_west" },
        },
        excludes = {
            { id = "fbmh_2_room_WSW" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_room_7",
    result = "fbmh_2_room_7",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a room north of the center on the west side of the camp."),
}
    :camp_blueprint {
        update = "fbmh_2_room_WNW",
        name = content.text("west north west room"),
        provides = {
            { id = "fbmh_2_room_WNW", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_center_west" },
        },
        excludes = {
            { id = "fbmh_2_room_WNW" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_room_8",
    result = "fbmh_2_room_8",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a room on the northwest side of the camp."),
}
    :camp_blueprint {
        update = "fbmh_2_room_NW",
        name = content.text("northwest room"),
        provides = {
            { id = "fbmh_2_room_NW", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_room_WNW", amount = 4 },
        },
        excludes = {
            { id = "fbmh_2_room_NW" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_center_east",
    result = "fbmh_2_center_east",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a kitchen and dining hall.  We should build the easternmost quarter of it."),
}
    :camp_blueprint {
        update = "fbmh_2_center_east",
        name = content.text("central building, east section"),
        provides = {
            { id = "fbmh_2_center_east" },
        },
        requires = {
            { id = "fbmh_2_room_ENE", amount = 4 },
        },
        excludes = {
            { id = "fbmh_2_center_east" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_center_mideast",
    result = "fbmh_2_center_mideast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a core and dining hall.  We should build the mideastern quarter of it."),
}
    :camp_blueprint {
        update = "fbmh_2_center_mideast",
        name = content.text("central building, mideast section"),
        provides = {
            { id = "fbmh_2_center_mideast" },
        },
        requires = {
            { id = "fbmh_2_center_east" },
        },
        excludes = {
            { id = "fbmh_2_center_mideast" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_center_midwest",
    result = "fbmh_2_center_midwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a core and dining hall.  We should build the midwestern quarter of it."),
}
    :camp_blueprint {
        update = "fbmh_2_center_midwest",
        name = content.text("central building, midwest section"),
        provides = {
            { id = "fbmh_2_center_midwest" },
        },
        requires = {
            { id = "fbmh_2_center_mideast" },
        },
        excludes = {
            { id = "fbmh_2_center_midwest" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_center_west",
    result = "fbmh_2_center_west",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a kitchen and dining hall.  We should build the westernmost quarter of it."),
}
    :camp_blueprint {
        update = "fbmh_2_center_west",
        name = content.text("central building, west section"),
        provides = {
            { id = "fbmh_2_center_west" },
        },
        requires = {
            { id = "fbmh_2_center_midwest" },
        },
        excludes = {
            { id = "fbmh_2_center_west" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_wall_north",
    result = "fbmh_2_wall_north",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A wall to the north provides a protected courtyard."),
}
    :camp_blueprint {
        update = "fbmh_2_courtyard_wall_north",
        name = content.text("courtyard wall north"),
        provides = {
            { id = "fbmh_2_wall_north" },
        },
        requires = {
            { id = "fbmh_2_room_NE" },
            { id = "fbmh_2_room_NW" },
        },
        excludes = {
            { id = "fbmh_2_wall_north" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_2_wall_south",
    result = "fbmh_2_wall_south",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A wall to the south provides a protected courtyard."),
}
    :camp_blueprint {
        update = "fbmh_2_courtyard_wall_south",
        name = content.text("courtyard wall south"),
        provides = {
            { id = "fbmh_2_wall_south" },
        },
        requires = {
            { id = "fbmh_2_room_SE" },
            { id = "fbmh_2_room_SW" },
        },
        excludes = {
            { id = "fbmh_2_wall_south" },
        },
        parameter_labels = {
            ["fbmh_2_construction_palette"] = {
                ["fbmh_2_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)
