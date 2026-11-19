local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_BROKER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } }),
        yes = ccb.content.text("Hello there.  Nice to see you again."),
        no = ccb.content.text("Who are you?  Would you like to trade?"),
    },
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "dialogue_first_meeting_talked_to_homeless", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you."),
            next_topic = "TALK_NPC_HOMELESS_BROKER_INTRO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } })),
        },
        {
            text = ccb.content.text("Hands up!"),
            trial = { kind = "intimidate", difficulty = 30 },
            success = {
                next_topic = "TALK_WEAPON_DROPPED",
                actions = { "drop_weapon" },
                opinion = { trust = 4, fear = -3 },
            },
            failure = { next_topic = "TALK_DONE", actions = { "hostile" } },
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } })),
        },
        {
            text = ccb.content.text("Pleasure to see you again."),
            next_topic = "TALK_NPC_HOMELESS_BROKER_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
