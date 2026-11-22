local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_idlechat",
    line = {
        choices = {
            ccb.content.text("Sure, what's happening?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Could you tell me a bit about yourself?"),
            next_topic = "TALK_GODCO_guard_food_about_self",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What are you planning on doing in the future?"),
            next_topic = "TALK_GODCO_guard_food_future_plans",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Could I borrow something from the stock?"),
            next_topic = "TALK_GODCO_guard_food_borrow",
        },
        {
            text = ccb.content.text("Would you be willing to buy any food?"),
            next_topic = "TALK_GODCO_guard_food_buy",
        },
        {
            text = ccb.content.text("Has anyone stolen from here?"),
            next_topic = "TALK_GODCO_guard_food_theft",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How much food do you have?"),
            next_topic = "TALK_GODCO_guard_food_stock",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Is there anything I can do to help you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Good luck with that."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_who",
    line = {
        choices = {
            ccb.content.text("Name's Eddie.  I'm making sure this stockpile is alright."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Could you just chat for a bit?"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("Is there anything I can do to help you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Could I borrow something from the stock?"),
            next_topic = "TALK_GODCO_guard_food_borrow",
        },
        {
            text = ccb.content.text("Has anyone stolen from here?"),
            next_topic = "TALK_GODCO_guard_food_theft",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How much food do you have?"),
            next_topic = "TALK_GODCO_guard_food_stock",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Good luck with that."),
            next_topic = "TALK_DONE",
        },
    },
}
