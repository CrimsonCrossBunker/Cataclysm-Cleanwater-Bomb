local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "vitrified_soil_talk_main",
    line = ccb.content.text("This little mound of soil is unlike the jagged dirt around it.  It is smooth, welcoming, and pleasant to the touch."),
    replies = {
        {
            text = ccb.content.text("Plant the withered apple in the soil."),
            next_topic = "vitrified_soil_add_apple",
            when = predicates.has_item("speaker", "glass_apple"),
            actions = { actions.handler("w16b_a_dda_310c8f069d11") },
        },
        {
            text = ccb.content.text("Leave."),
            next_topic = "TALK_DONE",
        },
    },
}
