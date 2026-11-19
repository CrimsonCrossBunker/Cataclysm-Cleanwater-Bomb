local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Arturo_Firstmeet",
    line = ccb.content.gendered_line("Yeah, just that I sometimes see things.  I wanna be sure you're real.", { "speaker" }),
    replies = {
        { text = ccb.content.text("It's alright, just take your time."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Arturo_2",
    line = ccb.content.text("What's hangin'?"),
    replies = { { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Arturo_Story",
    line = ccb.content.text("I've had a bad run of things.  I grew up real poor, in a bad part of town, always got my nose where it shouldn't have been.  When I was about eighteen, I started doing coke heavily.  Every two days, I'd get spaced out on the stuff; started robbing gas stations and dumb <freaking> things like that for a fix.  I went to jail, and I met the New England Church Community there.  I joined up to find penance for my sins.  Another thing, stay off of that <freaking> stuff; I messed up my brain real bad doin' that."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Arturo_2",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Arturo_Mood",
    line = ccb.content.text("They're not so hot.  The whole compound is always low on food, there's <freaking> <zombies> out on the roads, and Helena's starting to panic a bit.  She thinks I'm a holy visionary, with my episodes…  Sometimes I want to believe her.  I usually take the Thorazine Jane has, but I've been getting it less and less."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Arturo_2",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Arturo_Community",
    line = ccb.content.text("Well, its an old church group that decided to become doomsday preppers.  I don't know much else, except that they used to do a lot of charity work.  I met them that way."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Arturo_2",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Arturo_Recruit",
    line = ccb.content.text("Nah.  Not everything's perfect around here, but it's the only thing I've got left."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Arturo_2",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Arturo_Hallucinations",
    line = ccb.content.text("&Arturo stares blankly for a moment.  \"The man in the mirror comes to me at night, and whispers things in my ear.  Eyes on the walls, watching, watching…  The woman who crawls.  I'm sorry about that.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_GODCO_Arturo_2",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Arturo_U_Mutant",
    line = ccb.content.gendered_line("I see things sometimes, and there's no way anyone could look like you!  I know you're not real, and if you are, stay away you ugly <name_b>!", { "speaker" }),
    replies = { { text = ccb.content.text("Chill out man, I'm leaving."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Arturo_Angry",
    line = ccb.content.text("&\"I'd be a lot better if you'd go away, I'm not up for talking right now.\"  Arturo turns back his activities, ignoring you."),
    replies = {
        {
            text = ccb.content.text("Fine then, <name_b>, I'll see you later."),
            next_topic = "TALK_DONE",
        },
    },
}
