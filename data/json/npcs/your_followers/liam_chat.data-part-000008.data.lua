local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_HUB_DELIVERY_1",
    line = {
        when = predicates.handler("dlg_p_dda_9183061634b4"),
        yes = ccb.content.text("I'm thinking this kinda sounds like that intercom and their vague-yet-menacing government agency.\"  He pauses.  \"That might be a deep cut, if you never listened to Night Vale.  Anyway, I bet that's where we're going."),
        no = ccb.content.text("I'm thinking this sounds *awesome*, and also possibly we're gonna die.  At least we'll die investigating a vague-yet-menacing government agency.\"  He pauses.  \"That might be a deep cut, if you never listened to Night Vale."),
    },
    replies = {
        {
            text = ccb.content.text("Yep, same page.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
