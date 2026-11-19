local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_MUNDANE",
    line = {
        choices = {
            {
                when = predicates.has_trait("speaker", "VAMPIRE"),
                yes = ccb.content.text("Go see Blaine or Phyliss about your infection, or else Leonard won't calm down about it."),
                no = {
                    choices = {
                        ccb.content.text("Welcome."),
                        ccb.content.text("Hello."),
                        ccb.content.text("Hi."),
                    },
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Do you have something to trade?"),
            next_topic = "TALK_HUNTER_MUNDANE_TRADE",
        },
        {
            text = ccb.content.text("Could you teach me something?"),
            next_topic = "TALK_HUNTER_MUNDANE_TRAIN",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
