local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_modular_shelter_bedroom1",
    result = "faction_base_modular_shelter_bedroom1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some living quarters so we can expand.  We will start in the southeast corner."),
}
    :camp_blueprint {
        update = "fbmc_shelter_bedroom_se",
        name = content.text("build SE bedroom walls"),
        provides = {
            { id = "fbmc_shelter_bedroom1" },
        },
        requires = {
            { id = "fbmc_shelter_fire" },
        },
        excludes = {
            { id = "fbmc_shelter_bedroom1" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_shelter_palette_log"] = content.text("Log walls"),
                ["fbmc_shelter_palette_rock"] = content.text("Rock walls"),
                ["fbmc_shelter_palette_standard"] = content.text("Standard walls"),
                ["fbmc_shelter_palette_wad"] = content.text("Wattle-and-daub walls"),
                ["fbmc_shelter_palette_wood"] = content.text("Wooden walls"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_bedroom2",
    result = "faction_base_modular_shelter_bedroom2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some living quarters so we can expand.  We will continue along the same wall."),
}
    :camp_blueprint {
        update = "fbmc_shelter_bedroom_e",
        name = content.text("build E bedroom walls"),
        provides = {
            { id = "fbmc_shelter_bedroom2" },
        },
        requires = {
            { id = "fbmc_shelter_bedroom1" },
        },
        excludes = {
            { id = "fbmc_shelter_bedroom2" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_shelter_palette_log"] = content.text("Log walls"),
                ["fbmc_shelter_palette_rock"] = content.text("Rock walls"),
                ["fbmc_shelter_palette_standard"] = content.text("Regular walls"),
                ["fbmc_shelter_palette_wad"] = content.text("Wattle-and-daub walls"),
                ["fbmc_shelter_palette_wood"] = content.text("Wooden walls"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_bedroom3",
    result = "faction_base_modular_shelter_bedroom3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some living quarters so we can expand.  We will continue along the other wall."),
}
    :camp_blueprint {
        update = "fbmc_shelter_bedroom_SW",
        name = content.text("build SW bedroom walls"),
        provides = {
            { id = "fbmc_shelter_bedroom3" },
        },
        requires = {
            { id = "fbmc_shelter_bedroom2" },
        },
        excludes = {
            { id = "fbmc_shelter_bedroom3" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_shelter_palette_log"] = content.text("Log walls"),
                ["fbmc_shelter_palette_rock"] = content.text("Rock walls"),
                ["fbmc_shelter_palette_standard"] = content.text("Regular walls"),
                ["fbmc_shelter_palette_wad"] = content.text("Wattle-and-daub walls"),
                ["fbmc_shelter_palette_wood"] = content.text("Wooden walls"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_bedroom4",
    result = "faction_base_modular_shelter_bedroom4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some living quarters so we can expand.  We will continue along the other wall."),
}
    :camp_blueprint {
        update = "fbmc_shelter_bedroom_W",
        name = content.text("build W bedroom walls"),
        provides = {
            { id = "fbmc_shelter_bedroom4" },
        },
        requires = {
            { id = "fbmc_shelter_bedroom3" },
        },
        excludes = {
            { id = "fbmc_shelter_bedroom4" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_shelter_palette_log"] = content.text("Log walls"),
                ["fbmc_shelter_palette_rock"] = content.text("Rock walls"),
                ["fbmc_shelter_palette_standard"] = content.text("Regular walls"),
                ["fbmc_shelter_palette_wad"] = content.text("Wattle-and-daub walls"),
                ["fbmc_shelter_palette_wood"] = content.text("Wooden walls"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_bedroom5",
    result = "faction_base_modular_shelter_bedroom5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some living quarters so we can expand.  We will continue along the other wall."),
}
    :camp_blueprint {
        update = "fbmc_shelter_bedroom_NW",
        name = content.text("build NW bedroom walls"),
        provides = {
            { id = "fbmc_shelter_bedroom5" },
        },
        requires = {
            { id = "fbmc_shelter_bedroom4" },
        },
        excludes = {
            { id = "fbmc_shelter_bedroom5" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_shelter_palette_log"] = content.text("Log walls"),
                ["fbmc_shelter_palette_rock"] = content.text("Rock walls"),
                ["fbmc_shelter_palette_standard"] = content.text("Regular walls"),
                ["fbmc_shelter_palette_wad"] = content.text("Wattle-and-daub walls"),
                ["fbmc_shelter_palette_wood"] = content.text("Wooden walls"),
            },
        },
    }
)
