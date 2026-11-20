local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_meteorologist_4",
    name = ccb.content.text("Find a radio controller for the meteorologist"),
    description = ccb.content.text("The meteorologist asked to bring him a radio controller."),
    goal = "MGOAL_FIND_ITEM",
    item = "radiocontrol",
    item_count = 1,
    difficulty = 0,
    value = 100,
    finish = {
        actions = {
            ccb.content.dialogue_actions.record_time({ scope = "interlocutor", key = "time_mission_meteorologist_wait" }),
            { item = "textbook_electronics" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_meteorologist_5",
    dialogue = {
        describe = ccb.content.text("We need an RC to assemble a drone…"),
        offer = ccb.content.text("Well, what's next on the list… yeah, radio control.  Any kind will do, but the simplest one is better, so I can easily reconfigure it for my drone."),
        accepted = ccb.content.text("I'm waiting for you."),
        rejected = ccb.content.text("Maybe another time…"),
        advice = ccb.content.text("I advise you to search in a store, such as electronics or toy store."),
        inquire = ccb.content.text("How's it going?"),
        success = ccb.content.text("Great, very little work left.  I need a few days to finish all this, and to try it in work.  I hope everything will work fine!  While I'm working on the drone, you can read this book.  Maybe you can learn something new from it."),
        success_lie = ccb.content.text("Why do you say that?"),
        failure = ccb.content.text("…"),
    },
}
