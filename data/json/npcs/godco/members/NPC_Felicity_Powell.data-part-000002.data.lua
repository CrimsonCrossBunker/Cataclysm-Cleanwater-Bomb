local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Olwen",
    line = ccb.content.text("Olwen's a bright girl, always has been.  She studied electricity and computer science when she was in college, found a job with a research and development firm.  My girl's a fiancee now, her and Julian were going to get married in a few months.  She might teach you something, if you ask."),
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Felicity_3",
        },
        {
            text = ccb.content.text("What do you think about her love life with Julian in here?"),
            next_topic = "TALK_GODCO_Felicity_Olwen_Love0",
            when = predicates.handler("dlg_p_dda_f99453b5c14d"),
        },
        {
            text = ccb.content.text("What do you think about her love life with Julian in here?"),
            next_topic = "TALK_GODCO_Felicity_Olwen_Love1",
            when = predicates.handler("dlg_p_dda_e994ba98f6c9"),
        },
        {
            text = ccb.content.text("What do you think about her love life with Julian in here?"),
            next_topic = "TALK_GODCO_Felicity_Olwen_Love2",
            when = predicates.handler("dlg_p_dda_1ef53835301b"),
        },
        {
            text = ccb.content.text("<end_talking_leave>  Bye, Felicity."),
            next_topic = "TALK_DONE",
        },
    },
}
