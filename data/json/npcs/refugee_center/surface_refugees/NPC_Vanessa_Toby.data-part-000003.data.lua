local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Vanessa_Haircut_no",
    line = ccb.content.text("I can see you need one, but last time I used these shears it was to stab a zombie in the face.  I don't think you'd want them in your hair.  Maybe you could help me get set up properly?"),
    replies = {
        {
            text = ccb.content.text("What can I do to help you out?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
