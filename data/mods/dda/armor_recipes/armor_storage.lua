local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "XL_holster",
    result = "XL_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("strap_small", 1)
    :requirement("tailoring_leather_small", 9)
    :requirement("clasps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "XL_nylon_holster",
    result = "XL_nylon_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("strap_small", 1)
    :requirement("tailoring_nylon_patchwork", 2)
    :requirement("clasps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "ammo_satchel",
    result = "ammo_satchel",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("fastener_small", 2, true)
    :requirement("tailoring_canvas_patchwork", 4)
    :requirement("strap_large", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "ammo_satchel_leather",
    result = "ammo_satchel_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("fastener_small", 2, true)
    :requirement("tailoring_leather_patchwork", 2)
    :requirement("strap_large", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "baldric_holster",
    result = "baldric_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 8640000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_large", 1, true)
    :requirement("tailoring_leather", 4)
    :requirement("fastener_small", 7)
    :requires_skill("pistol", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "stone_pouch",
    result = "stone_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("strap_large", 1)
    :requirement("tailoring_cotton_patchwork_simple", 1)
    :requirement("fastener_small", 2)
    :requires_skill("throw", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "leather_stone_pouch",
    result = "leather_stone_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("strap_large", 1)
    :requirement("tailoring_leather_patchwork_simple", 1)
    :requirement("fastener_small", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "camera_bag",
    result = "camera_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_nylon_patchwork", 8)
    :requirement("fastener_large", 1)
    :requirement("fastener_small", 1)
    :requirement("plastic_molding", 2)
    :requires_skill("fabrication", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "canteen_pouch",
    result = "canteen_pouch",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_nylon_patchwork", 6)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "deployment_bag",
    result = "deployment_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 90000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_nylon_patchwork", 9)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "dry_bag",
    result = "dry_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_lycra_patchwork", 20)
    :requirement("clasps", 1)
    :requirement("waterproofing_plastic_sheets", 20)
    :requires_skill("fabrication", 2)
    :book("plastics_book", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
    :byproduct("scrap_lycra", 9)
)

content.add(content.Recipe {
    id = "fanny",
    result = "fanny",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 30000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_nylon_patchwork", 4)
    :requirement("fastener_small", 1)
    :requirement("clasps", 1)
    :requirement("plastic_molding", 1)
    :requires_skill("fabrication", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

-- Item disassembly based on reversible craft and manually defined uncraft integration. Read
-- ITEM_CRAFT_AND_DISASSEMBLY.md for more info.
content.add(content.Recipe {
    id = "dump_pouch",
    result = "dump_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_nylon_patchwork", 10)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :requirement("plastic_molding", 1)
    :requires_skill("fabrication", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "sustainment_pouch",
    result = "sustainment_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 90000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_nylon_patchwork", 4)
    :requirement("fastener_small", 2)
    :requirement("strap_small", 1)
    :requirement("clasps", 4)
    :requires_skill("fabrication", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "santa_belt",
    result = "santa_belt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 30000,
    reversible = true,
    skill = "tailor",
}
    :requirement("tailoring_leather_small", 5)
    :requirement("clasps", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "fireman_belt",
    result = "fireman_belt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 30000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("scrap", 2)
    :quality("HAMMER", 2, 1)
    :requirement("tailoring_leather_small", 4)
    :requirement("clasps", 1)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "webbing_belt",
    result = "webbing_belt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 30000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("scrap", 2)
    :component_any({
            { id = "buckle_steel", count = 1 },
            { id = "button_plastic", count = 1 },
            { id = "snapfastener_steel", count = 2 },
            { id = "touch_fastener", count = 2 }
        })
    :quality("HAMMER", 2, 1)
    :requirement("tailoring_nylon_patchwork", 2)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "police_belt",
    result = "police_belt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 30000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("scrap", 2)
    :component_any({
            { id = "buckle_steel", count = 1 },
            { id = "button_plastic", count = 1 },
            { id = "snapfastener_steel", count = 2 },
            { id = "touch_fastener", count = 2 }
        })
    :quality("HAMMER", 2, 1)
    :requirement("tailoring_leather_small", 5)
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "vest",
    result = "vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :requirement("tailoring_canvas_patchwork", 14)
    :requirement("fastener_large", 1)
    :requirement("fastener_small", 4)
    :byproduct("scrap_canvas", 28)
)

content.add(content.Recipe {
    id = "chestrig",
    result = "chestrig",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 42000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "chestpouch", count = 4 },
            { id = "legpouch_large", count = 2 }
        })
    :requirement("tailoring_canvas_patchwork", 2)
    :requirement("strap_small", 1)
    :requirement("clasps", 4)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xs_chestrig",
    result = "xs_chestrig",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 42000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "chestpouch", count = 4 },
            { id = "legpouch_large", count = 2 }
        })
    :requirement("tailoring_canvas_patchwork", 2)
    :requirement("strap_small", 1)
    :requirement("clasps", 4)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "xl_chestrig",
    result = "xl_chestrig",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 42000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "chestpouch", count = 4 },
            { id = "legpouch_large", count = 2 }
        })
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("strap_large", 1)
    :requirement("clasps", 4)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "axe_ring",
    result = "axe_ring",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 30000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("scrap", 1)
    :component("nails", 4, true)
    :quality("HAMMER", 1, 1)
    :requirement("adhesive", 1)
    :requirement("tailoring_leather_small", 5)
    :requirement("clasps", 1)
)

