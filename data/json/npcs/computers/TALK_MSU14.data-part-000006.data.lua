local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "MSU14_DOCS_SUCCESS",
    line = ccb.content.text("&Printing…"),
    replies = {
        {
            text = ccb.content.text("Return."),
            next_topic = "MSU14_MAIN",
            actions = { actions.handler("dlg_a_dda_33a0dce1e002"), actions.set_actor_value("speaker", "computer_hacking_msu14_printed_docs", "yes") },
        },
    },
}
