local ccb = require("ccb")

ccb.content.define_mutation {
    id = "eater_unbreakable",
    name = ccb.content.text("Unbreakable"),
    points = 0,
    starting_trait = false,
    purifiable = false,
    valid = false,
    description = ccb.content.text("<color_green>Nothing can slow you down</color>, and your <color_red>pain</color> sensations are dull."),
    enchantments = { "INLINE_ENCH_eater_unbreakable_0" },
    flags = { "STEADY" },
}
