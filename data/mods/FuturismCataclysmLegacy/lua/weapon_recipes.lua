local content = require("ccb").content

local LIGHT_EXERCISE = 2
local MODERATE_EXERCISE = 4
local BRISK_EXERCISE = 6
local ACTIVE_EXERCISE = 8

-- 3000 mg gunpowder rounded to 30 100 mg 'pieces'
content.add(content.Recipe {
    id = "fcl_reloaded_5x50dart",
    result = "fcl_reloaded_5x50dart",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_RIFLE",
    duration_moves = 12000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "fabrication",
    difficulty = 6,
}
    :component("fcl_5x50_hull", 1)
    :component("smrifle_primer", 1)
    :component_any({
            { id = "gunpowder", count = 30 },
            { id = "gunpowder_magnum_pistol", count = 30 }
        })
    :component("combatnail", 1)
    :requirement("bullet_forming", 2)
    :requirement("ammo_bullet", 2)
    :requires_skill("gun", 5)
    :book("recipe_caseless", 4)
    :proficiency("prof_plasticworking")
    :proficiency("prof_handloading")
    :batch_discount(60, 5)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "rebar_rail",
    result = "rebar_rail",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 720000,
    activity_level = MODERATE_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("rebar", 2)
    :quality("HAMMER", 1, 1)
    :quality("SAW_M", 1, 1)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "steel_rail",
    result = "steel_rail",
    category = "CC_AMMO",
    subcategory = "CSC_AMMO_OTHER",
    duration_moves = 600000,
    activity_level = BRISK_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :requirement("blacksmithing_standard", 16)
    :requirement("steel_standard", 4)
    :result_charges(10)
)

content.add(content.Recipe {
    id = "fcl_fusion_10_mag",
    result = "fcl_fusion_10_mag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 6,
}
    :component("fcl_fusion_pack", 1)
    :component("nanomaterial", 3)
    :component("circuit", 2)
    :component("cable", 4)
    :component("e_scrap", 8)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("mechanics", 4)
    :requires_skill("fabrication", 4)
    :book("advanced_electronics", 7)
    :book("textbook_electronics", 8)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_electromagnetics")
)

content.add(content.Recipe {
    id = "fcl_fusion_20_mag",
    result = "fcl_fusion_20_mag",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_MAGAZINES",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 8,
}
    :component("fcl_fusion_pack", 2)
    :component("nanomaterial", 5)
    :component("amplifier", 1)
    :component("processor", 1)
    :component("circuit", 4)
    :component("cable", 8)
    :component("e_scrap", 16)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 35)
    :requires_skill("mechanics", 5)
    :requires_skill("fabrication", 5)
    :book("advanced_electronics", 8)
    :book("textbook_electronics", 9)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_electromagnetics")
)

content.add(content.Recipe {
    id = "fcl_rebar_rifle",
    result = "fcl_rebar_rifle",
    category = "CC_WEAPON",
    subcategory = "CSC_WEAPON_RANGED",
    duration_moves = 2160000,
    activity_level = ACTIVE_EXERCISE,
    autolearn = false,
    skill = "electronics",
    difficulty = 9,
}
    :tool_any({
            { id = "oxy_torch", charges = 60 },
            { id = "welder", charges = 300 },
            { id = "welder_crude", charges = 450 },
            { id = "integrated_welder", charges = 450 }
        })
    :tool("laptop", 1)
    :component("cable", 80)
    :component("2x4", 1)
    :component("power_supply", 2)
    :component("amplifier", 2)
    :component("mixed_steel", 1, true)
    :component("pipe", 2)
    :component("e_scrap", 20)
    :quality("SAW_M_FINE", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH_FINE", 1, 1)
    :quality("GLARE", 1, 1)
    :quality("DRILL", 2, 1)
    :quality("SAW_W", 1, 1)
    :requires_skill("mechanics", 6)
    :book("advanced_electronics", 8)
    :book("textbook_electronics", 8)
    :proficiency("prof_elec_soldering")
    :proficiency("prof_electromagnetics")
    :proficiency("prof_gunsmithing_improv")
)
