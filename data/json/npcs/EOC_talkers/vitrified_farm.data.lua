local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "vitrified_repair_doll",
    line = ccb.content.text("Repairing the doll is easier than you thought.  The mismatched parts fit together easily, and soon it is whole again."),
    replies = {
        {
            text = ccb.content.text("You pick up the soft little thing, and feel a strong urge to hug it."),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "vitrified_bookcase_add_book",
    line = ccb.content.text("The book slots in among the rest, and you can no longer see the difference.  Maybe there isn't any."),
    replies = {
        {
            text = ccb.content.text("You find something new in your inventory."),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "vitrified_pool_add_boat",
    line = ccb.content.text("The boat would sink immediately in water.  On the denser sand, it finds a balance, and the breeze stirs it to life."),
    replies = {
        {
            text = ccb.content.text("You find something new in your inventory."),
            next_topic = "TALK_DONE",
        },
    },
}

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
