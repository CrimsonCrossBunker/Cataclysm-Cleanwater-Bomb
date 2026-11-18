local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "combat_exoskeleton_armor_head_heavy_reinforced",
    result = "combat_exoskeleton_armor_head_heavy_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("qt_link_sheet", 1)
    :component("qt_chain_link", 20)
    :component("qt_wire", 1)
    :component("combat_exoskeleton_armor_head_heavy", 1)
    :requirement("chainmail_standard", 1)
    :requirement("welding_standard", 100)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "combat_exoskeleton_armor_torso_heavy_reinforced",
    result = "combat_exoskeleton_armor_torso_heavy_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1170000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("qt_link_sheet", 2)
    :component("qt_chain_link", 45)
    :component("qt_wire", 1)
    :component("combat_exoskeleton_armor_torso_heavy", 1)
    :requirement("chainmail_standard", 2)
    :requirement("welding_standard", 200)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "combat_exoskeleton_armor_arm_heavy_reinforced",
    result = "combat_exoskeleton_armor_arm_heavy_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("qt_link_sheet", 1)
    :component("qt_chain_link", 25)
    :component("qt_wire", 1)
    :component("combat_exoskeleton_armor_arm_heavy", 1)
    :requirement("chainmail_standard", 1)
    :requirement("welding_standard", 100)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "combat_exoskeleton_armor_leg_heavy_reinforced",
    result = "combat_exoskeleton_armor_leg_heavy_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("qt_link_sheet", 1)
    :component("qt_chain_link", 25)
    :component("qt_wire", 1)
    :component("combat_exoskeleton_armor_leg_heavy", 1)
    :requirement("chainmail_standard", 1)
    :requirement("welding_standard", 100)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "combat_exoskeleton_armor_head_medium_reinforced",
    result = "combat_exoskeleton_armor_head_medium_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("qt_link_sheet", 1)
    :component("qt_chain_link", 20)
    :component("qt_wire", 1)
    :component("combat_exoskeleton_armor_head_medium", 1)
    :requirement("chainmail_standard", 1)
    :requirement("welding_standard", 100)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "combat_exoskeleton_armor_torso_medium_reinforced",
    result = "combat_exoskeleton_armor_torso_medium_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1170000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("qt_link_sheet", 2)
    :component("qt_chain_link", 45)
    :component("qt_wire", 1)
    :component("combat_exoskeleton_armor_torso_medium", 1)
    :requirement("chainmail_standard", 2)
    :requirement("welding_standard", 200)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "combat_exoskeleton_armor_arm_medium_reinforced",
    result = "combat_exoskeleton_armor_arm_medium_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("qt_link_sheet", 1)
    :component("qt_chain_link", 25)
    :component("qt_wire", 1)
    :component("combat_exoskeleton_armor_arm_medium", 1)
    :requirement("chainmail_standard", 1)
    :requirement("welding_standard", 100)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "combat_exoskeleton_armor_leg_medium_reinforced",
    result = "combat_exoskeleton_armor_leg_medium_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("qt_link_sheet", 1)
    :component("qt_chain_link", 25)
    :component("qt_wire", 1)
    :component("combat_exoskeleton_armor_leg_medium", 1)
    :requirement("chainmail_standard", 1)
    :requirement("welding_standard", 100)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "combat_exoskeleton_armor_head_light_reinforced",
    result = "combat_exoskeleton_armor_head_light_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("qt_link_sheet", 1)
    :component("qt_chain_link", 20)
    :component("qt_wire", 1)
    :component("combat_exoskeleton_armor_head_light", 1)
    :requirement("chainmail_standard", 1)
    :requirement("welding_standard", 100)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "combat_exoskeleton_armor_torso_light_reinforced",
    result = "combat_exoskeleton_armor_torso_light_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1170000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("qt_link_sheet", 2)
    :component("qt_chain_link", 45)
    :component("qt_wire", 1)
    :component("combat_exoskeleton_armor_torso_light", 1)
    :requirement("chainmail_standard", 2)
    :requirement("welding_standard", 200)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "combat_exoskeleton_armor_arm_light_reinforced",
    result = "combat_exoskeleton_armor_arm_light_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("qt_link_sheet", 1)
    :component("qt_chain_link", 25)
    :component("qt_wire", 1)
    :component("combat_exoskeleton_armor_arm_light", 1)
    :requirement("chainmail_standard", 1)
    :requirement("welding_standard", 100)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)

content.add(content.Recipe {
    id = "combat_exoskeleton_armor_leg_light_reinforced",
    result = "combat_exoskeleton_armor_leg_light_reinforced",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 8,
}
    :component("qt_link_sheet", 1)
    :component("qt_chain_link", 25)
    :component("qt_wire", 1)
    :component("combat_exoskeleton_armor_leg_light", 1)
    :requirement("chainmail_standard", 1)
    :requirement("welding_standard", 100)
    :book("textbook_armwest", 6)
    :book("textbook_fabrication", 6)
    :book("recipe_melee", 6)
    :proficiency("prof_chain_armour")
)
