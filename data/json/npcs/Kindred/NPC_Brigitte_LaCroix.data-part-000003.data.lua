local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_SONG",
    line = ccb.content.text("Listen carefully.  The bones… they hum.  Can you hear it?  The song they weave?  The stories they hold?"),
    replies = {
        {
            text = ccb.content.text("Bones?  What are you talking about?"),
            next_topic = "TALK_BONE_SEER_SONG2",
        },
        {
            text = ccb.content.text("Uh… yeah, sure.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
