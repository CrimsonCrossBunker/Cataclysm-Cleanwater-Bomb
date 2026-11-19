local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_HUNTER_1_STORY1",
    line = ccb.content.gendered_line("I live way out of town.  I hear the small towns lasted a bit longer than the big cities.  Doesn't matter to me, I was out on my end-of-winter hunting trip, I'd been out of town for a week already.  First clue I had things were going wrong was when I saw a mushroom cloud out near an old abandoned military base, way out in the middle of nowhere.  I didn't think much about that.  Then I was attacked by a demon.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("A demon?"), next_topic = "BGSS_HUNTER_1_STORY2" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_HUNTER_1_STORY2",
    line = ccb.content.gendered_line("Yeah, it was like a… like a soft shelled crab, with tentacle mouths, and it kept talking in different voices.  I saw it before it saw me, and I capped it with my Remington.  That just pissed it off, but I got another couple shots off while it charged me.  Third or fourth shot took it down.  I figured out shit had hit the fan, somehow.  Headed to my cabin and camped out there for a while, but I had to skip out when a bunch of <zombies> showed up and trashed the place.  I ran into you not much later.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
    },
}
