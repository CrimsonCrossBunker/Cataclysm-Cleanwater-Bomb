local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_SIMPLE_STATS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is a strength test response."),
            next_topic = "TALK_DONE",
            when = predicates.minimum_attribute("speaker", "strength", 7),
        },
        {
            text = ccb.content.text("This is a dexterity test response."),
            next_topic = "TALK_DONE",
            when = predicates.minimum_attribute("speaker", "dexterity", 7),
        },
        {
            text = ccb.content.text("This is an intelligence test response."),
            next_topic = "TALK_DONE",
            when = predicates.minimum_attribute("speaker", "intelligence", 7),
        },
        {
            text = ccb.content.text("This is a perception test response."),
            next_topic = "TALK_DONE",
            when = predicates.minimum_attribute("speaker", "perception", 7),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_NEGATED_STATS",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is a low strength test response."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.minimum_attribute("speaker", "strength", 7)),
        },
        {
            text = ccb.content.text("This is a low dexterity test response."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.minimum_attribute("speaker", "dexterity", 7)),
        },
        {
            text = ccb.content.text("This is a low intelligence test response."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.minimum_attribute("speaker", "intelligence", 7)),
        },
        {
            text = ccb.content.text("This is a low perception test response."),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.minimum_attribute("speaker", "perception", 7)),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_WEARING_AND_TRAIT",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is a trait test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_any_trait("speaker", { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS" }),
        },
        {
            text = ccb.content.text("This is a short trait test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("speaker", "ELFA_EARS"),
        },
        {
            text = ccb.content.text("This is a wearing test response."),
            next_topic = "TALK_DONE",
            when = predicates.wears("speaker", "badge_marshal"),
        },
        {
            text = ccb.content.text("This is an NPC trait test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_any_trait("interlocutor", { "CANINE_EARS", "LUPINE_EARS", "FELINE_EARS", "URSINE_EARS", "ELFA_EARS" }),
        },
        {
            text = ccb.content.text("This is an NPC short trait test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_trait("interlocutor", "ELFA_EARS"),
        },
        {
            text = ccb.content.text("This is a trait flags test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_flag("speaker", "PSYCHOPATH"),
        },
        {
            text = ccb.content.text("This is an NPC trait flags test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_flag("interlocutor", "SAPIOVORE"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_TEST_EFFECT",
    line = ccb.content.text("This is a test conversation that shouldn't appear in the game."),
    replies = {
        { text = ccb.content.text("This is a basic test response."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("This is an NPC effect test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_effect("interlocutor", "gave_quest_item"),
        },
        {
            text = ccb.content.text("This is a player effect test response."),
            next_topic = "TALK_DONE",
            when = predicates.has_effect("speaker", "gave_quest_item"),
        },
    },
}
