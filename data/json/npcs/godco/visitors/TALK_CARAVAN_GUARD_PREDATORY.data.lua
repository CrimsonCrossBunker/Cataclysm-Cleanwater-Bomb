local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY",
    line = ccb.content.text("*looks up at you in uninterested fashion.  \"What do you want?  I'm working.\""),
    replies = {
        {
            text = ccb.content.text("Oh, uh, sorry."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'm here to pick up a delivery."),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_PICKUP",
            when = predicates.all({ predicates.has_mission("MISSION_INVESTIGATE_TRADER"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_trade_u_talked_about_records" } })) }),
        },
        {
            text = ccb.content.text("I'm back for the records, and I have the money."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_trade_u_owe_20" } }),
            actions = { actions.handler("w16b_a_dda_905330b7b16a") },
        },
        {
            text = ccb.content.text("I'm back for the records, and I have the money."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_trade_u_owe_50" } }),
            actions = { actions.handler("w16b_a_dda_fef3fda7ed0f") },
        },
        {
            text = ccb.content.text("I'm back for the records, and I have the money."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_trade_u_owe_150" } }),
            actions = { actions.handler("w16b_a_dda_dc7499dbfcd6") },
        },
        {
            text = ccb.content.text("I'm back for your records."),
            next_topic = "TALK_DONE",
            when = predicates.handler("w16b_p_dda_1992fc90a741"),
            actions = { actions.handler("w16b_a_dda_6dc89c37aece"), actions.clear_actor_value("interlocutor", "timer_trade_fixing_records") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_PICKUP",
    line = ccb.content.gendered_line("Really, I haven't heard anything about it.  What's it you need?", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("The boss wants your accounting papers, I need them."),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_ACCRECORDS",
        },
        {
            text = ccb.content.text("Oh nothing, I must have the wrong person."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_ACCRECORDS",
    line = ccb.content.text("They're not ready yet, you'll have to come back later."),
    replies = {
        {
            text = ccb.content.text("I'll just take them as is, thanks.  Everything can be finalized later."),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_NOW",
        },
        {
            text = ccb.content.text("We both know that's a lie.  Hand them over, or else."),
            trial = {
                kind = "intimidate",
                difficulty = 10,
                modifiers = {
                    { score = "TRUST", scale = 3 },
                    { score = "VALUE", scale = 3 },
                    { score = "ANGER", scale = 3 },
                    { score = "FEAR", scale = -3 },
                },
            },
            success = {
                next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_INTIMSUCCESS",
                opinion = { trust = -4, fear = 3 },
            },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Could I get them for a price?"),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_BRIBE",
        },
        {
            text = ccb.content.text("When will they be ready?"),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_TIME",
        },
        { text = ccb.content.text("Okay, see ya."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_NOW",
    line = ccb.content.gendered_line("I told you already, I'm not finished with them, come back later.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("We both know that's a lie.  Hand them over, or else."),
            trial = {
                kind = "intimidate",
                difficulty = 10,
                modifiers = {
                    { score = "TRUST", scale = 3 },
                    { score = "VALUE", scale = 3 },
                    { score = "ANGER", scale = 3 },
                    { score = "FEAR", scale = -3 },
                },
            },
            success = {
                next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_INTIMSUCCESS",
                opinion = { trust = -4, fear = 3 },
            },
            failure = { next_topic = "TALK_DONE", native_actions = { "hostile" } },
        },
        {
            text = ccb.content.text("Could I get them for a price?"),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_BRIBE",
        },
        {
            text = ccb.content.text("When will they be ready?"),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_TIME",
        },
        { text = ccb.content.text("Okay, see ya."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_TIME",
    line = ccb.content.text("Just two more days is all I need with them, then the boss can do whatever.  Is that good?"),
    replies = {
        {
            text = ccb.content.text("Alright, I'll be back then."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_5dbea276c605"), actions.set_actor_value("interlocutor", "general_trade_u_talked_about_records", "yes") },
        },
        {
            text = ccb.content.text("No, I need them now."),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_NOW",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_INTIMSUCCESS",
    line = ccb.content.text("I don't know what the hell you want them for, but I sure don't care.  Take 'em, <name_b>."),
    on_enter = {
        { actions = { actions.set_first_topic("TALK_DONE") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks, <name_b>."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_120c74150ad9"), actions.set_actor_value("interlocutor", "general_trade_u_talked_about_records", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_BRIBE",
    line = ccb.content.text("How much are you thinking?"),
    replies = {
        {
            text = ccb.content.text("Does $5 sound good?"),
            next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_FIVE",
        },
        {
            text = ccb.content.text("How about $20?"),
            trial = {
                kind = "persuade",
                difficulty = 10,
                modifiers = {
                    { score = "TRUST", scale = -3 },
                    { score = "VALUE", scale = -3 },
                    { score = "ANGER", scale = 3 },
                    { score = "FEAR", scale = -3 },
                },
            },
            success = { next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_TWENTY_WIN" },
            failure = { next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_TWENTY_FAIL" },
        },
        {
            text = ccb.content.text("I'll give you $50, my best offer."),
            trial = {
                kind = "persuade",
                difficulty = 20,
                modifiers = {
                    { score = "TRUST", scale = -3 },
                    { score = "VALUE", scale = -3 },
                    { score = "ANGER", scale = 3 },
                    { score = "FEAR", scale = -3 },
                },
            },
            success = { next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_FIFTY_WIN" },
            failure = { next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_FIFTY_FAIL" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_FIVE",
    line = ccb.content.text("*holds their abdomen as they nearly keel over from laughter.  \"You better be glad that I think you're funny, anyone else would find it an insult.  $150 is more like it to me.\""),
    replies = {
        {
            text = ccb.content.text("Alright, here it is."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_4f624905997f"), actions.set_actor_value("interlocutor", "general_trade_u_talked_about_records", "yes") },
        },
        {
            text = ccb.content.text("I don't take kindly to your jokes, <name_b>.  Hand 'em over or else."),
            trial = { kind = "intimidate", difficulty = 10, modifiers = { { score = "TRUST", scale = 3 }, { score = "VALUE", scale = 3 }, { score = "ANGER", scale = 3 }, { score = "FEAR", scale = -3 } } },
            success = { next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_INTIMSUCCESS", opinion = { trust = -4, fear = 3 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_TWENTY_WIN",
    line = ccb.content.text("*seems to get lost in thought for a moment, before looking back at you.  \"Alright, you have a deal.\""),
    replies = {
        {
            text = ccb.content.text("Pleasure doing business."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_d1372e13dffc"), actions.set_actor_value("interlocutor", "general_trade_u_talked_about_records", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_TWENTY_FAIL",
    line = ccb.content.text("*seems to get lost in thought for a moment, before looking back at you.  \"Nah, I think $150 would be a better price.\""),
    replies = {
        {
            text = ccb.content.text("Alright, here it is."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_843591da9c04"), actions.set_actor_value("interlocutor", "general_trade_u_talked_about_records", "yes") },
        },
        {
            text = ccb.content.text("How about I don't give you any money instead?  Hand 'em over or else."),
            trial = { kind = "intimidate", difficulty = 10, modifiers = { { score = "TRUST", scale = 3 }, { score = "VALUE", scale = 3 }, { score = "ANGER", scale = 3 }, { score = "FEAR", scale = -3 } } },
            success = { next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_INTIMSUCCESS", opinion = { trust = -4, fear = 3 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_FIFTY_WIN",
    line = ccb.content.gendered_line("Ah, a rich man I see.  I think you have yourself a deal.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Sounds great to me."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_bf616f7e2638"), actions.set_actor_value("interlocutor", "general_trade_u_talked_about_records", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_FIFTY_FAIL",
    line = ccb.content.text("I think you can go a bit higher, $150 and the records are yours."),
    replies = {
        {
            text = ccb.content.text("Sounds great to me."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_ff5d4687cda9"), actions.set_actor_value("interlocutor", "general_trade_u_talked_about_records", "yes") },
        },
        {
            text = ccb.content.text("How about I don't give you any money instead?  Hand 'em over or else."),
            trial = { kind = "intimidate", difficulty = 10, modifiers = { { score = "TRUST", scale = 3 }, { score = "VALUE", scale = 3 }, { score = "ANGER", scale = 3 }, { score = "FEAR", scale = -3 } } },
            success = { next_topic = "TALK_CARAVAN_GUARD_PREDATORY_RECORDS_INTIMSUCCESS", opinion = { trust = -4, fear = 3 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
    },
}
