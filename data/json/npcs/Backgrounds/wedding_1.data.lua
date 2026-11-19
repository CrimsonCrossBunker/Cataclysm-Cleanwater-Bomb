local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "CWH_WEDDING_1_IDEAS1",
    line = ccb.content.gendered_line("I'll be honest with you, I was paying more attention to wedding planning than current events leading up to things.  I knew there were riots going on, but they were out of town.  Even when they got closer to home, I tried to ignore them so we could have our big day.  After the zombies started coming, though, well that's when stuff got really weird.  When I was running from the wedding I swear I saw the sky rip open and monsters fly out of the hole, like something out of Independence Day.  I don't know what it all was, it looked like black magic or something.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
