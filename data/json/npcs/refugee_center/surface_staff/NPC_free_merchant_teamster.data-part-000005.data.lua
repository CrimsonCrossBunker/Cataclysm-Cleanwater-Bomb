local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_FACTION_INTRO",
    line = ccb.content.text("Always lookin' for new places to trade.  What you got for me?"),
    replies = {
        {
            text = ccb.content.text("[Tell them about Rubik and the Exodii.]"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_EXODII_1",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
        },
        {
            text = ccb.content.text("Hold on, what were you saying before?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}
