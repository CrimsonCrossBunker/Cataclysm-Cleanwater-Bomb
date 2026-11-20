local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CHRIS_1",
    name = ccb.content.text("Free Barry from the mysterious structure"),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 50000,
    start = {
        target = {
            terrain = "barry_mi-go_scout_tower_3",
            special = "Barry's Mi-Go Scout Tower",
            reveal_radius = 3,
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We need to investigate the alien encampment and try to find out what happened to Barry."),
        offer = ccb.content.text("I can take you to the structure, I tracked them to it."),
        accepted = ccb.content.text("Awesome, I want some answers!"),
        rejected = ccb.content.text("Thanks anyway, I'll keep my eye on it, maybe I'll find a way one day."),
        advice = ccb.content.text("I feel like we are underprepared if they see us, I marked the location for you."),
        inquire = ccb.content.text("You ready?"),
        success = ccb.content.text("It's taller then I remember, we should look for prisoners.  I left a note for my family before we left.  If we survive, the cabin should be fixed up and ready for you to move in if you want to stay."),
        success_lie = ccb.content.text("Well it was here…"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +5, value +5).
    finish = {
        map_updates = {
            {
                terrain = "cabin_isherwood",
                layout = { nested = { { x = 3, y = 1, id = "cabin_isherwood_update" } } },
            },
        },
        handler = "set_world_isherwood_barry_rescued_to_1",
    },
}

-- Dialogue for this mission is handled externally.
ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CHRIS_1_GET_GEAR",
    name = ccb.content.text("Retrieve 5 sets of riot armor for the Isherwoods"),
    goal = "MGOAL_NULL",
    difficulty = 1,
    value = 0,
    start = {
        target = { terrain = "police_2ndfloor_1", special = "police_1", reveal_radius = 3 },
        map_updates = {
            {
                terrain = "police_2ndfloor_1",
                layout = { nested = { { x = 1, y = 5, id = "isherwood_barry_riot_drop" } } },
            },
        },
    },
    finish = { handler = "set_world_isherwood_gear_status_to_1" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("."),
        success = ccb.content.text("."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("."),
    },
}
