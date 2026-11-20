local ccb = require("ccb")

-- monster_kill_goal MUST be 1 or else the mission will spawn a new nemesis on its death.
ccb.content.define_mission {
    id = "MISSION_KILL_NEMESIS",
    name = ccb.content.text("Kill your pursuer"),
    description = ccb.content.text("Since the start of the Cataclysm, something has been hunting you relentlessly.  You can outrun it but never truly escape it.  It won't end until one of you dies."),
    goal = "MGOAL_KILL_NEMESIS",
    difficulty = 5,
    value = 0,
    monster_kill_goal = 1,
    start = "kill_nemesis",
    finish = { handler = "clear_trait_has_nemesis" },
    origins = { "ORIGIN_GAME_START" },
}
