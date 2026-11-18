local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "research_biochemistry_chemistry_set",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_SCIENCE",
    name = content.text("biochemistry"),
    description = content.text("Researching the chemical properties of dangerous blood from mutated creatures.  It also gives a slight insight into the vulnerabilities these substances cause to the monsters."),
    skill = "chemistry",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool_charges("chemistry_set", 50)
    :component_any({
            { id = "blood_acid", count = 1 },
            { id = "blood_acid_insect", count = 1 },
            { id = "blood_acid_plant", count = 1 },
            { id = "blood_acid_underground", count = 1 }
        })
    :learn_automatically("chemistry", 5)
    :proficiency("prof_intro_biology", { required = true })
    :proficiency("prof_organic_chemistry", { required = true })
    :proficiency("prof_biochemistry", { time_multiplier = 1, skill_penalty = 0 })
)

content.add(content.Recipe {
    id = "research_biochemistry_chemistry_set_basic",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_SCIENCE",
    name = content.text("biochemistry"),
    description = content.text("Researching the chemical properties of dangerous blood from mutated creatures.  It also gives a slight insight into the vulnerabilities these substances cause to the monsters."),
    skill = "chemistry",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :tool("chemistry_set_basic", 1)
    :tool_charges("surface_heat", 60, true)
    :component_any({
            { id = "blood_acid", count = 1 },
            { id = "blood_acid_insect", count = 1 },
            { id = "blood_acid_plant", count = 1 },
            { id = "blood_acid_underground", count = 1 }
        })
    :learn_automatically("chemistry", 5)
    :proficiency("prof_intro_biology", { required = true })
    :proficiency("prof_organic_chemistry", { required = true })
    :proficiency("prof_biochemistry", { time_multiplier = 1, skill_penalty = 0 })
)
