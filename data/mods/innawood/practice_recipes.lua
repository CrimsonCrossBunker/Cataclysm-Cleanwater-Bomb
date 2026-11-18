local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "prac_mechanics",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MECHANICS",
    name = content.text("mechanics (beginner)"),
    description = content.text("Practice attaching and detaching wheels to vehicle frames."),
    skill = "mechanics",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :tool_any({
            { id = "foldframe", count = 1 },
            { id = "xlframe", count = 1 },
            { id = "frame", count = 1 },
            { id = "hdframe", count = 1 },
            { id = "hdframe", count = 1 },
            { id = "frame_wood", count = 1 },
            { id = "foldwoodframe", count = 1 },
            { id = "frame_wood_light", count = 1 }
        })
    :tool_any({
            { id = "wheel_wood", count = 1 },
            { id = "wheel_wood_b", count = 1 },
            { id = "wheel", count = 1 },
            { id = "wheel_bicycle", count = 1 }
        })
    :learn_automatically("mechanics", 0)
)

-- Only training weapons or wooden versions of swords, a real katana would be too much to handle correctly at
-- these levels.
-- Some components to mark the striking points for the session.
content.replace(content.Recipe {
    id = "prac_cutting_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("cutting (beginner)"),
    description = content.text("Practice the use of the sword and similar weapons against a training dummy.  You will need something to mark the striking points while you train."),
    skill = "cutting",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :tool_any({
            { id = "bokken", count = 1 },
            { id = "bokken_fake", count = 1 },
            { id = "bokken_inferior", count = 1 },
            { id = "sword_wood", count = 1 }
        })
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :component_any({
            { id = "duct_tape", count = 25 },
            { id = "medical_tape", count = 50 },
            { id = "paint", count = 25, requirement = true },
            { id = "charcoal", count = 5 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("cutting", 1)
    :book("mag_cutting", 0)
    :book("manual_cutting", 0)
)

-- Only training weapons or light and easy to use weapons, a war hammer is a good weapon but you should not
-- start your training with one.
-- Some components to mark the striking points for the session.
content.replace(content.Recipe {
    id = "prac_bashing_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("bashing (beginner)"),
    description = content.text("Practice the use of batons and similar weapons against a training dummy.  You will need something to mark the striking points while you train."),
    skill = "bashing",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :tool_any({
            { id = "cudgel", count = 1 },
            { id = "q_staff", count = 1 },
            { id = "bat", count = 1 },
            { id = "baton-extended", count = 1 },
            { id = "PR24-extended", count = 1 }
        })
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :component_any({
            { id = "duct_tape", count = 25 },
            { id = "medical_tape", count = 50 },
            { id = "paint", count = 25, requirement = true },
            { id = "charcoal", count = 5 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("bashing", 1)
    :book("mag_bashing", 0)
    :book("manual_bashing", 0)
)

-- Only training weapons or light and easy to use weapons.
-- Some components to mark the striking points for the session.
content.add(content.Recipe {
    id = "prac_stabbing_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_MELEE",
    name = content.text("stabbing (beginner)"),
    description = content.text("Practice the use of spears and similar stabbing weapons against a training dummy.  You will need something to mark the striking points while you train."),
    skill = "stabbing",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :tool_any({
            { id = "spear_wood", count = 1 },
            { id = "spear_knife_superior", count = 1 },
            { id = "spear_stone", count = 1 },
            { id = "spear_spike", count = 1 },
            { id = "fencing_foil", count = 1 },
            { id = "fencing_epee", count = 1 },
            { id = "fencing_sabre", count = 1 }
        })
    :tool_any({
            { id = "pseudo_training_dummy_light", count = 1 },
            { id = "pseudo_training_dummy_heavy", count = 1 }
        })
    :component_any({
            { id = "duct_tape", count = 25 },
            { id = "medical_tape", count = 50 },
            { id = "paint", count = 25, requirement = true },
            { id = "charcoal", count = 5 }
        })
    :requires_skill("melee", 1)
    :learn_automatically("stabbing", 1)
    :book("mag_stabbing", 0)
    :book("manual_stabbing", 0)
)

content.replace(content.Recipe {
    id = "prac_knitting",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_TAILORING",
    name = content.text("knitting"),
    description = content.text("Practice knitting whatever comes to your mind, from simple forms to elaborate and rich designs."),
    skill = "tailor",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :component_any({
            { id = "yarn", count = 40 },
            { id = "thread", count = 40 },
            { id = "sinew", count = 40 },
            { id = "plant_fibre", count = 40 }
        })
    :quality("KNIT", 1, 1)
    :learn_automatically("tailor", 0)
    :proficiency("prof_knitting", { time_multiplier = 1, skill_penalty = 0 })
    :proficiency("prof_knitting_speed", { time_multiplier = 1, skill_penalty = 0 })
)
