local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

-- Modifying so much the arrows/bolts will cause them to eventually lose their shape
content.add(content.Recipe {
    id = "prac_fletching",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("fletching"),
    description = content.text("Practice fletching by modifying, studying and testing the aerodynamics of some arrows or bolts."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 1, max_difficulty = 2, skill_limit = 3 },
    autolearn = true,
}
    :component_any({
            { id = "arrow_fire_hardened_fletched", count = 4 },
            { id = "bolt_crude", count = 4 }
        })
    :component_any({
            { id = "adhesive", count = 1, requirement = true },
            { id = "filament", count = 20, requirement = true }
        })
    :component("fletching", 1, true)
    :quality("HAMMER", 2, 1)
    :quality("CUT", 2, 1)
    :requires_skill("archery", 1)
    :learn_automatically("fabrication", 2)
    :book("recipe_arrows", 1)
    :proficiency("prof_fletching", { time_multiplier = 1, skill_penalty = 0 })
)

-- One could use other wooden items to practice carving, but the stick and plank are the most easily
-- acquired.
content.add(content.Recipe {
    id = "prac_carving",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("carving"),
    description = content.text("Practice carving different forms and shapes in a piece of wood."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :component_any({
            { id = "stick", count = 1 },
            { id = "2x4", count = 1 }
        })
    :quality("CUT", 2, 1)
    :learn_automatically("fabrication", 0)
    :proficiency("prof_carving", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("splinter", 5)
)

-- You destroy the wood with your practice, and the nails are now unusable.
content.add(content.Recipe {
    id = "prac_carpentry_basic",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("basic carpentry"),
    description = content.text("Practice basic carpentry by cutting, shaping and uniting some planks or sticks with nails."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    practice = { min_difficulty = 0, max_difficulty = 1, skill_limit = 2 },
    autolearn = true,
}
    :component_any({
            { id = "stick", count = 4 },
            { id = "2x4", count = 2 }
        })
    :component("nails", 20, true)
    :quality("HAMMER", 1, 1)
    :quality("CUT", 2, 1)
    :learn_automatically("fabrication", 0)
    :proficiency("prof_carpentry_basic", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("splinter", 15)
)

-- 40cm of welding, you're taking it slow and probably referencing a manual
content.add(content.Recipe {
    id = "prac_welding_beg",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("welding (beginner)"),
    description = content.text("Practice welding and separating some small metal sheets to one another in some simple forms and designs."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 4 },
    autolearn = true,
}
    :component("sheet_metal_small", 4)
    :requirement("welding_standard", 40)
    :learn_automatically("fabrication", 4)
    :book("textbook_fabrication", 2)
    :book("welding_book", 2)
    :proficiency("prof_metalworking", { time_multiplier = 1, skill_penalty = 0 })
    :proficiency("prof_welding_basic", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("scrap", 4)
)

-- 60cm of welding, you're taking it slow and probably referencing a manual
content.add(content.Recipe {
    id = "prac_welding_adv",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("welding (advanced)"),
    description = content.text("Practice welding, separating and giving form to some metal sheets in intricate patterns and complicated designs."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 4, max_difficulty = 5, skill_limit = 6 },
    autolearn = true,
}
    :component("sheet_metal_small", 6)
    :requirement("welding_standard", 60)
    :learn_automatically("fabrication", 6)
    :book("welding_book", 4)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_welding_basic", { required = true })
    :proficiency("prof_welding", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("scrap", 6)
)

content.add(content.Recipe {
    id = "prac_redsmithing",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("redsmithing (beginner)"),
    description = content.text("Practice the basics of redsmithing by working copper into some simple forms and designs."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 3 },
    autolearn = true,
}
    :tool_charges("surface_heat", 20, true)
    :component("copper_scrap_equivalent", 10, true)
    :quality("HAMMER", 1, 1)
    :learn_automatically("fabrication", 4)
    :book("bronze_book", 1)
    :book("bronze_mag", 2)
    :book("alloy_book", 2)
    :book("textbook_armwest", 3)
    :book("textbook_weapwest", 3)
    :book("textbook_armschina", 3)
    :proficiency("prof_metalworking", { time_multiplier = 1, skill_penalty = 0 })
    :proficiency("prof_redsmithing", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("scrap_copper", 2)
    :byproduct("copper", 1)
)

content.add(content.Recipe {
    id = "prac_redsmithing_adv",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("redsmithing (advanced)"),
    description = content.text("Practice the more advanced techniques of redsmithing by working bronze into different and complex forms and designs."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 4, max_difficulty = 5, skill_limit = 5 },
    autolearn = true,
}
    :tool("casting_mold", 1)
    :tool_charges("metalworking_tongs_any", 1, true)
    :component("scrap_bronze", 16)
    :requirement("forging_standard", 9)
    :requirement("bronzesmithing_tools", 1)
    :learn_automatically("fabrication", 6)
    :book("bronze_book", 3)
    :book("bronze_mag", 4)
    :book("alloy_book", 4)
    :book("textbook_armwest", 5)
    :book("textbook_weapwest", 5)
    :book("textbook_armschina", 5)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_redsmithing", { required = true })
    :proficiency("prof_redsmithing_adv", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("scrap_bronze", 8)
)

content.add(content.Recipe {
    id = "prac_blacksmithing",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("blacksmithing"),
    description = content.text("Practice working metal into some simple but useful forms and designs."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 3, max_difficulty = 4, skill_limit = 4 },
    autolearn = true,
}
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 11)
    :requirement("steel_standard", 5)
    :learn_automatically("fabrication", 5)
    :book("textbook_fabrication", 3)
    :book("reference_fabrication1", 3)
    :book("alloy_book", 3)
    :book("welding_book", 3)
    :book("textbook_weapeast", 4)
    :book("textbook_armeast", 4)
    :book("textbook_armwest", 4)
    :book("textbook_weapwest", 4)
    :book("textbook_weparabic", 4)
    :book("textbook_armschina", 4)
    :proficiency("prof_metalworking", { time_multiplier = 1, skill_penalty = 0 })
    :proficiency("prof_blacksmithing", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("scrap", 5)
)

content.add(content.Recipe {
    id = "prac_armorsmithing",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("armorsmithing"),
    description = content.text("Practice working metal into the form of various armor pieces, and test their articulation with you using some cotton for padding along with the armor pieces."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 4, max_difficulty = 5, skill_limit = 5 },
    autolearn = true,
}
    :tool("swage", 1)
    :tool("sheet", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 14)
    :requirement("steel_standard", 4)
    :requires_skill("tailor", 4)
    :learn_automatically("fabrication", 6)
    :learn_automatically("tailor", 4)
    :book("textbook_armeast", 4)
    :book("textbook_armwest", 4)
    :book("textbook_armschina", 4)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_blacksmithing", { required = true })
    :proficiency("prof_armorsmithing", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("scrap", 4)
)

content.add(content.Recipe {
    id = "prac_bladesmith",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("bladesmithing"),
    description = content.text("Practice working metal into the form of useful blades of all sizes and designs, grind them until you learn how much is too much."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    practice = { min_difficulty = 4, max_difficulty = 5, skill_limit = 5 },
    autolearn = true,
}
    :tool("swage", 1)
    :tool_charges("hotcut_any", 1, true)
    :quality("GRIND", 2, 1)
    :requirement("blacksmithing_standard", 17)
    :requirement("steel_standard", 5)
    :learn_automatically("fabrication", 6)
    :book("textbook_weapeast", 4)
    :book("textbook_weapwest", 4)
    :book("textbook_weparabic", 4)
    :book("textbook_fabrication", 5)
    :book("reference_fabrication1", 5)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_blacksmithing", { required = true })
    :proficiency("prof_bladesmith", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("scrap", 5)
)

content.add(content.Recipe {
    id = "prac_toolsmithing",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("manual tooling"),
    description = content.text("Practice working metal into the complex forms and designs of several tools like hammers and screwdrivers."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 4, max_difficulty = 5, skill_limit = 5 },
    autolearn = true,
}
    :tool("drift", 1)
    :requirement("blacksmithing_standard", 20)
    :requirement("steel_standard", 7)
    :learn_automatically("fabrication", 6)
    :book("textbook_fabrication", 4)
    :book("reference_fabrication1", 4)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_blacksmithing", { required = true })
    :proficiency("prof_toolsmithing", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("scrap", 7)
)

content.add(content.Recipe {
    id = "prac_hardening",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("quenching & hardening"),
    description = content.text("Practice heating steel to its critical temperature, and using different quenching techniques to achieve various hardening effects."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 5, max_difficulty = 6, skill_limit = 6 },
    autolearn = true,
}
    :tool_charges("forge", 100)
    :tool_charges("metalworking_tongs_any", 1, true)
    :quality("HAMMER", 3, 1)
    :requirement("lc_steel_standard", 4)
    :learn_automatically("fabrication", 7)
    :book("textbook_weapeast", 5)
    :book("textbook_armeast", 5)
    :book("textbook_armwest", 5)
    :book("textbook_weapwest", 5)
    :book("textbook_weparabic", 5)
    :book("textbook_armschina", 5)
    :book("textbook_fabrication", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_blacksmithing", { time_multiplier = 1, skill_penalty = 0 })
    :proficiency("prof_hardening", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("scrap", 2)
)

content.add(content.Recipe {
    id = "prac_quenching",
    category = "CC_PRACTICE",
    subcategory = "CSC_PRACTICE_FABRICATION",
    name = content.text("tempering"),
    description = content.text("Practice heating chunks of steel and quickly cooling them down with water, and then, to reduce brittleness and restore ductility, heating them again to maximize its properties."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    practice = { min_difficulty = 5, max_difficulty = 6, skill_limit = 6 },
    autolearn = true,
}
    :tool_charges("forge", 100)
    :tool_charges("metalworking_tongs_any", 1, true)
    :tool("metal_tank", 1)
    :tool_any({
            { id = "water", count = 120 },
            { id = "water_clean", count = 120 }
        })
    :quality("HAMMER", 3, 1)
    :requirement("mc_steel_standard", 4)
    :learn_automatically("fabrication", 7)
    :book("textbook_weapeast", 5)
    :book("textbook_armeast", 5)
    :book("textbook_armwest", 5)
    :book("textbook_weapwest", 5)
    :book("textbook_weparabic", 5)
    :book("textbook_armschina", 5)
    :book("textbook_fabrication", 6)
    :book("welding_book", 6)
    :proficiency("prof_metalworking", { required = true })
    :proficiency("prof_blacksmithing", { time_multiplier = 1, skill_penalty = 0 })
    :proficiency("prof_tempering", { time_multiplier = 1, skill_penalty = 0 })
    :byproduct("scrap", 2)
)

content.add(content.Recipe {
    id = "prac_machining_lathe_aluminum",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("lathe turning (aluminum)"),
    description = content.text("Practice turning aluminum bar stock into basic parts."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 3 },
    autolearn = true,
}
    :tool_charges("fake_lathe", 40)
    :component_any({
            { id = "aluminum_bar_round", count = 1 },
            { id = "small_aluminum_bar_round", count = 3 }
        })
    :learn_automatically("fabrication", 4)
    :book("textbook_fabrication", 3)
    :book("reference_fabrication1", 2)
    :proficiency("prof_metalworking", { time_multiplier = 1, skill_penalty = 0 })
    :proficiency("prof_machining_basic", { time_multiplier = 1.5, skill_penalty = 0.5 })
    :byproduct("scrap_aluminum", 5)
)

content.add(content.Recipe {
    id = "prac_machining_lathe_steel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("lathe turning (steel)"),
    description = content.text("Practice turning steel bar stock into basic parts."),
    skill = "fabrication",
    duration_moves = 540000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 3, max_difficulty = 4, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("fake_lathe", 50)
    :component_any({
            { id = "lc_steel_bar_round", count = 1 },
            { id = "mc_steel_bar_round", count = 1 },
            { id = "pipe", count = 2 },
            { id = "small_lc_steel_bar_round", count = 3 },
            { id = "small_mc_steel_bar_round", count = 3 }
        })
    :learn_automatically("fabrication", 4)
    :book("textbook_fabrication", 3)
    :book("reference_fabrication1", 2)
    :proficiency("prof_metalworking", { time_multiplier = 1, skill_penalty = 0 })
    :proficiency("prof_machining_basic", { time_multiplier = 1.5, skill_penalty = 1.25 })
    :byproduct("scrap", 7)
)

content.add(content.Recipe {
    id = "prac_machining_mill_steel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("vertical milling (steel)"),
    description = content.text("Practice various milling techniques using steel bar stock."),
    skill = "fabrication",
    duration_moves = 540000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 3, max_difficulty = 4, skill_limit = 4 },
    autolearn = true,
}
    :tool_charges("fake_mill_vertical", 50)
    :component_any({
            { id = "lc_steel_bar_flat", count = 1 },
            { id = "mc_steel_bar_flat", count = 1 },
            { id = "small_lc_steel_bar_flat", count = 3 },
            { id = "small_mc_steel_bar_flat", count = 3 }
        })
    :learn_automatically("fabrication", 4)
    :book("textbook_fabrication", 3)
    :book("reference_fabrication1", 2)
    :proficiency("prof_metalworking", { time_multiplier = 1, skill_penalty = 0 })
    :proficiency("prof_machining_basic", { time_multiplier = 1.5, skill_penalty = 1.25 })
    :byproduct("scrap", 7)
)

content.add(content.Recipe {
    id = "prac_machining_mill_aluminum",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    name = content.text("vertical milling (aluminum)"),
    description = content.text("Practice various milling techniques using aluminum bar stock."),
    skill = "fabrication",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    practice = { min_difficulty = 2, max_difficulty = 3, skill_limit = 3 },
    autolearn = true,
}
    :tool_charges("fake_mill_vertical", 40)
    :component_any({
            { id = "aluminum_bar_flat", count = 1 },
            { id = "small_aluminum_bar_flat", count = 3 }
        })
    :learn_automatically("fabrication", 4)
    :book("textbook_fabrication", 3)
    :book("reference_fabrication1", 2)
    :proficiency("prof_metalworking", { time_multiplier = 1, skill_penalty = 0 })
    :proficiency("prof_machining_basic", { time_multiplier = 1.5, skill_penalty = 0.5 })
    :byproduct("scrap_aluminum", 5)
)
