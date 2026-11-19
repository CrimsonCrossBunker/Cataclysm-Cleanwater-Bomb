local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_HOSPITAL_2_STORY3",
    line = ccb.content.gendered_line("Somehow, I don't know how, I managed to fall asleep in there.  I think it might have started with me hyperventilating and passing out.  When I woke up it was night, I was starving and parched, and… and the screaming had died down.  At first I tried to go out the way I came in, but I peaked out the window and saw one of the nurses stumbling around, spitting that black shit up.  Her name was Becky.  She wasn't Becky anymore.  So, I went back up and somehow made it into the storage area.  From there, the roof.  I drank water from some nasty old puddle and I camped out there for a while, watching the city around me burn.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What finally brought you down?"),
            next_topic = "BGSS_HOSPITAL_2_STORY4",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
