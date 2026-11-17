local ccb = require("ccb")
local content = ccb.content

do
    local group = content.NestedRecipeCategory {
        id = "nested_eggs_tame",
        name = ccb.content.text("tame eggs"),
        description = ccb.content.text("Recipes related to taming the eggs of aggressive invertebrates."),
        category = "CC_FOOD",
        subcategory = "CSC_FOOD_OTHER",
        activity_level = 4,
        skill = "survival",
        difficulty = 5,
    }
    group:recipe("egg_dragonfly_tame", true)
    group:recipe("egg_mantis_tame", true)
    group:recipe("egg_lady_bug_tame", true)
    group:recipe("egg_antlion_tame", true)
    group:recipe("egg_cicada_tame", true)
    group:recipe("egg_water_beetle_tame", true)
    group:recipe("egg_water_bug_tame", true)
    group:recipe("egg_centipede_tame", true)
    content.add(group)
end
