local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_NINJA",
    name = ccb.content.text("Kill your rivals"),
    description = ccb.content.text("As a real ninja, you can't allow competitors for the night.  Kill 10 shady zombies and demonstrate who is the real ninja here."),
    goal = "MGOAL_KILL_MONSTER_TYPE",
    monster_type = "mon_zombie_shady",
    monster_kill_goal = 10,
    difficulty = 4,
    value = 0,
    finish = { handler = "morale_mission_ninja" },
    origins = { "ORIGIN_GAME_START" },
}
