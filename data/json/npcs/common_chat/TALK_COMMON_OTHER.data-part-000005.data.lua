local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_LEADER",
    line = ccb.content.text("What is it?"),
    replies = {
        {
            text = ccb.content.text("How much further?"),
            next_topic = "TALK_HOW_MUCH_FURTHER",
            when = predicates.handler("dlg_p_dda_378775caa047"),
        },
        {
            text = ccb.content.text("I'd like to lead for a while."),
            trial = { kind = "persuade", difficulty = 0, modifiers = { { score = "FEAR", scale = 1 }, { score = "VALUE", scale = 1 }, { score = "TRUST", scale = 1 }, { score = "BRAVERY", scale = -1 }, { score = "AGGRESSION", scale = -1 } } },
            success = { next_topic = "TALK_PLAYER_LEADS", actions = { "follow" } },
            failure = { next_topic = "TALK_LEADER_STAYS", opinion = { value = -1, anger = -1 } },
        },
        {
            text = ccb.content.text("Step aside.  I'm leader now."),
            trial = { kind = "intimidate", difficulty = 40 },
            success = { next_topic = "TALK_PLAYER_LEADS", actions = { "follow" }, opinion = { trust = -1, fear = 1, value = -1, anger = 1 } },
            failure = { next_topic = "TALK_LEADER_STAYS", opinion = { trust = -1, value = -1, anger = 1 } },
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_NONE",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}
