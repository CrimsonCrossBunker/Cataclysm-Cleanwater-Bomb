local ccb = require("ccb")
local content = ccb.content

do
    local group = content.NestedRecipeCategory {
        id = "fcl_nested_atomic_battery",
        name = ccb.content.text("atomic batteries"),
        description = ccb.content.text("Recipes related to constructing complex atomic battery cells."),
        category = "CC_ELECTRONIC",
        subcategory = "CSC_ELECTRONIC_PARTS",
        activity_level = 2,
        skill = "electronics",
        difficulty = 6,
    }
    group:recipe("fcl_light_minus_atomic_battery_cell", true)
    group:recipe("fcl_light_atomic_battery_cell", true)
    group:recipe("fcl_medium_atomic_battery_cell", true)
    group:recipe("heavy_atomic_battery_cell", true)
    content.add(group)
end
