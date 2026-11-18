local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.replace(content.Recipe { id = "bat", result = "bat", obsolete = true })

content.add(content.Recipe {
    id = "sheet_metal_bronze",
    result = "sheet_metal_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("scrap_bronze", 1)
    :requirement("smelting_standard", 180)
    :step {
        name = content.text("Gather resources and start the process"),
        duration_moves = 6000,
        activity_level = LIGHT_EXERCISE,
    }
    :step {
        name = content.text("Let it melt"),
        duration_moves = 360000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal for the sheet is melted and is ready for the mold."),
    }
    :step {
        name = content.text("Pour it into the mold"),
        duration_moves = 12000,
        activity_level = MODERATE_EXERCISE,
    }
    :step {
        name = content.text("Allow the metal to cool"),
        duration_moves = 540000,
        activity_level = NO_EXERCISE,
        attention = "unattended",
        unattended_message = content.text("The metal is cooling in the mold."),
    }
)

content.add(content.Recipe {
    id = "lamellae_bronze",
    result = "lamellae_bronze",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_MATERIALS",
    autolearn = true,
    skill = "fabrication",
    difficulty = 3,
    result_multiplier = 20,
}
    :component("sheet_metal_bronze", 1)
    :step {
        name = content.text("Drilling holes"),
        duration_moves = 120000,
        activity_level = MODERATE_EXERCISE,
        qualities = {
            { { id = "DRILL", level = 2, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
    :step {
        name = content.text("Sawing the pieces out"),
        duration_moves = 180000,
        activity_level = BRISK_EXERCISE,
        qualities = {
            { { id = "SAW_M_FINE", level = 1, count = 1 } },
        },
        proficiencies = {
            { id = "prof_metalworking" },
        },
    }
)
