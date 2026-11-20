local ccb = require("ccb")

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_dragon_black",
    name = ccb.content.text("Dragons don't have nightmares, nightmares have dragons!"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "DRAGON_BLACK" },
            description = ccb.content.text("crossed black dragon mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}
