local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_LUMBERMILL_MERCHANT",
    line = {
        when = predicates.handler("dlg_p_dda_89916db0b2be"),
        yes = ccb.content.text("Hello there.  Nice to see you again."),
        no = ccb.content.text("A new face at the mill?  Who might you be?"),
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you."),
            next_topic = "TALK_NPC_LUMBERMILL_MERCHANT_INTRO",
            when = predicates.handler("dlg_p_dda_10f926b68b74"),
            actions = { actions.handler("dlg_a_dda_f6aa485bf437") },
        },
        {
            text = ccb.content.text("Pleasure to see you again."),
            next_topic = "TALK_NPC_LUMBERMILL_MERCHANT_INTRO",
            when = predicates.handler("dlg_p_dda_89916db0b2be"),
        },
        {
            text = ccb.content.text("Hands up!"),
            when = predicates.handler("dlg_p_dda_10f926b68b74"),
            trial = { kind = "intimidate", difficulty = 30 },
            success = { next_topic = "TALK_WEAPON_DROPPED", actions = { "drop_weapon" }, opinion = { trust = -4, fear = 3 } },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_NPC_LUMBERMILL_MERCHANT_INTRO", "TALK_LUMBERMILL_RESTOCK" },
    line = ccb.content.text("So, what's up?"),
    replies = {
        {
            text = ccb.content.text("Let's trade."),
            next_topic = "TALK_NPC_LUMBERMILL_MERCHANT_INTRO",
            actions = { "start_trade" },
        },
        {
            text = ccb.content.text("When will you have new stuff in stock?"),
            next_topic = "TALK_LUMBERMILL_RESTOCK",
        },
        {
            text = ccb.content.text("Can I order a batch of lumber?"),
            next_topic = "TALK_LUMBERMILL_FABRICATE",
            when = predicates.handler("dlg_p_dda_a1e6553c880f"),
        },
        {
            text = ccb.content.text("How is my order going?"),
            next_topic = "TALK_LUMBERMILL_FABRICATE_FINISHED",
            when = predicates.handler("dlg_p_dda_e6af57b8eff7"),
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_NPC_LUMBERMILL_MERCHANT_STORY",
        },
        {
            text = ccb.content.text("I'd like to ask you a few questions."),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        {
            text = ccb.content.text("Can I use the gate?  I'd like to bring a vehicle for trade."),
            next_topic = "TALK_LUMBERMILL_GATE_PERMISSION",
        },
        {
            text = ccb.content.text("Any jobs you need done?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.all({ predicates.negate(predicates.assigned_missions(1, 1)), predicates.negate(predicates.assigned_missions(2)) }),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LUMBERMILL_GATE_PERMISSION",
    line = ccb.content.text("I'll tell the guys to open one of the gates, but you gotta promise to be careful.  We've got a simple rule here: You break it, you buy it!"),
    replies = {
        {
            text = ccb.content.text("I'll be careful."),
            next_topic = "TALK_NPC_LUMBERMILL_MERCHANT_INTRO",
            actions = { actions.update_map("ocu_lumbermill_opens_a_gate", "lumbermill_1_1_ocu") },
        },
    },
}
