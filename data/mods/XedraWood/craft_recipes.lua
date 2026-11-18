local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "magical_grimoire_apprentice",
    result = "magical_grimoire_apprentice",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_RESEARCH",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
}
    :component("paper", 100)
    :component("used_occult_notes", 2)
    :component("occult_research_minor", 5)
    :component("wood_panel", 1)
    :quality("CUT", 2, 1)
    :quality("SEW", 2, 1)
    :quality("SAW_W", 1, 1)
    :requirement("writing_formulae_apprentice_standard", 1)
    :requirement("sewing_standard", 5)
    :requirement("tailoring_leather", 1)
    :proficiency("prof_occult_exploration", { required = true })
    :proficiency("prof_thaumatology", { required = false })
)

content.add(content.Recipe {
    id = "magical_ink_simple",
    result = "magical_ink_simple",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ALCHEMY",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 4,
}
    :tool_charges("surface_heat", 2, true)
    :component("sweet_fruit", 1, true)
    :component("salt", 2)
    :component("vinegar", 2)
    :quality("COOK", 2, 1)
    :requirement("magical_herbs", 2)
    :book("magical_grimoire_apprentice", 4)
    :batch_discount(80, 4)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "q_staff_of_the_wise",
    result = "q_staff_of_the_wise",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_WEAPONS",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "deduction",
    difficulty = 6,
    flags = { "SECRET" },
}
    :component("q_staff", 1)
    :component("wild_herbs", 20)
    :component_any({
            { id = "any_tallow", count = 5, requirement = true },
            { id = "cooking_oil", count = 16 },
            { id = "lamp_oil", count = 250 }
        })
    :quality("CHISEL", 1, 1)
    :quality("MAGICAL_RESEARCH", 1, 1)
    :requirement("magical_herbs", 5)
    :requires_skill("fabrication", 4)
    :proficiency("prof_carving", { required = true })
    :proficiency("prof_occult_exploration", { required = true })
    :proficiency("prof_thaumatology", { required = true })
)

content.add(content.Recipe {
    id = "occult_research_intro",
    result = "occult_research_intro",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_RESEARCH",
    duration_moves = 720000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "deduction",
    difficulty = 1,
}
    :component("paper", 10)
    :requirement("writing_standard", 1)
    :proficiency("prof_occult_exploration", { time_multiplier = 2, skill_penalty = 1, required = false })
)

content.add(content.Recipe {
    id = "occult_research_minor",
    result = "occult_research_minor",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_RESEARCH",
    duration_moves = 1440000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "deduction",
    difficulty = 2,
}
    :component("paper", 20)
    :requirement("writing_standard", 1)
    :proficiency("prof_occult_exploration", { time_multiplier = 4, skill_penalty = 1, required = false })
)

content.replace(content.Recipe {
    id = "doll_repair_paste",
    result = "doll_repair_paste",
    category = "CC_XEDRA",
    subcategory = "CSC_XEDRA_ELEMENTAL",
    duration_moves = 18000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "firstaid",
    difficulty = 1,
    flags = { "SECRET" },
}
    :tool_charges("surface_heat", 10, true)
    :component("clay_lump", 2)
    :component("scrap_dreamdross", 1)
    :quality("COOK", 2, 1)
    :quality("DIG", 1, 1)
    :quality("CUT", 2, 1)
    :book("dollkin_tablet", 0)
)
