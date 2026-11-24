local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_FRIEND_Liam", "TALK_FRIEND_Liam_Abilities", "TALK_Liam_Callsigns" },
    line = { when = predicates.conversation_state("radio"), yes = ccb.content.text(" *pshhhttt* This is big turtle, I read you loud and clear, red burrito."), no = { when = predicates.conversation_state("has_reason"), yes = { special = "consume_reason" }, no = ccb.content.text("So, here we are.  What's up?") } },
    replies = {
        {
            text = ccb.content.text("[rules] Let's talk about how we'll work together."),
            next_topic = "TALK_DONE",
            actions = { "npc_rules_menu" },
        },
        {
            text = ccb.content.text("I'd like to know a bit more about your abilities."),
            next_topic = "TALK_FRIEND_Liam_Abilities",
            actions = { "reveal_stats" },
        },
        {
            text = ccb.content.text("Please go to this location."),
            next_topic = "TALK_GOTO_LOCATION",
            actions = { "goto_location" },
        },
        {
            text = ccb.content.text("There's something I want you to do."),
            next_topic = "TALK_Liam_ORDERS",
        },
        {
            text = ccb.content.text("I'd like your opinion on a job we're doing."),
            next_topic = "TALK_Liam_Opinions",
        },
        {
            text = ccb.content.text("I just wanted to talk for a bit."),
            next_topic = "TALK_Liam_SOCIAL",
            when = predicates.handler("dlg_p_dda_5d493fb3087d"),
        },
        {
            text = ccb.content.text("Can you help me understand something?  (HELP/TUTORIAL)"),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("Big turtle?  Red burrito?  Seriously?"),
            next_topic = "TALK_Liam_Callsigns",
            when = predicates.conversation_state("radio"),
        },
        {
            text = ccb.content.text("[DEBUG MIND CONTROL] Now listen closely… (DEBUG FUNCTIONS)"),
            next_topic = "TALK_ALLY_DEBUG",
            when = predicates.has_trait("speaker", "DEBUG_MIND_CONTROL"),
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
    id = "TALK_FRIEND_GUARD_Liam",
    line = ccb.content.text("*shrugs.  \"Not my favorite job, but sure.  I'll keep an eye out.\""),
    replies = {
        {
            text = ccb.content.text("I need you to come with me."),
            next_topic = "TALK_FRIEND_Liam",
            native_actions = { "stop_guard" },
        },
        { text = ccb.content.text("Let's talk."), next_topic = "TALK_FRIEND_Liam" },
        { text = ccb.content.text("See you around."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_Liam_Abilities",
    line = ccb.content.text("As you know, I am experienced in practically every low-wage job on the Eastern seaboard, and I'm probably a regional leading expert on video games.  My dad made me learn archery and I kinda kept it up.  What else is there?"),
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_PERSUADE_Liam",
    line = ccb.content.text("I mean, I'm not sure what I can teach you about, but okay."),
    replies = {
        {
            text = ccb.content.text("Don't sell yourself short, Liam.  I just wanted to know about…"),
            next_topic = "TALK_TRAIN",
            actions = { actions.add_effect("interlocutor", "asked_to_train", { turns = 21600 }) },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_SEMINAR_PERSUADE_Liam",
    line = ccb.content.text("A… seminar?  About what, how not to burn yourself on the frier at Foodplace?"),
    replies = {
        {
            text = ccb.content.text("Y'know, you have more useful skills than you think."),
            trial = {
                kind = "persuade",
                difficulty = 0,
                modifiers = {
                    { score = "TRUST", scale = 6 },
                    { score = "VALUE", scale = 2 },
                    { score = "ANGER", scale = -6 },
                },
            },
            success = { next_topic = "TALK_TRAIN_SEMINAR" },
            failure = {
                next_topic = "TALK_DENY_PERSONAL",
                actions = { actions.add_effect("interlocutor", "asked_to_train", { turns = 21600 }) },
            },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Callsigns",
    line = ccb.content.text("Roger that red burrito, that's a ten-forward on the callsigns.  Glad you like 'em."),
    replies = {
        {
            text = ccb.content.text("You're weird, my friend.  Red burrito, out."),
            next_topic = "TALK_DONE",
        },
    },
}
