local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Boris_Mission_1",
    line = ccb.content.gendered_line("Yeah, I'll help out.  I've pretty much been waiting for someone to ask, the mess is in my way but I've been too busy to organize it myself.  Boris is the one to talk to, you say?  I'll let him know.", { "interlocutor" }),
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"), actions.handler("dlg_a_dda_1771a2e9be11") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks so much!  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("Thanks so much!  I have to go ask a few others, talk to you later."),
            next_topic = "TALK_DONE",
        },
    },
}
