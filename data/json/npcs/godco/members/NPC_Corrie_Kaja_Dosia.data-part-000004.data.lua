local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Corrie_Result_rewardIcon1",
    line = ccb.content.text("Oh, I completely forget.  Here you are."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_7ce525ad4b34") } },
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
