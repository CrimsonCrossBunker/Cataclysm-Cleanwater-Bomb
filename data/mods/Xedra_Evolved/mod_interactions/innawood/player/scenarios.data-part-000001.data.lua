local ccb = require("ccb")

ccb.content.define_scenario {
    id = "xe_lilin_scenario_naked_afraid",
    name = "The Owl, Naked and Afraid",
    points = 0,
    description = "For most or all of your life, you've had a secret; you are a predator.  While you don't need to drink blood or eat flesh or anything so crude, you must absorb the spiritual essence, the \"ruach\", of living beings in order to maintain your health and vitality.  Something happened, and now you're alone in the wilderness, without any of your possessions.  You'd best find others quick, or you'll wither away.",
    start_name = "Alone",
    locations = { "sloc_field", "sloc_forest", "sloc_desert_island", "sloc_river" },
    professions = { "naked" },
    forced_traits = { "LILIN_TRAITS", "LILIN_DRAIN_RUACH_MELEE" },
    flags = { "LONE_START" },
}

ccb.content.define_scenario {
    id = "once_bitten",
    copy_from = "infected",
    name = "Once Bitten",
    points = 0,
    description = "Whether you were visiting Salem's Lot, boating on the Demeter, vacationing to Transylvania, or just another lost boy or girl, you've been bitten by a stranger at twilight the night before.  And to make matters worse, when you woke up, you were alone in the wilderness with no sign of humanity anywhere.  You're going to have to survive somehow.",
    locations = { "sloc_cave_underground_innawood", "sloc_cave_innawood" },
    start_name = "Cave",
    requirement = "avchievement_gains_vampire_trait",
    flags = { "LONE_START" },
}

ccb.content.define_scenario {
    id = "once_bitten_naked_and_afraid",
    copy_from = "infected",
    name = "Once Bitten, Naked and Afraid",
    points = 0,
    description = "Whether you were visiting Salem's Lot, boating on the Demeter, vacationing to Transylvania, or just another lost boy or girl, you've been bitten by a stranger at twilight the night before.  And to make matters worse, when you woke up, you were alone in the wilderness with no sign of humanity anywhere.  You're going to have to survive somehow.",
    start_name = "Alone",
    locations = { "sloc_field", "sloc_forest", "sloc_desert_island", "sloc_river" },
    professions = { "naked" },
    requirement = "avchievement_gains_vampire_trait",
    flags = { "LONE_START" },
}
