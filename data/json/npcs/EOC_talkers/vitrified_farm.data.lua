local ccb = require("ccb")

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
