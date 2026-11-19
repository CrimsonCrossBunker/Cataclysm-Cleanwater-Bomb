local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

-- Due to her heartvines, she notices vampirism before it has visible symptoms.
ccb.content.define_dialogue_topic {
    id = "TALK_HUNTER_BLOODTHORNE",
    line = {
        choices = {
            {
                when = predicates.has_effect("speaker", "vampire_virus"),
                yes = ccb.content.text("You seem unwell.  Are you looking for a cure to your condition?"),
                no = {
                    choices = {
                        {
                            when = predicates.has_item("speaker", "arvore_sample"),
                            yes = ccb.content.text("I see you brought some arvore samples.  Can I have them?  I'll tell Elsa and Blaine to reward you if you do."),
                            no = ccb.content.text("You do not need my help right now, so I'll return to my work."),
                        },
                    },
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("I am.  Free me from this curse."),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_OFFER_CURE",
            when = predicates.has_effect("speaker", "vampire_virus"),
        },
        {
            text = ccb.content.text("How can you help me?"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_INTRO",
            when = predicates.negate(predicates.has_effect("speaker", "vampire_virus")),
        },
        {
            text = ccb.content.text("Sure!  How many do you want?"),
            next_topic = "TALK_VAMPIRE_HUNTER_BLOODTHORNE_SELL_SAMPLES",
            when = predicates.has_item("speaker", "arvore_sample"),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
