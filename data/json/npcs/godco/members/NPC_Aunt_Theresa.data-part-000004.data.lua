local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Theresa_Knit_Something",
    line = ccb.content.text("I suppose I could, in exchange for a few icons.  A scarf is five, a blanket ten, a quilt thirty."),
    replies = {
        {
            text = ccb.content.text("I'll have a scarf."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "icon", 5),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_scarf", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 5) },
        },
        {
            text = ccb.content.text("I'll have a blanket."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "icon", 10),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_blanket", "yes"), actions.handler("dlg_a_dda_bc30246b108a"), actions.transfer_items("icon", 10) },
        },
        {
            text = ccb.content.text("I'll have a quilt."),
            next_topic = "TALK_DONE",
            when = predicates.has_inventory("speaker", "icon", 30),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_quilt", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 30) },
        },
        {
            text = ccb.content.text("How long does it take you to make these?"),
            next_topic = "TALK_GODCO_Theresa_Knit_Time",
        },
        {
            text = ccb.content.text("I've changed my mind.  How're you feeling?"),
            next_topic = "TALK_GODCO_Theresa_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}
