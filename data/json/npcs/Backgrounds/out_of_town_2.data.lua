local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_OUT_OF_TOWN_2_STORY1",
    line = ccb.content.gendered_line("I was out on a fishing trip with my friend when it happened.  I don't know exactly how the days line up… our first clue that Armageddon had come was when we got blasted by some kind of poison wind, with a sort of acid mist in it that burnt our eyes and skin.  We weren't sure what to make of it so we went inside to rest up, and while we were in there a weird dust settled over everything.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("What happened after the acid mist?"),
            next_topic = "BGSS_OUT_OF_TOWN_2_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_OUT_OF_TOWN_2_STORY2",
    line = ccb.content.text("By morning, the area around the lake was covered in a pinkish mold, and there were walking mushrooms around shooting clouds of the dust in the air.  We didn't know what was going on, but neither of us wanted to stay and find out.  We packed up our shit, scraped off the boat, and took off upriver."),
    replies = {
        {
            text = ccb.content.text("What happened to your friend?"),
            next_topic = "BGSS_OUT_OF_TOWN_2_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_OUT_OF_TOWN_2_STORY3",
    line = ccb.content.gendered_line("She took sick a few hours after we left the lake.  Puking, complaining about her joints hurting.  I took us to a little shop I knew about on the riverside, hoping they might have something to help or at least know what was going on.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I guess they didn't know."),
            next_topic = "BGSS_OUT_OF_TOWN_2_STORY4",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_OUT_OF_TOWN_2_STORY4",
    line = ccb.content.gendered_line("The shop was empty, actually.  She was desperate though, so I broke in.  I found out more about the chaos in towns from the store radio.  Got my friend some painkillers and Gravol, but when I came out to the boat, well… it was too late for her.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("She was dead?"), next_topic = "BGSS_OUT_OF_TOWN_2_STORY5" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

-- In the future this NPC might give you the coordinates of his friend where you can go take down a fungal grove of some kind.
ccb.content.define_dialogue_topic {
    id = "BGSS_OUT_OF_TOWN_2_STORY5",
    line = ccb.content.gendered_line("I wish.  That would have been a mercy.  She was letting out an awful, choking scream, and her body was shredding itself apart.  Mushrooms were busting out of every part of her.  I… I ran.  Now I wish that I'd put her out of her misery, but going back there now would be suicide.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("That's awful.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text("That's awful.  <end_talking>"), next_topic = "TALK_DONE" },
    },
}
