local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_WEARING",
    line = ccb.content.text("You ask me what I can see, but I don't tell you what you see.  Sometimes we have shields up, to protect ourselves."),
    replies = {
        {
            text = ccb.content.text("Yes.  I ask because I noticed there are dinosaurs around.  Do you know anything about that?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_DINO2",
        },
    },
}
