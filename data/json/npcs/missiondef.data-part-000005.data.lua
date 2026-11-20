local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GET_FLAG",
    name = ccb.content.text("Find Flag"),
    goal = "MGOAL_FIND_ITEM",
    start = { actions = { ccb.content.dialogue_actions.remove_items("interlocutor", "american_flag") } },
    difficulty = 2,
    value = 100000,
    item = "american_flag",
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    followup = "MISSION_GET_BLACK_BOX",
    dialogue = {
        describe = ccb.content.text("Does our flag still yet wave?"),
        offer = ccb.content.text("Does our flag still yet wave?  We're battered but not yet out of the fight, we need the old colors!"),
        accepted = ccb.content.text("Hell ya!  Find me one of those big ol' American flags."),
        rejected = ccb.content.text("Seriously?  God damned commie…"),
        advice = ccb.content.text("Find a large federal building or school, they must have one."),
        inquire = ccb.content.text("Rescued the standard yet?"),
        success = ccb.content.text("America, fuck ya!"),
        success_lie = ccb.content.text("What?!  You liar!"),
        failure = ccb.content.text("You give up?  This country fell apart because no one could find a good man to rely on… might as well give up, I guess."),
    },
}
