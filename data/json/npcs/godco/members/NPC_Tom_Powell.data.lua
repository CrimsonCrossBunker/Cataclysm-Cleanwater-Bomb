local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Tom_Firstmeet4", "TALK_GODCO_Tom_2", "TALK_GODCO_Tom_Goal", "TALK_GODCO_Tom_Goal1", "TALK_GODCO_Tom_Help" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Tom_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Let's talk about your goals."),
            next_topic = "TALK_GODCO_Tom_Goal",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Tom_Story", "TALK_GODCO_Tom_Background", "TALK_GODCO_Tom_Family", "TALK_GODCO_Tom_Community" },
    replies = {
        {
            text = ccb.content.text("Tell me about yourself."),
            next_topic = "TALK_GODCO_Tom_Background",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Tell me about your family."),
            next_topic = "TALK_GODCO_Tom_Family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Tell me about the community."),
            next_topic = "TALK_GODCO_Tom_Community",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Tom_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Let's talk about your goals."),
            next_topic = "TALK_GODCO_Tom_Goal",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("What the hell are you?  Get away from me!"),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("It's you again <u_name>, you have some nerve coming around after what you've done."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_tom" } }),
                yes = ccb.content.text("Hey, it's you again <u_name>!  Any news from the outside world?"),
                no = ccb.content.gendered_line("Ah, another survivor!  I hope you come in peace.  I'm Tom, nice to meet you.", { "speaker" }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Tom."),
            next_topic = "TALK_GODCO_Tom_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_tom" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_tom", "yes") },
        },
        {
            text = ccb.content.text("Hi Tom, got a minute?"),
            next_topic = "TALK_GODCO_Tom_2",
            when = predicates.handler("dlg_p_dda_bff6e448efd8"),
        },
        {
            text = ccb.content.text("Hi Tom, got a minute?"),
            next_topic = "TALK_GODCO_Tom_Angry",
            when = predicates.handler("dlg_p_dda_21271b12063e"),
        },
        {
            text = ccb.content.text("Hey, Tom.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("Alright, alright, I'll leave you be."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_a5ec6d0947e2"),
        },
        {
            text = ccb.content.text("Alright, alright, chill out, I'm leaving!"),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Firstmeet",
    line = ccb.content.text("Was it difficult to find us?  We haven't seen a single soul out there for so long, I'm starting to lose my hope.  So, tell me about yourself."),
    replies = {
        {
            text = ccb.content.text("I'm just a curious traveler.  What about you, how are you doing?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })),
            next_topic = "TALK_GODCO_Tom_Firstmeet2",
        },
        {
            text = ccb.content.text("I'm seeking asylum here.  What about you, how are you doing?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }),
            next_topic = "TALK_GODCO_Tom_Firstmeet2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Firstmeet2",
    line = ccb.content.text("Hey, that's nice of you to ask.  The people here are barely holding on.  Malnutrition, sleepless nights, odd sounds from the woods, everyone turns a little mad in these circumstances.  It's not their fault, I know, but they did get what they wanted."),
    replies = {
        { text = ccb.content.text("Please continue."), next_topic = "TALK_GODCO_Tom_Firstmeet3" },
        {
            text = ccb.content.text("No rest for the weary.  See you around, Tom."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Firstmeet3",
    line = ccb.content.text("The sky has broken!  They received a rather passive-aggressive sign from God!  The wait is finally over.  Well, not for me.  So much is left unanswered, and I know for a fact the answer's out there."),
    replies = {
        {
            text = ccb.content.text("Perhaps it's not worth finding out."),
            next_topic = "TALK_GODCO_Tom_Firstmeet4",
        },
        {
            text = ccb.content.text("Try not to get stuck in the past.  See you around, Tom."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Firstmeet4",
    line = ccb.content.text("Perhaps.  You don't wanna think about the stuff I'm thinking about, it would spiral a newbie independent thinker into madness.  I don't blame you for saying that."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_2",
    line = ccb.content.text("I'm currently in the middle of solving a pointless mystery for my own entertainment.  Of course I have time!"),
    replies = {
        {
            text = ccb.content.text("Maybe I could help you with that mystery?"),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("Sorry Tom.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Story",
    line = ccb.content.text("I haven't got a story.  I'm an independent thinker.  Living out here, away from the Man."),
    replies = {
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

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Background",
    line = ccb.content.text("I was nobody but an ordinary office drone.  Lived the average suburban life, prepping for the inevitable.  Had the bright idea of purchasing a Last Man On Earth shelter, but I decided to settle for less when I found out it cost five times my annual salary.  That's how I ended up in a religious campground with my family and a survival kit."),
    replies = {
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

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Family",
    line = ccb.content.text("All of us are here; me, Felicity, and Olwen.  We're so lucky, I feel like crying tears of joy every time I see them."),
    replies = {
        {
            text = ccb.content.text("Could you tell me about Felicity?"),
            next_topic = "TALK_GODCO_Tom_Felicity",
        },
        {
            text = ccb.content.text("Could you tell me about Olwen?"),
            next_topic = "TALK_GODCO_Tom_Olwen",
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

-- Stillwater is a legitimate publishing firm, operating in Rhode Island.
ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Felicity",
    line = ccb.content.text("She's my wife, we've been married for a while now.  We used to live in Rhode Island, worked at a publishing firm, Stillwater.  She's always wanted to be a writer, that's why we moved away.  We've been a bit distant as of late, I don't think she's taking the \"whole end-of-the-world\" thing too well."),
    replies = {
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

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Olwen",
    line = ccb.content.text("Olwen's a bright girl; she's fiddled with electronics and computers since she was in high school.  She got a master's in it from the University of Rhode Island.  Felicity's been a good mother for her, always been there for us.  Olwen might be able to teach you a few things, she should be around here somewhere."),
    replies = {
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("What do you think about her love life with Julian in here?"),
            next_topic = "TALK_GODCO_Tom_Olwen_Love0",
            when = predicates.handler("dlg_p_dda_f99453b5c14d"),
        },
        {
            text = ccb.content.text("What do you think about her love life with Julian in here?"),
            next_topic = "TALK_GODCO_Tom_Olwen_Love1",
            when = predicates.handler("dlg_p_dda_e994ba98f6c9"),
        },
        {
            text = ccb.content.text("What do you think about her love life with Julian in here?"),
            next_topic = "TALK_GODCO_Tom_Olwen_Love2",
            when = predicates.handler("dlg_p_dda_1ef53835301b"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Olwen_Love0",
    line = ccb.content.text("I see that she is feeling down since <the_cataclysm> ruined their plans of living together, but Julian was asking me the other day about my wedding with Felicity so…  I can expect that to not last long."),
    replies = {
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

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Olwen_Love1",
    line = ccb.content.text("I saw her big smile when receiving her ring from Julian, some days the smiles of my family are what keeps me going after everything that happened…"),
    replies = {
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

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Olwen_Love2",
    line = ccb.content.text("She is constantly jumping from happiness after trying her wedding dress with her mother…  I keep getting distracted from my investigation into <the_cataclysm>, but seeing those two makes me smile so I can't stop seeing their antics."),
    replies = {
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

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Community",
    line = ccb.content.text("New England Church Community is what they're called.  My wife was the first in the family to come in contact with 'em.  She joined because of their charity work and as for myself, well… you know why I was there.  Let me tell you, being surrounded by like-minded folks was like a breath of fresh air.  Even if the only belief we shared was paranoia, but you get what I'm saying.  I tried everything to prep my family for the inevitable, I really did, but in the end it wasn't me who saved us all."),
    replies = {
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

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Goal",
    line = ccb.content.text("I want to find out the truth and preserve the past for the following generation, so that they'll know some of what happened."),
    replies = {
        { text = ccb.content.text("Any progress?"), next_topic = "TALK_GODCO_Tom_Goal1" },
        {
            text = ccb.content.text("Sounds like an ambitious project.  Is there anything I can do to help you out?"),
            next_topic = "TALK_GODCO_Tom_Help",
        },
        {
            text = ccb.content.text("Good luck with that.  See you around, Tom."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Goal1",
    line = ccb.content.text("So far?  Not so great.  Now that the Internet is down, I don't know.  Such abundant hidden information - all gone!"),
    replies = {
        {
            text = ccb.content.text("Is there anything I can do to help you out?"),
            next_topic = "TALK_GODCO_Tom_Help",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Try not to glorify the past.  See you around, Tom."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Help",
    line = ccb.content.text("Of course!  Just put all your literary findings on that chair over there.  Remember, you're not only doing a favor for me, but for all of humanity as well.  World heritage is what we're talking about!  I managed to get my hands on a book called 'Zombie Survival Guide' while, uh… dumpster diving.  Imagine how much this book alone reveals about our pre-Cataclysm culture!  Oh boy, how wrong we were about everything."),
    replies = {
        {
            text = ccb.content.text("I mean, can I help with the research?"),
            next_topic = "TALK_GODCO_Tom_Research",
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

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Research",
    line = ccb.content.text("No no no no no!  Thinking is one of the only thing I have left and you can't take that away from me.  But, If you *really* want to make yourself useful, relevant newspapers would help me piece out the puzzle."),
    repeat_replies = {
        {
            items = { "newest_newspaper", "weeks_old_newspaper", "months_old_newspaper" },
            reply = { text = ccb.content.text("Delivering <topic_item>."), next_topic = "TALK_DELIVER_ASK" },
        },
    },
    replies = {
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

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Tom_Angry",
    line = ccb.content.text("No, I'm all out of them.  Now, I've got better things to do, goodbye."),
    replies = { { text = ccb.content.text("Okay Tom, go ahead and be that way."), next_topic = "TALK_DONE" } },
}
