local ccb = require("ccb")

ccb.content.define_mutation {
    id = "IERDE_CRAFT_IN_DARKNESS",
    name = ccb.content.text("Sense the Smallest Tremor"),
    points = 3,
    description = ccb.content.text("The Ierde's ability to sense small movements is heightened to such a degree that with small movements of their fingers, they can sense the exact shape and position of objects nearby.  They can craft in darkness, as long as \"The Soil Knows Those Who Tread Upon It\" is active."),
    prerequisites = { "IERDE_DETECT_NEARBY_MONSTERS_EARTH" },
    categories = { "IERDE" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_IERDE_CRAFT_IN_DARKNESS_0" },
}
