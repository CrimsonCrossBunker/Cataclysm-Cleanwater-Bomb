local ccb = require("ccb")

ccb.content.define_harvest {
    id = "alien_tree_harv",
    drops = { { output = "alien_tree_1_fruit", base_quantity = { 1, 4 }, skill_quantity = { 0, 0.5 } } },
}
