local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_CalledOut2",
    line = ccb.content.text("Better'n you'd maybe think, okay?  Can we drop it?"),
    replies = {
        {
            text = ccb.content.text("Just stop talking like that around me, maybe?  It's really obnoxious."),
            next_topic = "TALK_REFUGEE_Alonso_CalledOut3",
            actions = { actions.set_actor_value("interlocutor", "general_none_Alonso_accent", "asked") },
        },
        {
            text = ccb.content.text("You know what?  You do you.  It's all good."),
            next_topic = "TALK_REFUGEE_Alonso_CalledOut3",
            actions = { actions.set_actor_value("interlocutor", "general_none_Alonso_accent", "accepted"), actions.handler("dlg_a_dda_e1b9d929b004") },
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'll leave you to it then."),
            next_topic = "TALK_DONE",
        },
    },
}
