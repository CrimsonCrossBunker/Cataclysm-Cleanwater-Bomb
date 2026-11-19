local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_HUNTER_2_STORY1",
    line = ccb.content.text("My brother and I were out on a hunting trip.  We saw helicopters overhead… big, military ones, loaded up with crazy high-end military stuff like you only see on TV.  Laser cannons even.  They were heading in the direction of our parent's ranch.  Something about it really shook us up, and we started heading back that way… we weren't that far off when we saw this huge, floating eyeball appear out of fucking nowhere.  Ha.  Hard to believe we're in a time where I don't feel like I need to convince you I'm telling the truth."),
    replies = {
        { text = ccb.content.text("What happened next?"), next_topic = "BGSS_HUNTER_2_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HUNTER_2_STORY2",
    line = ccb.content.text("We watched the eyeball just blast one of the Apache choppers with some kind of ray.  The chopper fired back, but it went down.  It was coming right for us… I veered, got out of the way, but a chunk of the chopper smacked into the bed and our truck did a crazy backflip right off the road.  The impact knocked me out cold.  My brother… he wasn't so lucky."),
    replies = {
        { text = ccb.content.text("Oh, no."), next_topic = "BGSS_HUNTER_2_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HUNTER_2_STORY3",
    line = ccb.content.gendered_line("Yeah… the… the accident got him, but when I came to he was already coming back.  Thank god for seatbelts, right?  He was screeching and flapping around, hanging upside down.  I thought he was just hurt at first, but he just kept coming at me while I tried to talk to him.  His arm was badly hurt already and instead of unbuckling himself he started… he was ripping it right off pulling against the seatbelt.  That, and the crazy shit with the chopper, was when I realized just how fucked up things had got.  I grabbed my hunting knife and ran, but my brother got out and started crawling after me.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Did you keep running?"), next_topic = "BGSS_HUNTER_2_STORY4" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HUNTER_2_STORY4",
    line = ccb.content.gendered_line("I ran for a little bit, but then I saw soldier zombies crawling out of that chopper.  They had the same look about them as my brother did, and it was them on one side and him on the other.  I'm no genius but I've seen a few movies: I figured out what was happening.  I didn't want to take on Kevlar armor with my knife, so I turned back and faced the other zombie.  I couldn't let my brother stay… like that.  So I did what I had to, and I guess I'll live with that forever.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Thanks for telling me your story.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
