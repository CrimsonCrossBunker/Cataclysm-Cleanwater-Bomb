local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_GODCO_Julian_Leave", "TALK_GODCO_Julian_2", "TALK_GODCO_Julian_Story", "TALK_GODCO_Julian_Leader", "TALK_GODCO_Julian_Mood" },
    replies = {
        {
            text = ccb.content.text("What's your story?"),
            next_topic = "TALK_GODCO_Julian_Story",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("How are things here?"),
            next_topic = "TALK_GODCO_Julian_Mood",
        },
        {
            text = ccb.content.text("What are the advantages of being a dorm leader?"),
            next_topic = "TALK_GODCO_Julian_Leader",
        },
        {
            text = ccb.content.text("Heard you and Olwen were some kind of lovebirds?"),
            next_topic = "TALK_GODCO_Julian_Love0",
            when = predicates.handler("dlg_p_dda_f99453b5c14d"),
        },
        {
            text = ccb.content.text("How did Olwen receive the rings?"),
            next_topic = "TALK_GODCO_Julian_Love1",
            when = predicates.handler("dlg_p_dda_e994ba98f6c9"),
        },
        {
            text = ccb.content.text("Did Olwen like the dress?"),
            next_topic = "TALK_GODCO_Julian_Love2",
            when = predicates.handler("dlg_p_dda_1ef53835301b"),
        },
        {
            text = ccb.content.text("Why did you join the Church?"),
            next_topic = "TALK_GODCO_Julian_Church",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("I want to join the community."),
            next_topic = "TALK_GODCO_Julian_Join",
            when = predicates.handler("dlg_p_dda_4a3f3f2c8c2b"),
        },
        {
            text = ccb.content.text("I want to join the community."),
            next_topic = "TALK_GODCO_Julian_Mutant_Join",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_julian" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }) }),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_1",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }),
        yes = ccb.content.text("Hey…  I'm Julian, the guy in charge of this room.  Are you… planning on sticking around or somethin'?"),
        no = {
            when = predicates.handler("dlg_p_dda_3ae720d7aecb"),
            yes = ccb.content.text("Why are you still around, don't you have someone else to bother?"),
            no = {
                when = predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_julian" } }),
                yes = {
                    choices = {
                        ccb.content.text("Praise the Lord."),
                        ccb.content.text("Hey, <name_g>."),
                        ccb.content.text("Good to see you again <u_name>."),
                    },
                },
                no = ccb.content.text("Hey, a new face.  I'm Julian, the guy in charge of this room.  You're planning on sticking around or somethin'?"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice to meet you, Julian.  I'm just passing through."),
            next_topic = "TALK_GODCO_Julian_Leave",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_julian" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_julian", "yes") },
        },
        {
            text = ccb.content.text("Nice to meet you, Julian.  I'm seeking asylum."),
            next_topic = "TALK_GODCO_Julian_Join",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_julian" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_julian", "yes") },
        },
        {
            text = ccb.content.text("I'm a joinee actually.  Nice to meet you."),
            next_topic = "TALK_GODCO_Julian_2",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_julian" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_julian", "yes") },
        },
        {
            text = ccb.content.text("Nice to meet you, Julian.  I'm seeking asylum."),
            next_topic = "TALK_GODCO_Julian_Mutant_Join",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_u_met_godco_julian" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_godco_godco_notalk_to_u" } }) }),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_u_met_godco_julian", "yes") },
        },
        {
            text = ccb.content.text("Hey, good to see you again."),
            next_topic = "TALK_GODCO_Julian_2",
            when = predicates.handler("dlg_p_dda_ed54f56716f3"),
        },
        {
            text = ccb.content.text("Nope, just me and you pal.  What's the attitude about?"),
            next_topic = "TALK_GODCO_Julian_Angry",
            when = predicates.handler("dlg_p_dda_84616cfc7457"),
        },
        {
            text = ccb.content.text("Hello, Julian.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_2",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_godco_joinee" } }),
        yes = {
            choices = {
                ccb.content.text("If you have complaints, please don't tell anyone."),
                ccb.content.text("You're still staying here, joinee?"),
                ccb.content.text("Need anything, joinee?"),
            },
        },
        no = { choices = { ccb.content.text("Need anything?"), ccb.content.text("Go on…") } },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Leave",
    line = ccb.content.gendered_line("You sure?  I mean, you've been traveling for a long time, haven't you?  Alright, it's your decision.  Let me know when you changed your mind.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("<end_talking_leave>  Nice meeting you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Join",
    line = ccb.content.text("Aight, here are the rules: don't commit sins, don't litter, and try not to die.  Have some mutual respect, capiche?"),
    replies = {
        {
            text = ccb.content.text("Got it."),
            next_topic = "TALK_GODCO_Julian_Joinee",
            actions = { actions.handler("dlg_a_dda_bdc407533a0b") },
        },
        {
            text = ccb.content.text("Actually, <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Love0",
    line = ccb.content.text("Of course, our relationship was going pretty well before <the_cataclysm>.  Olwen seems to be under the weather lately, but I want to give her a great surprise and make her smile again…"),
    replies = {
        {
            text = ccb.content.text("Want me to help you with that surprise?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Julian_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Love1",
    line = ccb.content.text("With a big smile and her eyes wide open!  I can't thank you enough for helping me with that, even so…  You could maybe lend your hand again to bring even more happiness to this place?"),
    replies = {
        { text = ccb.content.text("What do you need?"), next_topic = "TALK_MISSION_LIST" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Julian_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Love2",
    line = ccb.content.text("She loved it!  I still can't believe I will be able to provide her with a proper wedding even after everything that happened, you have been a real life saver <name_g>."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Julian_2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Mutant_Join",
    line = ccb.content.text("Listen, I have some bad news.  I don't personally have anything against you, but many of the people here are very… discriminatory against those who look like you.  I hate to say it, but I'll have to turn you away.  I'm sorry."),
    replies = {
        {
            text = ccb.content.text("Alright, let's talk about something else."),
            next_topic = "TALK_GODCO_Julian_2",
        },
        { text = ccb.content.text("I get the picture, screw this."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Joinee",
    line = ccb.content.text("Your name is now on the books.  Here's your blanket, joinee.  Those two beds next to the window, you can choose one of them.  It's safe, don't worry.  I'm armed.  By the way, if you're hungry you can go bug Simon for a meal, up to one in a day."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_a026e5b0762a"), actions.set_actor_value("speaker", "general_meeting_godco_joinee", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Thank you.  See you around, Julian."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Story",
    line = ccb.content.text("&Julian suddenly appears disturbed, and looks away from you for a moment.  \"It's a long story, and not an interesting one at that.  I was a cop before.  You must've heard about those riots and all that.  I'm glad we all managed to make it out alive.\""),
    replies = {
        {
            text = ccb.content.text("How did you make it out?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "general_meeting_told_backstory" } })),
            trial = { kind = "persuade", difficulty = 30 },
            failure = { next_topic = "TALK_GODCO_Julian_NoChat" },
            success = { next_topic = "TALK_GODCO_Julian_Riots" },
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
    id = "TALK_GODCO_Julian_Riots",
    line = ccb.content.text("Well, I might as well be honest with you.  I ran mostly, ran like the devil was chasin' me.  I was at one of the police stations in town, when we were called out to handle a violent mob on the loose.  When we got there, the people were crazy, smashing and killing everything in their way.  They had these bloodshot eyes and a weird goo in their mouths.  We pulled out all the stops to handle them.  When tear gas wouldn't work, the chief told us to draw guns and kill them all.  We did…  There was so much blood…  That maneuver killed a lot of them, but not all.  One snuck up behind a lady who worked with us, tore a whole section of her spine out.  She never even had time to scream, just slumped over the cruiser door…  So I jumped post and ran, never looked back.  God, I can still hear the cries…"),
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss.  Maybe we should change the subject."),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_told_backstory", "yes") },
            next_topic = "TALK_GODCO_Julian_2",
        },
        {
            text = ccb.content.text("I'm sorry for your loss.  <end_talking_leave>"),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_told_backstory", "yes") },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Leader",
    line = ccb.content.text("Advantages?  All I do is work!"),
    replies = {
        {
            text = ccb.content.text("Anything I can do to help you out?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Yeah, it must be exhausting.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Mood",
    line = ccb.content.text("It's been a struggle, trying to keep this bunch together.  Oh things could be better here, of course.  It could always be, but sometimes we don't even realize how good we have it here."),
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
    id = "TALK_GODCO_Julian_Church",
    line = ccb.content.text("When I was younger, I used to go to church with my family.  When I started growing up, I saw all this evil around me, people hating and persecuting others, despite the teachings of Jesus; I just stopped going one day, decided to make my own way.  I joined the NECC a few years back to rekindle my relationship with God, get back to who I was."),
    replies = { { text = ccb.content.text("Let's change the subject."), next_topic = "TALK_GODCO_Julian_2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_NoChat",
    line = ccb.content.text("I'd rather not talk about it."),
    replies = {
        {
            text = ccb.content.text("Yeah, I can understand.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Julian_Angry",
    line = ccb.content.text("&\"You've messed me over a good bit, and I've had enough.  Goodbye.\"  Julian goes back to his business and ignores you."),
    replies = { { text = ccb.content.text("See ya later <name_b>."), next_topic = "TALK_DONE" } },
}
