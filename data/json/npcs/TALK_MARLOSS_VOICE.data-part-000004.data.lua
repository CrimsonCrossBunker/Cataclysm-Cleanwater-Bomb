local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

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
