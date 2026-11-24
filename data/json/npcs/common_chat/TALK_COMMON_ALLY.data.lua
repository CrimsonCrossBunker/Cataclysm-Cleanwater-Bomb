local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_WAKE_UP",
    line = {
        when = predicates.has_effect("interlocutor", "sleep"),
        yes = {
            when = predicates.handler("dlg_p_dda_d03e6b7290e6"),
            yes = ccb.content.text("No, just no…"),
            no = {
                when = predicates.handler("dlg_p_dda_db3bbd60cd2c"),
                yes = ccb.content.text("Just let me sleep, <name_b>!"),
                no = {
                    when = predicates.handler("dlg_p_dda_ea60ec832f23"),
                    yes = ccb.content.text("Make it quick, I want to go back to sleep."),
                    no = ccb.content.text("Just few minutes more…"),
                },
            },
        },
        no = ccb.content.text("Anything to do before I go to sleep?"),
    },
    replies = {
        {
            text = ccb.content.text("Wake up!"),
            next_topic = "TALK_NONE",
            actions = { "wake_up" },
        },
        {
            text = ccb.content.text("Go back to sleep."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REBOOT",
    line = ccb.content.text("This character was previously put into a suspension state due to an AI bug.  If you have reason to believe the problem was fixed, you can wake them up.  Do you want to do that now?"),
    replies = {
        {
            text = ccb.content.text("Yes, wake up!"),
            next_topic = "TALK_NONE",
            native_actions = { "wake_up" },
        },
        { text = ccb.content.text("No, go back to sleep."), next_topic = "TALK_DONE" },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_PERSUADE",
    line = ccb.content.text("Why should I teach you?"),
    replies = {
        {
            text = ccb.content.text("Come on, we're friends."),
            trial = {
                kind = "persuade",
                difficulty = 0,
                modifiers = {
                    { score = "TRUST", scale = 6 },
                    { score = "VALUE", scale = 2 },
                    { score = "ANGER", scale = -6 },
                },
            },
            success = { next_topic = "TALK_TRAIN" },
            failure = {
                next_topic = "TALK_DENY_PERSONAL",
                actions = { actions.add_effect("interlocutor", "asked_to_train", { turns = 21600 }) },
            },
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("<end_talking_nevermind>  <lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TRAIN_SEMINAR_PERSUADE",
    line = ccb.content.text("Why should I host a training seminar?"),
    replies = {
        {
            text = ccb.content.text("Come on, we're friends."),
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
        { text = ccb.content.text("<end_talking_nevermind>  <lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE",
    line = ccb.content.text("You're really leaving?"),
    replies = {
        {
            text = ccb.content.text("Yeah, I'm sure.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            native_actions = { "leave" },
            opinion = { trust = -2, anger = 1 },
        },
        { text = ccb.content.text("Nah, I'm just kidding."), next_topic = "TALK_NONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_RADIO",
    replies = {
        {
            text = ccb.content.text("Please go to this location."),
            next_topic = "TALK_GOTO_LOCATION_RADIO",
            actions = { "goto_location" },
        },
        {
            text = ccb.content.text("Stay at your current position."),
            next_topic = "TALK_DONE",
            actions = { "assign_guard" },
        },
        {
            text = ccb.content.text("Show me what needs to be done at the camp."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c5904e1a60f2"),
            actions = { "basecamp_mission" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ACTIVITIES",
    line = { when = predicates.actor_state("interlocutor", "has_activity"), yes = ccb.content.text("I'm currently <current_activity>."), no = ccb.content.text("I'm not doing much currently.") },
    replies = {
        {
            text = ccb.content.text("I meant what are your goals?"),
            next_topic = "TALK_DESCRIBE_MISSION",
        },
        {
            text = ccb.content.text("Carry on."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Please stop your current activity."),
            next_topic = "TALK_DONE",
            when = predicates.actor_state("interlocutor", "has_activity"),
            actions = { "revert_activity" },
        },
        {
            text = ccb.content.text("Please sort out some of these items nearby."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "sort_loot" },
        },
        {
            text = ccb.content.text("Please do any construction work that you can."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_construction" },
        },
        {
            text = ccb.content.text("Please do any mining work that you can."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_mining" },
        },
        {
            text = ccb.content.text("Please go mop the area."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_mopping" },
        },
        {
            text = ccb.content.text("Please study from a book."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_read" },
        },
        {
            text = ccb.content.text("Please study from an e-book."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_eread" },
        },
        {
            text = ccb.content.text("Please study from books you have in order."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_read_repeatedly" },
        },
        {
            text = ccb.content.text("Please study from books in study zones."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_study" },
        },
        {
            text = ccb.content.text("Please start deconstructing any vehicles in a deconstruction zone."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_vehicle_deconstruct" },
        },
        {
            text = ccb.content.text("Please start repairing any vehicles in a repair zone."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_vehicle_repair" },
        },
        {
            text = ccb.content.text("Please chop logs into planks."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_chop_plank" },
        },
        {
            text = ccb.content.text("Please butcher any corpses that you can."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_butcher" },
        },
        {
            text = ccb.content.text("Please chop any trees in the designated areas."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_chop_trees" },
        },
        {
            text = ccb.content.text("Please go catch some fish."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_fishing" },
        },
        {
            text = ccb.content.text("Please do some farming work."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_farming" },
        },
        {
            text = ccb.content.text("Please disassemble anything in the designated areas."),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_disassembly" },
        },
        {
            text = ccb.content.text("Can you craft this item?"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "has_activity")), predicates.negate(predicates.has_trait("interlocutor", "HALLUCINATION")) }),
            actions = { "do_craft" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GOTO_LOCATION_RADIO",
    line = ccb.content.text("*pssshht* ten-four, I'll make my way there, over."),
    replies = { { text = ccb.content.text("Affirmative."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GOTO_LOCATION",
    line = { when = predicates.handler("dlg_p_dda_2379dbeda833"), yes = ccb.content.text("Sure thing, I'll make my way there."), no = ccb.content.text("All right, tell me if you want me to go somewhere.") },
    replies = {
        {
            text = ccb.content.text("Affirmative."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TRADE_HALLU",
    line = ccb.content.text_without_extraction("<hallu_dont_trade>"),
    replies = { { text = ccb.content.text("Fair enough."), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP",
    line = ccb.content.text("What about the camp?"),
    replies = {
        {
            text = ccb.content.text("I want to assign you to work at this camp."),
            next_topic = "TALK_FRIEND_GUARD",
            when = predicates.handler("dlg_p_dda_c5904e1a60f2"),
            actions = { "assign_camp" },
        },
        {
            text = ccb.content.text("I want you to build a camp here."),
            next_topic = "TALK_HALLU_CAMP",
            when = predicates.has_trait("interlocutor", "HALLUCINATION"),
            switch = true,
        },
        {
            text = ccb.content.text("I want you to build a camp here."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_0a469b3f65f6"),
            actions = { "start_camp" },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("Since we can't build a camp here, I want you to tell me where can we build a camp?"),
            next_topic = "TALK_CAMP_SITES",
            when = predicates.handler("dlg_p_dda_717555b46202"),
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("We need to abandon this camp."),
            next_topic = "TALK_ABANDON",
            when = predicates.handler("dlg_p_dda_c5904e1a60f2"),
        },
        {
            text = ccb.content.text("Show me what needs to be done at the camp."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c5904e1a60f2"),
            actions = { "basecamp_mission" },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ABANDON",
    line = ccb.content.gendered_line("Are you sure?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Yes, I'm sure."),
            next_topic = "TALK_DONE",
            actions = { "abandon_camp" },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ALLY_DEBUG" },
    line = { when = predicates.conversation_state("radio"), yes = ccb.content.text(" *tshk* Not sure it works when I am that far."), no = ccb.content.text("Yes?") },
    replies = {
        {
            text = ccb.content.text("Trust me (+10 trust)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { trust = 10 } },
        },
        {
            text = ccb.content.text("Do not trust me (-10 trust)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { trust = -10 } },
        },
        {
            text = ccb.content.text("Fear me (+10 fear)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { fear = 10 } },
        },
        {
            text = ccb.content.text("Do not fear me (-10 fear)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { fear = -10 } },
        },
        {
            text = ccb.content.text("Fear me (+10 fear)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { fear = 10 } },
        },
        {
            text = ccb.content.text("Do not fear me (-10 fear)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { fear = -10 } },
        },
        {
            text = ccb.content.text("Value me (+10 value)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { value = 10 } },
        },
        {
            text = ccb.content.text("Do not value me (-10 value)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { value = -10 } },
        },
        {
            text = ccb.content.text("Be angry (+10 anger)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { anger = 10 } },
        },
        {
            text = ccb.content.text("Do not be angry (-10 anger)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { anger = -10 } },
        },
        {
            text = ccb.content.text("Owe me (+10 owed)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { owed = 10 } },
        },
        {
            text = ccb.content.text("Do not owe me (-10 owed)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = { owed = -10 } },
        },
        {
            text = ccb.content.text("Favor me (+10 favors)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = {  } },
        },
        {
            text = ccb.content.text("Do not favor me (-10 favors)."),
            trial = { kind = "none" },
            success = { next_topic = "TALK_ALLY_DEBUG", opinion = {  } },
        },
        {
            text = ccb.content.text("Train me."),
            next_topic = "TALK_TRAIN",
        },
        {
            text = ccb.content.text("Do a seminar."),
            next_topic = "TALK_TRAIN_SEMINAR",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}
