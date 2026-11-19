local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_CONFUSED_1_STORY1",
    line = ccb.content.gendered_line("I don't even fucking know anymore.  I have no freaking idea what is going on.  I'm just doing what I can to stay alive.  The world ended and I bungled along not dying, until I met you.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Huh."), next_topic = "TALK_FRIEND_CONVERSATION" } },
}

ccb.content.define_dialogue_topic {
    id = "CWH_CONFUSED_1_IDEAS1",
    line = ccb.content.gendered_line("I barely understand what's going on *now*.  Why do you think I'd know how the world ended?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("OK, fine.  Can you at least tell me what you remember about the events leading up to now?"),
            next_topic = "CWH_CONFUSED_1_IDEAS2",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_nevermind>"),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "CWH_CONFUSED_1_IDEAS2",
    line = ccb.content.text("What, don't you remember?  No, sorry, that's not fair, it was a weird time.  OK, well, I guess this all started with the riots, didn't it?  We were just leading our lives, doing our jobs, and then people started rioting.  Not the usual protests that turned violent or anything, either, people just left their houses and started breaking shit.  The news tried to downplay it but they couldn't keep it off the internet.  I don't know what caused it, they said it was some kind of drug or toxin in the water?  Still, I didn't really realize how bad it was getting at first.  Somewhere along the way the \"rioters\" started getting up and walking around with holes in their chests, and that's when the real panic took over.  The next few days - or weeks, not really sure - are a blur to me.  You'd have to ask someone else how we got from there to total collapse."),
    replies = {
        {
            text = ccb.content.text("Thanks for filling me in."),
            next_topic = "TALK_FRIEND_CONVERSATION",
        },
    },
}
