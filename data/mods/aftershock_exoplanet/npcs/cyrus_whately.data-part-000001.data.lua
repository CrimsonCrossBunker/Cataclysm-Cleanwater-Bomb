local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_firstmeet",
    line = ccb.content.text("Are you here because you are morally flexible and willing to take questionable directions from obviously insane people."),
    replies = {
        {
            text = ccb.content.text("Your niece is looking for you."),
            next_topic = "TALK_CYRUS_millyficent",
        },
        {
            text = ccb.content.text("How did you survive the Cataclysm?"),
            next_topic = "TALK_CYRUS_cataclysm",
        },
        { text = ccb.content.text("Quite the setup you have here."), next_topic = "TALK_CYRUS_1" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_place",
    line = ccb.content.text("This is a Whately family property.  And you are an intruder."),
    replies = {
        { text = ccb.content.text("I've met your niece."), next_topic = "TALK_CYRUS_millyficent" },
        { text = ccb.content.text("I didn't mean to intrude."), next_topic = "TALK_CYRUS_1" },
        { text = ccb.content.text("I think there's been a mistake."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_millyficent",
    line = ccb.content.text("She's always been so precocious!  I knew that she was going places and we'd see great things from her."),
    replies = {
        {
            text = ccb.content.text("She needed a lab assistant, do you?"),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("This whole family is deranged."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_ask_past",
    line = ccb.content.text("The Whately family has been part of the fabric of New England since before the Revolutionary War.  And I have been growing our interests for the last few decades."),
    replies = { { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_CYRUS_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_cataclysm",
    line = ccb.content.text("*muttering.  \"They whispered of a prison.  Ragnarok engine humming.  Wrapped they in darkness dreaming.\"  He shakes himself.  \"Anyway it looks like something woke up, for at least a little bit.\""),
    replies = { { text = ccb.content.text("Let's talk about something else."), next_topic = "TALK_CYRUS_1" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CYRUS_ask_mood",
    line = ccb.content.text("This is a time of great danger and great opportunity and it must not be squandered."),
    replies = { { text = ccb.content.text("This is not reassuring."), next_topic = "TALK_CYRUS_1" } },
}
