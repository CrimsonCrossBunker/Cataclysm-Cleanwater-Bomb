local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "MISSION_ROBOFAC_INTERCOM_1_INQUIRE",
    line = ccb.content.text("You're back.  Do you have anything to report?"),
    replies = {
        {
            text = ccb.content.text("Your scientist was dead, but I disabled the prototype.  Is this what you were looking for?  [Hand over the prototype I/O recorder.]"),
            next_topic = "MISSION_ROBOFAC_INTERCOM_1_COMPLETE",
            when = predicates.has_item("speaker", "robofac_test_data"),
            actions = { actions.handler("dlg_a_dda_a757f4a3a655") },
        },
        {
            text = ccb.content.text("Not yet.  I'll get back to it."),
            next_topic = "TALK_DONE",
        },
    },
}
