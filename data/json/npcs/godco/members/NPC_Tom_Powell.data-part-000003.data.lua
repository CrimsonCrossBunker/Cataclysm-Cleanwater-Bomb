local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Olwen",
    line = ccb.content.text("Olwen's a bright girl; she's fiddled with electronics and computers since she was in high school.  She got a master's in it from the University of Rhode Island.  Felicity's been a good mother for her, always been there for us.  Olwen might be able to teach you a few things, she should be around here somewhere."),
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("What do you think about her love life with Julian in here?"),
            next_topic = "TALK_GODCO_Tom_Olwen_Love0",
            when = predicates.handler("dlg_p_dda_f99453b5c14d"),
        },
        {
            text = ccb.content.text("What do you think about her love life with Julian in here?"),
            next_topic = "TALK_GODCO_Tom_Olwen_Love1",
            when = predicates.handler("dlg_p_dda_e994ba98f6c9"),
        },
        {
            text = ccb.content.text("What do you think about her love life with Julian in here?"),
            next_topic = "TALK_GODCO_Tom_Olwen_Love2",
            when = predicates.handler("dlg_p_dda_1ef53835301b"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
