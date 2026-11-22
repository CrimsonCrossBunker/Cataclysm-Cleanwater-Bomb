local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "vitrified_pool_talk_main",
    line = ccb.content.text("A soft breeze rolls across this pool of sand, rippling it in gentle waves."),
    replies = {
        {
            text = ccb.content.text("Place the glass sailboat in the pool."),
            next_topic = "vitrified_pool_add_boat",
            when = predicates.has_item("speaker", "glass_boat"),
            actions = { actions.handler("w16b_a_dda_8aa0c6c12124") },
        },
        {
            text = ccb.content.text("Leave."),
            next_topic = "TALK_DONE",
        },
    },
}
