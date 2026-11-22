local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Join",
    line = ccb.content.text("Aight, here are the rules: don't commit sins, don't litter, and try not to die.  Have some mutual respect, capiche?"),
    replies = {
        {
            text = ccb.content.text("Got it."),
            next_topic = "TALK_GODCO_Julian_Joinee",
            actions = { actions.handler("dlg_a_dda_bdc407533a0b") },
        },
        {
            text = ccb.content.text("Actually, <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
