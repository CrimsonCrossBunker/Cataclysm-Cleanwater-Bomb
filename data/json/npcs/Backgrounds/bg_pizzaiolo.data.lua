local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_pizzaiolo_STORY1",
    line = ccb.content.gendered_line("I was just a regular pizzaiolo.  My father was a pizzaiolo, my grandfather was a pizzaiolo and I also became a pizzaiolo.  I was making pizza my whole life, until some American <name_b>s ruined my business!  I couldn't do anything about this, but now, with <the_cataclysm> and <zombies> around, I have a chance to get my revenge!  And I got my revenge, thanks to a special someone.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("He-he, that was a fun ride, <name_g>."),
            next_topic = "BGSS_pizzaiolo_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_pizzaiolo_STORY2",
    line = ccb.content.gendered_line("Are you kidding?  That was the best!  When I imagine the face of that arrogant cook… mmm, sweet, sweet picture.  Oh, and how we beat up that <freaking> food-<name_b>, I dreamed about it for so long… and my restaurant, we beat the shit out of those <name_b>s.  Too bad it was trashed as hell… anyway, let's hit the dirt.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
