local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Manuscript",
    line = ccb.content.text("It's finally finished!  Here, I want you to have a copy of it.  This is my first time writing like this professionally, I hope you enjoy it."),
    replies = {
        {
            text = ccb.content.text("Thank you, I'm sure it's lovely."),
            next_topic = "TALK_GODCO_Felicity_3",
            actions = { actions.set_actor_value("interlocutor", "general_trade_gave_u_manuscript", "yes"), actions.handler("dlg_a_dda_cebc6d85dfd0") },
        },
    },
}
