local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_COSPLAY",
    name = ccb.content.text("Find some cosplay suits"),
    description = ccb.content.text("The world could have ended, but there are still some fantastic costumes out there, just waiting for you to wear them.  Search them until you find them."),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 0,
    finish = { handler = "morale_mission_cosplay" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_cosplay",
}

ccb.content.define_mission {
    id = "MISSION_SKATES",
    name = ccb.content.text("Find some skates"),
    description = ccb.content.text("You are a skater at heart, and as such you need some skates to drive by, any kind will suffice."),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 0,
    finish = { handler = "morale_mission_skates" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_skates",
}

ccb.content.define_mission {
    id = "MISSION_STYLISH",
    name = ccb.content.text("Dress with style"),
    description = ccb.content.text("You need to always dress in style and fashion.  Find a dress or tuxedo for your personal use."),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 0,
    finish = { handler = "morale_mission_stylish" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_stylish",
}

ccb.content.define_mission {
    id = "MISSION_GAME_MASTER",
    name = ccb.content.text("Find a tabletop game"),
    description = ccb.content.text("As a Game Master, it's just unacceptable that you now lack your means to play.  Find any tabletop game to play with any survivors you could find, even a cards game will suffice."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    finish = { handler = "morale_mission_game_master" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_game_master",
}

ccb.content.define_mission {
    id = "MISSION_MANSION_START",
    name = ccb.content.text("Ready or Not"),
    description = ccb.content.text("Survive all day from the crazy inhabitants of the mansion."),
    goal = "MGOAL_CONDITION",
    difficulty = 3,
    value = 0,
    finish = { handler = "morale_mission_mansion_start" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_mansion_start",
}

ccb.content.define_mission {
    id = "MISSION_INFECTED_START_FIND_ANTIBIOTICS",
    name = ccb.content.text("Find Antibiotics Before You Die!"),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    finish = { handler = "morale_mission_infected_start_find_antibiotics" },
    origins = { "ORIGIN_GAME_START" },
    complete_when = "complete_mission_infected_start_find_antibiotics",
}
