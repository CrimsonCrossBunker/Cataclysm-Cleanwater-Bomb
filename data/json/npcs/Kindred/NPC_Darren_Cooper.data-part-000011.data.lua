local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_COOPER_ABOUT",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }),
        yes = ccb.content.text("I was born here in New England, lived here all my life.  Was an accountant before the Collapse, if you can believe that.  There wasn't really anything special about my life before I learned about the Song, so there isn't much to say."),
        no = ccb.content.text("Sorry, but I don't know you that well and I'd rather not go into that."),
    },
    replies = {
        {
            text = ccb.content.text("I understand."),
            next_topic = "TALK_KINDRED_COOPER",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } })),
        },
        {
            text = ccb.content.text("Do you have a favorite food?"),
            next_topic = "TALK_COOPER_FOOD",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }),
        },
        {
            text = ccb.content.text("I see.  Thanks for sharing."),
            next_topic = "TALK_KINDRED_COOPER",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cooper_cooper_friendly" } }),
        },
    },
}
