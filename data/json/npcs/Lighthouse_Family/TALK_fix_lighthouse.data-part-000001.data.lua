local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ENG_LIGHTHOUSE",
    line = ccb.content.text("I did, actually.  Why are you asking?"),
    replies = {
        {
            text = ccb.content.text("We're here.  Ready to start?"),
            next_topic = "TALK_ENG_LIGHTHOUSE_2",
            when = predicates.handler("dlg_p_dda_f0bf0c5e00c6"),
            actions = { "leave", "assign_guard" },
        },
        {
            text = ccb.content.text("Can you repair the mechanism of the lighthouse?"),
            next_topic = "TALK_ENG_LIGHTHOUSE_1",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
    },
}
