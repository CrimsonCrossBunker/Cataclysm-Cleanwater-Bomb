local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_WORKSPACE",
    line = ccb.content.text("It's just a fetch job, right?  I'd say our best first bet would be to see if Smokes up at the Free Merchant desk has one, and just shell out to get it covered.  These guys are broke as heck, but we can easily make the cash back by doing some good old fashioned scavenging."),
    replies = {
        {
            text = ccb.content.text("Worth checking.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_LAPTOP",
    line = ccb.content.text("&His voice comes out a bit softer and lower than usual.  \"This is just a sad one, my friend.  I don't think we'll have any troubles with the delivery, but it's so goddamn sad.\""),
    replies = {
        {
            text = ccb.content.text("You can say that again.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Dana_Sourdough",
    line = ccb.content.text("Nah, not me.  I hear they're hard to keep alive or something, and that makes me nervous.  I was never really that much of a baker to be honest.  I love the bread though, pretty excited to see what she makes.\"  He looks thoughtful for a moment.  \"Depending on where the bakery is though, this could be a heck of a job.  We should make sure we're ready to sneak past a lot of zed to get to it."),
    replies = {
        {
            text = ccb.content.text("Or we could clear the area some other way.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Draco_GET_GUITAR",
    line = ccb.content.text("*grins.  \"Yeah, he sure is.  I never got the hang of the guitar, myself, but I respect the journey.  It shouldn't be too hard to find one, right?  Lots of people have them in their houses, or we could maybe loot a music store if we want to get fancy.\""),
    replies = {
        {
            text = ccb.content.text("With your singing voice, I'm glad you never learned.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Fatima_1",
    line = ccb.content.text("Of course!  People need what comfort they can get, right?  I've always been kinda spiritual, but I'm not the sort to put a label on it or anything.  I don't have a clue where to find one though, I'm not sure I'd even recognize a mosque if I saw one.  Do they stock books like that in normal stores?\"  He frowns.  \"I feel like I should know this, but… well, no Wikipedia, right?"),
    replies = {
        {
            text = ccb.content.text("Cell phones were something else.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_PNEUMATICS",
    line = ccb.content.text("&He scratches his head.  \"No.  I guess a library or a bookstore.  I have a feeling this is going to be a tough one though.  Maybe we could try like, hardware stores?  Or school libraries?\"  He thinks a bit more.  \"Those seem like our best bets to me, but I'm just guessing.\""),
    replies = {
        {
            text = ccb.content.text("Thanks, man.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_MOTOR",
    line = ccb.content.text("This one sounds easy to me.  Let's just take apart some old machinery until we find a good one."),
    replies = {
        {
            text = ccb.content.text("Thanks, man.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
