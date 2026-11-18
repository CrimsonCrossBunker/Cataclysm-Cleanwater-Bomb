local content = require("ccb").content

local NO_EXERCISE = 1

content.add(content.Recipe {
    id = "prac_soldering",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_ELECTRONICS",
    name = content.text("electronics soldering"),
    description = content.text("Practice soldering and de-soldering wires and electronic components."),
    skill = "electronics",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :component("cable", 2)
    :component("e_scrap", 2)
    :requirement("soldering_standard", 5)
    :learn_automatically("electronics", 1)
    :book("mag_electronics", 0)
    :book("manual_electronics", 0)
    :proficiency("prof_elec_soldering", { time_multiplier = 1, skill_penalty = 0 })
)

-- Some parts are listed as tools so they are not destroyed during crafting, while the components are
-- consumed.
content.add(content.Recipe {
    id = "prac_elec_circuit",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_ELECTRONICS",
    name = content.text("electrical circuit design"),
    description = content.text("Practice designing and building simple electrical circuits, such as a battery-powered motor or light bulb, and measuring their properties to understand the flow of current."),
    skill = "electronics",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = false,
}
    :tool_any({
            { id = "voltmeter", count = 1 },
            { id = "multimeter", charges = 1 },
            { id = "integrated_multimeter", charges = 1 }
        })
    :tool_any({
            { id = "antenna", count = 1 },
            { id = "circuit", count = 1 },
            { id = "element", count = 1 },
            { id = "light_bulb", count = 1 },
            { id = "motor_micro", count = 1 }
        })
    :component("cable", 4)
    :component("e_scrap", 5)
    :requirement("soldering_standard", 10)
    :book("mag_electronics", 1)
    :book("manual_electronics", 1)
    :book("advanced_electronics", 2)
    :book("textbook_electronics", 3)
    :proficiency("prof_elec_circuits", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("e_scrap", 2)
)

content.add(content.Recipe {
    id = "prac_elec_semiconductors",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_ELECTRONICS",
    name = content.text("semiconductor circuits"),
    description = content.text("Practice prototyping circuits using transistors for switching or amplifying electrical signals."),
    skill = "electronics",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 3, skill_limit = 4 },
    autolearn = false,
}
    :tool_any({
            { id = "multimeter", charges = 1 },
            { id = "integrated_multimeter", charges = 1 }
        })
    :tool("breadboard", 1)
    :tool("power_supply", 1)
    :tool_any({
            { id = "amplifier", count = 1 },
            { id = "element", count = 1 },
            { id = "receiver", count = 1 },
            { id = "transponder", count = 1 }
        })
    :component("cable", 7)
    :component("e_scrap", 10)
    :component("circuit", 1)
    :requirement("soldering_standard", 20)
    :book("manual_electronics", 1)
    :book("advanced_electronics", 2)
    :book("textbook_electronics", 3)
    :proficiency("prof_elec_circuits", { required = true })
    :proficiency("prof_elec_semiconductors", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("e_scrap", 5)
)

content.add(content.Recipe {
    id = "prac_elec_integrated_circuits",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_ELECTRONICS",
    name = content.text("integrated circuits"),
    description = content.text("Practice building electronic circuits using standard IC chips for voltage regulation, timing, logic, and simple processing."),
    skill = "electronics",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 3, max_difficulty = 5, skill_limit = 6 },
    autolearn = false,
}
    :tool_any({
            { id = "multimeter", charges = 1 },
            { id = "integrated_multimeter", charges = 1 }
        })
    :tool("breadboard", 1)
    :tool("power_supply", 1)
    :tool("processor", 1)
    :tool_any({
            { id = "amplifier", count = 1 },
            { id = "receiver", count = 1 },
            { id = "transponder", count = 1 }
        })
    :component("cable", 7)
    :component("e_scrap", 20)
    :component("circuit", 2)
    :requirement("soldering_standard", 40)
    :book("advanced_electronics", 4)
    :book("textbook_electronics", 4)
    :book("ic_reference_electronics", 3)
    :proficiency("prof_elec_circuits", { required = true })
    :proficiency("prof_elec_semiconductors", { required = true })
    :proficiency("prof_elec_integrated_circuits", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("e_scrap", 10)
)
