local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Interval",
    line = {
        choices = {
            ccb.content.text("I'm afraid I haven't gone out there for a while, maybe come back after <restock_time_point>.  These are all I have, care to take a look?"),
            ccb.content.text("Sorry these are all I have.  However I'll be back from my next run after <restock_time_point>.  Care to take a look in the meanwhile?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Alright, I'll take a look."),
            native_actions = { "start_trade" },
            next_topic = "TALK_GODCO_Kostas_1",
        },
        {
            text = ccb.content.text("Alright, thanks for informing me.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_2",
    line = ccb.content.text("What can I do for you, <name_g>?"),
    replies = {
        {
            text = ccb.content.text("Are there any jobs I could do?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Story",
    line = ccb.content.text("My story?  I'm afraid it's not as gripping as the other tales around here.  My father was an herbalist, my grandfather was an herbalist and - as ancestral pressure would have it - I also became an herbalist.  I studied from the best teachers and, through the years, a generation's knowledge passed on to me.  I've spent a good portion of my life warning others of the fakery that is plastic medicine and helping them rediscover the forgotten beauty that lies in our surroundings.  I joined the New England Church Community to express my gratitude towards the benevolence of nature.  This is where it brought me."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Mood",
    line = ccb.content.text("It's been quiet and peaceful.  Nature is recovering, and so are we.  There's something bittersweet about <the_cataclysm>, isn't there?  Our species was on the path of destruction, but Mother Nature spared us.  A sign of mercy for a creature that did not deserve it."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Kostas_Task",
    line = ccb.content.text("You must be new to herbalism, no?  In short, I scavenge the land for herbs to supply our humble community with medicine.  And that's just one part of my job.  Say, are you interested in buying campsite gear?  I came across an abandoned camp while foraging.  One can only wonder what happened to its poor inhabitants…"),
    replies = {
        {
            text = ccb.content.text("Care to share your knowledge about herbalism?"),
            next_topic = "TALK_GODCO_Kostas_Herbalism",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
