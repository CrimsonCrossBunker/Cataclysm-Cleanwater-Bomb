local ccb = require("ccb")

ccb.content.define_achievement {
    id = "achievement_kill_dino",
    name = ccb.content.text("They should all be destroyed…"),
    requirements = { { statistic = "num_avatar_dino_kills", comparison = ">=", target = 1 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_10_dinos",
    name = ccb.content.text("Muldoon"),
    requirements = { { statistic = "num_avatar_dino_kills", comparison = ">=", target = 10 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_100_dinos",
    name = ccb.content.text("Sharptooth"),
    hidden_by = { "achievement_kill_10_dinos" },
    requirements = { { statistic = "num_avatar_dino_kills", comparison = ">=", target = 100 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_1000_dinos",
    name = ccb.content.text("KILL ALL DINOS"),
    requirements = { { statistic = "num_avatar_dino_kills", comparison = ">=", target = 1000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_10000_dinos",
    name = ccb.content.text("Red", "achievement"),
    hidden_by = { "achievement_kill_1000_dinos" },
    requirements = { { statistic = "num_avatar_dino_kills", comparison = ">=", target = 10000 } },
}

ccb.content.define_achievement {
    id = "achievement_kill_100000_dinos",
    name = ccb.content.text("Giant Asteroid"),
    hidden_by = { "achievement_kill_10000_dinos" },
    requirements = { { statistic = "num_avatar_dino_kills", comparison = ">=", target = 100000 } },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_tyrant",
    name = ccb.content.text("Unending hunger"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "TYRANT" },
            description = ccb.content.text("crossed tyrant mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_stego",
    name = ccb.content.text("Fortress secure"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "STEGO" },
            description = ccb.content.text("crossed stego mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}

ccb.content.define_achievement {
    id = "achievement_mutation_threshold_horns",
    name = ccb.content.text("Too dangerous to mess with"),
    requirements = {
        {
            statistic = "avatar_last_crosses_mutation_threshold",
            comparison = "==",
            target = { type = "mutation_category_id", value = "HORNS" },
            description = ccb.content.text("crossed horns mutation threshold"),
            visibility = "when_achievement_completed",
        },
    },
}
