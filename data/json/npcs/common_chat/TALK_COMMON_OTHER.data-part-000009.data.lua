local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FRIEND_GUARD_CAMP",
    line = ccb.content.text("I'm on watch."),
    replies = {
        {
            text = ccb.content.text("Go back to your camp duties."),
            next_topic = "TALK_FRIEND",
            actions = { "return_to_camp_duties" },
        },
        {
            text = ccb.content.text("I need you to come with me."),
            next_topic = "TALK_FRIEND",
            actions = { "stop_guard" },
        },
        { text = ccb.content.text("Let's talk."), next_topic = "TALK_FRIEND" },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
