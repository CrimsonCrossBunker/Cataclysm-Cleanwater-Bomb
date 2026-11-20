local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_MUTANT_VOLUNTEER",
    name = ccb.content.text("Continue with your evolution"),
    description = ccb.content.text("Your evolution to a more perfect form was interrupted by the Cataclysm.  Restart your transformation process whatever it costs."),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    value = 0,
    finish = { handler = "morale_mission_mutant_volunteer" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_mutant_volunteer",
}

ccb.content.define_mission {
    id = "MISSION_PORTAL_TRAVELER",
    name = ccb.content.text("Recover a part of yourself"),
    description = ccb.content.text("They took away something from you, something important.  You feel a connection with this weather, maybe you can recover some portion of what you lost in one of these storms."),
    goal = "MGOAL_CONDITION",
    difficulty = 7,
    value = 0,
    finish = { handler = "morale_mission_portal_traveler" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_portal_traveler",
}

ccb.content.define_mission {
    id = "MISSION_SOCIAL_BUTTERFLY",
    name = ccb.content.text("Social butterfly"),
    description = ccb.content.text("You have always had good social abilities.  Go and recruit 2 followers and establish your leadership among them.  Don't forget to order them to build a base of operations for you in the form of a survivor camp."),
    goal = "MGOAL_CONDITION",
    difficulty = 3,
    value = 0,
    finish = { handler = "morale_mission_social_butterfly" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_social_butterfly",
}
