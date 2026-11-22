local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Mandeep_Situation",
    line = {
        when = predicates.handler("dlg_p_dda_defb5ab5fdd2"),
        yes = ccb.content.text("The situation is tense, but it seems like things are slowly improving.  This place isn't home, but we're starting to become a community.  Perhaps, in time, I will call some of these people friends.  At least we don't feel like outsiders so much anymore."),
        no = ccb.content.text("It is hard for me to say.  No one is happy here.  I sense that some are frustrated that my family and I have escaped the end of the world apparently unscathed.  That, and perhaps some other things, have made it hard for us to make close friends here."),
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
