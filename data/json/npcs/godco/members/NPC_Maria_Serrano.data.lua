local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Maria_2", "TALK_GODCO_Maria_Story", "TALK_GODCO_Maria_Feeling", "TALK_GODCO_Maria_Past", "TALK_GODCO_Maria_Godco", "TALK_GODCO_Maria_Theresa" },
    replies = {
        {
            text = ccb.content.text("How did you get here?"),
            next_topic = "TALK_GODCO_Maria_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Could you tell me about yourself?"),
            next_topic = "TALK_GODCO_Maria_Past",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things around here?"),
            next_topic = "TALK_GODCO_Maria_Feeling",
        },
        {
            text = ccb.content.text("Is everyone treating you fairly?"),
            next_topic = "TALK_GODCO_Maria_Godco",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("Ahh!  What the hell are you?  Get the freaking away from me!"),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("Buzz off <name_b>, I'm not interested in <freaking> chatting with you."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_maria" } }),
                yes = {
                    choices = {
                        ccb.content.text("Hey <name_g>!  Nice to see you again!"),
                        ccb.content.text("Hey <u_name>!  Nice to see you again!"),
                    },
                },
                no = ccb.content.text("I don't think I've met you before, have I?  I'm Maria Serrano, it's nice to see an new face."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("It's a pleasure to meet you, Maria."),
            next_topic = "TALK_GODCO_Maria_Feeling",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_maria" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_maria", "yes") },
        },
        {
            text = ccb.content.text("Hey Maria.  What's up?"),
            next_topic = "TALK_GODCO_Maria_2",
            when = predicates.handler("dlg_p_dda_71af41b625da"),
        },
        {
            text = ccb.content.text("Maria, why the sudden hostility?"),
            next_topic = "TALK_GODCO_Maria_Angry",
            when = predicates.handler("dlg_p_dda_7d65e3e31354"),
        },
        {
            text = ccb.content.text("Hey Maria.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("Alright, alright, chill out, I'm leaving!"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5ebd062782a3"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_2",
    line = ccb.content.text("What can I do for you?"),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do for you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Could you sew something for me?"),
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_trade_can_sew_for_u" } }),
            next_topic = "TALK_GODCO_Maria_Tailor_Something",
        },
        {
            text = ccb.content.text("How's my order going?"),
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_trade_can_sew_for_u" } }),
            next_topic = "TALK_GODCO_Maria_Retrieve_Order",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Story",
    line = ccb.content.text("I arrived a bit later than everyone else, I was at my studio when <the_cataclysm> came.  Had to dodge a big horde of <zombies> on my way out of town, totaled my car, and hiked the rest of the way."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Past",
    line = ccb.content.text("I always wanted to be a fashion designer when I was young.  I used to have a set of dolls, and I'd make dresses for them out of spare cloth I could find.  I took up sewing in high school, and I was trying to get a job with Fashion Nova before <the_cataclysm> screwed that up."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Feeling",
    line = ccb.content.text("Things are alright, could be better.  I've been mending clothes and sheets ever since I arrived, fixing this and that.  Theresa's been a big help in those regards, we've traded quilt patterns and designs quite a bit."),
    replies = {
        {
            text = ccb.content.text("Could you tell me about Theresa?"),
            next_topic = "TALK_GODCO_Maria_Theresa",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Theresa",
    line = ccb.content.text("She's a kind old lady, does a lot of knitting.  She could probably make you something if you asked nicely."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Godco",
    line = ccb.content.text("Yeah, they are.  I just wish my work was more appreciated."),
    replies = {
        {
            text = ccb.content.text("Could you sew something for me?"),
            actions = { actions.set_actor_value("interlocutor", "general_trade_can_sew_for_u", "yes") },
            next_topic = "TALK_GODCO_Maria_Tailor_What",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Maria_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Tailor_What",
    line = ccb.content.text("I sure can!  For now, I can make t-shirts, pants, dresses, dusters, trench coats, backpacks, jackets, and a gambeson; if that's your thing."),
    replies = {
        {
            text = ccb.content.text("Let's get to it."),
            next_topic = "TALK_GODCO_Maria_Tailor_Something",
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
            text = ccb.content.text("Can you make me something else with leather?"),
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
    id = "TALK_GODCO_Maria_Tailor_Price",
    line = ccb.content.text("T-shirts, pants, jackets, and dresses are four icons.  Dusters, trench coats, and backpacks are eight icons.  A gambeson is sixteen."),
    replies = {
        {
            text = ccb.content.text("Let's get to it."),
            next_topic = "TALK_GODCO_Maria_Tailor_Something",
        },
        {
            text = ccb.content.text("How long does it take you to make these?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Time",
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
    id = "TALK_GODCO_Maria_Tailor_Time",
    line = ccb.content.text("T-shirts, pants, jackets, and dresses take me just a day.  Dusters, trench coats, and backpacks take four days, while a gambeson takes six days."),
    replies = {
        {
            text = ccb.content.text("Let's get to it."),
            next_topic = "TALK_GODCO_Maria_Tailor_Something",
        },
        {
            text = ccb.content.text("What's the price?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Price",
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
    id = "TALK_GODCO_Maria_Tailor_Leather_What",
    line = ccb.content.text("But of course!  Right now, I can make a set of pouches, pants, cloaks, thicker jackets, or even a full set of body armor; it should be useful in your travels."),
    replies = {
        {
            text = ccb.content.text("Let's get to it."),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Something",
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
            text = ccb.content.text("I think I rather want something softer…"),
            next_topic = "TALK_GODCO_Maria_Tailor_What",
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
    id = "TALK_GODCO_Maria_Tailor_Leather_Price",
    line = ccb.content.text("Pouches and pants are eight icons.  Cloaks and thick jackets are twelve icons.  A set of body armor is twenty-four."),
    replies = {
        {
            text = ccb.content.text("Let's get to it."),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Something",
        },
        {
            text = ccb.content.text("How long does it take you to make these?"),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Time",
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
    id = "TALK_GODCO_Maria_Tailor_Leather_Time",
    line = ccb.content.text("Pouches and pants take me two days.  Cloaks and thick jackets take four days, while the set of body armor takes six days."),
    replies = {
        {
            text = ccb.content.text("Let's get to it."),
            next_topic = "TALK_GODCO_Maria_Tailor_Leather_Something",
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
    id = "TALK_GODCO_Maria_Tailor_Start",
    line = ccb.content.text("Alright, I'll get to it."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Tailor_Done",
    line = ccb.content.text("Here it is, I hope you enjoy it.  If you want something else, just come to me."),
    replies = { { text = ccb.content.text("Thank you."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Maria_Angry",
    line = ccb.content.text("'Cause your a <freaking> <name_b> is why!  You think you can just do what fucking ever you want with no consequence!  I'm sick of this, I'm not talking to you anymore."),
    replies = { { text = ccb.content.text("Okay, <name_b>, piss on it."), next_topic = "TALK_DONE" } },
}
