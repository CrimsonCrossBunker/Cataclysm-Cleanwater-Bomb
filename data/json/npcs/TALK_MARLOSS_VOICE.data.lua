local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_MARLOSS_VOICE",
    line = {
        choices = {
            ccb.content.text("Yes, friend?"),
            ccb.content.text("Your travels be fruitful, friend."),
            ccb.content.text("May you find your peace, traveler."),
            ccb.content.text("We might have lost everything, but hope remains."),
            ccb.content.text("May the earth flourish beneath our paths."),
            ccb.content.text("Unity of spirit, of mind, and body…"),
            ccb.content.text("Look for the bonds which define you, and act in accord."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I don't know what kind of heresy you are spreading, but I'm putting an end to it!"),
            next_topic = "TALK_DONE",
            when = predicates.all({ predicates.has_trait("speaker", "SPIRITUAL"), predicates.negate(predicates.has_flag("speaker", "mycus")) }),
            actions = { "hostile" },
        },
        {
            text = ccb.content.text("This place is dangerous, what are you doing here?"),
            next_topic = "TALK_MARLOSS_VOICE_BANKET",
            when = predicates.negate(predicates.has_effect("speaker", "u_offered_marloss_meal")),
            actions = { actions.add_effect("speaker", "u_offered_marloss_meal", { turns = 25920 }) },
        },
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_MARLOSS_VOICE_A_PRIEST" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MARLOSS_VOICE_BANKET",
    line = ccb.content.text("Dangerous?  It may look different, but this land cares and provides for us.  We are celebrating with a feast, in fact.  Do you care to join us?"),
    replies = {
        { text = ccb.content.text("Well, sure."), next_topic = "TALK_MARLOSS_VOICE_OFFER_BERRY" },
        { text = ccb.content.text("I'd… rather not."), next_topic = "TALK_MARLOSS_VOICE" },
        { text = ccb.content.text("I'm sorry… I have places to be."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MARLOSS_VOICE_A_PRIEST",
    line = ccb.content.gendered_line("I'm a priest or guide of a sort.  I sing the hymns along my companions so that we may learn to live in unity, both with each other and with our ailing world.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Alright."), next_topic = "TALK_MARLOSS_VOICE" },
        {
            text = ccb.content.text("Can I join you?"),
            next_topic = "TALK_MARLOSS_VOICE_WITH_US",
            when = predicates.has_flag("speaker", "mycus"),
        },
        {
            text = ccb.content.text("Understood.  Can I join you?"),
            next_topic = "TALK_MARLOSS_VOICE_OFFER_BERRY",
            when = predicates.all({ predicates.negate(predicates.has_flag("speaker", "mycus")), predicates.negate(predicates.has_effect("speaker", "u_given_berry")) }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MARLOSS_VOICE_WITH_US",
    line = ccb.content.text("Oh, but you already have."),
    replies = { { text = ccb.content.text("Yes… yes I have."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MARLOSS_VOICE_OFFER_BERRY",
    line = ccb.content.text("Join us then, eat from this meal with us."),
    replies = {
        {
            text = ccb.content.text("[Take Marloss berry.] Thank you."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_ccc2d6c9a534"), actions.add_effect("speaker", "u_given_berry", { turns = 43200 }) },
        },
        {
            text = ccb.content.text("I have changed my mind, thank you."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I'm joining no stinking cult!  Take your berry and shove it!"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.has_flag("speaker", "mycus")),
            actions = { "hostile" },
        },
    },
}
