local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "fbmh_0_room_1_1",
    result = "fbmh_0_room_1_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build half of a shack with a roof on the northeast side of the camp."),
}
    :camp_blueprint {
        update = "fbmh_0_room_NE_1",
        name = content.text("northeast shack"),
        provides = {
            { id = "fbmh_northeast" },
            { id = "fbmh_shack_northeast" },
        },
        requires = {
            { id = "fbmh_0" },
        },
        excludes = {
            { id = "fbmh_northeast" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_room_1_2",
    result = "fbmh_0_room_1_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand the shack so we have space for another bed."),
}
    :camp_blueprint {
        update = "fbmh_0_room_NE_2",
        name = content.text("expand northeast shack"),
        provides = {
            { id = "fbmh_northeast" },
        },
        requires = {
            { id = "fbmh_northeast" },
        },
        excludes = {
            { id = "fbmh_northeast", amount = 2 },
            { id = "fbmh_tent_northeast" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_room_1_3",
    result = "fbmh_0_room_1_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should finish the northeast shack."),
}
    :camp_blueprint {
        update = "fbmh_0_room_NE_3",
        name = content.text("finish northeast shack"),
        provides = {
            { id = "fbmh_northeast", amount = 2 },
        },
        requires = {
            { id = "fbmh_northeast", amount = 2 },
        },
        excludes = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_tent_northeast" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_shack_2",
    result = "fbmh_0_shack_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by putting up a building on the east side, which we can also use as part of the central building."),
}
    :camp_blueprint {
        update = "fbmh_0_shack_east",
        name = content.text("east shack"),
        provides = {
            { id = "fbmh_east", amount = 4 },
        },
        requires = {
            { id = "fbmh_tent_northeast" },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbmh_east" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_room_2",
    result = "fbmh_0_room_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a room on the east side, which we can also use as part of the central building."),
}
    :camp_blueprint {
        update = "fbmh_0_room_east",
        name = content.text("east room"),
        provides = {
            { id = "fbmh_east", amount = 4 },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbmh_east" },
            { id = "fbmh_tent_northeast" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_shack_southeast",
    result = "fbmh_0_shack_southeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by putting up a building on the southeast side, which we can also use as part of the central building."),
}
    :camp_blueprint {
        update = "fbmh_0_shack_southeast",
        name = content.text("southeast shack"),
        provides = {
            { id = "fbmh_southeast", amount = 4 },
        },
        requires = {
            { id = "fbmh_tent_east" },
        },
        excludes = {
            { id = "fbmh_southeast" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_room_southeast",
    result = "fbmh_0_room_southeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a room on the southeast side, which we can also use as part of the central building."),
}
    :camp_blueprint {
        update = "fbmh_0_room_southeast",
        name = content.text("southeast room"),
        provides = {
            { id = "fbmh_southeast", amount = 4 },
        },
        requires = {
            { id = "fbmh_east", amount = 4 },
        },
        excludes = {
            { id = "fbmh_southeast" },
            { id = "fbmh_tent_east" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_shack_northwest",
    result = "fbmh_0_shack_northwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by putting up a building on the northwest side, which we can also use as part of the central building."),
}
    :camp_blueprint {
        update = "fbmh_0_shack_northwest",
        name = content.text("northwest shack"),
        provides = {
            { id = "fbmh_northwest", amount = 4 },
        },
        requires = {
            { id = "fbmh_northeast", amount = 4 },
            { id = "fbmh_fire_northeast" },
            { id = "fbmh_bed2_northeast" },
        },
        excludes = {
            { id = "fbmh_northwest" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_shack_west",
    result = "fbmh_0_shack_west",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by putting up a building on the west side, which we can also use as part of the central building."),
}
    :camp_blueprint {
        update = "fbmh_0_shack_west",
        name = content.text("west shack"),
        provides = {
            { id = "fbmh_west", amount = 4 },
        },
        requires = {
            { id = "fbmh_tent_northwest" },
        },
        excludes = {
            { id = "fbmh_west" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_room_west",
    result = "fbmh_0_room_west",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a room on the west side, which we can also use as part of the central building."),
}
    :camp_blueprint {
        update = "fbmh_0_room_west",
        name = content.text("west room"),
        provides = {
            { id = "fbmh_west", amount = 4 },
        },
        requires = {
            { id = "fbmh_northwest", amount = 4 },
        },
        excludes = {
            { id = "fbmh_west" },
            { id = "fbmh_tent_northwest" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_shack_southwest",
    result = "fbmh_0_shack_southwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by putting up a building on the southwest side, which we can also use as part of the central building."),
}
    :camp_blueprint {
        update = "fbmh_0_shack_southwest",
        name = content.text("southwest shack"),
        provides = {
            { id = "fbmh_southwest", amount = 4 },
        },
        requires = {
            { id = "fbmh_tent_west" },
        },
        excludes = {
            { id = "fbmh_southwest" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_room_southwest",
    result = "fbmh_0_room_southwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a room on the southwest side, which we can also use as part of the central building."),
}
    :camp_blueprint {
        update = "fbmh_0_room_southwest",
        name = content.text("southwest room"),
        provides = {
            { id = "fbmh_southwest", amount = 4 },
        },
        requires = {
            { id = "fbmh_west", amount = 4 },
        },
        excludes = {
            { id = "fbmh_southwest" },
            { id = "fbmh_tent_west" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_core_shack_ne",
    result = "fbmh_0_core_shack_ne",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a kitchen and dining hall.  We should build the northeast quarter of one."),
}
    :camp_blueprint {
        update = "fbmh_0_core_shack_ne",
        name = content.text("central building NE corner"),
        provides = {
            { id = "fbmh_center", amount = 2 },
            { id = "fbmh_ne_center" },
        },
        requires = {
            { id = "fbmh_tent_east" },
        },
        excludes = {
            { id = "fbmh_ne_center" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_core_room_ne",
    result = "fbmh_0_core_room_ne",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a core and dining hall.  We should build out from the east room."),
}
    :camp_blueprint {
        update = "fbmh_0_core_room_ne",
        name = content.text("central building NE corner"),
        provides = {
            { id = "fbmh_center", amount = 2 },
            { id = "fbmh_ne_center" },
        },
        requires = {
            { id = "fbmh_east", amount = 4 },
        },
        excludes = {
            { id = "fbmh_ne_center" },
            { id = "fbmh_tent_east" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_core_shack_nw",
    result = "fbmh_0_core_shack_nw",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a core and dining hall.  We should build the northwest quarter of one."),
}
    :camp_blueprint {
        update = "fbmh_0_core_shack_nw",
        name = content.text("central building NW corner"),
        provides = {
            { id = "fbmh_center", amount = 2 },
            { id = "fbmh_nw_center" },
        },
        requires = {
            { id = "fbmh_tent_west" },
        },
        excludes = {
            { id = "fbmh_nw_center" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_core_room_nw",
    result = "fbmh_0_core_room_nw",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a core and dining hall.  We should build out from the west room."),
}
    :camp_blueprint {
        update = "fbmh_0_core_room_nw",
        name = content.text("central building NW corner"),
        provides = {
            { id = "fbmh_center", amount = 2 },
            { id = "fbmh_nw_center" },
        },
        requires = {
            { id = "fbmh_west", amount = 4 },
        },
        excludes = {
            { id = "fbmh_nw_center" },
            { id = "fbmh_tent_west" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_core_center_north",
    result = "fbmh_0_core_center_north",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a core and dining hall.  We should build between the east and west rooms."),
}
    :camp_blueprint {
        update = "fbmh_0_core_center_north",
        name = content.text("central building north half"),
        provides = {
            { id = "fbmh_center", amount = 4 },
            { id = "fbmh_ne_center" },
            { id = "fbmh_nw_center" },
        },
        requires = {
            { id = "fbmh_east", amount = 4 },
            { id = "fbmh_west", amount = 4 },
        },
        excludes = {
            { id = "fbmh_ne_center" },
            { id = "fbmh_nw_center" },
            { id = "fbmh_tent_east" },
            { id = "fbmh_tent_west" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_core_shack_se",
    result = "fbmh_0_core_shack_se",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a core and dining hall.  We should build the southeast quarter of one."),
}
    :camp_blueprint {
        update = "fbmh_0_core_shack_se",
        name = content.text("central building SE corner"),
        provides = {
            { id = "fbmh_south", amount = 2 },
            { id = "fbmh_se_south" },
        },
        requires = {
            { id = "fbmh_tent_southeast" },
        },
        excludes = {
            { id = "fbmh_se_south" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_core_room_se",
    result = "fbmh_0_core_room_se",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a core and dining hall.  We should build the southeast quarter of one."),
}
    :camp_blueprint {
        update = "fbmh_0_core_room_se",
        name = content.text("central building SE corner"),
        provides = {
            { id = "fbmh_south", amount = 2 },
            { id = "fbmh_se_south" },
        },
        requires = {
            { id = "fbmh_southeast", amount = 4 },
        },
        excludes = {
            { id = "fbmh_se_south" },
            { id = "fbmh_tent_southeast" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_core_shack_sw",
    result = "fbmh_0_core_shack_sw",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a core and dining hall.  We should build the southwest quarter of one."),
}
    :camp_blueprint {
        update = "fbmh_0_core_shack_sw",
        name = content.text("central building SW corner"),
        provides = {
            { id = "fbmh_south", amount = 2 },
            { id = "fbmh_sw_south" },
        },
        requires = {
            { id = "fbmh_tent_southwest" },
        },
        excludes = {
            { id = "fbmh_sw_south" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_core_room_sw",
    result = "fbmh_0_core_room_sw",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a core and dining hall.  We should build the southwest quarter of one."),
}
    :camp_blueprint {
        update = "fbmh_0_core_room_sw",
        name = content.text("central building SW corner"),
        provides = {
            { id = "fbmh_south", amount = 2 },
            { id = "fbmh_sw_south" },
        },
        requires = {
            { id = "fbmh_southwest", amount = 4 },
        },
        excludes = {
            { id = "fbmh_sw_south" },
            { id = "fbmh_tent_southwest" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmh_0_core_center_south",
    result = "fbmh_0_core_center_south",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("A central building can act as a core and dining hall.  We should build between the southeast and southwest rooms."),
}
    :camp_blueprint {
        update = "fbmh_0_core_center_south",
        name = content.text("central building south half"),
        provides = {
            { id = "fbmh_south", amount = 4 },
            { id = "fbmh_se_south" },
            { id = "fbmh_sw_south" },
        },
        requires = {
            { id = "fbmh_southeast", amount = 4 },
            { id = "fbmh_southwest", amount = 4 },
        },
        excludes = {
            { id = "fbmh_se_south" },
            { id = "fbmh_sw_south" },
            { id = "fbmh_tent_southeast" },
            { id = "fbmh_tent_southwest" },
        },
        parameter_labels = {
            ["fbmh_0_construction_palette"] = {
                ["fbmh_0_adobe_palette"] = content.text("Adobe walls and wooden roof"),
                ["fbmh_0_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmh_0_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmh_0_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmh_0_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmh_0_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmh_0_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmh_0_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmh_0_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)
