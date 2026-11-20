local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_SOFTWARE",
    name = ccb.content.text("Retrieve Stick"),
    goal = "MGOAL_FIND_ITEM",
    item = "stick",
    difficulty = 2,
    value = 80000,
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh man, I can't believe I forgot to bring it…"),
        offer = ccb.content.text("There's some important notes on my special stick that I need."),
        accepted = ccb.content.text("Thanks!  Just get the stick and bring it to me."),
        rejected = ccb.content.text("Seriously?  It's an easy job…"),
        advice = ccb.content.text("Don't worry, you'll know the stick when you see it, it is unmistakable."),
        inquire = ccb.content.text("So, do you have my stick yet?"),
        success = ccb.content.text("Excellent, thank you!"),
        success_lie = ccb.content.text("What?!  You liar!"),
        failure = ccb.content.text("Wow, you failed?  All that work, down the drain…"),
    },
}
