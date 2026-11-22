local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("That sure is a shiny badge you got there!"),
        no = ccb.content.text("Heh, you look important."),
    },
    replies = {
        {
            text = ccb.content.text("I'm actually new."),
            next_topic = "TALK_ARSONIST_NEW",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_ARSONIST_DOING",
        },
        {
            text = ccb.content.text("Heard anything about the outside world?"),
            next_topic = "TALK_ARSONIST_WORLD",
        },
        {
            text = ccb.content.text("Is there any way I can join your group?"),
            next_topic = "TALK_ARSONIST_JOIN",
        },
        {
            text = ccb.content.text("Do you have any jobs for me?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("What's with your ears?"),
            next_topic = "TALK_ARSONIST_MUTATION",
            when = predicates.handler("dlg_p_dda_e3eb48cfc8df"),
        },
        {
            text = ccb.content.text("How are you doing these days?"),
            next_topic = "TALK_ARSONIST_TRADING",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "talk_flag_TALK_ARSONIST_SUPPLIED" } }),
        },
        {
            text = ccb.content.text("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_NEW",
    line = ccb.content.text("Guess that makes two of us.  Well, kind of.  I don't think we're open, though.  Full up as hell; it's almost a crowd downstairs.  Did you see the trader at the entrance?  There's the one to ask."),
    replies = { { text = ccb.content.text("Sucks…"), next_topic = "TALK_ARSONIST" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_DOING_REBAR",
    line = ccb.content.text("Well, there's a guy downstairs who got a working pneumatic cannon.  It shoots metal like… like a cannon without the bang.  Cost-efficient as hell.  And there's no shortage of improvised weapons you can make.  The big thing though, seems to be continuing construction of fortifications.  Very few of those monsters seem to be able to break through a fence or wall constructed with the stuff."),
    replies = { { text = ccb.content.text("Well, then…"), next_topic = "TALK_ARSONIST" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_WORLD",
    line = ccb.content.text("Nothing optimistic, at least.  Had a pal on the road with a ham radio, but she's gone and so is that thing.  Kaput."),
    replies = {
        { text = ccb.content.text("…"), next_topic = "TALK_ARSONIST" },
        {
            text = ccb.content.text("Nothing optimistic?"),
            next_topic = "TALK_ARSONIST_WORLD_OPTIMISTIC",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_WORLD_OPTIMISTIC",
    line = ccb.content.text("Most of the emergency camps have dissolved by now.  The cities are mobbed, the forests crawling with glowing eyes and zombies.  Some insane shit out there, and everyone with a radio seems to feel like documenting their last awful moments."),
    replies = { { text = ccb.content.text("I feel bad for asking."), next_topic = "TALK_ARSONIST" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ARSONIST_JOIN",
    line = ccb.content.text("I don't know.  I mean, if you can make yourself useful.  But that's become a real hazy thing nowadays.  It depends who you ask.  The merchant definitely doesn't want me here when I'm not selling, but… some people get away with it."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_ARSONIST" } },
}
