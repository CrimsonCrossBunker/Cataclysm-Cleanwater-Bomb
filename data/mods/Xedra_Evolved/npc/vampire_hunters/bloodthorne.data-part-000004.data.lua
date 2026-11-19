local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_NEED_SAMPLES",
    line = {
        choices = {
            ccb.content.text("Their very essence, torn from their corpses and transferred into our bodies.  They can sense that, and it is why they try to kill all Bloodthorne druids on sight.  As long as you don't ingest their essence they won't hate you for killing their brethren, so you're perfect to gather these samples for our mutual gain."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I have some.  Do you want them?"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_SELL_SAMPLES",
            when = predicates.has_item("speaker", "arvore_sample"),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
