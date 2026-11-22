local ccb = require("ccb")

ccb.content.define_recipe_category {
    id = "CC_PRACTICE",
    copy_from = "CC_PRACTICE",
    extend_subcategories = { "CSC_PRACTICE_OCCULT" },
}
