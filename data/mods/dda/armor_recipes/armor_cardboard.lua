local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "helmet_cardboard",
    result = "helmet_cardboard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("cardboard", 300)
    :component("aluminum_foil", 5)
    :quality("CUT", 1, 1)
    :requirement("adhesive", 2)
    :requires_skill("fabrication", 1)
    :book("recipe_dave_manual", 1)
)

content.add(content.Recipe {
    id = "armor_cardboard",
    result = "armor_cardboard",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_SUIT",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 3,
}
    :component("cardboard", 2000)
    :component("paper", 60)
    :quality("CUT", 1, 1)
    :requirement("adhesive", 15)
    :requires_skill("fabrication", 2)
    :book("recipe_dave_manual", 1)
)

content.add(content.Recipe {
    id = "armor_cardboard_cuirass",
    result = "armor_cardboard_cuirass",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 900000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    difficulty = 2,
}
    :component("cardboard", 1200)
    :component("paper", 20)
    :quality("CUT", 1, 1)
    :requirement("adhesive", 10)
    :requires_skill("fabrication", 1)
    :book("recipe_dave_manual", 1)
)

content.add(content.Recipe {
    id = "cardboard_crown",
    result = "cardboard_crown",
    category = "CC_ARMOR",
    subcategory = "CSC_ARMOR_HEAD",
    duration_moves = 30000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "fabrication",
}
    :component("cardboard", 100)
    :quality("CUT", 1, 1)
    :book("recipe_dave_manual", 0)
)
