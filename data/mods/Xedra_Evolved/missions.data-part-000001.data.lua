local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_KILL_DREAM_DRAINER",
    name = ccb.content.text("Kill that mosquito"),
    description = ccb.content.text("You summoned a dream-draining mosquito.  Now it is time for you to kill it."),
    goal = "MGOAL_KILL_MONSTER_TYPE",
    monster_type = "mon_dream_drainer_mosquito",
    monster_kill_goal = 1,
    difficulty = 10,
    value = 0,
    finish = {
        before_rewards = "announce_dream_drainer_loot",
        item_rewards = { { item = "dream_drainer_heart", count = 1, preview = false } },
    },
    generic_rewards = false,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}

ccb.content.define_mission {
    id = "MISSION_KILL_LUNA_ATTUNED",
    name = ccb.content.text("Kill the Luna-attuned revenant"),
    description = ccb.content.text("You created a Luna-attuned revenant.  Now it is time for you to kill it."),
    goal = "MGOAL_KILL_MONSTER_TYPE",
    monster_type = "mon_luna_attuned_revenant",
    monster_kill_goal = 1,
    difficulty = 10,
    value = 0,
    finish = {
        before_rewards = "announce_luna_attuned_loot",
        item_rewards = { { item = "moonstruck_pearl", count = 1, preview = false } },
    },
    generic_rewards = false,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = "",
        offer = "",
        accepted = "",
        rejected = "",
        advice = "",
        inquire = "",
        success = "",
        success_lie = "",
        failure = "",
    },
}
