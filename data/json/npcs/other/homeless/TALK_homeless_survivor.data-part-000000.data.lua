local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_NPC_HOMELESS_SURVIVOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_homeless" } }),
        yes = ccb.content.text("Hello there.  Nice to see you again."),
        no = ccb.content.text("Who are you?"),
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
            next_topic = "TALK_NPC_HOMELESS_SURVIVOR_INTRO",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } })),
        },
        {
            text = ccb.content.text("Pleasure to see you again."),
            next_topic = "TALK_NPC_HOMELESS_SURVIVOR_INTRO",
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "dialogue_first_meeting_talked_to_homeless" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
