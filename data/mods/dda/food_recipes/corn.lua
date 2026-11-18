local content = require("ccb").content

local LIGHT_EXERCISE = 2

-- 17u for corn (840g), 1u for oil
content.add(content.Recipe {
    id = "pan_roasted_corn",
    result = "pan_roasted_corn",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 120000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 18, true)
    :component("veggy_any_corn_uncooked", 4, true)
    :component_any({
            { id = "salt", count = 2 },
            { id = "saline", count = 2 },
            { id = "seasoning_salt", count = 2 },
            { id = "soysauce", count = 1 }
        })
    :component_any({
            { id = "seasoning_italian", count = 3 },
            { id = "wild_herbs", count = 3 },
            { id = "wild_garlic", count = 3 },
            { id = "pepper", count = 3 },
            { id = "cinnamon", count = 3 },
            { id = "chilly-p", count = 3 },
            { id = "curry_powder", count = 3 },
            { id = "mustard_powder", count = 3 },
            { id = "garlic_clove", count = 2 },
            { id = "rehydrated_garlic", count = 2 }
        })
    :component("any_butter_or_oil", 1, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 2, 1)
    :batch_discount(50, 2)
    :result_charges(4)
)

-- corncob weighs 690g, so about 14u heat + 1u for the oil
content.add(content.Recipe {
    id = "corn_on_cob",
    result = "corn_on_cob",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
}
    :tool_charges("surface_heat", 15, true)
    :component_any({
            { id = "corn", count = 1 },
            { id = "popcorn_cob", count = 1 }
        })
    :component_any({
            { id = "salt", count = 1 },
            { id = "seasoning_salt", count = 1 },
            { id = "soysauce", count = 1 }
        })
    :component_any({
            { id = "seasoning_italian", count = 1 },
            { id = "wild_herbs", count = 1 },
            { id = "pepper", count = 1 },
            { id = "cinnamon", count = 1 },
            { id = "chilly-p", count = 1 },
            { id = "curry_powder", count = 1 },
            { id = "mustard_powder", count = 1 }
        })
    :component("any_butter_or_oil", 2, true)
    :component("aluminum_foil", 1)
    :quality("COOK", 1, 1)
    :batch_discount(80, 2)
    :result_charges(1)
)
