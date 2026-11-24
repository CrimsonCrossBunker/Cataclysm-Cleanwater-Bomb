local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Katherine_Joinees", "TALK_GODCO_Katherine_Job", "TALK_GODCO_Katherine_Arturo", "TALK_GODCO_Katherine_Corrie", "TALK_GODCO_Katherine_Jane", "TALK_GODCO_Katherine_Sonia", "TALK_GODCO_Katherine_Zachary", "TALK_GODCO_Katherine_Simon", "TALK_GODCO_Katherine_Jeremiah" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Katherine_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_GODCO_Katherine_Mood",
        },
        {
            text = ccb.content.text("Can you tell me about Arturo?"),
            next_topic = "TALK_GODCO_Katherine_Arturo",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("Can you tell me about Corrie?"),
            next_topic = "TALK_GODCO_Katherine_Corrie",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("Can you tell me about Jane?"),
            next_topic = "TALK_GODCO_Katherine_Jane",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("Can you tell me about Sonia?"),
            next_topic = "TALK_GODCO_Katherine_Sonia",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("Can you tell me about Zachary?"),
            next_topic = "TALK_GODCO_Katherine_Zachary",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("Can you tell me about Simon?"),
            next_topic = "TALK_GODCO_Katherine_Simon",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("Can you tell me about Jeremiah?"),
            next_topic = "TALK_GODCO_Katherine_Jeremiah",
            when = predicates.handler("dlg_p_dda_8a1122999849"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Katherine_2a", "TALK_GODCO_Katherine_2", "TALK_GODCO_Katherine_Mood", "TALK_GODCO_Katherine_Story", "TALK_GODCO_Katherine_Family", "TALK_GODCO_Katherine_Community", "TALK_GODCO_Katherine_Founder", "TALK_GODCO_Katherine_Joinee_Opinion" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Katherine_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_Katherine_Job",
        },
        {
            text = ccb.content.text("You don't seem to like the joinees very much.  Why is that?"),
            next_topic = "TALK_GODCO_Katherine_Joinee_Opinion",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Do you know where I could find some work?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_GODCO_Katherine_Mood",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.gendered_line("Oh well, yet another sinner.  Don't talk to me.", { "speaker" }),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("Please go away, I'm not in the mood to talk right now."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_katherine" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord."),
                        ccb.content.text("<u_name>, bless you."),
                    },
                },
                no = ccb.content.gendered_line("Oh well, yet another survivor.  Welcome to our group, I'm Katherine.", { "speaker" }),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi, Katherine.  How's it going?"),
            next_topic = "TALK_GODCO_Katherine_2a",
            when = predicates.handler("dlg_p_dda_de17284a0857"),
        },
        {
            text = ccb.content.text("Nice to meet you, Katherine."),
            next_topic = "TALK_GODCO_Katherine_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_katherine" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_katherine", "yes") },
        },
        {
            text = ccb.content.text("You sure, I've got plenty of time."),
            next_topic = "TALK_GODCO_Katherine_Angry",
            when = predicates.handler("dlg_p_dda_a5ec6d0947e2"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("Okay, I'll see you later."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_a5ec6d0947e2"),
        },
        {
            text = ccb.content.text("Alright, fuck you then."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5ebd062782a3"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Firstmeet",
    line = ccb.content.text("It's always a pleasure.  How may I help you?"),
    replies = {
        {
            text = ccb.content.text("I just had some questions."),
            next_topic = "TALK_GODCO_Katherine_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_2a",
    line = ccb.content.text("We have many things to pray for, I'm afraid."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_2",
    line = ccb.content.text("I understand.  I don't have the answers you are looking for, I'm afraid."),
    replies = { { text = ccb.content.text("I'll be on my way then."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Mood",
    line = ccb.content.text("Our prayers were heard.  We knew the day was coming, so we prepared.  Our community stockpiled months' worth of canned goods, well enough until the chaos ends.  With the food we have left, we could live peacefully, but we foolishly didn't take extra people into consideration.  With so much at risk, I don't think we can afford more people.  Though I'm not the one who makes the decisions here, and it's probably for the better."),
    replies = {
        {
            text = ccb.content.text("Can you can take in joinees once there's a vacancy?"),
            next_topic = "TALK_GODCO_Katherine_Joinees",
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
    id = "TALK_GODCO_Katherine_Job",
    line = ccb.content.text("I worked for the Church, organized charities and filed paperwork.  That's how I met the Founder.  I did so much for everyone, yet they never noticed…"),
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
    id = "TALK_GODCO_Katherine_Joinee_Opinion",
    line = ccb.content.text("You're right, I don't.  They should've come when they had the chance.  Now that our Ark has sailed, they want to jump aboard.  Such is the way of sinners, I suppose."),
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
    id = "TALK_GODCO_Katherine_Joinees",
    line = ccb.content.text("If there's a vacancy.  Even then, there's the decision of which joinee to include.  Those people don't share or respect the same values as we do.  None of them are promising candidates."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Arturo",
    line = ccb.content.text("Jesus warned us about false prophets."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Corrie",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_godco_corrie_machine" } }),
        yes = ccb.content.text("She knows this and that about electronics.  The generator we have here was made by her.  Nice to have one here, even though there's not much use for it yet."),
        no = ccb.content.text("I hear she knows this and that about electronics.    She keeps herself occupied by doing menial tasks around the camp, looking for payment."),
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Jane",
    line = ccb.content.text("There's not an illness God can't cure.  Yet, by fate, we were given a doctor.  She's now taking care of Arturo, that poor thing.  Oh well, who am I to question God's ways?"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Sonia",
    line = ccb.content.text("She occasionally plays her guitar in the hall, and she's quite good at it.  Unsurprisingly, she doesn't know any hymns.  Wouldn't let her near my son."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Simon",
    line = ccb.content.text("My dear, sweet husband.  He worked as a cook for one of the homeless shelters, that's how we met.  He's always liked to try new things.  He should be in the dining hall, if you want to see him."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Jeremiah",
    line = ccb.content.text("He's my son, such a wonderful boy.  He's always been the light in my life, and I've tried to teach him well.  We've been a bit distant as of late, but I'm sure he'll come around."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Zachary",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_godco_corrie_machine" } }),
        yes = ccb.content.text("He can keep his distance with his smug nothingness.  At least he's a bit more useful than some of the others.  He helped Corrie make that generator."),
        no = ccb.content.text("I'm not planning to communicate with him, that's for certain.  He can keep his distance with his smug nothingness.  At least he knows how to cut lumber."),
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Story",
    line = ccb.content.text("If you're here for an exciting story, you're talking with the wrong person.  Ever since I was born I've lived very modestly.  Did I regret it?  No, it will all be worth it in the end…"),
    replies = {
        {
            text = ccb.content.text("Tell me about the community."),
            next_topic = "TALK_GODCO_Katherine_Community",
        },
        {
            text = ccb.content.text("Tell me about your family."),
            next_topic = "TALK_GODCO_Katherine_Family",
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
    id = "TALK_GODCO_Katherine_Community",
    line = ccb.content.text("I've been a member of the New England Church Community for a quarter of a century, took part in each and every sermon and gathering they held even while I was carrying my boy Jeremiah.  Not to mention the countless times we visited those filthy homeless shelters and prisons filled with sinners.  I even met the Founder himself.  I can confidently say I'm more worthy to be here than those impostors who leech on us at this camp."),
    replies = {
        { text = ccb.content.text("The Founder?"), next_topic = "TALK_GODCO_Katherine_Founder" },
        {
            text = ccb.content.text("Tell me about your family."),
            next_topic = "TALK_GODCO_Katherine_Family",
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
    id = "TALK_GODCO_Katherine_Family",
    line = ccb.content.text("I'm sure you've met my husband, Simon.  He was also a volunteer at a homeless shelter, working as a cook.  We were brought together by the hands of fate as some would say.  We have a son together, Jeremiah, the light in my life.  Such a creative and well-behaved boy, I just wish we could find an appropriate woman for him."),
    replies = {
        {
            text = ccb.content.text("Tell me about the community."),
            next_topic = "TALK_GODCO_Katherine_Community",
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
    id = "TALK_GODCO_Katherine_Founder",
    line = ccb.content.text("He was quite reserved when I met him, seemed distant in his thoughts.  Theresa has the answers you are looking for."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("I'll talk to her then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Angry",
    line = ccb.content.text("Look, I'm rather upset and just need some time alone, okay?  I'm sure you're very busy."),
    replies = {
        {
            text = ccb.content.text("I don't have the time to wait, now can we get on with business?"),
            next_topic = "TALK_GODCO_Katherine_Angry_Pressed",
        },
        { text = ccb.content.text("Okay, I'll see you later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Katherine_Angry_Pressed",
    line = ccb.content.text("&Katherine scowls with anger at you.  \"This is the exact <freaking> reason I don't want to talk to you, now go away!\""),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_f8bf9c2ba3b5") } },
    },
    replies = {
        {
            text = ccb.content.text("Fuck's sake <name_b>, I'm leaving!"),
            next_topic = "TALK_DONE",
        },
    },
}
