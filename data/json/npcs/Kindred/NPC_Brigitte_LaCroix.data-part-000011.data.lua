local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_SUGGEST_FOLLOW_SEER",
    line = {
        when = predicates.has_trait("speaker", "seer_mark"),
        yes = ccb.content.text("You bear my mark, meaning I believe you have potential to learn to truly listen to the Song.  Yes, I will lend my skills to you, for now."),
        no = ccb.content.text("Only those who bear my mark will prove themselves worthy of my skills."),
    },
    replies = {
        {
            text = ccb.content.text("I see.  Very well then."),
            next_topic = "TALK_NONE",
            when = predicates.negate(predicates.has_trait("speaker", "seer_mark")),
        },
        {
            text = ccb.content.text("I am glad to hear it.  Let's go then."),
            native_actions = { "follow" },
            when = predicates.has_trait("speaker", "seer_mark"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("That's good, but I need to go at it alone right now.  <end_talking_later>"),
            when = predicates.has_trait("speaker", "seer_mark"),
            next_topic = "TALK_NONE",
        },
    },
}
