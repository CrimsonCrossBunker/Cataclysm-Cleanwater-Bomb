local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_3",
    line = ccb.content.text("Oh you don't have time for all that, do you?  Well, I'll give you the short version.  I've gotten kinda tired of it in the telling.  Frankly, it's not as heroic, not as inspiring, not as tragic, and certainly not as funny as some of the tales around here.  But it's mine, ya know?  I'm a musician.  Guitar's my baby.  You like folk and the blues, friend?  Well, that was my bag and I sure could please my own ear with em, anyway.  Folks who's bein' generous might also say it pleased theirs.  Problem is, I seem to be between guitars right now, you know?  Temporarily guitar-light, if you get my saying.  Problem is, in the run for my life, I had to use old Jasmine as a bit of a billy club.  Had to curb some rowdy dudes on my way here.  It was her or me, you understand?  You wouldn't begrudge a man breakin' his instrument to save his life, would ya?"),
    replies = {
        {
            text = ccb.content.text("I think I would've done the same.  Nobody around here has a guitar?"),
            next_topic = "TALK_REFUGEE_Draco_4",
        },
        { text = ccb.content.text("Yes, yes I would… you monster."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_4",
    line = ccb.content.text("Would you believe that they don't!  Not a one in the whole place.  Well, maybe downstairs, but that's a different matter, isn't it?  Say, you're not planning on sticking around, right?  You're a free-roller, not a settler, seems like to me.  Don't know if I could beg or cajole you into maybe keepin' an ear out for a new guitar for me?  There gotta still be plenty out there not gettin' any love these days.  Whattya say?  Help an old man play some blues?  Would be good to have some real music around this place.  Be good for PEOPLE, you know what I'm sayin'?"),
    replies = {
        {
            text = ccb.content.text("Where would we be without music?"),
            next_topic = "TALK_REFUGEE_Draco_5a",
        },
        {
            text = ccb.content.text("You're aware that the world has ended, right?  I've got real problems to deal with.  You're on your own."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_5a",
    line = ccb.content.text("Let me ask you something.  What type are you?"),
    replies = {
        { text = ccb.content.text("Uhh, what do you mean?"), next_topic = "TALK_REFUGEE_Draco_5b" },
        {
            text = ccb.content.text("I'll tell you what type I am."),
            next_topic = "TALK_REFUGEE_Draco_5c",
        },
        { text = ccb.content.text("No, not playing this game."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_5b",
    line = ccb.content.text("You know, what kinda person are you?  What motivates you?"),
    replies = {
        {
            text = ccb.content.text("I'll tell you what type I am."),
            next_topic = "TALK_REFUGEE_Draco_5c",
        },
        { text = ccb.content.text("Leaving."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_5c",
    line = ccb.content.text("So then, what type are you?"),
    replies = {
        {
            text = ccb.content.text("The 'just getting by' type."),
            next_topic = "TALK_REFUGEE_Draco_6a",
        },
        { text = ccb.content.text("The serious type."), next_topic = "TALK_REFUGEE_Draco_6b" },
        { text = ccb.content.text("The zany type."), next_topic = "TALK_REFUGEE_Draco_6c" },
        { text = ccb.content.text("I fight stuff."), next_topic = "TALK_REFUGEE_Draco_6d" },
        { text = ccb.content.text("I want to see it all."), next_topic = "TALK_REFUGEE_Draco_6e" },
        {
            text = ccb.content.text("The 'doesn't have time for this' type."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_6a",
    line = ccb.content.text("Me too!  You can understand how folks be wantin' some liveliness in these times.  Some music sure would help with that.  Damn, I miss it.  All I hear is those MP3 players with their tin-can drum machines and whiny vocals.  Help me find a guitar and we'll really get this place smokin'!"),
    replies = {
        { text = ccb.content.text("I could be persuaded."), next_topic = "TALK_REFUGEE_Draco_7" },
        {
            text = ccb.content.text("It's called dub-step and I like it.  Goodbye, old man."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_6b",
    line = ccb.content.text("Me too!  Times are hard for folks and that's no laughing matter.  People need some normality in these times.  Some reminders of how things used to be.  I think a sing-along or two could do folks good."),
    replies = {
        { text = ccb.content.text("Couldn't hurt."), next_topic = "TALK_REFUGEE_Draco_7" },
        {
            text = ccb.content.text("I don't need to hear amateur-hour karaoke around here.  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_6c",
    line = ccb.content.text("Me too!  I did stand-up comedy at a club once.  Well, outside a club anyway.  You know what'd be funny?  Next time one of those stupid ferals starts running around chasing after a squirrel or something, if I had me a guitar I could play the Benny Hill tune and get everybody crackin' up.  Places needs some laughter badly."),
    replies = {
        { text = ccb.content.text("That'd be awesome."), next_topic = "TALK_REFUGEE_Draco_7" },
        {
            text = ccb.content.text("Yeah, wouldn't be so funny when Zed heard all the sound and broke in.  Be responsible."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_6d",
    line = ccb.content.text("Me too.  It's fight a stay afloat in these times.  Some music would lift all spirits, though, don't you think?"),
    replies = {
        {
            text = ccb.content.text("Can you play heavy metal on an acoustic guitar?"),
            next_topic = "TALK_REFUGEE_Draco_7",
        },
        {
            text = ccb.content.text("Boring.  I'm going to go destroy something."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Draco_6e",
    line = ccb.content.text("Me too!  For now, anyway, that's not really possible for me.  I mean, I guess you know better than me about that.  Man, I used to travel all around.  Saw halfa the States with my guitar on my back.  Now, though, well, I think I'll stay inside til this all flies over."),
    replies = {
        {
            text = ccb.content.text("Maybe I could help with something?"),
            next_topic = "TALK_REFUGEE_Draco_7",
        },
        {
            text = ccb.content.text("Well then, I'll leave you here where it's safe."),
            next_topic = "TALK_DONE",
        },
    },
}
