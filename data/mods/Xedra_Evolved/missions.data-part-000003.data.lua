local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_LOW_VAMPIRE_HUNTER",
    name = ccb.content.text("Kill a vampire"),
    description = ccb.content.text("You prepared for so long to kill vampires, and there's no way you let all that preparation be for nothing.  Kill a vampire to show that you can and will hunt them!"),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "VAMPIRE",
    monster_kill_goal = 1,
    difficulty = 3,
    value = 0,
    finish = { handler = "morale_mission_low_vampire_hunter" },
    origins = { "ORIGIN_GAME_START" },
}

ccb.content.define_mission {
    id = "MISSION_VAMPIRE_HUNTER",
    name = ccb.content.text("Kill ten vampires"),
    description = ccb.content.text("The end of society is no excuse to stop the hunt.  In fact, it's another reason to continue your work.  Kill ten vampires, so the world will be a little more free of them."),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "VAMPIRE",
    monster_kill_goal = 10,
    difficulty = 5,
    value = 0,
    finish = { handler = "morale_mission_vampire_hunter" },
    origins = { "ORIGIN_GAME_START" },
}
