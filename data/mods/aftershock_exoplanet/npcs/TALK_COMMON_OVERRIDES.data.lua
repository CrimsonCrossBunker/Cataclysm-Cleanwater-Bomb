local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND", "TALK_GIVE_ITEM", "TALK_USE_ITEM", "TALK_RADIO" },
    line = { when = predicates.conversation_state("radio"), yes = ccb.content.text(" *pshhhttt* I'm reading you boss, over."), no = { when = predicates.conversation_state("has_reason"), yes = { special = "consume_reason" }, no = ccb.content.text("What is it, friend?") } },
    replies = {
        {
            text = ccb.content.text("Switch to controlling this follower."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "AFS_LEADERSHIP"),
            actions = { actions.handler("dlg_a_aftershock_exoplanet_dff20e5248e1"), "take_control" },
        },
        {
            text = ccb.content.text("Switch to controlling your party leader."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "AFS_LEADERSHIP"),
            actions = { actions.handler("dlg_a_aftershock_exoplanet_57417bc70225"), "take_control" },
        },
    },
}
