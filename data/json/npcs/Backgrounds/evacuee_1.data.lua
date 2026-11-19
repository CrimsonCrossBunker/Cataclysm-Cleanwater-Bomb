local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_1_STORY3",
    line = ccb.content.gendered_line("Not exactly.  After a while, I got brave.  I started venturing towards the outskirts of town, picking off zombies here and there.  I learned about traveling in at night to avoid all but those <freaking> shadow-zombies, and that got me pretty far.  Eventually I cleared out a cozy little nook for myself and started really feeling comfortable.  I guess I got a bit complacent.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Complacent?"), next_topic = "BGSS_EVACUEE_1_STORY4" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_EVACUEE_1_STORY4",
    line = ccb.content.gendered_line("I thought I had those damned <zombies> figured out.  I got braver, started heading out by day more and more.  One of those screamer zombies spotted me and called in a horde, with a giant <freaking> beastie at the head of it, the size of a Volkswagen and all covered in bone plates.  I know when I'm outclassed.  The big guy was held back by his own horde of buddies, and I managed to book it back to my place.  I closed the windows, locked it down, but it was too late.  The giant followed me and just started hammering right through the walls.  I grabbed what I could and made for the horizon.  Last I saw of my squat, it was collapsing on the bastard.  For all I know, it died in the crash, but I am not going back to find out.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_EVACUEE_1_IDEAS1",
    line = ccb.content.gendered_line("What happened?  I'm not really sure.  You must know about the riots and all that, that the government and the police totally failed to contain.  I don't have a good guess what caused that.  I thought it was the usual stuff at first, and I gotta admit, I was sort of excited and scared it was the start of a revolution.  Not excited enough to join in though, and I guess anyone who was is probably dead now.  I tried to wait it out at home, packed a little bug-out bag, but then the internet started showing videos of rioters getting back up and fighting with crazy injuries.  I don't know how many people really believed it at first, but I took that as my sign and ditched town for the evac shelter.  I don't know exactly what happened after that.  The center I was in was heavily vandalized and empty, and I never saw anyone else.  The cell phone grid was locked up, except for one emergency message that came through around a day later saying the government had fallen.  Power went out a few days later.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
