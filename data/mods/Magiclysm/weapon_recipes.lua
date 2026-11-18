local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local EXTRA_EXERCISE = 10

content.add(content.Recipe {
    id = "magic_suppressor",
    result = "magic_suppressor",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MODS",
    duration_moves = 15600,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "mechanics",
    difficulty = 4,
}
    :tool_any({
            { id = "rune_technomancer", count = 1 },
            { id = "rune_technomancer_weapon", count = 1 },
            { id = "rune_technomancer_weapon_adept", count = 1 }
        })
    :component_any({
            { id = "filter_liquid", count = 1 },
            { id = "muffler", count = 1 }
        })
    :component("pipe", 1)
    :component("scrap", 2)
    :component("glow_dust", 1)
    :quality("SAW_M_FINE", 1, 1)
    :requires_skill("spellcraft", 4)
    :requires_skill("gun", 4)
    :book("techno_basic", 4)
)

content.add(content.Recipe {
    id = "sharped_bone",
    result = "sharped_bone",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_ARROWS",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = false,
    skill = "fabrication",
    difficulty = 1,
}
    :tool("fire", 1)
    :component("bone", 1)
    :quality("CUT", 1, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_carving", { required = false, time_multiplier = 2 })
    :result_charges(10)
)

content.add(content.Recipe {
    id = "mjolnir",
    result = "mjolnir",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_BASHING",
    duration_moves = 7200000,
    activity_level = EXTRA_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :component("warhammer", 1)
    :component("gold_small", 1)
    :component("silver_small", 2)
    :component("rebar", 1)
    :component("orichalcum_ingot", 2)
    :quality("HAMMER", 3, 1)
    :quality("ANVIL", 3, 1)
    :quality("CHISEL", 3, 1)
    :requirement("forging_standard", 3)
    :requires_skill("spellcraft", 7)
    :requires_skill("bashing", 6)
    :book("book_mythological", 10)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3 })
    :proficiency("prof_toolsmithing")
    :proficiency("prof_almetallurgy")
)

content.add(content.Recipe {
    id = "gungnir",
    result = "gungnir",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_PIERCING",
    duration_moves = 7200000,
    activity_level = EXTRA_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :component("spear_steel", 1)
    :component("gold_small", 1)
    :component("silver_small", 2)
    :component("orichalcum_ingot", 2)
    :quality("HAMMER", 3, 1)
    :quality("ANVIL", 3, 1)
    :quality("CHISEL", 3, 1)
    :requirement("forging_standard", 3)
    :requires_skill("spellcraft", 7)
    :requires_skill("stabbing", 6)
    :book("book_mythological", 10)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3 })
    :proficiency("prof_bladesmith")
    :proficiency("prof_almetallurgy")
)

content.add(content.Recipe {
    id = "gram",
    result = "gram",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 7200000,
    activity_level = EXTRA_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :component("qt_broadsword", 1)
    :component("gold_small", 20)
    :component("orichalcum_ingot", 2)
    :quality("HAMMER", 3, 1)
    :quality("ANVIL", 3, 1)
    :quality("CHISEL", 3, 1)
    :requirement("forging_standard", 3)
    :requires_skill("spellcraft", 7)
    :requires_skill("cutting", 6)
    :book("book_mythological", 10)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3 })
    :proficiency("prof_bladesmith")
    :proficiency("prof_almetallurgy")
)

content.add(content.Recipe {
    id = "ichaival",
    result = "ichaival",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 7200000,
    activity_level = EXTRA_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :component_any({
            { id = "stick_long", count = 1 },
            { id = "2x4", count = 1 }
        })
    :component("cordage_superior", 2, true)
    :component("gold_small", 1)
    :component("orichalcum_ingot", 1)
    :quality("HAMMER", 3, 1)
    :quality("ANVIL", 3, 1)
    :quality("CHISEL", 3, 1)
    :quality("CUT", 2, 1)
    :requirement("forging_standard", 3)
    :requires_skill("spellcraft", 7)
    :requires_skill("archery", 6)
    :book("book_mythological", 10)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3 })
    :proficiency("prof_bowyery", { required = false, time_multiplier = 2 })
    :proficiency("prof_almetallurgy")
)

content.add(content.Recipe {
    id = "laevateinn",
    result = "laevateinn",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 7200000,
    activity_level = EXTRA_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 10,
}
    :tool("metalworking_tongs", 1)
    :tool("swage", 1)
    :component("i_staff", 1)
    :component("gold_small", 1)
    :component("orichalcum_ingot", 1)
    :quality("HAMMER", 3, 1)
    :quality("ANVIL", 3, 1)
    :quality("CHISEL", 3, 1)
    :requirement("forging_standard", 3)
    :requires_skill("spellcraft", 7)
    :book("book_mythological", 10)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing", { required = false, time_multiplier = 3 })
    :proficiency("prof_toolsmithing")
    :proficiency("prof_almetallurgy")
)

content.add(content.Recipe {
    id = "borealmosin_clip",
    result = "borealmosin_clip",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :tool_any({
            { id = "small_repairkit", charges = 10 },
            { id = "large_repairkit", charges = 5 }
        })
    :component("sheet_metal_small", 1)
    :quality("SAW_M", 1, 1)
    :quality("HAMMER", 1, 1)
    :requirement("308_casehead", 1)
    :requires_skill("gun", 2)
    :book("recipe_bullets", 2)
    :book("mag_rifle", 3)
    :book("techno_basic", 3)
)

content.add(content.Recipe {
    id = "longsword_mithril",
    result = "longsword_mithril",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_CUTTING",
    duration_moves = 2520000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :tool("hotcut", 1)
    :component_any({
            { id = "2x4", count = 1 },
            { id = "stick", count = 2 }
        })
    :component_any({
            { id = "fur", count = 1 },
            { id = "leather", count = 1 }
        })
    :component("mithril_ingot", 4)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 16)
    :book("textbook_mithril", 7)
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_bladesmith")
    :proficiency("prof_carving", { time_multiplier = 1.2, learning_time_multiplier = 0.2, skill_penalty = 0 })
)
