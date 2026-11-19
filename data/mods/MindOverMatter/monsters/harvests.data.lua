local ccb = require("ccb")

ccb.content.define_harvest {
    id = "mutant_cow_with_skull",
    copy_from = "mutant_mammal_large_leather",
    extend = {
        drops = { { output = "skull_bovine", category = "bone", skill_quantity = { 1, 1 }, maximum = 1 } },
    },
}
