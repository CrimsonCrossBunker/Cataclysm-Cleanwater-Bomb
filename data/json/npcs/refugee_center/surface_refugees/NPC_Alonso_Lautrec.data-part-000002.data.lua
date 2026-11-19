local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_1a",
    line = ccb.content.gendered_line("*leans casually against the brick wall of the shelter.  \"Hello again, gorgeous\"", { "speaker" }),
    replies = {
        { text = ccb.content.text("Hi, Alonso.  What's up?"), next_topic = "TALK_REFUGEE_Alonso_2" },
        { text = ccb.content.text("Hi Alonso.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Alonso_1_firstmeet",
    line = ccb.content.text("Nice to meet you too.  Very nice.  It gets so lonely here in the center."),
    replies = {
        { text = ccb.content.text("What's up?"), next_topic = "TALK_REFUGEE_Alonso_2" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
