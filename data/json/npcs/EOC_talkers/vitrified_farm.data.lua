local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



ccb.content.define_dialogue_topic {
    id = "vitrified_soil_add_apple",
    line = ccb.content.text("The soil yields easily, as if welcoming your contribution.  The rotten shell of the apple crumbles away, and the seeds sparkle as the dirt covers them."),
    replies = {
        {
            text = ccb.content.text("You find something new in your inventory."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "vitrified_doll_talk_main",
    line = ccb.content.text("Sitting among the glass cushions of the couch is the only thing among all the glass which is soft; the limbless, faceless torso of a worn plush doll.  It is warm to the touch, but it doesn't feel right to pick it up while it's so damaged."),
    replies = {
        {
            text = ccb.content.text("Reassemble the doll."),
            next_topic = "vitrified_repair_doll",
            when = predicates.all({ predicates.has_item("speaker", "imperfect_doll_features"), predicates.has_item("speaker", "imperfect_doll_arms"), predicates.has_item("speaker", "imperfect_doll_legs") }),
            actions = { actions.handler("w16b_a_dda_436f6f0b54ed") },
        },
        {
            text = ccb.content.text("Leave."),
            next_topic = "TALK_DONE",
        },
    },
}
