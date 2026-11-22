local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Tailor_Something",
    line = ccb.content.text("What'll ya have?"),
    replies = {
        {
            text = ccb.content.text("I'll have a t-shirt."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 4),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_tshirt", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 4) },
        },
        {
            text = ccb.content.text("I'll have a pair of pants."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 4),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_pants", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 4) },
        },
        {
            text = ccb.content.text("I'll have a leather jacket."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 4),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_jacket", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 4) },
        },
        {
            text = ccb.content.text("I'll have a dress."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 4),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_dress", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 4) },
        },
        {
            text = ccb.content.text("I'll have a duster."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 6),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_duster", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 8) },
        },
        {
            text = ccb.content.text("I'll have a trench coat."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 6),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_trenchcoat", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 8) },
        },
        {
            text = ccb.content.text("I'll have a backpack."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 6),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_backpack", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 8) },
        },
        {
            text = ccb.content.text("I'll have a gambeson."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 15),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_gambeson", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 16) },
        },
        {
            text = ccb.content.text("What can you sew?"),
            next_topic = "TALK_GODCO_Maria_Tailor_What",
        },
        {
            text = ccb.content.text("How long does it take you to make these?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Time",
        },
        {
            text = ccb.content.text("What's the price?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Price",
        },
        {
            text = ccb.content.text("Do you make more things with leather?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_What",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Tailor_Leather_Something",
    line = ccb.content.text("What'll ya have?"),
    replies = {
        {
            text = ccb.content.text("I'll have a set of pouches."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 8),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_pouches", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 8) },
        },
        {
            text = ccb.content.text("I'll have a pair of leather pants."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 8),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_leather_pants", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 8) },
        },
        {
            text = ccb.content.text("I'll have a leather cloak."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 12),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_cloak", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 12) },
        },
        {
            text = ccb.content.text("I'll have a thicker leather jacket."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 12),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_jacket_thick", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 12) },
        },
        {
            text = ccb.content.text("I'll have a set of body armor."),
            next_topic = "TALK_GODCO_Maria_Tailor_Start",
            when = predicates.has_inventory("speaker", "icon", 24),
            actions = { actions.set_actor_value("interlocutor", "general_trade_u_want_body_armor", "yes"), actions.handler("dlg_a_dda_d384e3101085"), actions.transfer_items("icon", 24) },
        },
        {
            text = ccb.content.text("What can you sew?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_What",
        },
        {
            text = ccb.content.text("How long does it take you to make these?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Time",
        },
        {
            text = ccb.content.text("What's the price?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Price",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Retrieve_Order",
    line = ccb.content.text("I've been busy lately, what did you ask for again?"),
    replies = {
        {
            text = ccb.content.text("I ordered a t-shirt."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_59256ea374c7"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_tshirt"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_1164db67331e") },
        },
        {
            text = ccb.content.text("I ordered a pair of pants."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_170ed5de53b8"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_pants"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_35cbaacd9e02") },
        },
        {
            text = ccb.content.text("I ordered a leather jacket."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_4b4f81870ac1"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_jacket"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_ffd8e3ec9202") },
        },
        {
            text = ccb.content.text("I ordered a dress."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_6458309178f7"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_dress"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_7cc387b0bfbd") },
        },
        {
            text = ccb.content.text("I ordered a duster."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_f12224d21e87"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_duster"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_a20b6c27cb1c") },
        },
        {
            text = ccb.content.text("I ordered a trench coat."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_9a97176136e0"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_trenchcoat"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_a855c3058f95") },
        },
        {
            text = ccb.content.text("I ordered a backpack."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_0137e622fe39"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_backpack"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_4565df971ccb") },
        },
        {
            text = ccb.content.text("I ordered a gambeson."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_83af47bef271"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_gambeson"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_c809816b2535") },
        },
        {
            text = ccb.content.text("I ordered a set of pouches."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_64d6b0dd5a5b"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_pouches"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_cf8715923c26") },
        },
        {
            text = ccb.content.text("I ordered a pair of leather pants."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_4a28600a12c5"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_leather_pants"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_8e7f02feef9a") },
        },
        {
            text = ccb.content.text("I ordered a leather cloak."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_33d2373df3aa"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_cloak"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_ce0f31c5a4db") },
        },
        {
            text = ccb.content.text("I ordered a thick leather jacket."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_007f7691adf8"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_jacket_thick"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_affaa2da3c28") },
        },
        {
            text = ccb.content.text("I ordered a set of body armor."),
            next_topic = "TALK_GODCO_Maria_Tailor_Done",
            when = predicates.handler("dlg_p_dda_44eb7ec73bee"),
            actions = { actions.clear_actor_value("interlocutor", "general_trade_u_want_body_armor"), actions.clear_actor_value("interlocutor", "timer_trade_knitting"), actions.handler("dlg_a_dda_9bf56bd8a629") },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}
