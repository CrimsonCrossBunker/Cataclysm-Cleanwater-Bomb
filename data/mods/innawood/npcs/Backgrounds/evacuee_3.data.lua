local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_3_STORY1",
    line = ccb.content.text("There's nothing too special about me, I'm not sure why I survived.  I was traveling with a handful of others, but we were too late to make the second trip to the main group of survivors.  We got attacked by the dead… I was the only one to make it out.  I never looked back."),
    replies = {
        {
            text = ccb.content.text("How did you survive after that?"),
            next_topic = "BGSS_EVACUEE_3_STORY2",
            when = predicates.handler("dlg_p_innawood_c0c4514d741e"),
            actions = { actions.add_effect("interlocutor", "BGSS_EVACUEE_3_earlymeeting", { permanent = true }) },
        },
        {
            text = ccb.content.text("How did you survive after that?"),
            next_topic = "BGSS_EVACUEE_3_STORY2",
            when = predicates.handler("dlg_p_innawood_e56eebad836d"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text("<end_talking>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_3_STORY2",
    line = ccb.content.text("Sheer luck I guess.  I got lost in the woods and lived off of whatever nuts and berries I found.  Not as many things are poisonous as I thought."),
    replies = {
        {
            text = ccb.content.text("What got you out of the woods?"),
            when = predicates.negate(predicates.has_effect("interlocutor", "BGSS_EVACUEE_3_earlymeeting")),
            next_topic = "BGSS_EVACUEE_3_STORY3_LATE",
        },
        {
            text = ccb.content.text("What got you out of the woods?"),
            when = predicates.has_effect("interlocutor", "BGSS_EVACUEE_3_earlymeeting"),
            next_topic = "BGSS_EVACUEE_3_STORY3_EARLY",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_3_STORY3_EARLY",
    line = ccb.content.text("Straight up hunger.  I didn't find much food.  I was starting to feel pretty off.  Eventually I found my way here."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_3_STORY3_LATE",
    line = ccb.content.text("Straight up hunger.  I didn't find much food.  I was starting to feel pretty off.  I finally stumbled into a river and built a decent little base there, figured out some basic survival stuff like making a fire and some light fishing with a sharpened stick."),
    replies = {
        {
            text = ccb.content.text("I didn't meet you at the river though.  You left."),
            next_topic = "BGSS_EVACUEE_3_STORY4",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_3_STORY4",
    line = ccb.content.text("Yeah.  I had it pretty good there, but eventually I just started going a bit nuts.  Those geese are vicious neighbors.  So I moved on.  I've camped a few places, scavenged berries and whatnot, lived a pretty good life compared to those first few months."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_3_IDEAS1",
    line = ccb.content.text("Woah, <name_g>, I don't even know where to start.  The riots?  I think it was going on sooner than that.  There were bad murmurs going on a few weeks before that happened.  Lots of really scary crimes, not your usual stuff but like cannibalism and some real unspeakable shit, you know?  When the riots started, I think I was already primed to think of it as something different from a normal equality riot or anything like that.  I think that's part of how I got out safer, I had had some time to get some stuff and get going.  People were abso-fuckin-lutely crazy in those days.  It was a lot like the pandemic a few years back, except for all of the gruesome violence everywhere."),
    replies = {
        {
            text = ccb.content.text("Do you have any idea what the actual cause was?"),
            next_topic = "CWH_EVACUEE_3_IDEAS2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_3_IDEAS2",
    line = ccb.content.text("Not really.  The leadership fed us all kinds of conflicting stories, and there was some absolutely heinous stuff going on.  God, I still have nightmares.  I saw this one woman eat her own baby.  I don't know what it was about it, something about the look on her face.  Now we've both seen worse things with our own eyes, but that one still comes back to haunt me.  Anyway, they never could control the riots, and by the time the rioters started turning into undead it was way too late.  I don't know if morale just broke or what but I heard rumors it just became a free for all bloodletting.  What actually made the dead come back to life though?  I haven't got a clue."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
