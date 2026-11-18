local content = require("ccb").content

local NO_EXERCISE = 1
local LIGHT_EXERCISE = 2

-- barely any cooking going on here
content.add(content.Recipe {
    id = "sauerkraut_ferment_active",
    result = "sauerkraut_ferment_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 4, true)
    :component("water_clean", 1)
    :component_any({
            { id = "salt_water", count = 1 },
            { id = "saline", count = 2 },
            { id = "salt", count = 2 }
        })
    :component("jar_glass_sealed", 1)
    :component_any({
            { id = "veggy", count = 2 },
            { id = "lettuce", count = 2 },
            { id = "veggy_wild", count = 2 },
            { id = "cabbage", count = 2 }
        })
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("fermenting_book", 2)
    :book("cookbook_foodfashions", 4)
    :proficiency("prof_knife_skills")
    :proficiency("prof_fermenting")
    :proficiency("prof_lactofermenting")
)

-- barely any cooking going on here
content.add(content.Recipe {
    id = "pickles_ferment_active",
    result = "pickles_ferment_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_VEGGI",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 2, true)
    :component("water_clean", 1)
    :component("vinegar", 1)
    :component_any({
            { id = "saline", count = 1 },
            { id = "salt", count = 2 }
        })
    :component("jar_glass_sealed", 1)
    :component("any_gherkin_cucumber", 8, true)
    :quality("CUT", 2, 1)
    :quality("COOK", 3, 1)
    :book("fermenting_book", 3)
    :proficiency("prof_fermenting")
    :proficiency("prof_lactofermenting")
)

-- eggs are already cooked so no need to make this high
content.add(content.Recipe {
    id = "eggs_ferment_active",
    result = "eggs_ferment_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_OTHER",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 10, true)
    :component("water_clean", 1)
    :component("vinegar", 1)
    :component_any({
            { id = "saline", count = 1 },
            { id = "salt", count = 2 }
        })
    :component("jar_glass_sealed", 1)
    :component("boiled_egg", 10)
    :quality("COOK", 3, 1)
    :book("fermenting_book", 4)
    :proficiency("prof_fermenting")
    :proficiency("prof_lactofermenting")
)

-- Should be taught by a flag/mutation rather than autolearned
-- 1u for fruit, then 6u to heat the water & activate the yeast
content.add(content.Recipe {
    id = "brew_mycus_wine",
    result = "brew_mycus_wine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 40000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 7, true)
    :component("water_clean", 3)
    :component("mycus_fruit", 1)
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_winemaking")
    :batch_discount(80, 4)
    :result_charges(5)
)

-- Should be taught by a flag/mutation rather than autolearned
-- 1u for fruit, then 6u to heat the water & activate the yeast
content.add(content.Recipe {
    id = "brew_marloss_wine",
    result = "brew_marloss_wine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 40000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 7, true)
    :component("water_clean", 3)
    :component("marloss_berry", 1)
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_winemaking")
    :batch_discount(80, 4)
    :result_charges(5)
)

content.add(content.Recipe {
    id = "brew_milk_curdled",
    result = "brew_milk_curdled",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :component("vinegar", 3)
    :component_any({
            { id = "wild_herbs", count = 40 },
            { id = "meat_stomach", count = 1, requirement = true }
        })
    :requirement("milk_standard_raw_fresh", 15)
    :requires_skill("survival", 4)
    :book("survival_book", 3)
    :book("textbook_survival", 3)
    :book("manual_survival", 3)
    :book("dairy_book", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_cheesemaking_1")
    :batch_discount(50, 4)
    :result_charges(18)
)

-- assuming grains are roasted, that's 52u flour by weight, plus 6u to heat water and activate yeast
-- Using 3x250ml of water, this should give us ~750ml of product. For brew_whiskey it is 7 charges
-- per 250ml. Hence 3x7=21 charges
content.add(content.Recipe {
    id = "brew_whiskey",
    result = "brew_whiskey",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 58, true)
    :component("water_clean", 3)
    :component("malted_grain", 2)
    :component("sugar", 50)
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :book("distilling_cookbook", 5)
    :book("scots_cookbook", 5)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_brewing")
    :batch_discount(95, 4)
    :result_charges(21)
)

-- assuming grains are roasted, slightly variable weight roughly close to 20u flour, +10u for the junipers
-- Using 2x250ml of water, this should give us ~500ml of product. For brew_gin it is 7 charges
-- per 250ml. Hence 2x7=14 charges
content.add(content.Recipe {
    id = "brew_gin",
    result = "brew_gin",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 30, true)
    :component("water_clean", 2)
    :component_any({
            { id = "corn", count = 3 },
            { id = "popcorn_cob", count = 3 },
            { id = "cornmeal", count = 5 },
            { id = "barley", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "oats", count = 3 }
        })
    :component("juniper", 10)
    :quality("BOIL", 2, 1)
    :book("distilling_cookbook", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_brewing")
    :batch_discount(95, 4)
    :result_charges(14)
)

content.add(content.Recipe {
    id = "brew_sake_koji_active",
    result = "brew_sake_koji_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :component("rice_cooked", 1)
    :component("water_clean", 1)
    :component("koji", 1)
    :component("yeast", 1)
    :quality("CONTAIN", 1, 1)
    :book("brewing_cookbook", 6)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_brewing")
    :batch_discount(95, 4)
)

-- Using 3x250ml of water, this should give us ~750ml of product. For brew_sake it is 7 charges
-- per 250ml. Hence 3x7=21 charges
content.add(content.Recipe {
    id = "brew_sake",
    result = "brew_sake",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :component("sake_koji_rice", 1)
    :component("rice_cooked", 1)
    :component("water_clean", 3)
    :component("yeast", 1)
    :quality("CONTAIN", 1, 1)
    :book("brewing_cookbook", 6)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_brewing")
    :batch_discount(95, 4)
    :result_charges(21)
)

content.add(content.Recipe {
    id = "sake_filtered",
    result = "sake_filtered",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 30000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 3,
}
    :component("sake_unfiltered", 1)
    :quality("STRAIN", 2, 1)
    :book("brewing_cookbook", 6)
    :batch_discount(50, 4)
    :result_charges(1)
)

-- Using 3x250ml of water, this should give us ~750ml of product. For brew_soy_sauce it is 10 charges
-- per 250ml. Hence 3x10=30 charges
content.add(content.Recipe {
    id = "brew_soy_sauce",
    result = "brew_soy_sauce",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :component("soy_wheat_dough_done", 1)
    :component("water_clean", 3)
    :component("salt", 30)
    :quality("CONTAIN", 1, 1)
    :book("cookbook_sushi", 6)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :batch_discount(95, 4)
    :result_charges(30)
)

-- unsure if wheat needs roasted here but sugar doesn't. 6u to heat the water & activate the yeast
-- Using 3x250ml of water, this should give us ~750ml of product. For brew_vodka it is 7 charges per 250ml.
-- Hence 3x7=21 charges
content.add(content.Recipe {
    id = "brew_vodka",
    result = "brew_vodka",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = true,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 6, true)
    :component("water_clean", 3)
    :component_any({
            { id = "molasses", count = 5 },
            { id = "wheat", count = 1 },
            { id = "barley", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "sugar", count = 50 },
            { id = "sweet_water", count = 5 },
            { id = "sugar_beet", count = 1 }
        })
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :learn_automatically("cooking", 7)
    :book("distilling_cookbook", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_brewing")
    :batch_discount(50, 4)
    :result_charges(21)
)

-- Using 3x250ml of water, this should give us ~750ml of product. For brew_rum it is 7 charges per 250ml.
-- Hence 3x7=21 charges
content.add(content.Recipe {
    id = "brew_rum",
    result = "brew_rum",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 2, true)
    :component("water_clean", 3)
    :component_any({
            { id = "molasses", count = 2 },
            { id = "sugar_beet", count = 1 }
        })
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :book("distilling_cookbook", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :batch_discount(95, 4)
    :result_charges(21)
)

-- 30u for corn and 30u to heat water & activate the yeast
-- Using 15x250ml of water, this should give us ~3750ml of product. For brew_moonshine it is 7 charges per
-- 250ml.
-- Hence 3750/250ml*7=105 charges
content.add(content.Recipe {
    id = "brew_moonshine",
    result = "brew_moonshine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 60, true)
    :component("water_clean", 15)
    :component_any({
            { id = "cornmeal", count = 12 },
            { id = "corn", count = 2 },
            { id = "popcorn_cob", count = 2 }
        })
    :component("sugar", 100)
    :component("yeast", 2)
    :quality("BOIL", 2, 1)
    :book("brewing_cookbook", 1)
    :book("family_cookbook", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_brewing")
    :batch_discount(95, 4)
    :result_charges(105)
)

-- 2u for fruit and 20u to heat the water & activate the yeast
-- Using 10x250ml of water, this should give us ~2500ml of product. For brew_hb_seltzer it is 1 charge per
-- 250ml.
-- Hence 2500/250*1=10 charges.
content.add(content.Recipe {
    id = "brew_hb_seltzer",
    result = "brew_hb_seltzer",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 22, true)
    :component("water_clean", 10)
    :component("sugar", 2)
    :component("yeast", 1)
    :component_any({
            { id = "juice", count = 2 },
            { id = "apple_cider", count = 4 },
            { id = "sweet_fruit", count = 1, requirement = true }
        })
    :quality("BOIL", 2, 1)
    :book("brewing_cookbook", 4)
    :book("winemaking_beginner", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_winemaking")
    :batch_discount(95, 4)
    :result_charges(10)
)

-- 24u for pumpkin and 30u to heat water & activate the yeast
-- Using 15x250ml of water, this should give us ~3750ml of product. For brew_moonshine it is 7 charges per
-- 250ml.
-- Hence 3750ml/250ml*7=105 charges
content.add(content.Recipe {
    id = "brew_moonshine_pumpkin",
    result = "brew_moonshine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :tool_charges("surface_heat", 54, true)
    :component("water_clean", 15)
    :component("pumpkin_cut", 12)
    :component("sugar", 50)
    :component("yeast", 2)
    :quality("BOIL", 2, 1)
    :book("distilling_cookbook", 1)
    :book("family_cookbook", 1)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :batch_discount(95, 4)
    :result_charges(105)
)

-- Using 2x250ml of water plus 2x125ml of juice, this should give us ~750ml of product. For brew_fruit_wine
-- it is 7 charges
-- per 250ml. Hence (750ml/250ml)x7=21 charges
content.add(content.Recipe {
    id = "brew_fruit_wine",
    result = "brew_fruit_wine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :component("juice", 2)
    :component("yeast", 1)
    :component("water_clean", 2)
    :quality("CONTAIN", 1, 1)
    :book("brewing_cookbook", 2)
    :book("winemaking_beginner", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_winemaking")
    :batch_discount(95, 4)
    :result_charges(21)
)

-- assuming grains are roasted, that's 52u flour by weight, 2u for hops, plus 20u to heat water and activate
-- yeast
-- Using 10x250ml of water, this should give us ~2500ml of product. For brew_hb_beer it is 1 charge per
-- 250ml.
-- Hence 2500ml/250ml*1=10 charges.
content.add(content.Recipe {
    id = "brew_hb_beer",
    result = "brew_hb_beer",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 74, true)
    :component("water_clean", 10)
    :component("malted_grain", 2)
    :component("hops", 1)
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :book("brewing_cookbook", 4)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_brewing")
    :batch_discount(95, 4)
    :result_charges(10)
)

-- Using 3x250ml of water, this should give us ~750ml of product. For brew_mead it is 7 charges per 250ml.
-- Hence (750ml/250ml)x7=21 charges
content.add(content.Recipe {
    id = "brew_mead",
    result = "brew_mead",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 12000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :component("water_clean", 3)
    :component_any({
            { id = "honey_bottled", count = 12 },
            { id = "honeycomb", count = 2 },
            { id = "honey_glassed", count = 4 }
        })
    :component("yeast", 1)
    :quality("CONTAIN", 1, 1)
    :book("brewing_cookbook", 2)
    :book("winemaking_beginner", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_winemaking")
    :batch_discount(95, 4)
    :result_charges(21)
)

-- 6u to heat water and activate yeast
-- Using 3x250ml of water, this should give us ~750ml of product. For brew_hopped_mead it is 7 charges per
-- 250ml
-- (copy from brew_mead). Hence (750ml/250ml)x7=21 charges
content.add(content.Recipe {
    id = "brew_hopped_mead",
    result = "brew_hopped_mead",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 4,
}
    :tool_charges("surface_heat", 6, true)
    :component("water_clean", 3)
    :component_any({
            { id = "honey_bottled", count = 12 },
            { id = "honeycomb", count = 2 },
            { id = "honey_glassed", count = 4 }
        })
    :component("hops", 1)
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :book("brewing_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_winemaking")
    :batch_discount(95, 4)
    :result_charges(21)
)

-- 6u to heat water and activate yeast
-- Using 3x250ml of water, this should give us ~750ml of product. For brew_spiced_mead it is 7 charges per
-- 250ml
-- (copy from brew_mead). Hence (750ml/250ml)x7=21 charges
content.add(content.Recipe {
    id = "brew_spiced_mead",
    result = "brew_spiced_mead",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 90000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 5,
}
    :tool_charges("surface_heat", 6, true)
    :component("water_clean", 3)
    :component_any({
            { id = "honey_bottled", count = 12 },
            { id = "honeycomb", count = 2 },
            { id = "honey_glassed", count = 4 }
        })
    :component_any({
            { id = "chilly-p", count = 50 },
            { id = "any_chili_pepper", count = 1, requirement = true },
            { id = "cinnamon", count = 25 },
            { id = "pepper", count = 50 },
            { id = "wild_herbs", count = 10 }
        })
    :component("yeast", 1)
    :quality("BOIL", 2, 1)
    :book("brewing_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_winemaking")
    :batch_discount(95, 4)
    :result_charges(21)
)

-- 6u to heat water and activate yeast, dandelions don't appear to be roasted here
-- Using 3x250ml of water, this should give us ~750ml of product. For brew_dandelion_wine it is 7 charges per
-- 250ml.
-- Hence (750ml/250ml)x7=21 charges
content.add(content.Recipe {
    id = "brew_dandelion_wine",
    result = "brew_dandelion_wine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :component("water_clean", 3)
    :component("soaked_dandelion", 10)
    :component_any({
            { id = "sugar_standard", count = 2, requirement = true },
            { id = "honeycomb", count = 1 }
        })
    :component("yeast", 1)
    :quality("CONTAIN", 1, 1)
    :book("brewing_cookbook", 3)
    :book("family_cookbook", 2)
    :book("survival_book", 3)
    :book("textbook_survival", 3)
    :book("manual_survival", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_winemaking")
    :batch_discount(95, 4)
    :result_charges(21)
)

-- 20u to roast the burdocks and 6u to heat water & activate the yeast
-- Using 3x250ml of water, this should give us ~750ml of product. For brew_burdock_wine it is 7 charges per
-- 250ml.
-- No distilling/evaporation (just roasting), so no volume loss. Hence (750ml/250ml)x7=21 charges
content.add(content.Recipe {
    id = "brew_burdock_wine",
    result = "brew_burdock_wine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 26, true)
    :component("water_clean", 3)
    :component("raw_burdock", 10)
    :component_any({
            { id = "sugar_standard", count = 2, requirement = true },
            { id = "honeycomb", count = 1 }
        })
    :component("yeast", 1)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :book("brewing_cookbook", 3)
    :book("family_cookbook", 2)
    :book("survival_book", 3)
    :book("textbook_survival", 3)
    :book("manual_survival", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_knife_skills")
    :proficiency("prof_fermenting")
    :proficiency("prof_winemaking")
    :batch_discount(95, 4)
    :result_charges(21)
)

-- 6u to heat water & activate the yeast, pineboughs don't appear to be roasted
-- Using 3x250ml of water, this should give us ~750ml of product. For brew_burdock_wine it is 7 charges per
-- 250ml.
-- No distilling/evaporation (not even roasting, see comment above), so no volume loss. Hence
-- (750ml/250ml)x7=21 charges
content.add(content.Recipe {
    id = "brew_pine_wine",
    result = "brew_pine_wine",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :component_any({
            { id = "water", count = 3 },
            { id = "water_clean", count = 3 }
        })
    :component("pine_bough", 5)
    :component_any({
            { id = "sugar_standard", count = 2, requirement = true },
            { id = "honeycomb", count = 1 }
        })
    :component("yeast", 1)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :book("survival_book", 3)
    :book("textbook_survival", 3)
    :book("manual_survival", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_winemaking")
    :batch_discount(95, 4)
    :result_charges(21)
)

content.add(content.Recipe {
    id = "malting_grain_active",
    result = "malting_grain_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 3000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :component("water_clean", 1)
    :component_any({
            { id = "corn", count = 1 },
            { id = "popcorn_cob", count = 1 },
            { id = "barley", count = 1 },
            { id = "buckwheat", count = 1 },
            { id = "oats", count = 1 },
            { id = "wheat", count = 1 }
        })
    :quality("CONTAIN", 1, 1)
    :book("brewing_cookbook", 4)
    :proficiency("prof_food_prep")
    :batch_discount(95, 4)
    :result_charges(1)
)

content.add(content.Recipe {
    id = "soaking_dandelion_active",
    result = "soaking_dandelion_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 180000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 6, true)
    :component("water_clean", 1)
    :component("raw_dandelion", 1)
    :quality("BOIL", 2, 1)
    :book("brewing_cookbook", 3)
    :book("family_cookbook", 2)
    :book("survival_book", 3)
    :book("textbook_survival", 3)
    :book("manual_survival", 3)
    :proficiency("prof_food_prep")
    :batch_discount(95, 4)
    :result_charges(1)
)

-- Using 2x250ml of water, this should give us ~500ml of product. For brew_vinegar it is 16 charges per
-- 250ml.
-- Hence (500ml/250ml)x16=32 charges
content.add(content.Recipe {
    id = "brew_vinegar",
    result = "brew_vinegar",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 48000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :component("water_clean", 2)
    :component_any({
            { id = "juice", count = 2 },
            { id = "apple_cider", count = 4 },
            { id = "cheap_wine", count = 2, requirement = true },
            { id = "worthy_wine", count = 1, requirement = true },
            { id = "sweet_fruit", count = 1, requirement = true },
            { id = "wild_herbs", count = 40 }
        })
    :book("vinegar_maker", 1)
    :book("winemaking_beginner", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_lactofermenting")
    :batch_discount(50, 4)
    :result_charges(32)
)

-- 14u for dairy and 1u for the additive
content.add(content.Recipe {
    id = "fermenting_yogurt_active",
    result = "fermenting_yogurt_active",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 60000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 3,
}
    :tool_charges("surface_heat", 15, true)
    :component("milk_standard_raw", 9, true)
    :component_any({
            { id = "cabbage", count = 1 },
            { id = "any_chili_pepper", count = 1, requirement = true },
            { id = "yoghurt", count = 1 },
            { id = "yogurt_starter_culture", count = 1 }
        })
    :quality("BOIL", 2, 1)
    :book("dairy_book", 3)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :proficiency("prof_lactofermenting")
    :batch_discount(95, 4)
    :result_charges(10)
)

-- Using 1x250ml of water, this should give us ~250ml of product. For brew_rootbeer it is 7 charges per
-- 250ml.
-- Hence (250ml/250ml)x7=7 charges
content.add(content.Recipe {
    id = "brew_rootbeer",
    result = "brew_rootbeer",
    category = "CC_FOOD",
    subcategory = "CSC_FOOD_BREW",
    duration_moves = 120000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "cooking",
    difficulty = 2,
}
    :component("water_clean", 1)
    :component("sugar", 40)
    :component("molasses", 1)
    :component("yeast", 1)
    :component("sassafras_root", 1)
    :quality("CUT", 2, 1)
    :quality("BOIL", 2, 1)
    :book("brewing_cookbook", 2)
    :book("family_cookbook", 2)
    :proficiency("prof_food_prep")
    :proficiency("prof_fermenting")
    :batch_discount(95, 4)
    :result_charges(7)
)
