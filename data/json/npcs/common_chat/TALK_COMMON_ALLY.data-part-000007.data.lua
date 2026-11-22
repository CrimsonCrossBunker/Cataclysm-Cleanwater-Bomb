local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GOTO_LOCATION",
    line = { when = predicates.handler("dlg_p_dda_2379dbeda833"), yes = ccb.content.text("Sure thing, I'll make my way there."), no = ccb.content.text("All right, tell me if you want me to go somewhere.") },
    replies = {
        {
            text = ccb.content.text("Affirmative."),
            next_topic = "TALK_DONE",
        },
    },
}
