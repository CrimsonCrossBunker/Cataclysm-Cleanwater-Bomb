local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- ["The responses here are currently merged with the built in responses as not all", "responses for the topics here have been moved to json.", "Some of the topics here can be moved to NPC type specific files later."]
-- Generic responses for NPCs that can have missions
ccb.content.define_dialogue_topic {
    id = {
        "TALK_SHELTER", "TALK_EVAC_MERCHANT", "TALK_FREE_MERCHANTS_MERCHANT", "TALK_ARSONIST",
        "TALK_OLD_GUARD_REP", "TALK_EVAC_GUARD2", "TALK_RANCH_FOREMAN", "TALK_RANCH_CROP_OVERSEER",
        "TALK_CITY_COP",
    },
    replies = {
        {
            text = ccb.content.text("About that job…"),
            next_topic = "TALK_MISSION_INQUIRE",
            when = predicates.assigned_missions(1, 1),
        },
        {
            text = ccb.content.text("About one of those jobs…"),
            next_topic = "TALK_MISSION_LIST_ASSIGNED",
            when = predicates.assigned_missions(2),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_MISSION_DESCRIBE_URGENT", "TALK_MISSION_DESCRIBE" },
    replies = {
        { text = ccb.content.text("What's the matter?"), next_topic = "TALK_MISSION_OFFER" },
        { text = ccb.content.text("I don't care."), next_topic = "TALK_MISSION_REJECTED" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_LIST",
    line = {
        when = predicates.available_missions("interlocutor", 0, 0),
        yes = {
            when = predicates.assigned_missions(0, 0),
            yes = ccb.content.text("I don't have any jobs for you."),
            no = {
                when = predicates.assigned_missions(2),
                yes = ccb.content.text("I don't have any more jobs for you."),
                no = ccb.content.text("I don't have any more jobs for you."),
            },
        },
        no = {
            when = predicates.available_missions("interlocutor", 2),
            yes = {
                when = predicates.assigned_missions(0, 0),
                yes = ccb.content.text("I have other jobs for you.  Want to hear about them?"),
                no = {
                    when = predicates.assigned_missions(2),
                    yes = ccb.content.text("I have more jobs for you.  Want to hear about them?"),
                    no = ccb.content.text("I have other jobs for you.  Want to hear about them?"),
                },
            },
            no = {
                when = predicates.assigned_missions(0, 0),
                yes = ccb.content.text("I have a job for you.  Want to hear about it?"),
                no = {
                    when = predicates.assigned_missions(2),
                    yes = ccb.content.text("I just have one job for you.  Want to hear about it?"),
                    no = ccb.content.text("I just have one job for you.  Want to hear about it?"),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Oh, okay."),
            next_topic = "TALK_NONE",
            when = predicates.available_missions("interlocutor", 0, 0),
        },
        {
            text = ccb.content.text("Never mind, I'm not interested."),
            next_topic = "TALK_NONE",
            when = predicates.negate(predicates.available_missions("interlocutor", 0, 0)),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_LIST_ASSIGNED",
    line = {
        when = predicates.assigned_missions(0, 0),
        yes = ccb.content.text("You're not working on anything for me now."),
        no = {
            when = predicates.assigned_missions(2),
            yes = ccb.content.text("Which job?"),
            no = ccb.content.text("What about it?"),
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_OFFER",
    replies = {
        {
            text = ccb.content.text("I'll do it!"),
            next_topic = "TALK_MISSION_ACCEPTED",
            native_actions = { "assign_mission" },
        },
        { text = ccb.content.text("Not interested."), next_topic = "TALK_MISSION_REJECTED" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_ACCEPTED",
    replies = {
        { text = ccb.content.text("Not a problem."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Got any advice?"), next_topic = "TALK_MISSION_ADVICE" },
        {
            text = ccb.content.text("Can you share some equipment?"),
            next_topic = "TALK_SHARE_EQUIPMENT",
        },
        { text = ccb.content.text("I'll be back soon!"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_ADVICE",
    replies = {
        { text = ccb.content.text("Sounds good, thanks."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Sounds good.  Bye!"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_REJECTED",
    replies = {
        { text = ccb.content.text("I'm sorry."), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Whatever.  <end_talking_bye>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_INQUIRE",
    replies = {
        {
            text = ccb.content.text("I'm sorry… I failed."),
            next_topic = "TALK_MISSION_FAILURE",
            when = predicates.actor_state("interlocutor", "mission_failed"),
            opinion = { trust = -1, value = -1, anger = 1 },
        },
        {
            text = ccb.content.text("Not yet."),
            when = predicates.actor_state("interlocutor", "mission_failed"),
            trial = { kind = "lie", difficulty = 10, modifiers = { { score = "TRUST", scale = 3 } } },
            success = { next_topic = "TALK_NONE" },
            failure = { next_topic = "TALK_MISSION_FAILURE", opinion = { trust = -3, value = -1, anger = 2 } },
        },
        {
            text = ccb.content.text("Not yet."),
            next_topic = "TALK_NONE",
            when = predicates.actor_state("interlocutor", "mission_incomplete"),
        },
        {
            text = ccb.content.text("I killed him."),
            false_text = ccb.content.text("I killed it."),
            text_when = predicates.handler("dlg_p_dda_1236053a2f9b"),
            when = predicates.handler("dlg_p_dda_b5438c3b18da"),
            trial = { kind = "lie", difficulty = 10, modifiers = { { score = "TRUST", scale = 5 } } },
            success = { next_topic = "TALK_MISSION_SUCCESS", actions = { "mission_success" } },
            failure = { next_topic = "TALK_MISSION_SUCCESS_LIE", opinion = { trust = -5, value = -1, anger = 5 } },
        },
        {
            text = ccb.content.text("No.  I'll get back to it, bye!"),
            next_topic = "TALK_DONE",
            when = predicates.actor_state("interlocutor", "mission_incomplete"),
        },
        {
            text = ccb.content.text("Yup!  Here it is!"),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.handler("dlg_p_dda_9df400458154"),
            actions = { "mission_success" },
            switch = true,
        },
        {
            text = ccb.content.text("We're here!"),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.handler("dlg_p_dda_6b028eae1cf6"),
            actions = { "mission_success" },
            switch = true,
        },
        {
            text = ccb.content.text("Here I am."),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.handler("dlg_p_dda_735c3ce07a5e"),
            actions = { "mission_success" },
            switch = true,
        },
        {
            text = ccb.content.text("I talked to them."),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.handler("dlg_p_dda_aaeabe75dc28"),
            actions = { "mission_success" },
            switch = true,
        },
        {
            text = ccb.content.text("Here it is!"),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.handler("dlg_p_dda_da2dac1c4495"),
            actions = { "mission_success" },
            switch = true,
        },
        {
            text = ccb.content.text("Justice has been served."),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.handler("dlg_p_dda_d7d86c55d371"),
            actions = { "mission_success" },
            switch = true,
        },
        {
            text = ccb.content.text("I killed it."),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.handler("dlg_p_dda_61b3cdccfe99"),
            actions = { "mission_success" },
            switch = true,
        },
        {
            text = ccb.content.text("I killed them.  All of them."),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.handler("dlg_p_dda_1d08495c348b"),
            actions = { "mission_success" },
            switch = true,
        },
        {
            text = ccb.content.text("I brought 'em."),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.handler("dlg_p_dda_5c7f7def7d93"),
            actions = { "mission_success" },
            switch = true,
        },
        {
            text = ccb.content.text("I've taken care of it."),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.handler("dlg_p_dda_e1ce49b951c6"),
            actions = { "mission_success" },
            switch = true,
        },
        {
            text = ccb.content.text("I found it, but I'm keeping it, and I'll find you another one.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
            when = predicates.handler("dlg_p_dda_198cb07b916b"),
            actions = { actions.add_effect("interlocutor", "npc_player_still_looking", { turns = 43200 }) },
        },
        {
            text = ccb.content.text("I found it, but I'm keeping it, and I'll find you another one.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_198cb07b916b"),
            actions = { actions.add_effect("interlocutor", "npc_player_still_looking", { turns = 43200 }) },
        },
        {
            text = ccb.content.text("Mission success!  I don't know what else to say."),
            next_topic = "TALK_MISSION_SUCCESS",
            when = predicates.actor_state("interlocutor", "mission_complete"),
            actions = { "mission_success" },
            switch = true,
            default = true,
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_SUCCESS",
    replies = {
        {
            text = ccb.content.text("Glad to help.  I need no payment."),
            next_topic = "TALK_NONE",
            when = predicates.conversation_state("mission_offers_generic_rewards"),
            native_actions = { "clear_mission" },
            mission_opinion = { trust = 4, value = 3 },
            opinion = { fear = -1, anger = -1 },
        },
        {
            text = ccb.content.text("How about some items as payment?"),
            next_topic = "TALK_MISSION_REWARD",
            when = predicates.all({ predicates.conversation_state("mission_offers_generic_rewards"), predicates.negate(predicates.actor_state("interlocutor", "friendly")) }),
            native_actions = { "mission_reward" },
        },
        {
            text = ccb.content.text("Maybe you can teach me something as payment?"),
            next_topic = "TALK_TRAIN",
            when = predicates.all({ predicates.conversation_state("mission_offers_generic_rewards"), predicates.any({ predicates.actor_state("interlocutor", "offers_skill_training"), predicates.actor_state("interlocutor", "offers_style_training") }) }),
        },
        {
            text = ccb.content.text("Glad to help.  I need no payment.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            when = predicates.conversation_state("mission_offers_generic_rewards"),
            native_actions = { "clear_mission" },
            mission_opinion = { trust = 4, value = 3 },
            opinion = { fear = -1, anger = -1 },
        },
        {
            text = ccb.content.text("Glad to help."),
            next_topic = "TALK_NONE",
            when = predicates.negate(predicates.conversation_state("mission_offers_generic_rewards")),
            native_actions = { "clear_mission" },
            mission_opinion = { trust = 4, value = 3 },
            opinion = { fear = -1, anger = -1 },
        },
        {
            text = ccb.content.text("Glad to help.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.conversation_state("mission_offers_generic_rewards")),
            native_actions = { "clear_mission" },
            mission_opinion = { trust = 4, value = 3 },
            opinion = { fear = -1, anger = -1 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_SUCCESS_LIE",
    replies = {
        {
            text = ccb.content.text("Well, um, sorry."),
            next_topic = "TALK_NONE",
            native_actions = { "clear_mission" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_FAILURE",
    replies = {
        {
            text = ccb.content.text("I'm sorry.  I did what I could."),
            next_topic = "TALK_NONE",
            native_actions = { "clear_mission" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_REWARD",
    line = ccb.content.text("Sure, here you go!"),
    replies = {
        {
            text = ccb.content.text("Thank you."),
            next_topic = "TALK_NONE",
            native_actions = { "clear_mission" },
        },
        {
            text = ccb.content.text("Thanks, bye."),
            next_topic = "TALK_DONE",
            native_actions = { "clear_mission" },
        },
    },
}
