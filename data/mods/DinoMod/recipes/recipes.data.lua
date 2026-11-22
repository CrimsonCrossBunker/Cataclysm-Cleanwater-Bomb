local ccb = require("ccb")

ccb.content.define_recipe_category {
    id = "CC_ANIMALS",
    copy_from = "CC_ANIMALS",
    extend_subcategories = {
        "CSC_ANIMALS_ELEPHANT ARMOR",
        "CSC_ANIMALS_OSTRICH ARMOR",
        "CSC_ANIMALS_BEAR ARMOR",
    },
}
