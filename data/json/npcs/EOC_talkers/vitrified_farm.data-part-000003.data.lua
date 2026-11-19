local ccb = require("ccb")

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
