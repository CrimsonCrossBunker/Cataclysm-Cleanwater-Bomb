local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Olwen_Love0",
    line = ccb.content.text("She is feeling down since her relationship with Julian seems to have been put on pause by <the_cataclysm>, but I heard Julian talking about making a proper confession with some rings and everything, maybe you could ask him about it?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Felicity_3",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Felicity."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Olwen_Love1",
    line = ccb.content.text("She is feeling great since receiving her ring from Julian, I can't stop smiling seeing her flourishing here even after everything that happened…"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Felicity_3",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Felicity."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Olwen_Love2",
    line = ccb.content.text("I just helped her trying on her wedding dress!  She will look gorgeous in that dress.  I can't wait to see her smile when the day arrives, she already goes from here and there with a smile from ear to ear…"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Felicity_3",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Felicity."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Tom",
    line = ccb.content.text("He wasn't always like this.  Olwen came not long after we married, he was a great, caring father to her.  A few months before <the_cataclysm> is when he lost it, got in some survivalist circle.  He'd stay up pouring over newspapers and any documents he could find, and wound up quitting his job to study it more.  We didn't see much of him for a while, always in the basement, and took out a chunk of our savings to buy canned goods en masse."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Felicity_3",
        },
        {
            text = ccb.content.text("Is there any way to get him out of it?"),
            next_topic = "TALK_GODCO_Felicity_Tom_Mood",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Felicity."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Tom_Mood",
    line = ccb.content.text("I don't know.  I've tried talking to him, tried to convince him to give it up.  I think he's stressed out with everything going on, and snapped because of that.  I just want my husband back…"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Felicity_3",
        },
        {
            text = ccb.content.text("I'll see what I can do.  Bye, Felicity."),
            next_topic = "TALK_DONE",
        },
    },
}
