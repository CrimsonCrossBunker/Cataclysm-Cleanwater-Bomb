local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_TACOMA_Pablo_Firebrick",
    name = ccb.content.text("Get Pablo some fire bricks."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 1000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    item = "fire_brick",
    item_count = 20,
    dialogue = {
        describe = ccb.content.text("Find some fire bricks to help Pablo build an oven."),
        offer = ccb.content.text("n/a"),
        accepted = ccb.content.text("n/a"),
        rejected = ccb.content.text("n/a"),
        advice = ccb.content.text("n/a"),
        inquire = ccb.content.text("n/a"),
        success = ccb.content.text("n/a"),
        success_lie = ccb.content.text("n/a"),
        failure = ccb.content.text("n/a"),
    },
}

ccb.content.define_mission {
    id = "MISSION_TACOMA_Pablo_Message",
    name = ccb.content.text("Pass a message to Jenny Forcette."),
    goal = "MGOAL_NULL",
    difficulty = 2,
    value = 1000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Ask Jenny Forcette if she can help Pablo Nunez with his mill designs."),
        offer = ccb.content.text("n/a"),
        accepted = ccb.content.text("n/a"),
        rejected = ccb.content.text("n/a"),
        advice = ccb.content.text("n/a"),
        inquire = ccb.content.text("n/a"),
        success = ccb.content.text("n/a"),
        success_lie = ccb.content.text("n/a"),
        failure = ccb.content.text("n/a"),
    },
}
