local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Story",
    line = ccb.content.text("Who cares what's up with me?  You're the new one here.  Let me put it another way: what have you seen out there?  I'm talking about the monsters that lurk deep in the woods.  Have you witnessed them with your very own eyes?"),
    replies = {
        {
            text = ccb.content.text("I wouldn't be here if I saw one.  Why do you ask?"),
            next_topic = "TALK_GODCO_Russell_Trophy",
        },
        {
            text = ccb.content.text("I've seen too many things out there.  Why do you ask?"),
            next_topic = "TALK_GODCO_Russell_Trophy",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_StoryB",
    line = ccb.content.text("I won't let you leave just yet.  You're the new one here, I have so much to ask.  Let me put it another way: what have you seen out there?  I'm talking about the monsters that lurk deep in the woods.  Have you witnessed them with your very own eyes?"),
    replies = {
        {
            text = ccb.content.text("I wouldn't be here if I saw one.  Why do you ask?"),
            next_topic = "TALK_GODCO_Russell_Trophy",
        },
        {
            text = ccb.content.text("I've seen too much out there.  Why do you ask?"),
            next_topic = "TALK_GODCO_Russell_Trophy",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_Trophy",
    line = ccb.content.text("Well, let's just say I'm interested in rare game.  I've heard stories, rumors and some tall tales about otherworldly beings out there in the wasteland.  That's where you come in.  I want to see the evidence, something physical I can collect as a trophy collection.  You seem to have experience, I was hoping you could help me."),
    replies = {
        {
            text = ccb.content.text("Let's talk about getting you those trophies."),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("Go and hunt them yourself.  You have a gun after all."),
            next_topic = "TALK_GODCO_Russell_Trophy3",
        },
        {
            text = ccb.content.text("I've got other things to deal with.  Do you really need these trophies?"),
            next_topic = "TALK_GODCO_Russell_Trophy2",
        },
        {
            text = ccb.content.text("I can help.  Anyway, how are things?"),
            next_topic = "TALK_GODCO_Russell_2",
        },
        { text = ccb.content.text("Find somebody else, dude."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Russell_2",
    line = ccb.content.text("I've been better.  Having a hellish time keeping up with strange wildlife that suddenly want us dead… hey, let's forget the world while we're talking.  How's life treatin' ya?"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
