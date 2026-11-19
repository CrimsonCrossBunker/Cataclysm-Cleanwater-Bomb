local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_3_STORY3_EARLY",
    line = ccb.content.gendered_line("Straight up hunger.  I didn't have any great light source down there, and I didn't have much food.  I was slipping up and down to the station to buy from the vending machines, but once I ran out of cash I had to make a break for it.  I waited until dark and then skipped out.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_3_STORY3_LATE",
    line = ccb.content.gendered_line("Straight up hunger.  I didn't have any great light source down there, and I didn't have much food.  I was slipping up and down to the station to buy from the vending machines, but once I ran out of cash I had to think of something else.  I started raiding the surrounding area by night, and built a decent little base under there.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I didn't meet you in the subway though.  You left."),
            next_topic = "BGSS_EVACUEE_3_STORY4",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_3_STORY4",
    line = ccb.content.gendered_line("Yeah.  I had it pretty good there, but eventually I just started going a bit nuts.  Always dark, a bit cold, living off scavenged junk food… a soul can only live like that for so long.  When the weather above ground got warmer and the daylight hours got longer I decided to get a bit braver.  I'd learned enough about the <zombies> that I was able to live pretty well after that.  I've camped a few places, scavenged berries and whatnot, lived a pretty good life compared to those first few months.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_3_IDEAS1",
    line = ccb.content.gendered_line("Woah, <name_g>, I don't even know where to start.  The riots?  I think it was going on sooner than that.  There were bad murmurs going on a few weeks before that happened.  Lots of really scary crimes, not your usual stuff but like cannibalism and some real unspeakable shit, you know?  When the riots started, I think I was already primed to think of it as something different from a normal equality riot or anything like that.  I think that's part of how I got out safer, I had had some time to get some stuff and get going, and didn't try to make shopping trips.  People were abso-fuckin-lutely crazy in those days.  It was a lot like the pandemic a few years back, except the police were out in the streets in force, gunning people down like it was going out of style.", { "interlocutor" }),
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
    line = ccb.content.text("Not really.  Government fed us all kinds of conflicting stories, and there was some absolutely heinous stuff going on.  I mean, you can't have missed that video of the woman killing her own baby, right?  God, that still gives me nightmares.  I don't know what it was about it, something about the look on her face.  Worse stuff came out of course, and now we've both seen worse things with our own eyes, but that one still comes back to haunt me.  Anyway, they never could control the riots, and by the time the rioters started turning into undead it was way too late.  I don't know if morale just broke or what but I heard rumors the military and police started turning on each other as much as the crowds.  What actually made the dead come back to life though?  I haven't got a clue."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
