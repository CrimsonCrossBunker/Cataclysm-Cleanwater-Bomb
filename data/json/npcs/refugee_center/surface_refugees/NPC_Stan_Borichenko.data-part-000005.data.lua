local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Stan_Garry",
    line = {
        joined = {
            ccb.content.text("*smiles thinly.  \"Best little brother a guy could ask for.  He's been with me through everything, literally everything."),
            {
            when = predicates.handler("dlg_p_dda_3845f6520b02"),
            yes = ccb.content.text("  I wouldn't wish this world we find ourselves in on anyone, but I'm glad Garry made it through with me.\"  Stan sighs, touching his neck."),
            no = ccb.content.text("\"  He seems to realize where he is suddenly, and the faint smile melts.  \"He's lost too much, too.\""),
        },
        },
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
