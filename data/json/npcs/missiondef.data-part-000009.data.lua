local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_SAFE_BOX",
    name = ccb.content.text("Retrieve Deposit Box"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 30000,
    item = "safe_box",
    start = {
        actions = { "follow_only" },
        target = { terrain = "bank", match = "PREFIX", special = "bank", random = true, z = 0 },
        map_updates = {
            {
                layout = {
                    item_placements = {
                        { id = "safe_box", x = { 18, 21 }, y = { 4, 6 }, amount = 1 },
                    },
                },
            },
        },
    },
    finish = {
        actions = {
            "stop_following",
            { handler = "reward_mission_get_safe_box" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_GET_DEPUTY_BADGE",
    dialogue = {
        describe = ccb.content.text("Those twisted snakes…"),
        offer = ccb.content.text("Now I don't mean to upset you but I'm not sure what I can do with the accounting ledger at the moment.  We do have a new lead though, the ledger has a safe deposit box under the regional manager's name.  Guess what, dumb sucker wrote down his combination.  Come with me to retrieve the box and you can keep any of the goodies in it that I can't use to press charges against these bastards."),
        accepted = ccb.content.text("You may make a tidy profit from this."),
        rejected = ccb.content.text("I know it isn't pressing but the world is going to be just as corrupt when we start rebuilding unless we take measure to stop those who seek to rule over us."),
        advice = ccb.content.text("This shouldn't be hard unless we run into a horde."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Great, anything I can't use to prosecute the bastards is yours, as promised."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("The day of reckoning will come for the corporations if it hasn't already."),
    },
}

ccb.content.define_mission {
    id = "MISSION_GET_SOFTWARE",
    name = ccb.content.text("Retrieve Software"),
    description = ccb.content.text("Retrieve the software in their computer marked on your map."),
    goal = "MGOAL_FIND_ANY_ITEM",
    difficulty = 2,
    value = 80000,
    place = "near_town",
    start = "place_npc_software",
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh man, I can't believe I forgot to download it…"),
        offer = ccb.content.text("There's some important software on my computer that I need on USB."),
        accepted = ccb.content.text("Thanks!  Just pull the data onto this USB drive and bring it to me."),
        rejected = ccb.content.text("Seriously?  It's an easy job…"),
        advice = ccb.content.text("Take this USB drive.  Use the console, and download the software."),
        inquire = ccb.content.text("So, do you have my software yet?"),
        success = ccb.content.text("Excellent, thank you!"),
        success_lie = ccb.content.text("What?!  You liar!"),
        failure = ccb.content.text("Wow, you failed?  All that work, down the drain…"),
    },
}
