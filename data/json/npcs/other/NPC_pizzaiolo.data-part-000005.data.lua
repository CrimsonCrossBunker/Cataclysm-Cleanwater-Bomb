local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_pizzaiolo_1",
    name = ccb.content.text("Angry pizzaiolo"),
    description = ccb.content.text("Bring the pizzaiolo to <color_light_blue>their rival's house</color> and don't forget to <color_yellow>bring at least 200 units of gasoline</color>.  After you got there, talk to the pizzaiolo to start burning the house."),
    goal = "MGOAL_GO_TO",
    difficulty = 0,
    value = 10000,
    generic_rewards = false,
    start = {
        target = { terrain = "s_restaurant", special = "restraunt", min_distance = 5, z = 0 },
        actions = { "follow_only", ccb.content.dialogue_actions.set_first_topic("MISSION_PYROMANIAC") },
    },
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_first_topic("TALK_pizzaiolo_1"),
            "stop_following",
            { handler = "deliver_gasoline_200_items" },
            ccb.content.dialogue_actions.update_map("MISSION_PYROMANIAC_BURN"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_pizzaiolo_2",
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("I'm so angry!  I have an enemy that ruined my life, and I want revenge for it!  I don't care about <the_cataclysm>, I just want to burn his <freaking> restaurant!  Will you help me?"),
        accepted = ccb.content.text("Good.  Let's go to his restaurant and fucking burn it!  Oh, by the way, could you bring gasoline with you, <name_g>?  I was so angry I forgot to bring it with me…"),
        rejected = ccb.content.text("What?!  Why do you… ah, forget it."),
        advice = ccb.content.text("Maybe we can find some gasoline at a gas station."),
        inquire = ccb.content.text("Are you ready, <name_g>?"),
        success = ccb.content.text("Sweet, sweet revenge!  It smells so nice!  His restaurant burns, his legacy is now ruined!  Even if he became a <zombie>, it still good."),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
}
