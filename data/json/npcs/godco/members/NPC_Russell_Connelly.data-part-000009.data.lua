local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Trade2",
    line = ccb.content.text("I can't give a discount, but here's some meat instead.  Made by yours truly."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_da267392f0c1"), actions.add_effect("interlocutor", "trade_godco_russell", { permanent = true }) } },
    },
    replies = {
        {
            text = ccb.content.text("Thank you.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Thank you.  I'll see you around, Russell."),
            next_topic = "TALK_DONE",
        },
    },
}
