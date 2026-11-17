local ccb = require("ccb")
local content = ccb.content

do
    local group = content.NestedRecipeCategory {
        id = "test_nested_outer",
        name = ccb.content.text("test nested outer"),
        description = ccb.content.text("Nested category whose second child is itself a nested category."),
        category = "CC_WEAPON",
        subcategory = "CSC_WEAPON_BASHING",
        activity_level = 1,
        skill = "fabrication",
        difficulty = 0,
    }
    group:recipe("test_tallow")
    group:recipe("test_nested_weapons")
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "test_nested_gate_charged",
        name = ccb.content.text("test nested charged tool"),
        description = ccb.content.text("Nested category whose only child needs a charged tool."),
        category = "CC_WEAPON",
        subcategory = "CSC_WEAPON_BASHING",
        activity_level = 1,
        skill = "fabrication",
        difficulty = 0,
    }
    group:recipe("cudgel_test_charged_fast_stepless")
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "test_nested_gate_prof",
        name = ccb.content.text("test nested required proficiency"),
        description = ccb.content.text("Nested category whose only child requires a proficiency."),
        category = "CC_WEAPON",
        subcategory = "CSC_WEAPON_BASHING",
        activity_level = 1,
        skill = "fabrication",
        difficulty = 0,
    }
    group:recipe("cudgel_test_steps_required_prof")
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "test_nested_gate_charreq",
        name = ccb.content.text("test nested character requirement"),
        description = ccb.content.text("Nested category whose only child requires a minimum strength."),
        category = "CC_WEAPON",
        subcategory = "CSC_WEAPON_BASHING",
        activity_level = 1,
        skill = "fabrication",
        difficulty = 0,
    }
    group:recipe("cudgel_character_requirements_restricted")
    content.add(group)
end

do
    local group = content.NestedRecipeCategory {
        id = "test_nested_weapons",
        name = ccb.content.text("test nested weapons"),
        description = ccb.content.text("Test nested category for crafting GUI tests."),
        category = "CC_WEAPON",
        subcategory = "CSC_WEAPON_BASHING",
        activity_level = 1,
        skill = "fabrication",
        difficulty = 0,
    }
    group:recipe("cudgel_test_no_tools")
    content.add(group)
end
