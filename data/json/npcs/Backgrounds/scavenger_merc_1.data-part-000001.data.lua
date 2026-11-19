local ccb = require("ccb")

-- UPCOMING: this merc will offer a mission for you to explore the warehouse in question.
ccb.content.define_dialogue_topic {
    id = "BGSS_SCAVENGER_MERC_1_STORY4",
    line = ccb.content.gendered_line("Huh.  Hadn't thought about it in ages, but now that you mention it, that was a weird job.  It was just a boarded up warehouse in the middle of nowhere, and I was not a cheap contractor in those days.  Coulda got any fat rent-a-cop to watch it.  I had only just started working there when the shit hit the fan, and I kinda forgot about that to be honest.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Thanks for that."), next_topic = "TALK_FRIEND_CONVERSATION" },
        { text = ccb.content.text("Thanks for that.  <lets_go>"), next_topic = "TALK_DONE" },
    },
}
