local content = require("ccb").content

local LIGHT_EXERCISE = 2

content.add(content.Recipe {
    id = "sporeos",
    result = "sporeos",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_SNACK",
    duration_moves = 1000,
    activity_level = LIGHT_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 1,
}
    :component("cookies", 4)
    :component_any({
            { id = "marloss_berry", count = 1 },
            { id = "marloss_seed", count = 1 },
            { id = "mycus_fruit", count = 1 }
        })
    :quality("COOK", 2, 1)
    :result_charges(4)
)
