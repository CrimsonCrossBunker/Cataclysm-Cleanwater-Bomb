local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Jeremiah_Parents",
    line = ccb.content.text("&Jeremiah leans his head towards your ear, speaking in a low whisper.  \"To be honest with you, I don't like my mom at all.  She's like a <freaking> helicopter, always telling me what to do, where to go, who I can be with.  She never thinks of me as an individual, only some idea of who she thinks I am.  My dad's alright, he's the chef around here.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Jeremiah_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
