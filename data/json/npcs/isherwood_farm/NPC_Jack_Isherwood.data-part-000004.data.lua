local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_JACK_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        {
            text = ccb.content.text("I'm here to deliver some resources."),
            next_topic = "TALK_ISHERWOOD_JACK_RESOURCES",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_scavenge_for_Jack_Isherwood" } }) }),
        },
        {
            text = ccb.content.text("A farm must be a pretty safe place these days."),
            next_topic = "TALK_JACK_FARM",
        },
        {
            text = ccb.content.text("Tell me about your wife, is she around?"),
            next_topic = "TALK_JACK_WIFE",
        },
        {
            text = ccb.content.text("Your daughter lives down the road?"),
            next_topic = "TALK_JACK_DAUGHTER",
        },
        {
            text = ccb.content.text("Where is your brother's place?"),
            next_topic = "TALK_JACK_BROTHER",
        },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_ISHERWOOD_JACK",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
