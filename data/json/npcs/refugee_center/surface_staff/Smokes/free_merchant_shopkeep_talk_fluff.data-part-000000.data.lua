local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting",
    line = ccb.content.text("A lot of the time, yes.  Our address is on the info boards of most of the evac shelters around here, and people keep showing up that we have to turn away.  It gets easier when you have something you can read off a script."),
    replies = {
        {
            text = ccb.content.text("I'm sorry."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_End",
        },
        {
            text = ccb.content.text("That sounds a little cruel."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_Cruel",
        },
        {
            text = ccb.content.text("[Cannibal + Uncaring] Wait, I thought you were having food problems."),
            next_topic = "TALK_FREE_MERCHANTS_MERCHANT_AboutGreeting_Cannibal",
            when = predicates.all({ predicates.has_trait("speaker", "CANNIBAL"), predicates.has_flag("speaker", "PSYCHOPATH") }),
        },
    },
}
