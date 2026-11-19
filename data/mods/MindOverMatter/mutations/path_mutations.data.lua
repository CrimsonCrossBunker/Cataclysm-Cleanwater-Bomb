local ccb = require("ccb")

ccb.content.define_mutation {
    id = "MORE_PSI_ALPHA",
    name = ccb.content.text("Noetic Flexibility"),
    points = 5,
    vitamin_cost = 300,
    description = ccb.content.text("Your expanded mind is far more capable of understanding Netherum Mathematics than a mere human's.  You have an greater chance of awakening new psionic paths."),
    prerequisites = { "INT_ALPHA" },
    threshold_requirements = { "THRESH_ALPHA" },
    categories = { "ALPHA" },
    enchantments = { "INLINE_ENCH_MORE_PSI_ALPHA_0" },
}
