local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- This is a very difficult sell-job unless you've earned her trust with food
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_1_RECRUIT1",
    line = {
        when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        yes = ccb.content.text("That's quite the offer, but I don't think I'd survive the trip.  I don't think you realize how useless I am in this world."),
        no = ccb.content.text("I'm sorry, I'm too hungry to make a big decision like that."),
    },
    replies = {
        {
            text = ccb.content.text("I can keep you safe.  I'll take you there myself."),
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            trial = {
                kind = "persuade",
                difficulty = 100,
                modifiers = {
                    { score = "TRUST", scale = 4 },
                    { score = "VALUE", scale = 2 },
                    { score = "OWED", scale = 3 },
                    { score = "ANGER", scale = -2 },
                    { score = "FEAR", scale = -6 },
                    { score = "BRAVERY", scale = 1 },
                },
            },
            success = {
                next_topic = "TALK_REFUGEE_BEGGAR_1_RECRUIT2",
                actions = { actions.set_actor_value("speaker", "general_recruit_reena_recruited", "yes") },
            },
            failure = { next_topic = "TALK_REFUGEE_BEGGAR_1_RECRUIT_NO" },
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I might have some food for you.  Let me check."),
            next_topic = "TALK_REFUGEE_BEGGAR_1_GIVE_FOOD",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("I'm sorry, I can't help you."),
            next_topic = "TALK_DONE",
        },
    },
}
