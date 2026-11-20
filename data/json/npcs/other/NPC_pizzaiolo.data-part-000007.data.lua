local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_pizzaiolo_4",
    generic_rewards = false,
    name = ccb.content.text("Family house"),
    description = ccb.content.text("First bring pizzaiolo some chocolate cake then lead him to his family house."),
    goal = "MGOAL_GO_TO",
    start = {
        target = {
            terrain = "house",
            match = "PREFIX",
            random = true,
            search_range = 75,
            min_distance = 5,
            z = 0,
        },
        actions = {
            { handler = "teach_cake2" },
            ccb.content.dialogue_actions.notify_player(ccb.content.text("You learn how to craft cake.")),
        },
    },
    failure = { actions = { "end_conversation" } },
    difficulty = 0,
    value = 100,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("Now, as my competitors dead, their places are ruined, it's time to relax… I know, let's celebrate it!  Lead me to my house.  Also, we need a cake for that.  What celebration without a cake, right?  I can teach you how to cook it, if you want."),
        accepted = ccb.content.text("Good.  Bring me chocolate cake and talk to me."),
        rejected = ccb.content.text("What?!  Why do you… ah, forget it."),
        advice = ccb.content.text("If you listened to me very closely, it wouldn't be hard for you to make it.  Good luck, <name_g>."),
        inquire = ccb.content.text("I'm waiting."),
        success = ccb.content.text("-"),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}
