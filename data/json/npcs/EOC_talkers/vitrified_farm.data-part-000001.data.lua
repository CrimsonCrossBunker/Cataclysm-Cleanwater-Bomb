local ccb = require("ccb")

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
