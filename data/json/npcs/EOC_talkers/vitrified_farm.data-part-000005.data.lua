local ccb = require("ccb")

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
