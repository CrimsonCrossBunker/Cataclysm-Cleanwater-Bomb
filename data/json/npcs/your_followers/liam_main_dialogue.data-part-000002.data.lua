local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_Liam_ORDERS" },
    line = {
        choices = {
            ccb.content.text("Sounds weird calling it \"orders\", I'm your friend, not your minion.  No worries though, what up?"),
            ccb.content.text("Sure, what do you want?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Can you teach me anything?"),
            when = predicates.negate(predicates.conversation_state("radio")),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_24352433e095") },
            success = { next_topic = "TALK_DENY_TRAIN" },
            failure = { next_topic = "TALK_TRAIN_PERSUADE_Liam" },
        },
        {
            text = ccb.content.text("Can you host a training seminar?"),
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_6df687e81cfd") },
            success = { next_topic = "TALK_DENY_TRAIN_SEMINAR" },
            failure = { next_topic = "TALK_TRAIN_SEMINAR_PERSUADE_Liam" },
        },
        {
            text = ccb.content.text("I have something to teach you."),
            next_topic = "TALK_TRAIN_NPC",
            when = predicates.handler("dlg_p_dda_6347d53c499b"),
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_FRIEND_Liam",
            when = predicates.all({ predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")), predicates.negate(predicates.conversation_state("radio")) }),
            actions = { "start_trade" },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("I want you to use this item."),
            next_topic = "TALK_FRIEND_Liam",
            when = predicates.negate(predicates.conversation_state("radio")),
            actions = { "npc_gets_item_to_use" },
        },
        {
            text = ccb.content.text("Hold on to this item."),
            next_topic = "TALK_FRIEND_Liam",
            when = predicates.negate(predicates.conversation_state("radio")),
            actions = { "npc_gets_item" },
        },
        {
            text = ccb.content.text("Guard this position."),
            next_topic = "TALK_FRIEND_GUARD_Liam",
            when = predicates.negate(predicates.conversation_state("radio")),
            actions = { "assign_guard" },
        },
        {
            text = ccb.content.text("Find a horse and mount up!"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_e15f2a008540"),
            actions = { "find_mount" },
        },
        {
            text = ccb.content.text("Drop off any items you're not using."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "drop_items_in_place" },
        },
        {
            text = ccb.content.text("Get off your mount, please."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_dc5e444f6fd5"),
            actions = { "dismount" },
        },
        {
            text = ccb.content.text("Let's talk about your current activity."),
            next_topic = "TALK_ACTIVITIES",
        },
        {
            text = ccb.content.text("Let's talk about the camp."),
            next_topic = "TALK_CAMP",
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}
