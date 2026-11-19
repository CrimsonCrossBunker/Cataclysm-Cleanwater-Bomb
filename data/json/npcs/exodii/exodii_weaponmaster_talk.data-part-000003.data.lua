local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_WEAPONMASTER_INTRO_6",
    line = ccb.content.text("&They clearly do not understand you.  It seems they do not hear you either."),
    replies = {
        {
            text = ccb.content.text("[You pull off your backpack, and start to pull out items you deem worthy of trading.  The weaponmaster finally looks interested.]"),
            next_topic = "TALK_DONE",
            actions = { actions.set_first_topic("TALK_EXODII_WEAPONMASTER"), "start_trade" },
        },
    },
}
