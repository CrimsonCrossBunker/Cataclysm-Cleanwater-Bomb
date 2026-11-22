local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BEM_HUMAN_SAMPLE_FINISH",
    line = ccb.content.text("&<mypronoun> quickly removes the offending piece of meat from your hand and places two golden coins on the table, apparently unshaken by the prospect of meeting someone who casually visits bars while carrying cuts of human flesh.  \"Now if you please, I have a meal to get rid of.\" <mypronoun> says, between poorly masked bouts of nausea."),
    on_enter = {
        { actions = { actions.transfer_items("human_sample"), actions.handler("dlg_a_dda_3cea5fb343d4") } },
    },
    replies = {
        {
            text = ccb.content.text("Leave."),
            next_topic = "TALK_DONE",
            actions = { "end_conversation" },
        },
    },
}
