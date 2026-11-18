local ccb = require("ccb")
local content = ccb.content
local register = require("psychic_contemplation")

local crystal_tools = {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "black_nether_crystal_pseudo_tool", count = 1 },
    { id = "matrix_crystal_vitakinesis", count = 1 },
}

register {
    id = "practice_vita_pain_split",
    name = content.text("contemplation: damage balancing"),
    description = content.text("This recipe exists for an Obsolete power."),
    spell = "vita_pain_split",
    proficiency = "prof_contemplation_vitakinesis",
    learning = "study",
    difficulty = 5,
    crafting_difficulty = 4,
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_METAPHYSICS",
    tools = crystal_tools,
    component = "matrix_crystal_vitakin_dust",
}

ccb.runtime.handler("complete_obsolete_lifting_field", function() end, 1)

content.add(content.Recipe {
    id = "improve_telekinesis_lifting_field",
    name = content.text("contemplation: lifting field"),
    description = content.text("This recipe is Obsolete and does nothing."),
    category = "CC_PSIONIC",
    subcategory = "CSC_PSIONIC_OTHER",
    skill = "metaphysics",
    difficulty = 0,
    duration_moves = 0,
    activity_level = 2,
    autolearn = false,
    flags = { "SECRET", "BLIND_EASY" },
    scripted_output = true,
}:tool_any {
    { id = "matrix_crystal_drained", count = 1 },
    { id = "black_nether_crystal_pseudo_tool", count = 1 },
    { id = "matrix_crystal_telekinesis", count = 1 },
}:on_complete("complete_obsolete_lifting_field"))