content.add(content.Recipe {
    id = "back_holster",
    result = "back_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_small", 7)
    :requirement("clasps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "backpack",
    result = "backpack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_nylon_patchwork", 16)
    :requirement("fastener_large", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :byproduct("nylon", 1)
)

content.add(content.Recipe {
    id = "backpack_denim",
    result = "backpack_denim",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_denim_patchwork", 6)
    :requirement("fastener_large", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "backpack_leather",
    result = "backpack_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 150000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("strap_large", 2)
    :requirement("tailoring_leather_patchwork", 3)
    :requirement("fastener_large", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "slingpack",
    result = "slingpack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_nylon_patchwork", 12)
    :requirement("fastener_large", 1)
    :requirement("plastic_molding", 2)
    :requires_skill("fabrication", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "daypack",
    result = "daypack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("strap_large", 2)
    :requirement("tailoring_nylon_patchwork", 12)
    :requirement("fastener_large", 2)
    :requirement("plastic_molding", 2)
    :requires_skill("fabrication", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "purse",
    result = "purse",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 6480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 120000,
    reversible = true,
    skill = "tailor",
    difficulty = 6,
}
    :requirement("tailoring_leather_patchwork", 2)
    :requirement("fastener_large", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "runner_bag",
    result = "runner_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_canvas_patchwork", 8)
    :requirement("fastener_large", 1)
    :requirement("plastic_molding", 2)
    :requires_skill("fabrication", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :byproduct("scrap_canvas", 24)
)

content.add(content.Recipe {
    id = "baldric",
    result = "baldric",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("2x4", 2)
    :component("nails", 8, true)
    :quality("HAMMER", 1, 1)
    :requirement("tailoring_leather_small", 10)
    :requirement("clasps", 1)
    :requires_skill("melee", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "bandolier_pistol",
    result = "bandolier_pistol",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_small", 4)
    :requirement("clasps", 1)
    :requires_skill("gun", 1)
    :requires_skill("pistol", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "bandolier_rifle",
    result = "bandolier_rifle",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_small", 4)
    :requirement("clasps", 1)
    :requires_skill("gun", 1)
    :requires_skill("rifle", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "bandolier_shotgun",
    result = "bandolier_shotgun",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1200000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_small", 4)
    :requirement("clasps", 1)
    :requires_skill("gun", 1)
    :requires_skill("shotgun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "torso_bandolier_shotgun",
    result = "torso_bandolier_shotgun",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_small", 5)
    :requirement("clasps", 1)
    :requires_skill("gun", 1)
    :requires_skill("shotgun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

-- The two items are very similar, so it makes sense to have their recipes be nearly identical,
-- with the exception of using launchers as the skill.
content.add(content.Recipe {
    id = "torso_bandolier_grenade",
    result = "torso_bandolier_grenade",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_small", 5)
    :requirement("clasps", 1)
    :requires_skill("gun", 1)
    :requires_skill("launcher", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "bandolier_wrist",
    result = "bandolier_wrist",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :requirement("tailoring_canvas_patchwork", 1)
    :requirement("fastener_small", 1)
    :requires_skill("gun", 1)
    :requires_skill("rifle", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "bholster",
    result = "bholster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_lycra_patchwork", 4)
    :requires_skill("gun", 1)
    :requires_skill("pistol", 1)
    :proficiency("prof_elastics")
    :byproduct("scrap_lycra", 2)
)

content.add(content.Recipe {
    id = "bbholster",
    result = "bbholster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_lycra_patchwork", 8)
    :requires_skill("gun", 1)
    :requires_skill("pistol", 1)
    :proficiency("prof_elastics")
    :byproduct("scrap_lycra", 6)
)

content.add(content.Recipe {
    id = "bindle",
    result = "bindle",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 4800,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "sheet_cotton_patchwork", count = 1 },
            { id = "sheet_cotton", count = 1 },
            { id = "sheet_fur_patchwork", count = 1 },
            { id = "tanned_pelt", count = 1 },
            { id = "tanned_hide", count = 1 },
            { id = "sheet_leather_patchwork", count = 6 }
        })
    :component_any({
            { id = "stick", count = 1 },
            { id = "broom", count = 1 },
            { id = "2x4", count = 1 },
            { id = "pool_cue", count = 1 },
            { id = "pointy_stick", count = 1 },
            { id = "mop", count = 1 }
        })
)

content.add(content.Recipe {
    id = "bootsheath",
    result = "bootsheath",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_small", 4)
    :requirement("clasps", 1)
    :requires_skill("melee", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "bootsheath_birchbark",
    result = "bootsheath_birchbark",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("birchbark", 1)
    :component("cordage_short", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_basketweaving")
)

-- Ankle holster
content.add(content.Recipe {
    id = "bootstrap",
    result = "bootstrap",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_small", 5)
    :requirement("clasps", 1)
    :requires_skill("pistol", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "bow_sling",
    result = "bow_sling",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("rope_natural_short", 1, true)
    :requirement("strap_large", 1)
    :requirement("clasps", 1)
    :requires_skill("archery", 1)
)

content.add(content.Recipe {
    id = "single_sling",
    result = "single_sling",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("clasps", 3)
)

content.add(content.Recipe {
    id = "bscabbard",
    result = "bscabbard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 240000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("2x4", 2)
    :component("nails", 10, true)
    :quality("HAMMER", 1, 1)
    :requirement("tailoring_leather_small", 15)
    :requirement("adhesive", 1)
    :requirement("clasps", 1)
    :requires_skill("melee", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "armrig",
    result = "armrig",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "leg_small_bag",
    result = "leg_small_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_canvas_patchwork", 3)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "chestpouch",
    result = "chestpouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_canvas_patchwork", 4)
    :requirement("filament_canvas", 2)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "chestpouch_leather",
    result = "chestpouch_leather",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1980000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_patchwork", 4)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "tacvest",
    result = "tacvest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 3600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "ragpouch", count = 2 },
            { id = "leather_pouch", count = 2 }
        })
    :component_any({
            { id = "chestpouch", count = 4 },
            { id = "legpouch_large", count = 2 },
            { id = "chestrig", count = 1 }
        })
    :requirement("tailoring_nylon_patchwork", 5)
    :requirement("plastic_molding", 2)
    :requirement("fastener_small", 6)
    :requires_skill("fabrication", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "xs_tacvest",
    result = "xs_tacvest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "ragpouch", count = 2 },
            { id = "leather_pouch", count = 2 }
        })
    :component_any({
            { id = "chestpouch", count = 4 },
            { id = "legpouch_large", count = 2 },
            { id = "chestrig", count = 1 }
        })
    :requirement("tailoring_nylon_patchwork", 3)
    :requirement("plastic_molding", 2)
    :requirement("fastener_small", 6)
    :requires_skill("fabrication", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "xl_tacvest",
    result = "xl_tacvest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 4860000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component_any({
            { id = "ragpouch", count = 2 },
            { id = "leather_pouch", count = 2 }
        })
    :component_any({
            { id = "chestpouch", count = 4 },
            { id = "legpouch_large", count = 2 },
            { id = "chestrig", count = 1 }
        })
    :requirement("tailoring_nylon_patchwork", 7)
    :requirement("plastic_molding", 3)
    :requirement("fastener_small", 6)
    :requires_skill("fabrication", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "duffelbag",
    result = "duffelbag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 360000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_canvas_patchwork", 26)
    :requirement("fastener_large", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "flintlock_pouch",
    result = "flintlock_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_leather_small", 2)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
)

-- Item disassembly based on reversible craft and manually defined uncraft integration. Read
-- ITEM_CRAFT_AND_DISASSEMBLY.md for more info.
content.add(content.Recipe {
    id = "grenade_pouch",
    result = "grenade_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("fastener_small", 1)
    :requirement("strap_small", 1)
    :requirement("clasps", 1)
    :requirement("plastic_molding", 2)
    :requires_skill("gun", 1)
    :requires_skill("launcher", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "hide_bag",
    result = "hide_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 3600,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    flags = { "BLIND_EASY" },
}
    :component_any({
            { id = "raw_leather", count = 6 },
            { id = "raw_hleather", count = 6 },
            { id = "raw_demihumanleather", count = 6 },
            { id = "raw_fur", count = 6 },
            { id = "raw_hfur", count = 6 }
        })
)

content.add(content.Recipe {
    id = "hide_tainted_bag",
    result = "hide_tainted_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 3600,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    flags = { "BLIND_EASY" },
}
    :component_any({
            { id = "raw_tainted_leather", count = 6 },
            { id = "raw_tainted_fur", count = 6 }
        })
)

content.add(content.Recipe {
    id = "holster",
    result = "holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 360000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :component("fastener_small", 1, true)
    :requirement("tailoring_leather_small", 6)
    :requires_skill("pistol", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "nylon_holster",
    result = "nylon_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :component("fastener_small", 1, true)
    :requirement("tailoring_nylon_patchwork", 2)
    :requires_skill("pistol", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "shoulder_holster",
    result = "shoulder_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :component("fastener_small", 1, true)
    :requirement("tailoring_leather_small", 6)
    :requires_skill("pistol", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "side_double_holster",
    result = "side_double_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 3000,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("holster", 2)
    :requirement("tailoring_cotton_patchwork", 1)
    :requires_skill("pistol", 1)
)

content.add(content.Recipe {
    id = "FB_double_holster",
    result = "FB_double_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 3000,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("holster", 2)
    :requirement("tailoring_cotton_patchwork", 1)
    :requires_skill("pistol", 1)
)

content.add(content.Recipe {
    id = "XS_holster",
    result = "XS_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 360000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :component("fastener_small", 1, true)
    :requirement("tailoring_leather_small", 2)
    :requires_skill("pistol", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "XS_nylon_holster",
    result = "XS_nylon_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :component("fastener_small", 1, true)
    :requirement("tailoring_nylon_patchwork", 1)
    :requires_skill("pistol", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "side_nylon_double_holster",
    result = "side_nylon_double_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 3000,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("nylon_holster", 2)
    :requirement("tailoring_cotton_patchwork", 1)
    :requires_skill("pistol", 1)
)

content.add(content.Recipe {
    id = "FB_nylon_double_holster",
    result = "FB_nylon_double_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 6000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 3000,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("nylon_holster", 2)
    :requirement("tailoring_cotton_patchwork", 1)
    :requires_skill("pistol", 1)
)

content.add(content.Recipe {
    id = "western_holster",
    result = "western_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 360000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :component("fastener_small", 2, true)
    :requirement("tailoring_leather_small", 7)
    :requires_skill("pistol", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "jerrypack",
    result = "jerrypack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 9000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("strap_small", 3, true)
    :component("jerrycan", 1)
    :quality("HAMMER", 3, 1)
    :requirement("adhesive", 3)
)

content.add(content.Recipe {
    id = "boxpack",
    result = "boxpack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("2x4", 3)
    :component("wood_panel", 1)
    :component("nails", 20, true)
    :component("rope_natural", 1, true)
    :quality("HAMMER", 2, 1)
    :quality("SAW_W", 2, 1)
    :proficiency("prof_carpentry_basic")
)

content.add(content.Recipe {
    id = "leather_belt",
    result = "leather_belt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 6000,
    reversible = true,
    skill = "tailor",
}
    :component_any({
            { id = "buckle_steel", count = 1 },
            { id = "button_plastic", count = 1 },
            { id = "snapfastener_steel", count = 2 },
            { id = "touch_fastener", count = 2 }
        })
    :requirement("tailoring_leather_small", 5)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "leather_pouch",
    result = "leather_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :requirement("tailoring_leather_small_simple", 3)
    :requirement("fastener_small", 1)
    :requires_skill("survival", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "ammo_pouch",
    result = "ammo_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("strap_large", 1, true)
    :requirement("tailoring_leather_small", 6)
    :requirement("fastener_small", 2)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "legpouch",
    result = "legpouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :requirement("tailoring_nylon_patchwork", 2)
    :requirement("fastener_small", 1)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "legpouch_large",
    result = "legpouch_large",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 90000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_large", 1, true)
    :component("chestpouch", 2)
    :requirement("tailoring_nylon_patchwork", 3)
    :requirement("fastener_small", 3)
    :requires_skill("gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "radio_pouch",
    result = "radio_pouch",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :requirement("tailoring_nylon_patchwork", 4)
    :requirement("fastener_small", 1)
    :requires_skill("gun", 1)
    :book("manual_gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "gadget_pouch",
    result = "gadget_pouch",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :requirement("tailoring_nylon_patchwork", 5)
    :requirement("fastener_small", 1)
    :requires_skill("gun", 1)
    :book("manual_gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "h2o_pouch",
    result = "h2o_pouch",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2700000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 2, true)
    :component("clasps", 2, true)
    :requirement("tailoring_nylon_patchwork", 5)
    :requirement("fastener_small", 2)
    :requires_skill("gun", 1)
    :book("manual_gun", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "tool_pouch",
    result = "tool_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 3, true)
    :component("clasps", 3, true)
    :requirement("tailoring_nylon_patchwork", 5)
    :requirement("fastener_small", 1)
    :requires_skill("gun", 1)
    :book("manual_gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "flashlight_pouch",
    result = "flashlight_pouch",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :requirement("tailoring_nylon_patchwork", 2)
    :requirement("fastener_small", 1)
    :requires_skill("gun", 1)
    :book("manual_gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "tactical_holster",
    result = "tactical_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1980000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :requirement("tailoring_nylon_patchwork", 4)
    :requirement("fastener_small", 1)
    :requires_skill("gun", 1)
    :book("manual_gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

-- Item disassembly based on reversible craft and manually defined uncraft integration. Read
-- ITEM_CRAFT_AND_DISASSEMBLY.md for more info.
content.add(content.Recipe {
    id = "gas_mask_pouch",
    result = "gas_mask_pouch",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 3060000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 2, true)
    :component("clasps", 2, true)
    :requirement("tailoring_nylon_patchwork", 6)
    :requirement("fastener_small", 2)
    :requires_skill("gun", 1)
    :book("manual_gun", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "tactical_grenade_pouch",
    result = "tactical_grenade_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :requirement("tailoring_nylon_patchwork", 4)
    :requirement("fastener_small", 1)
    :requires_skill("gun", 1)
    :book("manual_gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "triple_stacker_pouch",
    result = "triple_stacker_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 3, true)
    :component("clasps", 3, true)
    :requirement("tailoring_nylon_patchwork", 9)
    :requirement("fastener_small", 6)
    :requires_skill("gun", 1)
    :book("manual_gun", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "tactical_shotshell_pouch",
    result = "tactical_shotshell_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3060000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 2, true)
    :component("clasps", 2, true)
    :requirement("tailoring_nylon_patchwork", 6)
    :requirement("fastener_small", 1)
    :requires_skill("gun", 1)
    :book("manual_gun", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "legrig",
    result = "legrig",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 990000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("strap_large", 1, true)
    :component("clasps", 2, true)
    :requirement("tailoring_nylon_patchwork", 2)
    :requirement("plastic_molding", 1)
    :requires_skill("fabrication", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "leg_bag",
    result = "leg_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1980000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 90000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("strap_large", 1, true)
    :component("clasps", 2, true)
    :requirement("tailoring_canvas_patchwork", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "makeshift_knapsack",
    result = "makeshift_knapsack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 4800,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    flags = { "BLIND_HARD" },
}
    :component_any({
            { id = "pants", count = 1 },
            { id = "pants_cargo", count = 1 },
            { id = "pants_army", count = 1 },
            { id = "pants_checkered", count = 1 },
            { id = "striped_pants", count = 1 },
            { id = "technician_pants_gray", count = 1 },
            { id = "jeans", count = 1 }
        })
    :requirement("cordage", 1)
)

content.add(content.Recipe {
    id = "makeshift_sling",
    result = "makeshift_sling",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 4800,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    flags = { "BLIND_EASY" },
}
    :component_any({
            { id = "blanket", count = 1 },
            { id = "down_blanket", count = 1 },
            { id = "fur_blanket", count = 1 },
            { id = "electric_blanket", count = 1 },
            { id = "emer_blanket", count = 1 },
            { id = "quilt", count = 1 },
            { id = "quilt_patchwork", count = 1 },
            { id = "sheet", count = 1 }
        })
)

content.add(content.Recipe {
    id = "net_backpack",
    result = "net_backpack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("cordage_superior", 6, true)
    :quality("CUT", 2, 1)
)

content.add(content.Recipe {
    id = "quiver_takedown_bow",
    result = "quiver_takedown_bow",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_cotton_patchwork", 7)
    :requirement("fastener_large", 2)
    :requirement("clasps", 2)
    :requires_skill("archery", 1)
    :book("recipe_arrows", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "quiver",
    result = "quiver",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("strap_large", 1, true)
    :requirement("tailoring_leather_patchwork_simple", 1)
    :requirement("fastener_large", 2)
    :requires_skill("archery", 1)
    :learn_by_disassembly("tailor", 3)
    :book("recipe_arrows", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "nylon_quiver",
    result = "nylon_quiver",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 3960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("strap_large", 2, true)
    :requirement("tailoring_nylon_patchwork", 8)
    :requirement("fastener_large", 2)
    :requires_skill("archery", 2)
    :learn_by_disassembly("tailor", 3)
    :book("recipe_arrows", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "quiver_birchbark",
    result = "quiver_birchbark",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("birchbark", 6)
    :component("filament", 3, true)
    :component("cordage", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 1)
    :requires_skill("archery", 1)
    :learn_by_disassembly("tailor", 3)
    :book("recipe_arrows", 2)
    :proficiency("prof_basketweaving")
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "pipe_quiver",
    result = "pipe_quiver",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("rope_natural_short", 1, true)
    :component("duct_tape", 10)
    :component("pipe", 1)
    :requires_skill("archery", 1)
    :book("recipe_arrows", 1)
)

content.add(content.Recipe {
    id = "quiver_large",
    result = "quiver_large",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("fastener_large", 3, true)
    :quality("HAMMER", 2, 1)
    :requirement("tailoring_leather_patchwork_simple", 3)
    :requirement("strap_large", 2)
    :requires_skill("archery", 1)
    :learn_by_disassembly("tailor", 3)
    :book("recipe_arrows", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "quiver_large_birchbark",
    result = "quiver_large_birchbark",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 5400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("birchbark", 18)
    :component("filament", 10, true)
    :component("strap_large", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 2)
    :requires_skill("archery", 2)
    :learn_by_disassembly("tailor", 4)
    :book("recipe_arrows", 3)
    :proficiency("prof_basketweaving")
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "pipe_quiver_large",
    result = "pipe_quiver_large",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "fabrication",
    difficulty = 2,
}
    :component("rope_natural", 1, true)
    :component("duct_tape", 30)
    :component("pipe", 3)
    :requires_skill("archery", 1)
    :book("recipe_arrows", 2)
)

content.add(content.Recipe {
    id = "quiver_simple_cloth",
    result = "quiver_simple_cloth",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 1,
}
    :requirement("tailoring_cotton_patchwork_simple", 1)
    :requirement("strap_small", 2)
    :requires_skill("survival", 1)
)

content.add(content.Recipe {
    id = "ragpouch",
    result = "ragpouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :requirement("tailoring_cotton_patchwork_simple", 1)
)

content.add(content.Recipe {
    id = "scabbard",
    result = "scabbard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("2x4", 2)
    :component("nails", 5, true)
    :quality("HAMMER", 1, 1)
    :requirement("tailoring_leather_small", 10)
    :requirement("clasps", 1)
    :requirement("adhesive", 1)
    :requires_skill("melee", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "nylon_scabbard",
    result = "nylon_scabbard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("2x4", 2)
    :component("nails", 5, true)
    :quality("HAMMER", 1, 1)
    :requirement("tailoring_nylon_patchwork", 10)
    :requirement("clasps", 1)
    :requirement("adhesive", 1)
    :requires_skill("melee", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "leg_sheath6",
    result = "leg_sheath6",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_nylon_patchwork", 5)
    :requirement("clasps", 3)
    :requires_skill("throw", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "gartersheath1",
    result = "gartersheath1",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_nylon_patchwork", 2)
    :requirement("plastic_molding", 1)
    :requires_skill("melee", 1)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "gartersheath2",
    result = "gartersheath2",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_nylon_patchwork", 4)
    :requirement("plastic_molding", 2)
    :requires_skill("melee", 1)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "sheath",
    result = "sheath",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 150000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :requirement("tailoring_leather_small", 3)
    :requires_skill("melee", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "sheath_birchbark",
    result = "sheath_birchbark",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("birchbark", 2)
    :component("cordage_short", 1, true)
    :quality("CUT", 2, 1)
    :requires_skill("survival", 1)
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "sholster",
    result = "sholster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_small", 1, true)
    :component("clasps", 1, true)
    :quality("SEW", 1, 1)
    :requirement("tailoring_leather_small", 3)
    :requires_skill("pistol", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "spearsling",
    result = "spearsling",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_large", 1, true)
    :component("clasps", 1, true)
    :requirement("tailoring_leather_patchwork", 2)
    :requires_skill("melee", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "spearsling_canvas",
    result = "spearsling_canvas",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 270000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("strap_large", 1, true)
    :component("clasps", 1, true)
    :requirement("tailoring_canvas_patchwork", 2)
    :requires_skill("melee", 1)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "straw_basket",
    result = "straw_basket",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2880000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("plant_cordage", 6, true)
    :quality("CUT", 1, 1)
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "wicker_basket_large",
    result = "wicker_basket_large",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 9360000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("plant_cordage", 20, true)
    :quality("CUT", 1, 1)
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "survivor_duffel_bag",
    result = "survivor_duffel_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("canvas_patch", 78)
    :component("plastic_sheet", 2)
    :component_any({
            { id = "duffelbag", count = 1 },
            { id = "rucksack", count = 1 }
        })
    :component_any({
            { id = "tacvest", count = 1 },
            { id = "legrig", count = 1 },
            { id = "vest", count = 1 },
            { id = "tool_belt", count = 1 },
            { id = "leather_pouch", count = 2 },
            { id = "dump_pouch", count = 1 },
            { id = "purse", count = 2 },
            { id = "fanny", count = 2 }
        })
    :component("duct_tape", 200)
    :requirement("sewing_standard", 200)
    :requirement("tailoring_leather_small", 20)
    :requirement("fastener_large", 3)
    :requires_skill("fabrication", 6)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

-- Survivor expands the drybag a bit, reinforces it and adds compression straps to the side, along with
-- making other personal adjustments.
content.add(content.Recipe {
    id = "survivor_dry_duffelbag",
    result = "survivor_dry_duffelbag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 7,
}
    :component("dry_duffelbag", 1)
    :requirement("tailoring_lycra_patchwork", 20)
    :requirement("waterproofing_plastic_sheets", 16)
    :requires_skill("fabrication", 6)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "light_load_bearing_vest",
    result = "light_load_bearing_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 4860000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 540000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_nylon_patchwork", 12)
    :requirement("strap_small", 3)
    :requirement("filament", 3)
    :requires_skill("fabrication", 3)
)

content.add(content.Recipe {
    id = "load_bearing_vest",
    result = "load_bearing_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 13860000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 540000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_nylon_patchwork", 30)
    :requirement("strap_small", 6)
    :requirement("filament", 6)
    :requires_skill("fabrication", 3)
)

content.add(content.Recipe {
    id = "heavy_load_bearing_vest",
    result = "heavy_load_bearing_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 21240000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 540000,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("tailoring_nylon_patchwork", 45)
    :requirement("strap_small", 10)
    :requirement("filament", 10)
    :requires_skill("fabrication", 3)
)

content.add(content.Recipe {
    id = "heavy_load_bearing_vest_breacher",
    result = "heavy_load_bearing_vest_breacher",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 21600000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("single_sling", 1)
    :component("magnet", 2)
    :requirement("tailoring_nylon_patchwork", 45)
    :requirement("strap_small", 10)
    :requirement("filament", 10)
    :requires_skill("fabrication", 3)
)

content.add(content.Recipe {
    id = "survivor_pack",
    result = "survivor_pack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component("canvas_patch", 50)
    :component_any({
            { id = "backpack", count = 1 },
            { id = "backpack_leather", count = 1 },
            { id = "molle_pack", count = 1 }
        })
    :component("plastic_sheet", 1)
    :component_any({
            { id = "tacvest", count = 1 },
            { id = "legrig", count = 1 },
            { id = "vest", count = 1 },
            { id = "tool_belt", count = 1 },
            { id = "ragpouch", count = 4 },
            { id = "leather_pouch", count = 2 },
            { id = "dump_pouch", count = 1 },
            { id = "purse", count = 2 },
            { id = "fanny", count = 2 }
        })
    :component("duct_tape", 120)
    :requirement("sewing_standard", 120)
    :requirement("tailoring_leather_small", 10)
    :requirement("fastener_large", 2)
    :requires_skill("fabrication", 4)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "survivor_rucksack",
    result = "survivor_rucksack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2700000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component("canvas_patch", 64)
    :component_any({
            { id = "backpack", count = 1 },
            { id = "backpack_leather", count = 1 },
            { id = "molle_medium_rucksack", count = 1 },
            { id = "molle_large_rucksack", count = 1 },
            { id = "rucksack", count = 1 }
        })
    :component("plastic_sheet", 1)
    :component_any({
            { id = "tacvest", count = 1 },
            { id = "legrig", count = 1 },
            { id = "vest", count = 1 },
            { id = "tool_belt", count = 1 },
            { id = "ragpouch", count = 4 },
            { id = "leather_pouch", count = 2 },
            { id = "dump_pouch", count = 1 },
            { id = "purse", count = 2 },
            { id = "fanny", count = 2 }
        })
    :component("duct_tape", 160)
    :requirement("sewing_standard", 160)
    :requirement("tailoring_leather_small", 16)
    :requirement("fastener_large", 3)
    :requires_skill("fabrication", 5)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "survivor_runner_pack",
    result = "survivor_runner_pack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 420000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("canvas_patch", 26)
    :component_any({
            { id = "runner_bag", count = 1 },
            { id = "backpack", count = 1 },
            { id = "backpack_leather", count = 1 }
        })
    :component("plastic_sheet", 1)
    :component_any({
            { id = "tacvest", count = 1 },
            { id = "legrig", count = 1 },
            { id = "vest", count = 1 },
            { id = "tool_belt", count = 1 },
            { id = "ragpouch", count = 4 },
            { id = "leather_pouch", count = 2 },
            { id = "dump_pouch", count = 1 },
            { id = "purse", count = 2 },
            { id = "fanny", count = 2 }
        })
    :component("duct_tape", 80)
    :requirement("sewing_standard", 80)
    :requirement("tailoring_leather_small", 8)
    :requirement("fastener_large", 1)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
    :proficiency("prof_elastics")
)

content.add(content.Recipe {
    id = "survivor_dry_bag",
    result = "survivor_dry_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2520000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 6,
}
    :component("lycra_patch", 50)
    :component("dry_bag", 1)
    :component("plastic_sheet", 4)
    :component("duct_tape", 120)
    :requirement("sewing_standard", 120)
    :requirement("tailoring_lycra_patchwork", 10)
    :requirement("fastener_small", 1)
    :requires_skill("fabrication", 4)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :byproduct("scrap_lycra", 9)
)

content.add(content.Recipe {
    id = "survivor_vest",
    result = "survivor_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("canvas_patch", 22)
    :component_any({
            { id = "holster", count = 1 },
            { id = "sholster", count = 1 }
        })
    :component("leather_pouch", 3)
    :component("duct_tape", 50)
    :requirement("sewing_standard", 100)
    :requirement("tailoring_leather_small", 6)
    :requirement("fastener_large", 1)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "xs_survivor_vest",
    result = "xs_survivor_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("canvas_patch", 18)
    :component_any({
            { id = "holster", count = 1 },
            { id = "sholster", count = 1 }
        })
    :component("leather_pouch", 2)
    :component("duct_tape", 38)
    :requirement("sewing_standard", 75)
    :requirement("tailoring_leather_small", 4)
    :requirement("fastener_large", 1)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "xl_survivor_vest",
    result = "xl_survivor_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 4860000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("canvas_patch", 28)
    :component_any({
            { id = "holster", count = 1 },
            { id = "sholster", count = 1 }
        })
    :component("leather_pouch", 3)
    :component("duct_tape", 80)
    :requirement("sewing_standard", 150)
    :requirement("tailoring_leather_small", 9)
    :requirement("fastener_large", 2)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "swag_bag",
    result = "swag_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 3600,
    activity_level = NO_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "survival",
    flags = { "BLIND_EASY" },
}
    :component("bag_canvas", 1)
)

content.add(content.Recipe {
    id = "tool_belt",
    result = "tool_belt",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 60000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("leather_pouch", 2)
    :component("leather_belt", 1)
    :requirement("tailoring_leather_small", 12)
    :requirement("clasps", 5)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "javelin_bag",
    result = "javelin_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("strap_large", 1, true)
    :requirement("tailoring_leather_patchwork_simple", 3)
    :requirement("fastener_large", 2)
    :requires_skill("throw", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "grenadebandolier",
    result = "grenadebandolier",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("strap_large", 2)
    :requirement("tailoring_nylon_patchwork", 14)
    :requires_skill("gun", 1)
    :requires_skill("throw", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "bigback",
    result = "bigback",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 6480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("sheet_metal_small", 8)
    :component("strap_large", 2, true)
    :quality("HAMMER", 2, 1)
    :requirement("tailoring_leather_small", 44)
    :requirement("fastener_large", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "golf_bag",
    result = "golf_bag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :component("scrap", 4)
    :quality("HAMMER", 2, 1)
    :requirement("tailoring_nylon_patchwork", 12)
    :requirement("fastener_small", 2)
    :requirement("plastic_molding", 6)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "mbag",
    result = "mbag",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_nylon_patchwork", 18)
    :requirement("fastener_large", 2)
    :requirement("plastic_molding", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "rucksack",
    result = "rucksack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("strap_large", 2)
    :requirement("tailoring_nylon_patchwork", 28)
    :requirement("fastener_large", 3)
    :requirement("plastic_molding", 4)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "molle_pack",
    result = "molle_pack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 10800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("strap_large", 2)
    :requirement("tailoring_nylon_patchwork", 24)
    :requirement("fastener_large", 3)
    :requirement("plastic_molding", 4)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "molle_medium_rucksack",
    result = "molle_medium_rucksack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 12960000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("strap_large", 2)
    :requirement("tailoring_nylon_patchwork", 36)
    :requirement("fastener_large", 3)
    :requirement("plastic_molding", 6)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "molle_large_rucksack",
    result = "molle_large_rucksack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 17280000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 5,
}
    :requirement("strap_large", 2)
    :requirement("tailoring_nylon_patchwork", 42)
    :requirement("fastener_large", 4)
    :requirement("plastic_molding", 8)
    :requires_skill("fabrication", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "travelpack",
    result = "travelpack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2700000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 210000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_large", 1, true)
    :requirement("tailoring_nylon_patchwork", 15)
    :requirement("fastener_large", 1)
    :requirement("waterproofing_plastic_sheets", 2)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "petpack",
    result = "petpack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2400000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    disassembly_moves = 210000,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :requirement("tailoring_nylon_patchwork", 22)
    :requirement("fastener_large", 1)
    :requirement("waterproofing_plastic_sheets", 2)
    :book("plastics_book", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "wicker_backpack",
    result = "wicker_backpack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 5760000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("plant_cordage", 16, true)
    :component("cordage", 2, true)
    :quality("CUT", 2, 1)
    :proficiency("prof_basketweaving")
)

content.add(content.Recipe {
    id = "backpack_tactical_large",
    result = "backpack_tactical_large",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 6480000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 360000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("strap_large", 2, true)
    :component("leather_pouch", 2)
    :requirement("tailoring_leather_small", 28)
    :requirement("fastener_large", 3)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "backpack_hiking",
    result = "backpack_hiking",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 5040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 360000,
    reversible = true,
    skill = "tailor",
    difficulty = 4,
}
    :component("strap_large", 2, true)
    :requirement("tailoring_leather_patchwork", 8)
    :requirement("fastener_large", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_leatherworking_basic")
    :proficiency("prof_leatherworking")
)

content.add(content.Recipe {
    id = "rifle_case_soft",
    result = "rifle_case_soft",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1440000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_canvas_patchwork", 13)
    :requirement("fastener_large", 2)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "rifle_case_soft_leather",
    result = "rifle_case_soft_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_large", 1, true)
    :requirement("tailoring_leather_patchwork", 4)
    :requirement("fastener_large", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "rifle_case_soft_2",
    result = "rifle_case_soft_2",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1620000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    disassembly_moves = 150000,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component("strap_large", 1, true)
    :requirement("tailoring_canvas_patchwork", 17)
    :requirement("fastener_large", 3)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "rifle_case_soft_leather_2",
    result = "rifle_case_soft_leather_2",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1980000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_large", 1, true)
    :requirement("tailoring_leather_patchwork", 4)
    :requirement("fastener_large", 3)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "rifle_case_xl_soft_leather",
    result = "rifle_case_xl_soft_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 2040000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("strap_large", 1, true)
    :requirement("tailoring_leather_patchwork", 4)
    :requirement("fastener_large", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "wallet_duct_tape",
    result = "wallet_duct_tape",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 60000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "fabrication",
    difficulty = 1,
}
    :component("duct_tape", 10)
)

content.add(content.Recipe {
    id = "wallet_leather",
    result = "wallet_leather",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_leather_small", 1)
    :requirement("fastener_small", 1)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "ankle_wallet_pouch",
    result = "ankle_wallet_pouch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :requirement("tailoring_nylon_patchwork", 1)
    :requirement("fastener_small", 1)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
)

content.add(content.Recipe {
    id = "bookstrap",
    result = "bookstrap",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 540000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :requirement("tailoring_leather_small", 4)
    :requirement("clasps", 2)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "rope_loop",
    result = "rope_loop",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 36000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
}
    :component("rope_any_short", 1, true)
)

content.add(content.Recipe {
    id = "suspenders_holster",
    result = "suspenders_holster",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("holster", 1)
    :requirement("tailoring_leather_small", 4)
    :requirement("clasps", 3)
    :proficiency("prof_closures")
    :proficiency("prof_leatherworking_basic")
)

content.add(content.Recipe {
    id = "trapper_pack",
    result = "trapper_pack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1080000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :requirement("strap_large", 3)
    :requirement("tailoring_canvas_patchwork", 5)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "bigtrapper_pack",
    result = "bigtrapper_pack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 1800000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 4 },
            { id = "stick", count = 8 }
        })
    :requirement("strap_large", 3)
    :requirement("tailoring_canvas_patchwork", 8)
    :proficiency("prof_closures")
    :proficiency("prof_closures_waterproofing")
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "frame_pack",
    result = "frame_pack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 2,
}
    :component_any({
            { id = "2x4", count = 2 },
            { id = "stick", count = 4 }
        })
    :requirement("strap_large", 3)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "bigframe_pack",
    result = "bigframe_pack",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_STORAGE",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 3,
}
    :component_any({
            { id = "2x4", count = 4 },
            { id = "stick", count = 8 }
        })
    :requirement("strap_large", 3)
    :proficiency("prof_carving")
)

content.add(content.Recipe {
    id = "bandolier_pipebomb",
    result = "bandolier_pipebomb",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("clasps", 7, true)
    :requirement("tailoring_nylon", 21)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "bandolier_pipebomb_xs",
    result = "bandolier_pipebomb_xs",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("clasps", 5, true)
    :requirement("tailoring_nylon", 16)
    :proficiency("prof_closures")
)

content.add(content.Recipe {
    id = "bandolier_pipebomb_xl",
    result = "bandolier_pipebomb_xl",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 4320000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "tailor",
    difficulty = 3,
}
    :component("clasps", 9, true)
    :requirement("tailoring_nylon", 28)
    :proficiency("prof_closures")
)
