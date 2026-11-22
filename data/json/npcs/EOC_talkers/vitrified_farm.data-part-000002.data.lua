local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "vitrified_bookcase_talk_main",
    line = ccb.content.text("Among the solid wall of glass book spines, there is a single empty space."),
    replies = {
        {
            text = ccb.content.text("Place the glass storybook among the others."),
            next_topic = "vitrified_bookcase_add_book",
            when = predicates.has_item("speaker", "glass_book"),
            actions = { actions.handler("w16b_a_dda_bbba2c52d514") },
        },
        {
            text = ccb.content.text("Leave."),
            next_topic = "TALK_DONE",
        },
    },
}
