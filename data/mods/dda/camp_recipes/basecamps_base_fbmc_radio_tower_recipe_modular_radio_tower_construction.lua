local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_radio_tower_1_controls_room_construction",
    result = "faction_base_radio_tower_1_controls_room_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so wall over the windows in the radio control room."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_controls_room_construction",
        name = content.text("barricade radio control room"),
        provides = {
            { id = "fbmc_radio_tower_controls_room" },
            { id = "fbmc_radio_tower" },
        },
        requires = {
            { id = "fbmc_radio_tower_1" },
        },
        excludes = {
            { id = "fbmc_radio_tower_controls_room" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmc_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmc_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmc_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmc_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmc_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmc_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmc_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_construction_shack_0",
    result = "faction_base_radio_tower_construction_shack_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build a shack inside the radio tower."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_construction_shack_0",
        name = content.text("shack"),
        provides = {
            { id = "fbmc_radio_tower_shack_0" },
        },
        requires = {
            { id = "fbmc_radio_tower" },
        },
        excludes = {
            { id = "fbmc_radio_tower_shack_0" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmc_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmc_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmc_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmc_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmc_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmc_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmc_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_construction_shack_1",
    result = "faction_base_radio_tower_construction_shack_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build a shack on the northeast side of the camp."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_construction_shack_1",
        name = content.text("northeast shack"),
        provides = {
            { id = "fbmc_radio_tower_shack_1" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_0" },
        },
        excludes = {
            { id = "fbmc_radio_tower_shack_1" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmc_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmc_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmc_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmc_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmc_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmc_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmc_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_construction_shack_2",
    result = "faction_base_radio_tower_construction_shack_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build a shack on the southwest corner of the camp."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_construction_shack_2",
        name = content.text("southwest shack"),
        provides = {
            { id = "fbmc_radio_tower_shack_2" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_1" },
            { id = "fbmc_radio_tower_0" },
        },
        excludes = {
            { id = "fbmc_radio_tower_shack_2" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmc_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmc_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmc_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmc_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmc_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmc_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmc_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_construction_shack_3",
    result = "faction_base_radio_tower_construction_shack_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build a shack on the southwest side of the camp."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_construction_shack_3",
        name = content.text("southwest shack"),
        provides = {
            { id = "fbmc_radio_tower_shack_3" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_2" },
        },
        excludes = {
            { id = "fbmc_radio_tower_shack_3" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmc_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmc_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmc_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmc_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmc_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmc_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmc_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_construction_shack_4",
    result = "faction_base_radio_tower_construction_shack_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build a shack on the southeast side of the camp."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_construction_shack_4",
        name = content.text("southeast shack"),
        provides = {
            { id = "fbmc_radio_tower_shack_4" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_3" },
        },
        excludes = {
            { id = "fbmc_radio_tower_shack_4" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmc_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmc_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmc_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmc_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmc_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmc_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmc_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_construction_shack_5",
    result = "faction_base_radio_tower_construction_shack_5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build a shack on the southeast corner of the camp."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_construction_shack_5",
        name = content.text("southeast shack"),
        provides = {
            { id = "fbmc_radio_tower_shack_5" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_4" },
        },
        excludes = {
            { id = "fbmc_radio_tower_shack_5" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmc_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmc_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmc_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmc_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmc_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmc_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmc_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_construction_shack_6",
    result = "faction_base_radio_tower_construction_shack_6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build a shack on the southeast corner of the camp."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_construction_shack_6",
        name = content.text("southeast shack"),
        provides = {
            { id = "fbmc_radio_tower_shack_6" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_1" },
            { id = "fbmc_radio_tower_1" },
        },
        excludes = {
            { id = "fbmc_radio_tower_shack_6" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmc_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmc_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmc_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmc_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmc_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmc_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmc_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_construction_shack_7",
    result = "faction_base_radio_tower_construction_shack_7",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build a shack on the southwest corner of the camp."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_construction_shack_7",
        name = content.text("southwest shack"),
        provides = {
            { id = "fbmc_radio_tower_shack_7" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_6" },
        },
        excludes = {
            { id = "fbmc_radio_tower_shack_7" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmc_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmc_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmc_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmc_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmc_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmc_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmc_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_radio_tower_construction_shack_8",
    result = "faction_base_radio_tower_construction_shack_8",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so build a shack roof on the south side of the camp."),
}
    :camp_blueprint {
        update = "fbmc_radio_tower_construction_shack_8",
        name = content.text("south shack"),
        provides = {
            { id = "fbmc_radio_tower_shack_8" },
        },
        requires = {
            { id = "fbmc_radio_tower_shack_7" },
        },
        excludes = {
            { id = "fbmc_radio_tower_shack_8" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmc_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmc_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmc_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmc_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmc_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmc_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmc_wood_palette"] = content.text("Wooden walls and wooden roof"),
            },
        },
    }
)
