local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_PATIENT",
    name = ccb.content.text("Life vow"),
    description = ccb.content.text("Live your life to the fullest, prove to yourself that you can survive this new obstacle in the same way that you have survived the last."),
    goal = "MGOAL_CONDITION",
    difficulty = 4,
    value = 0,
    finish = { handler = "morale_mission_patient" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_patient",
}

ccb.content.define_mission {
    id = "MISSION_CLOWN",
    name = ccb.content.text("Prepare for your next show"),
    description = ccb.content.text("Become the best clown, make sure that your next show will make everyone laugh by training your social skills to perfection."),
    goal = "MGOAL_CONDITION",
    difficulty = 3,
    value = 0,
    finish = { handler = "morale_mission_clown" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_clown",
}

ccb.content.define_mission {
    id = "MISSION_LOST_SUB",
    name = ccb.content.text("Find a memory of your master"),
    description = ccb.content.text("Find and wield a whip to remember your master even when separated."),
    goal = "MGOAL_CONDITION",
    difficulty = 3,
    value = 0,
    finish = { handler = "morale_mission_lost_sub" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_lost_sub",
}

ccb.content.define_mission {
    id = "MISSION_BLACK_BELT_GOAL",
    name = ccb.content.text("Obtain your black belt"),
    description = ccb.content.text("You could have become a master in martial arts if you had the chance, so train until you achieve the level of a master in the old world, and find yourself a nice black belt to commemorate the occasion."),
    goal = "MGOAL_CONDITION",
    difficulty = 4,
    value = 0,
    finish = { handler = "morale_mission_black_belt_goal" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_black_belt_goal",
}

ccb.content.define_mission {
    id = "MISSION_URBAN_SAMURAI",
    name = ccb.content.text("Find a real katana"),
    description = ccb.content.text("The world has ended, but as an authentic samurai you lack a katana, you must find one, quickly."),
    goal = "MGOAL_CONDITION",
    difficulty = 4,
    value = 0,
    finish = { handler = "morale_mission_urban_samurai" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_urban_samurai",
}

ccb.content.define_mission {
    id = "MISSION_FIND_RIFLE",
    name = ccb.content.text("Find a new rifle"),
    description = ccb.content.text("When you were escaping an evacuation point that was overrun, you had to leave your rifle behind.  Shame on you, what's a hunter without their hunting rifle?  You have to find one immediately."),
    goal = "MGOAL_CONDITION",
    difficulty = 3,
    value = 0,
    finish = { handler = "morale_mission_find_rifle" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_find_rifle",
}
