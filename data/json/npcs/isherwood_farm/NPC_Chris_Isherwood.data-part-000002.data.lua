local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_TALK1",
    line = ccb.content.text("Yeah, they are always worried about us, I prefer to survey the land and try to track the changes.  I'm thinking about fixing up this cabin for some peace and quiet…"),
    replies = {
        {
            text = ccb.content.text("Sounds like you are restless, why not leave?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_WANTS",
        },
        {
            text = ccb.content.text("What sort of changes have you seen?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_LAND",
        },
        {
            text = ccb.content.text("I was talking to Luke earlier, said you had some interesting ideas about the world ending."),
            next_topic = "TALK_CHRIS_THEORIES",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_heard_about_chris" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_TALK2",
    line = ccb.content.text("I surveyed the land, and I am trying to track the changes.  I fixed up this cabin for some peace and quiet… you can settle here if you want"),
    replies = {
        {
            text = ccb.content.text("Sounds like you are restless, why not leave?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_WANTS",
        },
        {
            text = ccb.content.text("What sort of changes have you seen?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_LAND",
        },
        {
            text = ccb.content.text("Do you think, monsters that kidnaped Barry are responsible for end of the world?"),
            next_topic = "TALK_CHRIS_THEORIES2",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_heard_about_chris" } }) }),
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        { text = ccb.content.text("I'd better get going."), next_topic = "TALK_DONE" },
    },
}
