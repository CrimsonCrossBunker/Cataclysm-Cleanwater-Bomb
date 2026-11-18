local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "firekatana_off",
    result = "firekatana_off",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("leather", 5)
    :component("pipe", 1)
    :component("katana", 1)
    :component("pilot_light", 1)
    :component("aux_pressurized_tank", 1)
    :requirement("welding_standard", 2)
    :learn_by_disassembly("mechanics", 4)
    :book("welding_book", 8)
    :book("book_icef", 4)
)

content.add(content.Recipe {
    id = "zweifire_off",
    result = "zweifire_off",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 180000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "mechanics",
    difficulty = 5,
}
    :component("leather", 5)
    :component("pipe", 1)
    :component("zweihander", 1)
    :component("pilot_light", 1)
    :component("aux_pressurized_tank", 1)
    :requirement("welding_standard", 2)
    :learn_by_disassembly("mechanics", 4)
    :book("welding_book", 8)
    :book("book_icef", 4)
)

content.add(content.Recipe {
    id = "battletorch",
    result = "battletorch",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 12000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
}
    :component("cotton_patchwork", 1)
    :component("bat", 1)
    :component("nomex", 5)
    :component_any({
            { id = "lamp_oil", count = 50 },
            { id = "motor_oil", count = 50 },
            { id = "chem_ethanol", count = 100 },
            { id = "denat_alcohol", count = 100 },
            { id = "gasoline", count = 250 },
            { id = "diesel", count = 250 },
            { id = "biodiesel", count = 250 }
        })
)

content.add(content.Recipe {
    id = "bread_sword",
    result = "bread_sword",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 8, true)
    :tool("knife_large", 1)
    :component_any({
            { id = "flour", count = 20 },
            { id = "bread_flour", count = 20 }
        })
    :component("yeast", 1)
    :component_any({
            { id = "water", count = 2 },
            { id = "water_clean", count = 2 }
        })
    :quality("OVEN", 1, 1)
)

content.add(content.Recipe {
    id = "aux_pressurized_tank",
    result = "aux_pressurized_tank",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 4,
}
    :component("metal_tank_little", 1)
    :quality("HAMMER", 2, 1)
    :requirement("welding_standard", 2)
    :requires_skill("mechanics", 3)
)

content.replace(content.Recipe {
    id = "40x46mm_hornets_nest_410_slug",
    result = "40x46mm_hornets_nest_410_slug",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_SHOT",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 6000,
    reversible = true,
    skill = "shotgun",
    difficulty = 1,
}
    :component("egg_slug", 4)
    :component("40x46mm_hornets_nest_410_casing", 1)
    :component("lgpistol_primer", 1)
    :requires_skill("launcher", 1)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "akmag90",
    result = "akmag90",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 240000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("akmag30", 3)
    :component("akmag10", 9)
    :component("akmag20", 5)
    :quality("HAMMER", 2, 1)
    :requirement("welding_standard", 2)
)

content.add(content.Recipe {
    id = "diamond_sword",
    result = "diamond_sword",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 100,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 0,
}
    :component("diamond", 2)
    :component("stick", 1)
)
