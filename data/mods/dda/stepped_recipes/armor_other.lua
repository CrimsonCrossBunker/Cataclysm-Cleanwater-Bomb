local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- Based off of the quickest internet suggestions, which utilize sewing machines.
-- Cotton balls act as the warm filling material for the quilt. 5L / 25mL per cotton ball = 200 cotton balls
-- as an upper limit
content.add(content.Recipe {
    id = "quilt",
    result = "quilt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("sheet_felt", 33)
    :component("filament", 200, true)
    :component("cotton_ball", 150)
    :learn_automatically("tailor", 2)
    :byproduct("felt_patch", 6)
    :byproduct("scrap_felt", 2)
    :step {
        name = content.text("Cutting the pieces"),
        duration_moves = 1800000,
        activity_level = LIGHT_EXERCISE,
        qualities = {
            { { id = "FABRIC_CUT", level = 1, count = 1 } },
        },
    }
    :step {
        name = content.text("Sewing the pieces together"),
        duration_moves = 1800000,
        activity_level = LIGHT_EXERCISE,
        requirements = {
            { id = "sewing_tool", multiplier = 120 },
        },
        proficiencies = {
            { id = "prof_quilting", required = false, max_experience_turns = 7200 },
        },
    }
    :step {
        name = content.text("Adding the stuffing"),
        duration_moves = 1800000,
        activity_level = LIGHT_EXERCISE,
    }
)
