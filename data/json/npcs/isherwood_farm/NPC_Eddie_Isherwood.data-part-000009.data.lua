local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_EDDIE_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        {
            text = ccb.content.text("Your son helps with the dairy?"),
            next_topic = "TALK_EDDIE_LUKE",
        },
        {
            text = ccb.content.text("So, Jesse runs the horse farm?"),
            next_topic = "TALK_EDDIE_JESSE",
        },
        { text = ccb.content.text("Where can I find Carlos?"), next_topic = "TALK_EDDIE_CARLOS" },
        {
            text = ccb.content.text("Let's trade items."),
            next_topic = "TALK_ISHERWOOD_EDDIE",
            native_actions = { "start_trade" },
        },
        { text = ccb.content.text("Can I do anything for you?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
