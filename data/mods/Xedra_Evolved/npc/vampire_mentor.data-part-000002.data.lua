local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = { "TALK_VAMPIRE_MENTOR_MENTORING" },
    line = {
        when = predicates.has_effect("speaker", "vampire_virus"),
        yes = ccb.content.text("I can help you become a stronger vampire, if it is what you wish."),
        no = ccb.content.text("I can share with you the gift of vampirism, if it is what you wish."),
    },
    replies = {
        {
            text = ccb.content.text("I want to become a stronger vampire."),
            when = predicates.all({ predicates.has_effect("speaker", "vampire_virus"), predicates.negate(predicates.has_trait("speaker", "VAMPIRE4")) }),
            next_topic = "TALK_VAMPIRE_MENTOR_BECOME_STRONGER",
        },
        {
            text = ccb.content.text("I want to become a stronger vampire."),
            when = predicates.all({ predicates.has_trait("speaker", "VAMPIRE4"), predicates.negate(predicates.has_mission("GET_COMPONENTS_FOR_TIER_5")), predicates.negate(predicates.has_trait("speaker", "BLOOD_DRINKER")) }),
            next_topic = "TALK_VAMPIRE_MENTOR_BECOME_MORE_STRONGER",
        },
        {
            text = ccb.content.text("I want to become a vampire."),
            when = predicates.negate(predicates.has_effect("speaker", "vampire_virus")),
            next_topic = "TALK_VAMPIRE_MENTOR_BECOME_VAMPIRE",
        },
        {
            text = ccb.content.text("You already made me as strong as a vampire can be.  See you."),
            when = predicates.has_trait("speaker", "BLOOD_DRINKER"),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("Maybe later.  Bye."), next_topic = "TALK_DONE" },
    },
}
