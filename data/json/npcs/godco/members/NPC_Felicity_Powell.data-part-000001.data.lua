local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_2",
    line = ccb.content.text("I'm always good for a talk.  It's nice to have company, even if we don't have much else to offer."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_3",
    line = ccb.content.text("What's on your mind?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Firstmeet",
    line = ccb.content.text("They're alright.  What can I do for you?"),
    replies = {
        {
            text = ccb.content.text("It's nice to meet you, but I need to head out."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Firstmeet2",
    line = ccb.content.text("They're alright, but they won't take kindly to someone with your… appearance.  What can i do for you?"),
    replies = { { text = ccb.content.text("If that's the case, I'll leave."), next_topic = "TALK_DONE" } },
}

-- There is an actual bakery at the intersection of Chalkstone Avenue and Mt. Pleasant Avenue: DeLuise Bakery.  It has a 4.6/5 on Google.
-- Stillwater is a legitimate publishing firm, operating in Rhode Island.
ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Story",
    line = ccb.content.text("I'm actually from New England, Rhode Island specifically.  I grew up in Providence, the state capital.  It was lovely there, I'd always walk to school and stopped in the park on my way home.  Mom was an accountant for various companies, she went to Rivtech back when it was a startup.  Dad was a baker, ran a shop on the corner of Chalkstone and Mt Pleasant.  It smelled so good when you walked by…  I always wanted to be a writer, but I wound up as a proofreader for Stillwater, a publishing firm.  I met Tom at that office, we got married about three years later."),
    replies = {
        {
            text = ccb.content.text("Why'd you move out here?"),
            next_topic = "TALK_GODCO_Felicity_Move",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Felicity_3",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Move",
    line = ccb.content.text("Tom and I wanted to get away from the city, so we found a home up here.  We didn't move again until <the_cataclysm>, when we came here."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Felicity_3",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Mood",
    line = ccb.content.text("We've been through a lot without much help, it's been difficult to cope.  Still, we put on a happy little face, and some of us pretend everything's all right."),
    replies = {
        { text = ccb.content.text("I suppose we do."), next_topic = "TALK_GODCO_Felicity_3" },
        { text = ccb.content.text("<end_talking_leave>  Bye, Felicity."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Family",
    line = ccb.content.text("My family's alright.  I have a wonderful daughter, Olwen; she's an electronics nut, had a great job with it too.  My husband Tom is the crazy one, always rambling on about conspiracy theories, secret agents, all that."),
    replies = {
        { text = ccb.content.text("What's your story?"), next_topic = "TALK_GODCO_Felicity_Story" },
        {
            text = ccb.content.text("What's it like living here?"),
            next_topic = "TALK_GODCO_Felicity_Mood",
        },
        {
            text = ccb.content.text("Could you tell me more about Tom?"),
            next_topic = "TALK_GODCO_Felicity_Tom",
        },
        {
            text = ccb.content.text("Could you tell me more about Olwen?"),
            next_topic = "TALK_GODCO_Felicity_Olwen",
        },
        { text = ccb.content.text("<end_talking_leave>  Bye, Felicity."), next_topic = "TALK_DONE" },
    },
}
