local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD3_scan",
    line = {
        choices = {
            ccb.content.text("«Just what I need.  Come on, leave me alone.»"),
            ccb.content.text("«How am I supposed to…ugh, just go away.»"),
            ccb.content.text("«Who does this asshole think he is?»"),
        },
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_EVAC_GUARD3",
        },
        {
            text = ccb.content.text("[Telepathy 8+] *Go deeper*."),
            next_topic = "TALK_EVAC_GUARD3_deep_scan",
            when = predicates.handler("dlg_p_mindovermatter_88041846ca42"),
        },
    },
}
