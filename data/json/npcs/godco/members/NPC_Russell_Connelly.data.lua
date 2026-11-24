local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = {
        "TALK_GODCO_Russell_Joinee", "TALK_GODCO_Russell_2", "TALK_GODCO_Russell_Trophy2",
        "TALK_GODCO_Russell_Mood", "TALK_GODCO_Russell_Mood1", "TALK_GODCO_Russell_Trophy3",
        "TALK_GODCO_Russell_Trade2",
    },
    replies = {
        {
            text = ccb.content.text("Let's talk about getting you those trophies."),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.negate(predicates.has_effect("interlocutor", "hunt_godco_russell")),
        },
        {
            text = ccb.content.text("Why don't you hunt these trophies yourself?"),
            next_topic = "TALK_GODCO_Russell_Trophy3",
            when = predicates.negate(predicates.has_effect("interlocutor", "hunt_godco_russell")),
        },
        {
            text = ccb.content.text("Why didn't you hunt these trophies yourself?"),
            next_topic = "TALK_GODCO_Russell_Trophy3",
            when = predicates.has_effect("interlocutor", "hunt_godco_russell"),
        },
        {
            text = ccb.content.text("Do you really need these trophies?"),
            next_topic = "TALK_GODCO_Russell_Trophy2",
        },
        {
            text = ccb.content.text("How are things, living here?"),
            next_topic = "TALK_GODCO_Russell_Mood",
        },
        { text = ccb.content.text("Care to trade?"), next_topic = "TALK_GODCO_Russell_Trade" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("Get away from me, demon.  I shoot crazy sinners like you on a regular basis, and my rifle's right here."),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("Get away from me <name_b>.  I'm not interested in whatever <freaking> thing you have to say right now."),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_russell" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord, <name_g>."),
                        ccb.content.text("Praise the Lord, <u_name>."),
                        ccb.content.text("Greetings, <name_g><punc>  You okay?"),
                    },
                },
                no = ccb.content.text("Huh, so it was you over there.  It's always great to see a new face.  Name's Russell, Russell Connelly."),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Russell, hey?  Nice to meet you."),
            next_topic = "TALK_GODCO_Russell_Firstmeet",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_russell" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_russell", "yes") },
        },
        {
            text = ccb.content.text("Hi, Russell.  Got a minute?"),
            next_topic = "TALK_GODCO_Russell_2",
            when = predicates.handler("dlg_p_dda_1edc8717c0eb"),
        },
        {
            text = ccb.content.text("Hey, Russell.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_b39f59d33e4f"),
        },
        {
            text = ccb.content.text("Chill out man, I'll leave you alone."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_5ebd062782a3"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Firstmeet",
    line = ccb.content.text("It's not often that we see new folks around the remnants of the New England Community Church.  So, got any tales to share from the outside world?"),
    replies = {
        {
            text = ccb.content.text("I'm just a curious traveler.  What's up with you?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })),
            next_topic = "TALK_GODCO_Russell_Story",
        },
        {
            text = ccb.content.text("I'm seeking asylum here.  What's up with you?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }),
            next_topic = "TALK_GODCO_Russell_Story",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_GODCO_Russell_StoryB",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Story",
    line = ccb.content.text("Who cares what's up with me?  You're the new one here.  Let me put it another way: what have you seen out there?  I'm talking about the monsters that lurk deep in the woods.  Have you witnessed them with your very own eyes?"),
    replies = {
        {
            text = ccb.content.text("I wouldn't be here if I saw one.  Why do you ask?"),
            next_topic = "TALK_GODCO_Russell_Trophy",
        },
        {
            text = ccb.content.text("I've seen too many things out there.  Why do you ask?"),
            next_topic = "TALK_GODCO_Russell_Trophy",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_StoryB",
    line = ccb.content.text("I won't let you leave just yet.  You're the new one here, I have so much to ask.  Let me put it another way: what have you seen out there?  I'm talking about the monsters that lurk deep in the woods.  Have you witnessed them with your very own eyes?"),
    replies = {
        {
            text = ccb.content.text("I wouldn't be here if I saw one.  Why do you ask?"),
            next_topic = "TALK_GODCO_Russell_Trophy",
        },
        {
            text = ccb.content.text("I've seen too much out there.  Why do you ask?"),
            next_topic = "TALK_GODCO_Russell_Trophy",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Trophy",
    line = ccb.content.text("Well, let's just say I'm interested in rare game.  I've heard stories, rumors and some tall tales about otherworldly beings out there in the wasteland.  That's where you come in.  I want to see the evidence, something physical I can collect as a trophy collection.  You seem to have experience, I was hoping you could help me."),
    replies = {
        {
            text = ccb.content.text("Let's talk about getting you those trophies."),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Go and hunt them yourself.  You have a gun after all."),
            next_topic = "TALK_GODCO_Russell_Trophy3",
        },
        {
            text = ccb.content.text("I've got other things to deal with.  Do you really need these trophies?"),
            next_topic = "TALK_GODCO_Russell_Trophy2",
        },
        {
            text = ccb.content.text("I can help.  Anyway, how are things?"),
            next_topic = "TALK_GODCO_Russell_2",
        },
        { text = ccb.content.text("Find somebody else, dude."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_2",
    line = ccb.content.text("I've been better.  Having a hellish time keeping up with strange wildlife that suddenly want us dead… hey, let's forget the world while we're talking.  How's life treatin' ya?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Trophy2",
    line = {
        when = predicates.has_effect("interlocutor", "hunt_godco_russell"),
        yes = ccb.content.text("Look, I'm just a regular God-fearing fella like you.  You gotta have something to keep your mind off stuff.  You'd get mad otherwise.  My passion happens to be collecting trophies.  I appreciate your help, by the way."),
        no = ccb.content.text("Look, I'm just a regular God-fearing fella like you.  You gotta have something to keep your mind off stuff.  You'd get mad otherwise.  My passion happens to be collecting trophies."),
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("Your life, your escape mechanism…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Mood",
    line = ccb.content.text("Oh it's nothing new to me.  Livin' off the land, far from everyone - it's just what I'm adjusted to.  I've kept in touch with the church folks, and that was enough.  I had a loyal companion back home, Betsey, my rottweiler.  Things have been very different since she passed away, though."),
    replies = {
        { text = ccb.content.text("What do you do now?"), next_topic = "TALK_GODCO_Russell_Mood1" },
        {
            text = ccb.content.text("Could you tell me more about Betsey?"),
            next_topic = "TALK_GODCO_Russell_Betsey",
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
    id = "TALK_GODCO_Russell_Mood1",
    line = ccb.content.text("I hunt with most of my time these days.  Whatever game I spot, I bag and donate.  Thing is, it's getting harder and harder.  Have you also noticed how corruption is slowly overtaking the natural wildlife in this God-given planet?  They think the flesh is just rotten.  No, it's mutated, become something else."),
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
    id = "TALK_GODCO_Russell_Betsey",
    line = ccb.content.text("&Russel's expression becomes somber, and he briefly stares at the wall.  \"She was my dog, had her for seventeen years.  We used to go duck-hunting, she'd swim out and get anything I shot.  She helped me track many a deer through the woods…   When <the_cataclysm> hit, she saved me from some <zombies> when we were skippin' town, but she died…  Then she came back, wasn't herself…  I had to put her down.\""),
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss.  Let's change the subject."),
            next_topic = "TALK_GODCO_Russell_2",
        },
        {
            text = ccb.content.text("I'm sorry for your loss.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Trophy3",
    line = ccb.content.text("I may be more skilled or better equipped but you, my friend, have something I don't: experience.  A good hunter never leaves his hunting ground.  I sure ain't gonna leave it!  Now you <name_g>, you know what it's REALLY like out there!"),
    replies = {
        {
            text = ccb.content.text("I hate to break it to you, but I came here because I don't want to see the world."),
            next_topic = "TALK_GODCO_Russell_Joinee",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm humbled by your words.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Joinee",
    line = ccb.content.text("And I hate to break it to you, but my point still stands."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm humbled by your words.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Trade",
    line = ccb.content.text("We're all desperately holding on to our stockpiles, but I can find something for you.  I have some spare hides and pelts, if you're interested in buying."),
    replies = {
        {
            text = ccb.content.text("Since I helped you out with your trophies, can I get a discount?"),
            next_topic = "TALK_GODCO_Russell_Trade2",
            when = predicates.all({ predicates.has_effect("interlocutor", "hunt_godco_russell"), predicates.negate(predicates.has_effect("interlocutor", "trade_godco_russell")) }),
        },
        {
            text = ccb.content.text("Let's make a deal."),
            native_actions = { "start_trade" },
            next_topic = "TALK_GODCO_Russell_2",
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
    id = "TALK_GODCO_Russell_Trade2",
    line = ccb.content.text("I can't give a discount, but here's some meat instead.  Made by yours truly."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_da267392f0c1"), actions.add_effect("interlocutor", "trade_godco_russell", { permanent = true }) } },
    },
    replies = {
        {
            text = ccb.content.text("Thank you.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Thank you.  I'll see you around, Russell."),
            next_topic = "TALK_DONE",
        },
    },
}
