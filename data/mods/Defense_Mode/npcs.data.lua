local ccb = require("ccb")

ccb.content.define_mutation {
    id = "DEBUG_FLIMSY",
    name = ccb.content.text("Debug No HP"),
    points = -6,
    description = ccb.content.text("You will die in one hit, more or less.  Sneezing too hard will kill you."),
    debug = true,
    enchantments = { "INLINE_ENCH_DEBUG_FLIMSY_0" },
}

ccb.content.define_mutation {
    id = "DEBUG_FLIMSY2",
    name = ccb.content.text("Debug No HP II"),
    points = -6,
    description = ccb.content.text("You will die in one hit, more or less.  Sneezing too hard will kill you."),
    debug = true,
    enchantments = { "INLINE_ENCH_DEBUG_FLIMSY2_0" },
}
