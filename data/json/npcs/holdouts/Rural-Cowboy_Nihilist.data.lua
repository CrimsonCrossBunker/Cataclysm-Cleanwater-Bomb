local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_COWBOYN_FOLLOW",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmots" } }),
        yes = ccb.content.text("I dunno.  Maybe.  Might give me something to do while I think about all this."),
        no = ccb.content.gendered_line("I told you to just leave me alone.", { "interlocutor" }),
    },
    replies = {
        {
            text = ccb.content.text("It will.  <lets_go>"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmots" } }),
            native_actions = { "follow" },
        },
        {
            text = ccb.content.text("On a second thought, wait here a while."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmots" } }),
        },
        {
            text = ccb.content.text("Alright.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_cowboyn_cowboynmots" } })),
        },
    },
}
