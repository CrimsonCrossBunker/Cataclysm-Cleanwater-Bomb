local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = { "TALK_MUG_SCARECROW_MIEN_USED" },
    line = ccb.content.text("*blanches and takes a step back before turning and fleeing."),
    replies = {
        {
            text = ccb.content.text("Watch them go."),
            next_topic = "TALK_DONE",
            native_actions = { "flee" },
        },
    },
}
