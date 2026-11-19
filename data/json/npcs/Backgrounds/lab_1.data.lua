local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_LAB_1_STORY1",
    line = ccb.content.gendered_line("For me, this started a couple days before <the_cataclysm>.  I'm a biochemist.  I did my postdoc work with a brilliant colleague, Pat Dionne.  I hadn't talked to Pat in ages… word has it, the government got wind of our thesis, found out Pat did most of the heavy lifting, and that was the last we talked for years.  So, I was a bit surprised to see an e-mail from Pat.Dionne@FreeMailNow.co.ru… even more surprised when it was a series of nostalgic references to a D&D game we played years earlier.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I don't see where this is going."),
            next_topic = "BGSS_LAB_1_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LAB_1_STORY2",
    line = ccb.content.gendered_line("Well, the references weren't quite right.  Pat referred to things that we'd never played.  The situations were close, but not right, and when I put it all together, it told a story.  A story about a scholar whose kids were being held captive by a corrupt government, forced to research dark magic for them.  And there was a clincher: A warning that the magic had escaped, a warning that all heroes had to leave the kingdom before it fell.", { "interlocutor" }),
    replies = {
        { text = ccb.content.text("Okay…"), next_topic = "BGSS_LAB_1_STORY3" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_LAB_1_STORY3",
    line = ccb.content.gendered_line("Listen, I know it's incredibly cheesy.  That's D&D for you.  Anyway, something about the tone really got to me.  I knew it was important.  I wasted a little time waffling, then decided to use my outstanding vacation time and skip town for a while.  I packed for the end of the world.  Turns out, I packed the right stuff.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Was there anything else of use in that email?"),
            next_topic = "BGSS_LAB_1_DIONNE1",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

-- TK, give player the option to give this guy a copy of the Dionne report, in return for some special info about XE037… probably gated over time, giving the NPC a few days to read further.
ccb.content.define_dialogue_topic {
    id = "BGSS_LAB_1_DIONNE1",
    line = ccb.content.gendered_line("There was, yeah, but it was cryptic.  If I had a copy of Pat's notes, I could probably decipher it, but I'm sure those burned up in <the_cataclysm>.  They bombed those labs, you know.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
