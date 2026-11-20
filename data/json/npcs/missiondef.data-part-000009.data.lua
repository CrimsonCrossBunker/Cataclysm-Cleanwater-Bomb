local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_INVESTIGATE_PORTAL_DUNGEON",
    name = ccb.content.text("Investigate Strange Location"),
    goal = "MGOAL_GO_TO",
    description = ccb.content.text("You could find this place upside down, dizzy and blindfolded.  Its presence is too altered to allow the mercy of ignorance."),
    difficulty = 0,
    value = 0,
    invisible_on_complete = true,
    start = { target = { global_position = "portal_dungeon" } },
}

ccb.content.define_mission {
    id = "MISSION_INVESTIGATE_PORTAL_STORM_CENTER",
    name = ccb.content.text("Center of the storm"),
    goal = "MGOAL_CONDITION",
    description = ccb.content.text("This is the center of the portal storm, you could find it upside down, dizzy and blindfolded.  Its presence is too altered to allow the mercy of ignorance."),
    difficulty = 0,
    value = 0,
    invisible_on_complete = true,
    start = { target = { global_position = "portal_storm_center" } },
}
