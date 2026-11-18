local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "fbmw_2_smithy_1_construction",
    result = "fbmw_2_smithy_1_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We can use a smithy.  Let's start by building a spot to protect the workers from the rain."),
}
    :camp_blueprint {
        update = "fbmw_2_smithy_1_construction",
        name = content.text("smithy wall"),
        provides = {
            { id = "fbmw_2_smithy_1" },
            { id = "blacksmith" },
            { id = "fbmw_2_blacksmith_recipes_0" },
        },
        requires = {
            { id = "fbmw_2" },
        },
        excludes = {
            { id = "fbmw_2_smithy_1" },
        },
        parameter_labels = {
            ["fbmw_2_construction_palette"] = {
                ["fbmw_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmw_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_smithy_2_construction",
    result = "fbmw_2_smithy_2_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build a roof with pillars to protect future charcoal kilns from the rain."),
}
    :camp_blueprint {
        update = "fbmw_2_smithy_2_construction",
        name = content.text("charcoal kiln protection"),
        provides = {
            { id = "fbmw_2_smithy_2" },
        },
        requires = {
            { id = "fbmw_2_smithy_1" },
        },
        excludes = {
            { id = "fbmw_2_smithy_2" },
        },
        parameter_labels = {
            ["fbmw_2_construction_palette"] = {
                ["fbmw_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmw_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_smithy_3_construction",
    result = "fbmw_2_smithy_3_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build the final section of the smithy."),
}
    :camp_blueprint {
        update = "fbmw_2_smithy_3_construction",
        name = content.text("final smithy section"),
        provides = {
            { id = "fbmw_2_smithy_3" },
        },
        requires = {
            { id = "fbmw_2_smithy_2" },
        },
        excludes = {
            { id = "fbmw_2_smithy_3" },
        },
        parameter_labels = {
            ["fbmw_2_construction_palette"] = {
                ["fbmw_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmw_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_pottery_construction",
    result = "fbmw_2_pottery_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build a pottery section."),
}
    :camp_blueprint {
        update = "fbmw_2_pottery_construction",
        name = content.text("pottery section"),
        provides = {
            { id = "fbmw_2_pottery" },
        },
        requires = {
            { id = "fbmw_2" },
        },
        excludes = {
            { id = "fbmw_2_pottery" },
        },
        parameter_labels = {
            ["fbmw_2_construction_palette"] = {
                ["fbmw_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmw_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_glassblower_construction",
    result = "fbmw_2_glassblower_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's start building a glassblower's cottage."),
}
    :camp_blueprint {
        update = "fbmw_2_glassblower_construction",
        name = content.text("glassblower's cottage"),
        provides = {
            { id = "fbmw_2_glassblower" },
        },
        requires = {
            { id = "fbmw_2" },
        },
        excludes = {
            { id = "fbmw_2_glassblower" },
        },
        parameter_labels = {
            ["fbmw_2_construction_palette"] = {
                ["fbmw_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmw_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_tanner_construction",
    result = "fbmw_2_tanner_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's start building a tannery cottage."),
}
    :camp_blueprint {
        update = "fbmw_2_tanner_construction",
        name = content.text("tannery cottage"),
        provides = {
            { id = "fbmw_2_tanner" },
        },
        requires = {
            { id = "fbmw_2" },
        },
        excludes = {
            { id = "fbmw_2_tanner" },
        },
        parameter_labels = {
            ["fbmw_2_construction_palette"] = {
                ["fbmw_2_concrete_palette"] = content.text("Concrete walls and roof"),
                ["fbmw_2_log_palette"] = content.text("Log walls and wooden roof"),
                ["fbmw_2_metal_palette"] = content.text("Metal walls and roof"),
                ["fbmw_2_migo_resin_palette"] = content.text("Mi-go resin walls and roof"),
                ["fbmw_2_rammed_earth_palette"] = content.text("Rammed earth walls and sod roof"),
                ["fbmw_2_rock_palette"] = content.text("Rock walls and wooden roof"),
                ["fbmw_2_wad_palette"] = content.text("Wattle-and-daub walls and sod roof"),
                ["fbmw_2_wood_palette"] = content.text("Wooden walls and wooden roof"),
                ["fbmw_2_brick_palette"] = content.text("Brick walls and wooden roof"),
            },
        },
    }
)
