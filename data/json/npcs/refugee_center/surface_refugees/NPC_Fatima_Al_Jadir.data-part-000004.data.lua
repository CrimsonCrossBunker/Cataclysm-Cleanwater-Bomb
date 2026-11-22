local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_Teach",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "barter_flag_Fatima_barter_success" } }),
        yes = ccb.content.text("Sure.  As agreed, 3 merch."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Fatima_Mission1" } }),
            yes = ccb.content.gendered_line("Sure, I could teach you the basics, it'll cost you merch though.  Since you helped me out, I can shave a bit off the price, let's say 4 merch, plus a bit in trade depending on how in-depth you're looking for?", { "speaker" }),
            no = ccb.content.text("Sure, I could teach you the basics, I'll have to charge you though.  Let's say, 5 merch for a teaching session, plus a bit in trade depending on how in-depth you're looking for?"),
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "knowledge_trade_Fatima_Teacher", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("[5 merch] All right, here's your money."),
            next_topic = "TALK_TRAIN",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "barter_flag_Fatima_barter_success" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Fatima_Mission1" } })), predicates.has_inventory("speaker", "FMCNote", 5) }),
            actions = { actions.transfer_items("FMCNote", 5) },
        },
        {
            text = ccb.content.text("[4 merch] All right, here's your money."),
            next_topic = "TALK_TRAIN",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "barter_flag_Fatima_barter_success" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Fatima_Mission1" } }), predicates.has_inventory("speaker", "FMCNote", 4) }),
            actions = { actions.transfer_items("FMCNote", 4) },
        },
        {
            text = ccb.content.text("[3 merch] All right, here's your money."),
            next_topic = "TALK_TRAIN",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "barter_flag_Fatima_barter_success" } }), predicates.has_inventory("speaker", "FMCNote", 3) }),
            actions = { actions.transfer_items("FMCNote", 3) },
        },
        {
            text = ccb.content.text("[BARTER] Come on, I'm serious here."),
            when = predicates.handler("dlg_p_dda_891d2a7e9528"),
            trial = { kind = "persuade", difficulty = 35 },
            success = { next_topic = "TALK_REFUGEE_Fatima_Teach_yesbarter" },
            failure = { next_topic = "TALK_REFUGEE_Fatima_Teach_nobarter" },
        },
        {
            text = ccb.content.text("[BARTER] That's still pretty steep, I risked my neck out there for your book.  Can't you manage a little lower?"),
            when = predicates.handler("dlg_p_dda_28ad79fe4659"),
            trial = { kind = "persuade", difficulty = 15 },
            success = { next_topic = "TALK_REFUGEE_Fatima_Teach_yesbarter" },
            failure = { next_topic = "TALK_REFUGEE_Fatima_Teach_nobarter" },
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Fatima_Teach_nobarter",
    line = ccb.content.text("Hey, I appreciate that, but I know what I've got, and I can make good money with that time.  Sorry, my price stands."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_430b6c31392c") } },
    },
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
