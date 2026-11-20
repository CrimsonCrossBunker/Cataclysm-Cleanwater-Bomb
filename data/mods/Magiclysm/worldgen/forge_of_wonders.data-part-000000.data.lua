local ccb = require("ccb")

ccb.content.define_achievement {
    id = "achievement_reach_forge_of_wonder",
    name = ccb.content.text("Everything can be had for a price…"),
    requirements = {
        {
            statistic = "last_oter_type_avatar_entered",
            comparison = "==",
            target = { type = "oter_type_str_id", value = "forge_x3y2z1" },
            visibility = "when_achievement_completed",
            description = ccb.content.text("See the Forge of Wonders"),
        },
    },
}
