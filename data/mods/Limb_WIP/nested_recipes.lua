local ccb = require("ccb")
local content = ccb.content

do
    local group = content.NestedRecipeCategory {
        id = "nested_all_prosthetic_arms",
        name = ccb.content.text("prosthetic arms"),
        description = ccb.content.text("Recipes related to constructing prosthetic arms of varying materials and designs."),
        category = "CC_ARMOR",
        subcategory = "CSC_ARMOR_ARMS",
        activity_level = 4,
        skill = "fabrication",
        difficulty = 4,
    }
    group:recipe("right_arm_prosthetic_wood_old", true)
    group:recipe("left_arm_prosthetic_wood_old", true)
    group:recipe("right_arm_prosthetic_steel_old", true)
    group:recipe("left_arm_prosthetic_steel_old", true)
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "nested_all_prosthetic_legs",
        name = ccb.content.text("prosthetic legs"),
        description = ccb.content.text("Recipes related to constructing prosthetic legs of varying materials and designs."),
        category = "CC_ARMOR",
        subcategory = "CSC_ARMOR_LEGS",
        activity_level = 4,
        skill = "fabrication",
        difficulty = 4,
    }
    group:recipe("right_peg_leg_old", true)
    group:recipe("left_peg_leg_old", true)
    group:recipe("right_leg_prosthetic_steel_old", true)
    group:recipe("left_leg_prosthetic_steel_old", true)
    content.add(group)
end
