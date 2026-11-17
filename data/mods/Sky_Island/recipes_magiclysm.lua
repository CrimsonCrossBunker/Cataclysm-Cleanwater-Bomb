local ccb = require("ccb")
local content = ccb.content
local warped_recipe = require("recipes")

do
    local recipe = warped_recipe {
        id = "warp_druid_wood_floor_tokens",
        result = "warp_druid_wood_floor_tokens",
        subcategory = "CSC_WARP_ITEMS",
        duration_moves = 6000,
        autolearn = true,
    }
    recipe:result_charges(50)
    recipe:tool_any { { id = "fakeitem_statue", count = 1 } }
    recipe:component_any { { id = "warptoken", count = 1 } }
    recipe:component_any { { id = "leaves", count = 15 } }
    recipe:component_any { { id = "stick", count = 3 }, { id = "twig", count = 12 } }
    content.upsert(recipe)
end
