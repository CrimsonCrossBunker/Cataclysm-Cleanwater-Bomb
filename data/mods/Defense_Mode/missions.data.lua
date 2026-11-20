local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_DEFENSE_MODE_SURVIVE",
    name = ccb.content.text("Survive"),
    description = ccb.content.text("You don't know how you got here, or why.  All you know is that you need to live."),
    goal = "MGOAL_KILL_MONSTER_TYPE",
    monster_type = "mon_boss_shadow",
    monster_kill_goal = 1,
    difficulty = 3,
    value = 0,
    finish = { actions = { ccb.content.dialogue_actions.open_conversation("TALK_DEFENSE_MODE_WIN") } },
    origins = { "ORIGIN_GAME_START" },
}
