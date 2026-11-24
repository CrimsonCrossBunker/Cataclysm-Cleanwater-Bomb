local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ASSASSINATION",
    name = ccb.content.text("Finish your mission"),
    description = ccb.content.text("Your mission required you to eliminate a certain high-ranking individual in hiding.  Your mark seems to have turned feral while escaping and the world appears to be ending, but not even that can stop you from finishing your mission."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 4,
    start = {
        target = { terrain = "s_air_term", special = "o_airport", reveal_radius = 6, min_distance = 15, z = 0 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        {
                            id = "mon_feral_scientist_scalpel",
                            name = ccb.content.text("The Target"),
                            x = 11,
                            y = 11,
                            target = true,
                        },
                        {
                            id = "mon_feral_labsecurity_9mm",
                            name = ccb.content.text("The Guard"),
                            x = 12,
                            y = 12,
                        },
                        { id = "mon_feral_soldier", name = ccb.content.text("The Collaborator"), x = 9, y = 9 },
                        {
                            id = "mon_feral_fancy_rapier",
                            name = ccb.content.text("The Aristocrat"),
                            x = 13,
                            y = 13,
                        },
                        { id = "mon_feral_maid_broom", name = ccb.content.text("The Servant"), x = 12, y = 13 },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_GAME_START" },
    value = 0,
    finish = { handler = "morale_mission_assassination" },
}

ccb.content.define_mission {
    id = "MISSION_ASSASSIN_CONVICT_PRISON",
    name = ccb.content.text("Kill your mark"),
    description = ccb.content.text("Your employer could be no longer responding but you have decided to finish your mission.  Hunt down and kill your mark."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 3,
    start = {
        target = { terrain = "prison_1_3", special = "Prison", reveal_radius = 1, min_distance = 1, z = 0 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        {
                            id = "mon_zombie_prisoner_brute",
                            name = ccb.content.text("The Target"),
                            x = 18,
                            y = 23,
                            target = true,
                        },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_GAME_START" },
    value = 0,
    finish = { handler = "morale_mission_assassin_convict_prison" },
}

ccb.content.define_mission {
    id = "MISSION_ASSASSIN_CONVICT_PRISON_ISLAND1",
    name = ccb.content.text("Kill your mark"),
    description = ccb.content.text("Your employer could be no longer responding but you have decided to finish your mission.  Hunt down and kill your mark."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 3,
    start = {
        target = {
            terrain = "prison_alcatraz_9",
            special = "Alcatraz Prison",
            reveal_radius = 1,
            min_distance = 1,
            z = 0,
        },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        {
                            id = "mon_zombie_prisoner_brute",
                            name = ccb.content.text("The Target"),
                            x = 18,
                            y = 15,
                            target = true,
                        },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_GAME_START" },
    value = 0,
    finish = { handler = "morale_mission_assassin_convict_prison_island1" },
}

ccb.content.define_mission {
    id = "MISSION_ASSASSIN_CONVICT_PRISON_ISLAND2",
    name = ccb.content.text("Kill your mark"),
    description = ccb.content.text("Your employer could be no longer responding but you have decided to finish your mission.  Hunt down and kill your mark."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 3,
    start = {
        target = {
            terrain = "prison_island_1_8",
            special = "Island prison",
            reveal_radius = 1,
            min_distance = 1,
            z = 0,
        },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        {
                            id = "mon_zombie_prisoner_brute",
                            name = ccb.content.text("The Target"),
                            x = 18,
                            y = 10,
                            target = true,
                        },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_GAME_START" },
    value = 0,
    finish = { handler = "morale_mission_assassin_convict_prison_island2" },
}

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

ccb.content.define_mission {
    id = "MISSION_HELICOPTER_REFUEL",
    name = ccb.content.text("Refuel your helicopter."),
    description = ccb.content.text("You were flying towards a nearby private airport before your forced landing.  You could still reach it by ground, and scavenge it for fuel."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "s_air_hangars",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "s_air_hangars", reveal_radius = 5, special = "o_airport" } },
    finish = { handler = "morale_mission_helicopter_refuel" },
    origins = { "ORIGIN_GAME_START" },
}

ccb.content.define_mission {
    id = "MISSION_HELICOPTER_CRASH",
    name = ccb.content.text("Return to base"),
    description = ccb.content.text("Your helicopter was crashed to the ground, communications were lost with ground base, and the rest of your team died while landing, at least you still know the way back to the base."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "helipad_nw",
    difficulty = 4,
    value = 0,
    start = {
        target = {
            terrain = "helipad_nw",
            reveal_radius = 10,
            special = "military helipad",
            min_distance = 25,
            z = 0,
        },
    },
    origins = { "ORIGIN_GAME_START" },
}

ccb.content.define_mission {
    id = "MISSION_HELICOPTER_PILOT",
    name = ccb.content.text("Go to the refueling stop"),
    description = ccb.content.text("Your bird is now on the ground, never again able to fly, you could search for a new one in the closest refueling stop requisitioned by the military."),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 3,
    start = {
        target = {
            terrain = "s_air_helicopter_pad",
            special = "o_airport",
            reveal_radius = 6,
            min_distance = 15,
            z = 0,
        },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_zombie_military_pilot", x = 1, y = 1 },
                        { id = "mon_feral_soldier", x = 3, y = 3 },
                        { id = "mon_zombie_soldier", x = 7, y = 3 },
                        { id = "mon_zombie_soldier", x = 8, y = 2 },
                        { id = "mon_zombie_soldier", x = 7, y = 6 },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_GAME_START" },
    value = 0,
    finish = { handler = "morale_mission_helicopter_pilot" },
}

ccb.content.define_mission {
    id = "MISSION_LAST_DELIVERY",
    name = ccb.content.text("Deliver Your Cargo"),
    description = ccb.content.text("You're not sure who orders takeout when the world's ending, but that doesn't matter.  Evacuation doesn't matter.  Nothing, indeed, matters, save for safely delivering your precious cargo to its destination: a remote mansion."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "mansion_c3",
    difficulty = 1,
    value = 0,
    start = { target = { terrain = "mansion_c3", special = "Mansion_Road" } },
    origins = { "ORIGIN_GAME_START" },
}

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

ccb.content.define_mission {
    id = "MISSION_SURVIVE_NEMESIS",
    name = ccb.content.text("Survive your pursuer"),
    description = ccb.content.text("Since the start of the Cataclysm, something has been hunting you relentlessly.  You can fight it but never truly kill it.  It won't end until you die."),
    goal = "MGOAL_KILL_NEMESIS",
    difficulty = 10,
    value = 0,
    start = "kill_nemesis",
    origins = { "ORIGIN_GAME_START" },
}

ccb.content.define_mission {
    id = "MISSION_FIND_LABYRINTH_SPIRE",
    name = ccb.content.text("Investigate the green light"),
    description = ccb.content.text("You don't know where you are, but in the distance you see a jagged spire, with a green light atop it.  Perhaps you should climb this spire and investigate?  What else do you have to lose?"),
    difficulty = 10,
    value = 0,
    goal = "MGOAL_NULL",
    destination = "scarlet_scrap_metal_spire",
    origins = { "ORIGIN_SECONDARY" },
    start = {
        target = {
            terrain = "scarlet_scrap_metal_spire",
            special = "scarlet_scrap_metal_spire",
            reveal_radius = 2,
            random = false,
        },
    },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("…"),
        success = ccb.content.text("…"),
        success_lie = ccb.content.text("…"),
        failure = ccb.content.text("…"),
    },
}
