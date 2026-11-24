local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "BGSS_WEDDING_1_STORY2",
    line = ccb.content.text("Yeah, in hindsight it maybe wasn't the best choice of dates, huh?  I admit I had cold feet though.  Anyway I was running late after partying pretty hard and saw some corpses had gotten up and started harassing the party while they were waiting."),
    replies = {
        { text = ccb.content.text("What did you do next?"), next_topic = "BGSS_WEDDING_1_STORY3" },
        {
            text = ccb.content.text("You seem surprisingly calm about all this."),
            next_topic = "BGSS_WEDDING_1_CALM",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_WEDDING_1_STORY3",
    line = ccb.content.text("After I saw what was going on, I just turned around and headed out in the opposite direction.  I know a bad situation when I see it.  I grabbed a few things and headed out into the woods before things went really bad.  At the time I thought I was being a coward, but now I know if I'd stayed to help, I'd just be another dripping corpse."),
    replies = {
        {
            text = ccb.content.text("You seem surprisingly calm about all this."),
            next_topic = "BGSS_WEDDING_1_CALM",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

-- Some day it would be nice to have a demographically selected chance of this not being heteronormative
ccb.content.define_dialogue_topic {
    id = "BGSS_WEDDING_1_CALM",
    line = {
        when = predicates.actor_state("interlocutor", "female"),
        yes = ccb.content.text("Well, I have this weird hope.  It's probably stupid, but I saw my fiancé run out of there with his sister - my maid of honor - as things went bad.  So, until I run into them again one way or another, I'm just gonna keep on believing they're out there, doing well.  That's more than most of us have."),
        no = ccb.content.text("Well, I have this weird hope.  It's probably stupid, but I saw my fiancée run out of there with her brother - my best man - as things went bad.  So, until I run into them again one way or another, I'm just gonna keep on believing they're out there, doing well.  That's more than most of us have."),
    },
    replies = {
        { text = ccb.content.text("What were you saying before that?"), next_topic = "TALK_NONE" },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_WEDDING_1_IDEAS1",
    line = ccb.content.text("I'll be honest with you, I was paying more attention to wedding planning than current events leading up to things.  I knew there were riots going on, but they weren't nearby.  Even when they got closer to home, I tried to ignore them so we could have our big day.  After the zombies started coming, though, well that's when stuff got really weird.  When I was running from the wedding I swear I saw the sky rip open and monsters fly out of the hole, like a dream.  I don't know what it all was, it looked like black magic or something."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
