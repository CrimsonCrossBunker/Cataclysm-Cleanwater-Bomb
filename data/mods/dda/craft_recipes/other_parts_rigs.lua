local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "forgerig",
    result = "forgerig",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("power_supply", 2)
    :component("forge", 1)
    :component("cable", 5)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("electronics", 4)
    :learn_by_disassembly("fabrication", 4)
    :book("textbook_mechanics", 6)
    :book("textbook_electronics", 8)
    :book("textbook_fabrication", 8)
    :book("welding_book", 5)
)

content.add(content.Recipe {
    id = "kilnrig",
    result = "kilnrig",
    category = "CC_ELECTRONIC",
    subcategory = "CSC_ELECTRONIC_PARTS",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("power_supply", 2)
    :component("kiln", 1)
    :component("cable", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("electronics", 4)
    :learn_by_disassembly("fabrication", 4)
    :book("textbook_mechanics", 6)
    :book("textbook_electronics", 8)
    :book("textbook_fabrication", 8)
    :book("welding_book", 5)
)

-- 50cm weld
content.add(content.Recipe {
    id = "v_scoop_item",
    result = "v_scoop_item",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("pipe", 2)
    :component("sheet_metal", 1)
    :component("motor", 2)
    :component("processor", 1)
    :component("nuts_bolts", 16)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 2, 1)
    :requirement("welding_standard", 50)
    :book("textbook_mechanics", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 50cm weld
content.add(content.Recipe {
    id = "v_planter_item",
    result = "v_planter_item",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("pipe", 3)
    :component("sheet_metal", 1)
    :component("wheel", 2)
    :component("nuts_bolts", 16)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 2, 1)
    :requirement("welding_standard", 50)
    :book("textbook_mechanics", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 50cm weld
content.add(content.Recipe {
    id = "v_reaper_item",
    result = "v_reaper_item",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("pipe", 4)
    :component("sheet_metal", 1)
    :component("frame", 1)
    :component("wheel", 2)
    :component("nuts_bolts", 16)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 1, 1)
    :quality("WRENCH", 2, 1)
    :requirement("welding_standard", 50)
    :book("textbook_mechanics", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)

-- 80cm weld
content.add(content.Recipe {
    id = "v_plow_item",
    result = "v_plow_item",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_PARTS",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("pipe", 2)
    :component("steel_plate", 2)
    :component("frame", 1)
    :component("wheel", 1)
    :component("pipe_fittings", 2)
    :component("nuts_bolts", 50)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :quality("WRENCH", 2, 1)
    :requirement("welding_standard", 80)
    :book("textbook_mechanics", 4)
    :proficiency("prof_metalworking")
    :proficiency("prof_welding_basic", { skill_penalty = 0.5 })
    :proficiency("prof_welding")
)
