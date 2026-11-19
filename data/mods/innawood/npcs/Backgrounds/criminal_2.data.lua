local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_CRIMINAL_2_STORY1",
    line = ccb.content.text("I was fricking lucky for <the_cataclysm>.  I was squatting in a little canoe by the river.  I was in a real shitty place, and my crew had mostly just been arrested for trespassing, but I had skipped out.  I was scared they were gonna think I ratted 'em out and come get me, but hey, no worries about that now."),
    replies = {
        {
            text = ccb.content.text("Woah, lucky for you.  How did you find out about <the_cataclysm>?"),
            next_topic = "BGSS_CRIMINAL_2_STORY2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CRIMINAL_2_STORY2",
    line = ccb.content.text("I was just in a canoe, not in Zambonia.  I could see and hear.  Scared the shit out of me.  I had it pretty good though, I'd lifted a bunch of dried food and shit, and I had a pretty sweet little squat in that canoe.  I'd been planning on spending a long time there after all, while I figured out how to get in good with my crew."),
    replies = {
        {
            text = ccb.content.text("Something must have driven you out of there."),
            next_topic = "BGSS_CRIMINAL_2_STORY3",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CRIMINAL_2_STORY3",
    line = ccb.content.text("Yeah.  Giant dragonflies.  A bunch of them, some of them I'm pretty sure were fuckin', I shit you not.  I dunno what brought them way out my way but they saw me takin' a piss and that was that.  I took a few shots at them but they didn't stop, so I ran.  Once I got my shit together again I realized it wasn't so bad, I was running out of stuff anyway.  Been livin' on what I can grab ever since, until I fell in with you."),
    replies = {
        {
            text = ccb.content.text("Got any tips about the dragonflies?"),
            next_topic = "BGSS_CRIMINAL_2_NECROMANCER",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_CRIMINAL_2_NECROMANCER",
    line = ccb.content.text("Well, I mean, I think I just didn't have the firepower.  A pistol shot isn't much, but something bigger might stop them."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
