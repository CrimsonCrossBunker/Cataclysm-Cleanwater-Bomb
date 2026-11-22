local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND", "TALK_GIVE_ITEM", "TALK_USE_ITEM", "TALK_RADIO" },
    line = { when = predicates.conversation_state("radio"), yes = ccb.content.text(" *pshhhttt* I'm reading you boss, over."), no = { when = predicates.conversation_state("has_reason"), yes = { special = "consume_reason" }, no = ccb.content.text("What is it, friend?") } },
    replies = {
        {
            text = ccb.content.text("[rules] Let's talk about how we'll work together."),
            next_topic = "TALK_DONE",
            actions = { "npc_rules_menu" },
        },
        {
            text = ccb.content.text("I'd like to know a bit more about your abilities."),
            next_topic = "TALK_FRIEND",
            actions = { "reveal_stats" },
        },
        {
            text = ccb.content.text("Please go to this location."),
            next_topic = "TALK_GOTO_LOCATION",
            actions = { "goto_location" },
        },
        {
            text = ccb.content.text("There's something I want you to do."),
            next_topic = "TALK_ALLY_ORDERS",
        },
        {
            text = ccb.content.text("I just wanted to talk for a bit."),
            next_topic = "TALK_ALLY_SOCIAL",
        },
        {
            text = ccb.content.text("Can you help me understand something?  (HELP/TUTORIAL)"),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("[DEBUG MIND CONTROL] Now listen closely… (DEBUG FUNCTIONS)"),
            next_topic = "TALK_ALLY_DEBUG",
            when = predicates.has_trait("speaker", "DEBUG_MIND_CONTROL"),
        },
        {
            text = ccb.content.text("Go back to your camp."),
            next_topic = "TALK_FRIEND",
            when = predicates.handler("dlg_p_dda_92e5a7678228"),
            actions = { "return_to_camp_duties" },
        },
        {
            text = ccb.content.text("I'm going to go my own way for a while."),
            next_topic = "TALK_LEAVE",
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ALLY_SOCIAL" },
    line = { when = predicates.conversation_state("radio"), yes = ccb.content.text(" *tshk* Are you serious?  This isn't a cell phone.  Can it wait until we're in the same place?"), no = ccb.content.text("Sure, what did you want to say?") },
    replies = {
        {
            text = ccb.content.text("Mind if we just chat for a bit about your history?"),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_88e0075084ad"),
            switch = true,
        },
        {
            text = ccb.content.text("Mind if we just chat for a bit about your history?"),
            next_topic = "TALK_FRIEND_CONVERSATION",
            when = predicates.handler("dlg_p_dda_9860d3f75191"),
            actions = { actions.replace_mutation("interlocutor", "BGSS_Confused_1") },
            switch = true,
        },
        {
            text = ccb.content.text("Mind if we just chat for a bit about your history?"),
            next_topic = "TALK_CONVERSATION_DANGER",
            when = predicates.handler("dlg_p_dda_b241b3fc7b62"),
            switch = true,
        },
        {
            text = ccb.content.text("Mind if we just chat for a bit about your history?"),
            next_topic = "TALK_CONVERSATION_RADIO",
            when = predicates.negate(predicates.conversation_state("radio")),
            switch = true,
        },
        {
            text = ccb.content.text("Let's just chitchat for a while, I could use some relaxation."),
            next_topic = "TALK_FRIEND_CHAT",
            when = predicates.negate(predicates.has_effect("interlocutor", "asked_to_socialize")),
        },
        {
            text = ccb.content.text("Can I do anything for you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("I changed my mind, wanted to ask you something else."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ALLY_ORDERS" },
    line = {
        choices = {
            ccb.content.text("I'm all ears, my friend."),
            ccb.content.text("You gonna give me orders?"),
            ccb.content.text("What would you like?"),
            ccb.content.text("Just say the word."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Can you teach me anything?"),
            when = predicates.negate(predicates.conversation_state("radio")),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_24352433e095") },
            success = { next_topic = "TALK_DENY_TRAIN" },
            failure = { next_topic = "TALK_TRAIN_PERSUADE" },
        },
        {
            text = ccb.content.text("Can you host a training seminar?"),
            when = predicates.all({ predicates.negate(predicates.conversation_state("radio")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_6df687e81cfd") },
            success = { next_topic = "TALK_DENY_TRAIN_SEMINAR" },
            failure = { next_topic = "TALK_TRAIN_SEMINAR_PERSUADE" },
        },
        {
            text = ccb.content.text("I have something to teach you."),
            next_topic = "TALK_TRAIN_NPC",
            when = predicates.handler("dlg_p_dda_6347d53c499b"),
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_FRIEND",
            when = predicates.all({ predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")), predicates.negate(predicates.conversation_state("radio")) }),
            actions = { "start_trade" },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("Let's trade items"),
            next_topic = "TRADE_HALLU",
            when = predicates.has_trait("interlocutor", "HALLUCINATION"),
            switch = true,
            default = false,
        },
        {
            text = ccb.content.text("I want you to use this item."),
            next_topic = "TALK_FRIEND",
            when = predicates.negate(predicates.conversation_state("radio")),
            actions = { "npc_gets_item_to_use" },
        },
        {
            text = ccb.content.text("Hold on to this item."),
            next_topic = "TALK_FRIEND",
            when = predicates.negate(predicates.conversation_state("radio")),
            actions = { "npc_gets_item" },
        },
        {
            text = ccb.content.text("Guard this position."),
            next_topic = "TALK_FRIEND_GUARD",
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
            text = ccb.content.text("Set up pickup rules."),
            next_topic = "TALK_FRIEND",
            actions = { "set_npc_pickup" },
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
