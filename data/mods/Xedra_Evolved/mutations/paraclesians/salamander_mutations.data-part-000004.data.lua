local ccb = require("ccb")

ccb.content.define_mutation {
    id = "SALAMANDER_SLEEP_LESS",
    name = ccb.content.text("The Campfire Stands Watch"),
    points = 2,
    description = ccb.content.text("The Salamander needs less sleep than a human.  However, they will also need to eat slightly more."),
    replacements = { "SALAMANDER_SLEEP_LESS2" },
    types = { "SLEEP" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_SLEEP_LESS_0" },
}

ccb.content.define_mutation {
    id = "SALAMANDER_SLEEP_LESS2",
    name = ccb.content.text("The Bonfire Blazes Until the Revelers Have Gone"),
    points = 5,
    description = ccb.content.text("The Salamander needs much less sleep than a human.  However, they will also need to eat significantly more."),
    prerequisites = { "SALAMANDER_SLEEP_LESS" },
    replacements = { "SALAMANDER_SLEEP_LESS3" },
    types = { "SLEEP" },
    categories = { "SALAMANDER" },
    purifiable = false,
    enchantments = { "INLINE_ENCH_SALAMANDER_SLEEP_LESS2_0" },
}
