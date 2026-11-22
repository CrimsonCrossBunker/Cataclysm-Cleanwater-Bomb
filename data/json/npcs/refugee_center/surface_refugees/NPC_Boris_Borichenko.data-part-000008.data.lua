local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Teach",
    line = ccb.content.gendered_line("Yes, my friend.  You have done so much for me, I would be glad to teach you what I can.  I must ask a small amount in trade, for materials.  I hope you understand.", { "speaker" }),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_0957c05f4b74") } },
    },
    replies = {
        {
            text = ccb.content.text("Great!  Let's get started."),
            next_topic = "TALK_TRAIN",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  Let's do this later."),
            next_topic = "TALK_DONE",
        },
    },
}
