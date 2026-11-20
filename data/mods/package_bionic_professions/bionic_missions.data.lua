local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_BIONICS_FAULTY",
    name = ccb.content.text("Free yourself from your bionic failures"),
    description = ccb.content.text("You currently have some bionics malfunctioning.  Remove them and avoid any more faulty bionics in your body."),
    goal = "MGOAL_CONDITION",
    difficulty = 4,
    value = 0,
    finish = { handler = "morale_mission_bionics_faulty" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_bionics_faulty",
}
