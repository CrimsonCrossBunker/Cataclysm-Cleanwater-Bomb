local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_DOG_LOVER",
    name = ccb.content.text("Protect your canine friends"),
    description = ccb.content.text("You have saved your dogs from the fall of the world, but they could still suffer from danger everywhere.  Police dogs used some Kevlar harnesses for protection…  Maybe your friends could use some too?"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    item = "kevlar_harness",
    origins = { "ORIGIN_GAME_START" },
    value = 0,
    finish = { handler = "morale_mission_dog_lover" },
}

ccb.content.define_mission {
    id = "MISSION_HUNTER",
    name = ccb.content.text("Hunt big game"),
    description = ccb.content.text("The end of the world could have arrived, but you still crave for that one big hunt.  Search and kill a black bear to remember the old days."),
    goal = "MGOAL_KILL_MONSTER_TYPE",
    monster_type = "mon_bear",
    monster_kill_goal = 1,
    difficulty = 4,
    value = 0,
    finish = { handler = "morale_mission_hunter" },
    origins = { "ORIGIN_GAME_START" },
}

ccb.content.define_mission {
    id = "MISSION_OTAKU",
    name = ccb.content.text("Become the protagonist"),
    description = ccb.content.text("The world has become like an anime!  Zombies, mutants, the end of civilization as we know it…  You must become the protagonist if you want to survive, the plot armor will help you.  Go and kill 50 zombies to show your protagonist potential."),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "ZOMBIE",
    monster_kill_goal = 50,
    difficulty = 4,
    value = 0,
    finish = { handler = "morale_mission_otaku" },
    origins = { "ORIGIN_GAME_START" },
}

ccb.content.define_mission {
    id = "MISSION_MAFIA_BOSS",
    name = ccb.content.text("Make the cops pay"),
    description = ccb.content.text("They wanted to put you behind bars, but are now dead, make them pay with blood, unliving blood."),
    goal = "MGOAL_KILL_MONSTER_TYPE",
    monster_type = "mon_zombie_cop",
    monster_kill_goal = 10,
    difficulty = 4,
    value = 0,
    finish = { handler = "morale_mission_mafia_boss" },
    origins = { "ORIGIN_GAME_START" },
}
