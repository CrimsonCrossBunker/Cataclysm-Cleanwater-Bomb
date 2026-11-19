local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_5",
    line = ccb.content.text("Compared to what we've done, this doesn't sound so bad.  Creepy as heck though.  We should tell ghost stories on the way."),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_1",
    line = ccb.content.text("I mean, I have a basic understanding of the principles.  We could also see if we could just find a couple stills though, we're not far from the mountains.  I bet every second farm's gonna have a moonshine still set up in one of the sheds."),
    replies = {
        {
            text = ccb.content.text("Good point, although really, how hard can it be to make one?  I'd like your opinion on something else, too."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_2",
    line = ccb.content.text("I think a supermarket might be the *yeast* likely place to find it!\"  He watches your expression for a moment, then shrugs.  \"Worth a shot.  Anyway, as far as I know, dry yeast lasts practically forever.  Should be able to find some of it anywhere people did baking or brewing."),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_3",
    line = ccb.content.text("Those Tacoma folks really think about sustainability, hey?  I like that.  Buy local, you know?  I got no idea where to find sugar beet seeds though.  I don't remember having any stocked at the cabin.  Maybe a farm or farm supply store would have them?"),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_4",
    line = ccb.content.text("*laughs.  \"If we track these things down for the bartender, I hope we get a nice, sincere 'tanks' at the end.\""),
    replies = {
        {
            text = ccb.content.text("Me too.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_5",
    line = ccb.content.text("There's only one way for two folks like us to transport two huge liquid storage drums.  We bundle ourselves in them and roll them down the hill.  First one to the bar buys the other one a drink."),
    replies = {
        {
            text = ccb.content.text("You know it'd be me.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Alonso_pants",
    line = ccb.content.text("Of all the jobs we've agreed to do, this is certainly one of them."),
    replies = {
        {
            text = ccb.content.text("You can say that again.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
