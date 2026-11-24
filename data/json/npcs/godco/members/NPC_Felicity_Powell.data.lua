local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Felicity_2", "TALK_GODCO_Felicity_3", "TALK_GODCO_Felicity_Firstmeet", "TALK_GODCO_Felicity_Firstmeet2", "TALK_GODCO_Felicity_Community" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Felicity_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What's it like living here?"),
            next_topic = "TALK_GODCO_Felicity_Mood",
        },
        {
            text = ccb.content.text("How's your family?"),
            next_topic = "TALK_GODCO_Felicity_Family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Is there anything I can do for you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("How's the manuscript coming?"),
            next_topic = "TALK_GODCO_Felicity_Manuscript_InProgress",
            when = predicates.handler("dlg_p_dda_4b170013d58b"),
        },
        {
            text = ccb.content.text("How's the manuscript coming?"),
            next_topic = "TALK_GODCO_Felicity_Manuscript",
            when = predicates.handler("dlg_p_dda_d71ced0bb43b"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Felicity_3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_1",
    line = {
        when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
        yes = ccb.content.text("Please, go away.  I don't want to talk to you right now."),
        no = {
            when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_felicity" } }),
            yes = {
                choices = {
                    ccb.content.text("Oh, hi."),
                    ccb.content.text("Hey, good to see you're still around."),
                    ccb.content.text("Hey <u_name>, nice to see you."),
                },
            },
            no = ccb.content.text("Oh, hi there.  My name's Felicity, nice to see a new face."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Felicity?  Nice to meet you.  How are things here?"),
            next_topic = "TALK_GODCO_Felicity_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_felicity" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_felicity", "yes") },
        },
        {
            text = ccb.content.text("Felicity?  Nice to meet you.  How are things here?"),
            next_topic = "TALK_GODCO_Felicity_Firstmeet2",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_felicity" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_felicity", "yes") },
        },
        {
            text = ccb.content.text("Hi Felicity.  Got a minute?"),
            next_topic = "TALK_GODCO_Felicity_2",
            when = predicates.handler("dlg_p_dda_f9d159e20386"),
        },
        {
            text = ccb.content.text("What's all that about?"),
            next_topic = "TALK_GODCO_Felicity_2",
            when = predicates.handler("dlg_p_dda_3b46a78bb7af"),
        },
        {
            text = ccb.content.text("Hi Felicity.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Olwen",
    line = ccb.content.text("Olwen's a bright girl, always has been.  She studied electricity and computer science when she was in college, found a job with a research and development firm.  My girl's a fiancee now, her and Julian were going to get married in a few months.  She might teach you something, if you ask."),
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Felicity_3",
        },
        {
            text = ccb.content.text("What do you think about her love life with Julian in here?"),
            next_topic = "TALK_GODCO_Felicity_Olwen_Love0",
            when = predicates.handler("dlg_p_dda_f99453b5c14d"),
        },
        {
            text = ccb.content.text("What do you think about her love life with Julian in here?"),
            next_topic = "TALK_GODCO_Felicity_Olwen_Love1",
            when = predicates.handler("dlg_p_dda_e994ba98f6c9"),
        },
        {
            text = ccb.content.text("What do you think about her love life with Julian in here?"),
            next_topic = "TALK_GODCO_Felicity_Olwen_Love2",
            when = predicates.handler("dlg_p_dda_1ef53835301b"),
        },
        {
            text = ccb.content.text("<end_talking_leave>  Bye, Felicity."),
            next_topic = "TALK_DONE",
        },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Manuscript",
    line = ccb.content.text("It's finally finished!  Here, I want you to have a copy of it.  This is my first time writing like this professionally, I hope you enjoy it."),
    replies = {
        {
            text = ccb.content.text("Thank you, I'm sure it's lovely."),
            next_topic = "TALK_GODCO_Felicity_3",
            actions = { actions.set_actor_value("interlocutor", "general_trade_gave_u_manuscript", "yes"), actions.handler("dlg_a_dda_cebc6d85dfd0") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Manuscript_InProgress",
    line = ccb.content.text("I'm still working on it.  I'll have it ready soon."),
    replies = { { text = ccb.content.text("Good luck with that."), next_topic = "TALK_GODCO_Felicity_3" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Felicity_Angry",
    line = ccb.content.text("Overall, you've been quite unpleasent to us, and I've frankly had enough of your prude nature.  I won't repeat myself more, go away."),
    replies = {
        {
            text = ccb.content.text("Alright <name_b>, I'll see you later."),
            next_topic = "TALK_GODCO_Felicity_3",
        },
    },
}
