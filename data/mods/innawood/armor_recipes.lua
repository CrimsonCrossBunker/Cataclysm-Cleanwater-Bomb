local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.replace(content.Recipe {
    id = "2byarm_guard",
    result = "2byarm_guard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 90000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component("cotton_patchwork", 1)
    :quality("CUT", 2, 1)
    :requirement("cordage_short", 2)
)

content.add(content.Recipe {
    id = "goggles_welding",
    result = "goggles_welding",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "mechanics",
    difficulty = 2,
}
    :component_any({
            { id = "goggles_ski", count = 1 },
            { id = "goggles_swim", count = 1 },
            { id = "glasses_safety", count = 1 },
            { id = "glass_goggles", count = 1 },
            { id = "goggles_chem", count = 1 }
        })
    :component_any({
            { id = "eclipse_glasses", count = 1 },
            { id = "glass_tinted", count = 3 }
        })
    :component_any({
            { id = "duct_tape", count = 40 },
            { id = "medical_tape", count = 40 },
            { id = "glue_strong", count = 2 }
        })
    :requires_skill("fabrication", 1)
    :book("textbook_fabrication", 3)
    :book("welding_book", 3)
    :proficiency("prof_plasticworking")
)

content.replace(content.Recipe {
    id = "gold_bracelet",
    result = "gold_bracelet",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :component("gold_small", 12)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 3)
    :proficiency("prof_fine_metalsmithing")
)

content.replace(content.Recipe {
    id = "copper_bracelet",
    result = "copper_bracelet",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :component("copper_scrap_equivalent", 2, true)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 3)
    :proficiency("prof_fine_metalsmithing")
)

content.replace(content.Recipe {
    id = "silver_bracelet",
    result = "silver_bracelet",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 6,
}
    :tool("swage", 1)
    :component("silver_small", 15)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 3)
    :proficiency("prof_fine_metalsmithing")
)
