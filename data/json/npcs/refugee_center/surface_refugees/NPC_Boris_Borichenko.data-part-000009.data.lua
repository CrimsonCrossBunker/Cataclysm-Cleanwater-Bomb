local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_ReadLaptop1",
    line = ccb.content.text("It was difficult at first, but yes, I did.  It hurts, but it is good.  I am so proud of him.  Would you like to see some… some of what you brought me?"),
    replies = {
        {
            text = ccb.content.text("Sure, my friend.  I'd love to hear you brag about your boy."),
            next_topic = "TALK_REFUGEE_Boris_ReadLaptop2",
        },
        {
            text = ccb.content.text("That sounds a bit heavy for me right now, let's talk about something else"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Not today, I have to get going.  Just glad I was able to help."),
            next_topic = "TALK_DONE",
        },
    },
}

-- I would like a specialized effect here that reduces the 'guilty about killing' morale penalty while also adding a small morale penalty of its own.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_ReadLaptop2",
    line = {
        choices = {
            ccb.content.text("&Boris boots up the laptop and opens a folder labeled 'ART'.  He shows you simple digital paintings, clearly done by an adolescent.  There's nothing terribly remarkable about them except the number: Ash was a prolific creator.  Boris goes through several, proudly showing how his son learned little lighting tricks, or reminiscing on the time his son showed him the art.  After a while, he stops commenting and just continues quietly clicking through photos.  He seems different in the glow of the screen, like several years dropped away from his face, despite the deep sadness still etched there."),
            ccb.content.text("&Boris boots up the laptop and opens a folder labeled 'STORY 1'.  In it are numerous text files containing smatterings of stream-of-conscious notes, copy-and-pasted bits of fanfictions, notes about how to write a novel, and more.  The story itself is a handful of poorly fleshed out chapters written with the quality level you'd expect from a grade schooler.  Nonetheless it's quite impressive that there's this much stuff on a single topic.  Boris talks for a while about dinner conversations for weeks that would focus on Ash's ideas for his stories.  After a while, he trails off and just continues flipping through the files, reading silently."),
            ccb.content.text("&Boris boots up the laptop and opens the videos folder.  He shows you several self-made videos that follow a loose blog style, of an awkward young man talking about his favorite games, interspersed with comments about art and writing.  Boris comments on little events and laughs a few times, before becoming engrossed in his reminiscence."),
        },
    },
    replies = { { text = ccb.content.text("[Leave Boris alone for now.]"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Boris_Refuse_Boris_Mission_1",
    line = ccb.content.gendered_line("Have you had a problem with memory, friend?  I was the one who asked you this, I thought I explained why I could not.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Oh.  Right.  It's been a long apocalypse.  What were you saying?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Sorry.  I didn't notice which dialogue option I was selecting.  I'll just back away slowly now."),
            next_topic = "TALK_DONE",
        },
    },
}
