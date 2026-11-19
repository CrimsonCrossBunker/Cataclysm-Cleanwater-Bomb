local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPERAGREE",
    line = ccb.content.text("Tread carefully.  I can't allow anyone else to go down such a path.  I can't fail again."),
    replies = {
        {
            text = ccb.content.text("I'm sorry.  I'll think about it some more."),
            next_topic = "TALK_BONE_SEER",
        },
        {
            text = ccb.content.text("Just saying he has a point, that's all."),
            next_topic = "TALK_BONE_SEER",
        },
    },
}
