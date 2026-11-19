local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_BURGER_FLIPPER_1_STORY1",
    line = ccb.content.gendered_line("Before this started, I had a crappy job flipping burgers at Sambal's Grille.  Losing that isn't a big deal.  Losing my mom and dad hurts a lot more.  Last time I saw them alive, I just came home from school, grabbed a snack and went to work.  I don't think I even told my mom I loved her, and I was pissed at my dad for some dumb shit that really doesn't matter.  Didn't matter then, really doesn't now.  Things started going crazy while I was at work… the military rolled into town, and the evacuation alert sounded.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("So, did you evacuate?"),
            next_topic = "BGSS_BURGER_FLIPPER_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_BURGER_FLIPPER_1_STORY2",
    line = ccb.content.gendered_line("I didn't evacuate.  I went home… saw some freaky shit on the way, but at the time I just thought it was riots or drugs.  By the time I got there, my parents were gone.  No sign of them.  There was a big mess, stuff scattered everywhere like there'd been a struggle, and a little blood on the floor.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("So, did you evacuate then?"),
            next_topic = "BGSS_BURGER_FLIPPER_1_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_BURGER_FLIPPER_1_STORY3",
    line = ccb.content.gendered_line("I haven't found them yet.  Whenever I see a <zombie>, a little part of me is afraid it's going to be one of them.  But then, maybe not.  Maybe they were evacuated, maybe they fought and tried to wait for me but the military took them anyway?  I've heard that sort of thing happened.  I don't know if I'll ever know.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
