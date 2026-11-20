local ccb = require("ccb")

-- Just because you asked, I think we can work something out.  Yes, the Scythean has been bugging me about something.  It's not something a cyborg like me can do, but a mercenary would probably fit the bill.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_1_intro",
    line = ccb.content.text("Them as offer as can, an it be so.  How'd ye be twigged by a quick an' round, a nice escoltin' out to a place sommat of curiosity?  Aye, there's summat the old Scythy been larkin' up Rubik's tailpipe.  B'ain't tass right for a clanker like this'n, but a pop-an-work like you'n, maybe well and suited."),
    replies = {
        {
            text = ccb.content.text("What's \"the ol' Scythy\"?"),
            next_topic = "TALK_EXODII_MERCHANT_Scythean",
        },
        {
            text = ccb.content.text("Why can't one of you do this?"),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_explain",
        },
        {
            text = ccb.content.text("Tell me more about this job that you can't do."),
            next_topic = "TALK_EXODII_MERCHANT_mission_1_intro1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_EXODII_MERCHANT_Talk",
        },
        {
            text = ccb.content.text("<end_talking_leave>  See you later, Rubik."),
            next_topic = "TALK_DONE",
        },
    },
}
