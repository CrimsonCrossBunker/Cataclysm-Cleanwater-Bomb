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
