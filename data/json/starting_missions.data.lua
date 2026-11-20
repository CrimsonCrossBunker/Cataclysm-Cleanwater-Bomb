local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_SURVIVE_NEMESIS",
    name = ccb.content.text("Survive your pursuer"),
    description = ccb.content.text("Since the start of the Cataclysm, something has been hunting you relentlessly.  You can fight it but never truly kill it.  It won't end until you die."),
    goal = "MGOAL_KILL_NEMESIS",
    difficulty = 10,
    value = 0,
    start = "kill_nemesis",
    origins = { "ORIGIN_GAME_START" },
}

ccb.content.define_mission {
    id = "MISSION_FIND_LABYRINTH_SPIRE",
    name = ccb.content.text("Investigate the green light"),
    description = ccb.content.text("You don't know where you are, but in the distance you see a jagged spire, with a green light atop it.  Perhaps you should climb this spire and investigate?  What else do you have to lose?"),
    difficulty = 10,
    value = 0,
    goal = "MGOAL_NULL",
    destination = "scarlet_scrap_metal_spire",
    origins = { "ORIGIN_SECONDARY" },
    start = {
        target = {
            terrain = "scarlet_scrap_metal_spire",
            special = "scarlet_scrap_metal_spire",
            reveal_radius = 2,
            random = false,
        },
    },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}
