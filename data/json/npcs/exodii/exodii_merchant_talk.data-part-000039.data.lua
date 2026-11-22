local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmTimelineTough",
    line = ccb.content.text("Fine an' fine.  Rubik'll clarion for ye when ye stand o'er the garried trick o' Anubine hisself."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_d62a3b691c5f") } },
    },
    replies = {
        {
            text = ccb.content.text("Do you know what's going on?  What caused all this?"),
            next_topic = "TALK_EXODII_MERCHANT_Talk_CataclysmCause",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
