local content = require("ccb").content

local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "exo_helmet_steel",
    result = "exo_helmet_steel",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool("swage", 1)
    :tool("metal_tank", 1)
    :tool("water", 120)
    :component("damaged_exo_helmet_steel", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 16)
    :requirement("mc_steel_standard", 6)
    :book("textbook_armwest", 7)
    :book("welding_book", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "exo_torso_steel",
    result = "exo_torso_steel",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 8640000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool("swage", 1)
    :tool("metal_tank", 1)
    :tool("water", 120)
    :component("damaged_exo_torso_steel", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 32)
    :requirement("mc_steel_standard", 10)
    :book("textbook_armwest", 7)
    :book("welding_book", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "exo_arm_steel",
    result = "exo_arm_steel",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool("swage", 1)
    :tool("metal_tank", 1)
    :tool("water", 120)
    :component("damaged_exo_arm_steel", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("mc_steel_standard", 9)
    :book("textbook_armwest", 7)
    :book("welding_book", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "exo_leg_steel",
    result = "exo_leg_steel",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2880000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 9,
}
    :tool("swage", 1)
    :tool("metal_tank", 1)
    :tool("water", 120)
    :component("damaged_exo_leg_steel", 1)
    :quality("CHISEL", 3, 1)
    :requirement("blacksmithing_standard", 24)
    :requirement("mc_steel_standard", 9)
    :book("textbook_armwest", 7)
    :book("welding_book", 7)
    :proficiency("prof_armorsmithing")
    :proficiency("prof_metalworking")
    :proficiency("prof_blacksmithing")
    :proficiency("prof_tempering", { skill_penalty = 1 })
)

content.add(content.Recipe {
    id = "exo_helmet_plastic",
    result = "exo_helmet_plastic",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("damaged_exo_helmet_plastic", 1)
    :requirement("plastic_molding", 4)
    :requirement("soldering_standard", 10)
    :book("plastics_book", 7)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "exo_torso_plastic",
    result = "exo_torso_plastic",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 2880000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("damaged_exo_torso_plastic", 1)
    :requirement("plastic_molding", 8)
    :requirement("soldering_standard", 20)
    :book("plastics_book", 7)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "exo_arm_plastic",
    result = "exo_arm_plastic",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_ARMS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("damaged_exo_arm_plastic", 1)
    :requirement("plastic_molding", 6)
    :requirement("soldering_standard", 15)
    :book("plastics_book", 7)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "exo_leg_plastic",
    result = "exo_leg_plastic",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_LEGS",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 7,
}
    :component("damaged_exo_leg_plastic", 1)
    :requirement("plastic_molding", 6)
    :requirement("soldering_standard", 15)
    :book("plastics_book", 7)
    :proficiency("prof_plasticworking")
)

content.add(content.Recipe {
    id = "afs_titanium_vest",
    result = "afs_titanium_vest",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_TORSO",
    duration_moves = 10000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    reversible = true,
    skill = "tailor",
    difficulty = 1,
}
    :component("afs_scrap_titanium", 8)
    :component("cotton_patchwork", 6)
    :requirement("sewing_standard", 14)
)

content.add(content.Recipe {
    id = "afs_recall_rig",
    result = "afs_recall_rig",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_OTHER",
    duration_moves = 2160000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "electronics",
    difficulty = 7,
}
    :component("afs_circuitry_3", 3)
    :component("afs_energy_storage_3", 1)
    :component("afs_cloth_4", 1)
    :quality("SCREW_FINE", 1, 1)
    :requirement("soldering_standard", 10)
    :requirement("strap_small", 1)
    :requirement("clasps", 3)
    :requires_skill("chemistry", 6)
)
