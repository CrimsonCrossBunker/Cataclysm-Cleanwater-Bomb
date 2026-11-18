local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_bedroom1",
    result = "faction_base_modular_shelter_1_bedroom1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some living quarters so we can expand.  We will start in the northwest corner."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_bedroom_NW",
        name = content.text("build NW bedroom walls"),
        provides = {
            { id = "fbmc_shelter_1_bedroom1" },
        },
        requires = {
            { id = "fbmc_shelter_1_fire" },
        },
        excludes = {
            { id = "fbmc_shelter_1_bedroom1" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_shelter_1_palette_log"] = content.text("Log walls"),
                ["fbmc_shelter_1_palette_rock"] = content.text("Rock walls"),
                ["fbmc_shelter_1_palette_standard"] = content.text("Standard walls"),
                ["fbmc_shelter_1_palette_wad"] = content.text("Wattle-and-daub walls"),
                ["fbmc_shelter_1_palette_wood"] = content.text("Wooden walls"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_bedroom2",
    result = "faction_base_modular_shelter_1_bedroom2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some living quarters so we can expand.  We will continue along the west wall."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_bedroom_W1",
        name = content.text("build W bedroom walls"),
        provides = {
            { id = "fbmc_shelter_1_bedroom2" },
        },
        requires = {
            { id = "fbmc_shelter_1_bedroom1" },
        },
        excludes = {
            { id = "fbmc_shelter_1_bedroom2" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_shelter_1_palette_log"] = content.text("Log walls"),
                ["fbmc_shelter_1_palette_rock"] = content.text("Rock walls"),
                ["fbmc_shelter_1_palette_standard"] = content.text("Standard walls"),
                ["fbmc_shelter_1_palette_wad"] = content.text("Wattle-and-daub walls"),
                ["fbmc_shelter_1_palette_wood"] = content.text("Wooden walls"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_bedroom3",
    result = "faction_base_modular_shelter_1_bedroom3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some living quarters so we can expand.  We will continue along the same wall."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_bedroom_W2",
        name = content.text("build W bedroom walls"),
        provides = {
            { id = "fbmc_shelter_1_bedroom3" },
        },
        requires = {
            { id = "fbmc_shelter_1_bedroom2" },
        },
        excludes = {
            { id = "fbmc_shelter_1_bedroom3" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_shelter_1_palette_log"] = content.text("Log walls"),
                ["fbmc_shelter_1_palette_rock"] = content.text("Rock walls"),
                ["fbmc_shelter_1_palette_standard"] = content.text("Standard walls"),
                ["fbmc_shelter_1_palette_wad"] = content.text("Wattle-and-daub walls"),
                ["fbmc_shelter_1_palette_wood"] = content.text("Wooden walls"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_bedroom5",
    result = "faction_base_modular_shelter_1_bedroom5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some living quarters so we can expand.  We will continue along the southwest corner."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_bedroom_SW",
        name = content.text("build SW bedroom walls"),
        provides = {
            { id = "fbmc_shelter_1_bedroom5" },
        },
        requires = {
            { id = "fbmc_shelter_1_bedroom3" },
        },
        excludes = {
            { id = "fbmc_shelter_1_bedroom5" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_shelter_1_palette_log"] = content.text("Log walls"),
                ["fbmc_shelter_1_palette_rock"] = content.text("Rock walls"),
                ["fbmc_shelter_1_palette_standard"] = content.text("Standard walls"),
                ["fbmc_shelter_1_palette_wad"] = content.text("Wattle-and-daub walls"),
                ["fbmc_shelter_1_palette_wood"] = content.text("Wooden walls"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_shelter_1_bedroom6",
    result = "faction_base_modular_shelter_1_bedroom6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build some living quarters so we can expand.  We will continue along the south wall."),
}
    :camp_blueprint {
        update = "fbmc_shelter_1_bedroom_S",
        name = content.text("build S bedroom walls"),
        provides = {
            { id = "fbmc_shelter_1_bedroom6" },
        },
        requires = {
            { id = "fbmc_shelter_1_bedroom5" },
        },
        excludes = {
            { id = "fbmc_shelter_1_bedroom6" },
        },
        parameter_labels = {
            ["fbmc_construction_palette"] = {
                ["fbmc_shelter_1_palette_log"] = content.text("Log walls"),
                ["fbmc_shelter_1_palette_rock"] = content.text("Rock walls"),
                ["fbmc_shelter_1_palette_standard"] = content.text("Standard walls"),
                ["fbmc_shelter_1_palette_wad"] = content.text("Wattle-and-daub walls"),
                ["fbmc_shelter_1_palette_wood"] = content.text("Wooden walls"),
            },
        },
    }
)
