local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_KILL_SHADOW",
    name = ccb.content.text("Survive the night"),
    description = ccb.content.text("You don't know what you're facing.  You only know that it's very dangerous."),
    goal = "MGOAL_KILL_MONSTER_TYPE",
    monster_type = "mon_lieutenant_shadow",
    monster_kill_goal = 1,
    difficulty = 10,
    value = 0,
    finish = {
        before_rewards = "announce_shadow_loot",
        item_rewards = { { item = "shadow_singularity_piece", count = 1, preview = false } },
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
