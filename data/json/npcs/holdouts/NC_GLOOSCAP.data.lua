local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Hunter with indigenous ancestry and big ideas.
ccb.content.define_npc {
    id = "ABENAKI_Glooscap",
    unique_name = ccb.content.text("Glooscap"),
    class = "NC_HUNTER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_GLOOSCAP",
    faction = "no_faction",
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_glooscap" } }),
        yes = {
            choices = {
                ccb.content.text("Good to see you again, how can I help you?"),
                ccb.content.gendered_line("They say I turned a man into a cedar tree once.  That's a terrible thing to say.", { "interlocutor" }),
                ccb.content.gendered_line("You like maple syrup?  That was me.  Not the syrup, that was the trees, but I figured out how to make it much harder to concentrate it, used to be way too easy.  Pretty nice right?", { "interlocutor" }),
                ccb.content.gendered_line("Did I tell you the one about the beavers?  Used to be way too big.  Like giant beavers, it was a mess.  I fixed that.  Of course there seem to be a bunch of new giant things out here now.  I'll have to think about that.", { "interlocutor" }),
                ccb.content.text("You know storms?  Used to be more.  Took me a lot of work, but there aren't as many now.  That was me, I did that.  Fewer storms, pretty good.  There's a big eagle, it's a long story really.  I'm good with rope though."),
            },
        },
        no = ccb.content.text("It's decided then.  I will be Glooscap.  Who will you be?"),
    },
    replies = {
        {
            text = ccb.content.text("Glooscap?  That's a funny name.  Is it foreign?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_glooscap" } })),
            next_topic = "TALK_GLOOSCAP_WHERE",
        },
        {
            text = ccb.content.text("[INT 11]  Like the Wabanaki myth?"),
            next_topic = "TALK_GLOOSCAP_MYTH",
            when = predicates.all({ predicates.minimum_attribute("speaker", "intelligence", 11), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_accused_malsumis" } })) }),
        },
        {
            text = ccb.content.text("So.  You're dressed like a hunter.  Are you a hunter?"),
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_glooscap" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_befriended_glooscap" } })) }),
            next_topic = "TALK_GLOOSCAP_HUNTER",
        },
        {
            text = ccb.content.text("Have you had any luck out there?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_befriended_glooscap" } }),
            native_actions = { "start_trade" },
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("Whatever, I don't have time for whatever this is.  Try not to get your face eaten I guess."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_WHERE",
    line = ccb.content.gendered_line("I'm used to it.  No, Glooscap has been a name here for a very long time.  Is your name foreign?", { "interlocutor" }),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_glooscap", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("No, my name has been a name here for a very long time too."),
            next_topic = "TALK_GLOOSCAP",
        },
        { text = ccb.content.text("No, I just made it up."), next_topic = "TALK_GLOOSCAP" },
        {
            text = ccb.content.text("Yes, I just got here.  What's happening?"),
            next_topic = "TALK_GLOOSCAP_HAPPENING",
        },
        {
            text = ccb.content.text("I don't know about names, let's talk about something more interesting."),
            next_topic = "TALK_GLOOSCAP",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_MYTH",
    line = ccb.content.text("You know the real people's stories?  Yes, a lot like that."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_glooscap", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("Cool, cool.  So you like myths and stuff?"),
            next_topic = "TALK_GLOOSCAP_MYTH_FAIL",
        },
        {
            text = ccb.content.text("[INT 14] Do you have a twin named Malsumis?"),
            next_topic = "TALK_GLOOSCAP_MYTH_SUCCESS",
            when = predicates.minimum_attribute("speaker", "intelligence", 14),
        },
        {
            text = ccb.content.text("Yes, I'm a very smart survivor of the apocalypse.  <end_talking_leave>  Later Glooscap."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_MYTH_FAIL",
    line = ccb.content.gendered_line("And stuff sure.  How can I help you stranger?  They say I'm the nice one.  See this smile?  Nice smile right?", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("[Offer Beer] I am extremely into your smile yes.  I have some drinks with me, want to have some?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "beer"),
        },
        {
            text = ccb.content.text("[Offer India Pale Ale] I am extremely into your smile yes.  I have some drinks with me, want to have some?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "india_pale_ale"),
        },
        {
            text = ccb.content.text("[Offer Cigarettes] I am extremely into your smile yes.  I have some cigarettes, want one with me?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "cig"),
        },
        {
            text = ccb.content.text("[Offer Joint] I am extremely into your smile yes.  I have something to smoke, want to have some with me?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "joint"),
        },
        {
            text = ccb.content.text("You seem cool but I don't have anything fun.  I'll try and find something and come back so we can share."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[PRETTY] That smile is very nice.  It makes me smile too."),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_trait("speaker", "PRETTY"),
        },
        {
            text = ccb.content.text("[GLORIOUS] Worship my beauty."),
            next_topic = "TALK_GLOOSCAP_WORSHIP",
            when = predicates.has_trait("speaker", "BEAUTIFUL3"),
        },
        {
            text = ccb.content.text("[TERRIFYING] Fear me!  I am disgusting!"),
            next_topic = "TALK_GLOOSCAP_FEAR",
            when = predicates.all({ predicates.has_trait("speaker", "TERRIFYING") }),
        },
        {
            text = ccb.content.text("[TERRIFYING] Destroy me!"),
            native_actions = { "insult_combat" },
            when = predicates.has_trait("speaker", "TERRIFYING"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[INT 14] Do you have a twin named Malsumis?"),
            next_topic = "TALK_GLOOSCAP_MYTH_SUCCESS",
            when = predicates.minimum_attribute("speaker", "intelligence", 14),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_MYTH_SUCCESS",
    line = ccb.content.gendered_line("I do have a twin.  Malsumis is probably around here somewhere, very tricky.  You know I turned Malsumis to stone once?  I'm supposed to be the nice one, but you know how much it hurts turning yourself back from stone?  It takes days.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("[INT 14] I'll look out then, thanks.  Of course if you were Malsumis you probably wouldn't admit it because no one likes Malsumis.  Who would your twin say you are?"),
            next_topic = "TALK_GLOOSCAP_MYTH_RIDDLE",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_asked_malsumis", "yes") },
        },
        {
            text = ccb.content.text("You know you're not really Glooscap right?  You're joking right?"),
            next_topic = "TALK_GLOOSCAP_JOKING",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_asked_malsumis", "yes") },
        },
        {
            text = ccb.content.text("Of course, that all makes as much sense as anything I guess.  So you have crazy supernatural powers then?  Can you stop whatever is happening and make it like before?"),
            next_topic = "TALK_GLOOSCAP_POWERS",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_asked_malsumis", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_MYTH_RIDDLE",
    line = ccb.content.text("I don't know what Malsumis would say, Malsumis is very tricky.  I always tell the truth, it's very boring."),
    replies = {
        {
            text = ccb.content.text("[INT 14] I think you're Malsumis.  Where is Glooscap?"),
            next_topic = "TALK_GLOOSCAP_MYTH_ACCUSE",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_accused_malsumis", "yes") },
        },
        {
            text = ccb.content.text("[INT 14] Yes, that all makes sense to me.  Forget I asked."),
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("I don't have time for this.  I have serious survival business to do.  I am a serious survival business person."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_MYTH_ACCUSE",
    line = ccb.content.gendered_line("If I were Malsumis you would be in terrible danger my friend.  But Glooscap would stop me.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Fight me Malsumis!"),
            native_actions = { "insult_combat" },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[SKILLED LIAR] Then you're definitely not Malsumis and everything is cool.  So Malsumis wants to kill everybody right?  I guess they're feeling pretty great right now huh?"),
            next_topic = "TALK_GLOOSCAP_MYTH_KILL_EVERYBODY",
            when = predicates.has_trait("speaker", "SKILLED LIAR"),
        },
        {
            text = ccb.content.text("Haha, good one Glooscap.  So funny.  Love that.  Let's move on."),
            next_topic = "TALK_GLOOSCAP",
        },
        { text = ccb.content.text("This is awkward.  I need to leave."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_MYTH_KILL_EVERYBODY",
    line = ccb.content.text("Maybe.  Is it worse to be unhappy with a goal or to be unhappy without a goal?  You're all right, I feel like we get each other."),
    replies = {
        {
            text = ccb.content.text("I feel the same way best friend."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_befriended_glooscap", "yes") },
            next_topic = "TALK_GLOOSCAP",
        },
        { text = ccb.content.text("No idea what you mean."), next_topic = "TALK_GLOOSCAP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_JOKING",
    line = ccb.content.text("Haha, right.  What would Glooscap be doing in the sunrise lands at the beginning of the fourth age?  That's silly.  I'm probably some Wabanaki that got hit on the head or something.  And who turns into a beaver?  Haha.  You got me.  Just a normal human made out of trees like the rest."),
    replies = {
        {
            text = ccb.content.text("No problem, a lot of people are going through some hard times right now.  Honestly, you're doing better than most.  You should follow me, I have a pretty good handle on reality."),
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_reality_checked_glooscap", "yes"),
            },
            next_topic = "TALK_SUGGEST_FOLLOW_GLOOSCAP",
        },
        {
            text = ccb.content.text("I'm not made out of trees, I'm made out of awesome.  Follow me and you will grow fat and rich."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_boasted_glooscap", "yes") },
            next_topic = "TALK_SUGGEST_FOLLOW_GLOOSCAP",
        },
        {
            text = ccb.content.text("You shouldn't follow me, but I guess I can't stop you."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_low_esteemed_glooscap", "yes") },
            next_topic = "TALK_SUGGEST_FOLLOW_GLOOSCAP",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_HAPPENING",
    line = ccb.content.text("Another world is going and a new world is coming.  I hope this new one is better than the last, a new golden age.  So far not great."),
    replies = {
        {
            text = ccb.content.text("Sure sure.  So are you on drugs?"),
            next_topic = "TALK_GLOOSCAP_DRUGS",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("Whatever, I don't have time for creepy stuff."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_SOCIAL",
    line = ccb.content.text("Yes, thank you for sharing with me.  So what are you doing here?  What are you trying to accomplish?"),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_meeting_u_befriended_glooscap", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm just trying to survive."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_befriended_glooscap", "yes") },
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("[INT 14] I'm trying to understand what happened and see if I can make something better happen."),
            when = predicates.minimum_attribute("speaker", "intelligence", 14),
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("I'm trying to become more powerful than whatever else is out there."),
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("I'm trying to make a survivor settlement.  You should join!"),
            next_topic = "TALK_SUGGEST_FOLLOW_GLOOSCAP",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SUGGEST_FOLLOW_GLOOSCAP",
    line = ccb.content.text("Maybe some day.  If you can survive for long enough I may decide to come and stay with you."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_DRUGS",
    line = ccb.content.text("Not enough given what's happening."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_FEAR",
    line = ccb.content.text("Whoah whoah, calm down.  Yikes.  Yeah fine, we're good.  Just stop trying to spook me, I don't like it."),
    replies = {
        {
            text = ccb.content.text("Yes, that worked great."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_befriended_glooscap", "yes") },
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("We are not good and I'm done talking to you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_HUNTER",
    line = ccb.content.text("Among other things, sure.  I have some extra I might be willing to trade, but I only trade with my friends and I don't have a lot of those left."),
    replies = {
        {
            text = ccb.content.text("[Offer Beer] I don't know about friends, but I have some drinks with me, want to have some?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "beer"),
        },
        {
            text = ccb.content.text("[Offer India Pale Ale] I don't know about friends, but I have some drinks with me, want to have some?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "india_pale_ale"),
        },
        {
            text = ccb.content.text("[Offer Cigarettes] I don't know about friends, but I have some cigarettes, want one with me?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "cig"),
        },
        {
            text = ccb.content.text("[Offer Joint] I don't know about friends, but I have something to smoke, want to have some with me?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_item("speaker", "joint"),
        },
        {
            text = ccb.content.text("You seem cool and I'd like to talk more but I don't have anything fun.  I'll try and find something and come back so we can share."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[PRETTY] I think we're going to be great friends, don't you agree?"),
            next_topic = "TALK_GLOOSCAP_SOCIAL",
            when = predicates.has_trait("speaker", "PRETTY"),
        },
        {
            text = ccb.content.text("[GLORIOUS] Worship my beauty."),
            next_topic = "TALK_GLOOSCAP_WORSHIP",
            when = predicates.has_trait("speaker", "BEAUTIFUL3"),
        },
        {
            text = ccb.content.text("[TERRIFYING] Fear me!  I am disgusting!"),
            next_topic = "TALK_GLOOSCAP_FEAR",
            when = predicates.all({ predicates.has_trait("speaker", "TERRIFYING") }),
        },
        {
            text = ccb.content.text("[TERRIFYING] Destroy me!"),
            native_actions = { "insult_combat" },
            when = predicates.has_trait("speaker", "TERRIFYING"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("[INT 14] Do you have a twin named Malsumis?"),
            next_topic = "TALK_GLOOSCAP_MYTH_SUCCESS",
            when = predicates.minimum_attribute("speaker", "intelligence", 14),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_WORSHIP",
    line = ccb.content.text("Whoah whoah, calm down.  Yikes.  Yeah fine, we're good.  Just stop making that face, it's too much for me.  Gives me feelings."),
    replies = {
        {
            text = ccb.content.text("Yes, that worked great."),
            actions = { actions.set_actor_value("speaker", "general_meeting_u_befriended_glooscap", "yes") },
            next_topic = "TALK_GLOOSCAP",
        },
        {
            text = ccb.content.text("We are not good and I'm done talking to you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GLOOSCAP_POWERS",
    line = ccb.content.text("I don't think so.  I'm pretty good at hunting though."),
    replies = {
        { text = ccb.content.text("I guess that's something."), next_topic = "TALK_GLOOSCAP" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
