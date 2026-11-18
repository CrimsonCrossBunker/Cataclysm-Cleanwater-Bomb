local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_modular_livestock_coop_construction_northeast",
    result = "faction_base_modular_livestock_coop_construction_northeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a coop to contain our chickens and other birds, so build a shack on the northeast side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_coop_construction_northeast",
        name = content.text("northeast coop"),
        provides = {
            { id = "fbml_northeast" },
            { id = "chicken_coop" },
        },
        requires = {
            { id = "fbml_0" },
        },
        excludes = {
            { id = "fbml_northeast" },
        },
        parameter_labels = {
            ["fbml_construction_palette"] = {
                ["fbml_concrete_palette"] = content.text("Concrete walls"),
                ["fbml_log_palette"] = content.text("Log walls"),
                ["fbml_metal_palette"] = content.text("Metal walls"),
                ["fbml_migo_resin_palette"] = content.text("Mi-go resin walls"),
                ["fbml_rammed_earth_palette"] = content.text("Rammed earth walls"),
                ["fbml_rock_palette"] = content.text("Rock walls"),
                ["fbml_wad_palette"] = content.text("Wattle-and-daub walls"),
                ["fbml_wood_palette"] = content.text("Wooden walls"),
                ["fbml_brick_palette"] = content.text("Brick walls"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_livestock_shack_construction_southeast",
    result = "faction_base_modular_livestock_shack_construction_southeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a storage room for feed, animal gear and tools, so build a shack on the southeast side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_shack_construction_southeast",
        name = content.text("southeast storage room"),
        provides = {
            { id = "fbml_southeast" },
        },
        requires = {
            { id = "fbml_0" },
        },
        excludes = {
            { id = "fbml_southeast" },
        },
        parameter_labels = {
            ["fbml_construction_palette"] = {
                ["fbml_concrete_palette"] = content.text("Concrete walls"),
                ["fbml_log_palette"] = content.text("Log walls"),
                ["fbml_metal_palette"] = content.text("Metal walls"),
                ["fbml_migo_resin_palette"] = content.text("Mi-go resin walls"),
                ["fbml_rammed_earth_palette"] = content.text("Rammed earth walls"),
                ["fbml_rock_palette"] = content.text("Rock walls"),
                ["fbml_wad_palette"] = content.text("Wattle-and-daub walls"),
                ["fbml_wood_palette"] = content.text("Wooden walls"),
                ["fbml_brick_palette"] = content.text("Brick walls"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_livestock_stable0_construction_southwest",
    result = "faction_base_modular_livestock_stable0_construction_southwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use a stable for larger livestock, so build a stable on the southwest side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_stable0_construction_southwest",
        name = content.text("southwest stable"),
        provides = {
            { id = "fbml_southwest" },
            { id = "stables" },
        },
        requires = {
            { id = "fbml_0" },
        },
        excludes = {
            { id = "fbml_southwest" },
        },
        parameter_labels = {
            ["fbml_construction_palette"] = {
                ["fbml_concrete_palette"] = content.text("Concrete walls"),
                ["fbml_log_palette"] = content.text("Log walls"),
                ["fbml_metal_palette"] = content.text("Metal walls"),
                ["fbml_migo_resin_palette"] = content.text("Mi-go resin walls"),
                ["fbml_rammed_earth_palette"] = content.text("Rammed earth walls"),
                ["fbml_rock_palette"] = content.text("Rock walls"),
                ["fbml_wad_palette"] = content.text("Wattle-and-daub walls"),
                ["fbml_wood_palette"] = content.text("Wooden walls"),
                ["fbml_brick_palette"] = content.text("Brick walls"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_livestock_stable1_construction_west",
    result = "faction_base_modular_livestock_stable1_construction_west",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use an expansion for the stable, so build 2 more stalls on the west side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_stable1_construction_west",
        name = content.text("west stable"),
        provides = {
            { id = "fbml_west" },
        },
        requires = {
            { id = "fbml_southwest" },
        },
        excludes = {
            { id = "fbml_west" },
        },
        parameter_labels = {
            ["fbml_construction_palette"] = {
                ["fbml_concrete_palette"] = content.text("Concrete walls"),
                ["fbml_log_palette"] = content.text("Log walls"),
                ["fbml_metal_palette"] = content.text("Metal walls"),
                ["fbml_migo_resin_palette"] = content.text("Mi-go resin walls"),
                ["fbml_rammed_earth_palette"] = content.text("Rammed earth walls"),
                ["fbml_rock_palette"] = content.text("Rock walls"),
                ["fbml_wad_palette"] = content.text("Wattle-and-daub walls"),
                ["fbml_wood_palette"] = content.text("Wooden walls"),
                ["fbml_brick_palette"] = content.text("Brick walls"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_livestock_stable2_construction_northwest",
    result = "faction_base_modular_livestock_stable2_construction_northwest",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could use an expansion for the stable, so build 2 more stalls on the northwest side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_stable2_construction_northwest",
        name = content.text("northwest stable"),
        provides = {
            { id = "fbml_northwest" },
        },
        requires = {
            { id = "fbml_west" },
        },
        excludes = {
            { id = "fbml_northwest" },
        },
        parameter_labels = {
            ["fbml_construction_palette"] = {
                ["fbml_concrete_palette"] = content.text("Concrete walls"),
                ["fbml_log_palette"] = content.text("Log walls"),
                ["fbml_metal_palette"] = content.text("Metal walls"),
                ["fbml_migo_resin_palette"] = content.text("Mi-go resin walls"),
                ["fbml_rammed_earth_palette"] = content.text("Rammed earth walls"),
                ["fbml_rock_palette"] = content.text("Rock walls"),
                ["fbml_wad_palette"] = content.text("Wattle-and-daub walls"),
                ["fbml_wood_palette"] = content.text("Wooden walls"),
                ["fbml_brick_palette"] = content.text("Brick walls"),
            },
        },
    }
)
