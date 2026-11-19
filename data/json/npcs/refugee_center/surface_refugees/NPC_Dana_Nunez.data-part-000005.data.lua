local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_REFUGEE_Dana_Background_baking", "TALK_TACOMA_Dana_Baking" },
    line = {
        when = predicates.has_effect("interlocutor", "dana_baking_sold"),
        yes = ccb.content.text("Not since I last saw you, sorry.  Come by tomorrow and I'll try to keep a loaf set aside for you, but they disappear fast."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_trade_Dana_Bread_Sales" } }),
            yes = ccb.content.text("I sure do, if you've got the flour or the merch for me, I'd be happy to trade you another loaf."),
            no = ccb.content.text("I do a bit.  I got a sourdough starter going almost as soon as I arrived, and it's making passable bread already.  I cooked some up yesterday actually, I could probably trade a loaf of fresh bread for, say, about eight cups of flour, or two merch."),
        },
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "knowledge_trade_Dana_Bread_Sales", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("[BARTER] Is that the lowest you can go?  I'd love some bread, but I can't quite make that."),
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_fail")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_success")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })) }),
            trial = { kind = "persuade", difficulty = 20 },
            failure = {
                next_topic = "TALK_REFUGEE_Dana_Background_baking2_nobarter",
                actions = { actions.add_effect("interlocutor", "dana_barter_fail", { turns = 86400 }) },
            },
            success = {
                next_topic = "TALK_REFUGEE_Dana_Background_baking2_yesbarter",
                actions = { actions.add_effect("interlocutor", "dana_barter_success", { turns = 86400 }) },
            },
        },
        {
            text = ccb.content.text("[BARTER] Aw, c'mon.  I rescued Landough, can't you cut me a little deal?"),
            when = predicates.all({ predicates.negate(predicates.has_effect("interlocutor", "dana_baking_sold")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_fail")), predicates.negate(predicates.has_effect("interlocutor", "dana_barter_success")), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } }) }),
            trial = { kind = "persuade", difficulty = 5 },
            failure = {
                next_topic = "TALK_REFUGEE_Dana_Background_baking2_nobarter",
                actions = { actions.add_effect("interlocutor", "dana_barter_fail", { turns = 86400 }) },
            },
            success = {
                next_topic = "TALK_REFUGEE_Dana_Background_baking2_yesbarter",
                actions = { actions.add_effect("interlocutor", "dana_barter_success", { turns = 86400 }) },
            },
        },
    },
}
