local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

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
