local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_pottery_cottage_blacksmith_construction",
    result = "faction_base_pottery_cottage_blacksmith_construction",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a shack for our blacksmith's workshop."),
}
    :camp_blueprint {
        update = "fbmc_pottery_cottage_blacksmith_construction",
        name = content.text("blacksmith workshop"),
        provides = {
            { id = "blacksmith" },
            { id = "fbmc_pottery_cottage_blacksmith_0" },
        },
        requires = {
            { id = "fbmc_pottery_cottage_0" },
        },
        excludes = {
            { id = "fbmc_pottery_cottage_blacksmith_0" },
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
    id = "faction_base_pottery_cottage_blacksmith_1",
    result = "faction_base_pottery_cottage_blacksmith_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a rock forge and a workbench to start smithing."),
}
    :camp_blueprint {
        update = "fbmc_pottery_cottage_blacksmith_1",
        name = content.text("workbench and forge"),
        provides = {
            { id = "blacksmith_recipes_1" },
            { id = "fbmc_pottery_cottage_blacksmith_1" },
        },
        requires = {
            { id = "fbmc_pottery_cottage_blacksmith_0" },
        },
        excludes = {
            { id = "fbmc_pottery_cottage_blacksmith_1" },
        },
        resources = { "fake_forge" },
    }
)

content.add(content.Recipe {
    id = "faction_base_pottery_cottage_blacksmith_2",
    result = "faction_base_pottery_cottage_blacksmith_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a second workbench and a drop hammer for more productive smithing."),
}
    :camp_blueprint {
        update = "fbmc_pottery_cottage_blacksmith_2",
        name = content.text("workbench and drop hammer"),
        provides = {
            { id = "blacksmith_recipes_7" },
            { id = "fbmc_pottery_cottage_blacksmith_2" },
        },
        requires = {
            { id = "fbmc_pottery_cottage_blacksmith_1" },
        },
        excludes = {
            { id = "fbmc_pottery_cottage_blacksmith_2" },
        },
        resources = { "fake_drop_hammer" },
    }
)
