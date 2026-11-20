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
