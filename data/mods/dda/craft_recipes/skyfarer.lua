local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "c_hydrogen_gas",
    result = "c_hydrogen_gas",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_FUEL",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :tool_charges("electrolysis_kit", 200)
    :component_any({
            { id = "water_clean", count = 1 },
            { id = "water", count = 1 }
        })
    :quality("CHEM", 2, 1)
    :quality("PRESSURIZATION", 1, 1)
    :requires_skill("electronics", 2)
    :learn_automatically("chemistry", 5)
    :learn_automatically("electronics", 3)
    :book("adv_chemistry", 3)
    :book("textbook_chemistry", 3)
    :book("recipe_labchem", 3)
    :book("textbook_gaswarfare", 4)
    :book("atomic_survival", 4)
    :book("reference_fabrication1", 3)
    :book("reference_cooking", 4)
    :batch_discount(90, 4)
)

content.add(content.Recipe {
    id = "c_hydrogen_gas_from_bugs",
    result = "c_hydrogen_gas",
    category = "CC_CHEM",
    subcategory = "CSC_CHEM_FUEL",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "chemistry",
    difficulty = 3,
}
    :component("mutant_bug_hydrogen_sacs", 5)
    :quality("CUT_FINE", 1, 1)
    :quality("PRESSURIZATION", 1, 1)
    :requires_skill("survival", 2)
    :learn_automatically("chemistry", 5)
    :learn_automatically("survival", 3)
    :book("adv_chemistry", 3)
    :book("textbook_chemistry", 3)
    :book("recipe_labchem", 3)
    :book("textbook_gaswarfare", 4)
    :book("atomic_survival", 4)
)

content.add(content.Recipe {
    id = "sail_large_item",
    result = "sail_large_item",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 300000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("sheet", 8)
    :component("wood_beam", 1)
    :component("wood_structural", 2, true)
    :component("rope_natural", 1, true)
    :component("nail_glue", 50, true)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 1, 1)
    :requirement("sewing_standard", 250)
    :byproduct("splinter", 15)
)

-- Realistically you'd need a LOT more hydrogen, but fudged for gameplay purposes.
content.add(content.Recipe {
    id = "airship_balloon_item",
    result = "airship_balloon_item",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("c_hydrogen_gas", 50)
    :component_any({
            { id = "plastic_sheet", count = 2 },
            { id = "tarp", count = 2 },
            { id = "bag_body_bag", count = 2 }
        })
    :requirement("sewing_standard", 50)
    :requirement("adhesive", 5)
    :requires_skill("tailor", 4)
)

content.add(content.Recipe {
    id = "metal_propeller_item",
    result = "metal_propeller_item",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 360000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 7,
}
    :component_any({
            { id = "sheet_metal", count = 2 },
            { id = "sheet_metal_small", count = 48 }
        })
    :component("pipe", 6)
    :component("chain", 1)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_M", 2, 1)
    :requirement("welding_standard", 25)
    :requirement("steel_standard", 5)
    :requires_skill("mechanics", 5)
    :learn_by_disassembly("fabrication", 5)
    :book("textbook_fabrication", 6)
    :book("welding_book", 6)
    :book("book_icef", 4)
    :book("textbook_mechanics", 4)
    :book("reference_fabrication1", 6)
)

content.add(content.Recipe {
    id = "wood_propeller_item",
    result = "wood_propeller_item",
    category = "CC_OTHER",
    subcategory = "CSC_OTHER_VEHICLE",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 5,
}
    :component("wood_structural_small", 5, true)
    :component("nail_glue", 20, true)
    :component("chain", 1)
    :component("steel_tiny", 2, true)
    :quality("SCREW", 1, 1)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
    :quality("CUT", 1, 1)
    :requires_skill("mechanics", 4)
    :learn_by_disassembly("fabrication", 5)
    :book("textbook_fabrication", 6)
    :book("welding_book", 6)
    :book("book_icef", 4)
    :book("textbook_mechanics", 4)
    :book("reference_fabrication1", 6)
)
