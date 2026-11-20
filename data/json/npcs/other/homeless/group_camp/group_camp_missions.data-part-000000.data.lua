local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_KILL_SLIMES",
    name = ccb.content.text("Sticky Situation"),
    description = ccb.content.text("Kill some slimes in exchange for credit with some of the traders and bring back six of their slime scraps."),
    goal = "MGOAL_FIND_ITEM",
    item = "slime_scrap",
    item_count = 6,
    difficulty = 1,
    value = 4000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_HUNT_ANTS",
    start = {
        target = { terrain = "field", reveal_radius = 1, random = true, search_range = 15, min_distance = 10 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_blob", pack_size = { 6, 6 }, x = 8, y = 8, target = true },
                    },
                },
            },
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("We've had some trouble with slimes not far from us.  It's been hard going through there with all them around, so I want you to go take care of it."),
        advice = ccb.content.text("Sure, they can be cut, but I'd say it's better to splatter them with something large and heavy."),
        accepted = ccb.content.text("I'll be here when you get back."),
        rejected = ccb.content.text("No problem.  I'm sure one of us will get to it anyway."),
        inquire = ccb.content.text("Are those slimes dead yet?"),
        success = ccb.content.text("Nice.  I'll just take those off your hands.  Might be good for greasing the bike chains and door hinges around here even though it is a bit… abnormal."),
        success_lie = ccb.content.text("You don't look nearly as sticky as you're supposed to.  Get back to it."),
        failure = ccb.content.text("Did they give you the slip?  It's worse than I thought, then."),
    },
}
