local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD1_PLACE",
    line = ccb.content.text("This is a refugee center that we've made into a sort of trading hub."),
    replies = {
        {
            text = ccb.content.text("So are you with the government or something?"),
            next_topic = "TALK_EVAC_GUARD1_GOVERNMENT",
        },
        { text = ccb.content.text("What do you trade?"), next_topic = "TALK_EVAC_GUARD1_TRADE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD1_GOVERNMENT",
    line = ccb.content.text("Ha ha ha, no.  Though there is Old Guard somewhere around here if you have any questions relating to what the government is up to."),
    replies = {
        { text = ccb.content.text("Oh, okay."), next_topic = "TALK_EVAC_GUARD1" },
        { text = ccb.content.text("Oh, okay.  I'll go look for him."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD1_TRADE",
    line = ccb.content.text("Anything valuable really.  If you really want to know, go ask one of the actual traders.  I'm just protection."),
    replies = {
        { text = ccb.content.text("I'll go talk to them later."), next_topic = "TALK_EVAC_GUARD1" },
        { text = ccb.content.text("Will do, thanks!"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD1_JOIN",
    line = ccb.content.text("Nope."),
    replies = { { text = ccb.content.text("That's pretty blunt!"), next_topic = "TALK_EVAC_GUARD1_JOIN2" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD1_JOIN2",
    line = ccb.content.text("Death is pretty blunt."),
    replies = {
        {
            text = ccb.content.text("So no negotiating?  No, 'If you do this quest then we'll let you in?'"),
            next_topic = "TALK_EVAC_GUARD1_JOIN3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD1_JOIN3",
    line = ccb.content.text("Nope."),
    replies = {
        {
            text = ccb.content.text("I don't like your attitude."),
            next_topic = "TALK_EVAC_GUARD1_ATTITUDE",
        },
        { text = ccb.content.text("Well alright then."), next_topic = "TALK_EVAC_GUARD1" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD1_ATTITUDE",
    line = ccb.content.text("Then leave, you have two feet."),
    replies = {
        {
            text = ccb.content.text("I think I'd rather rearrange your face instead!"),
            next_topic = "TALK_DONE",
            native_actions = { "insult_combat" },
        },
        { text = ccb.content.text("I will."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD1_JOB",
    line = ccb.content.text("Depends on what you want.  Go talk to a merchant if you have anything to sell.  Otherwise the Old Guard liaison might have something, if you can find him.  But if you're just looking for someone to put a good word in, I might have something for you."),
    replies = {
        { text = ccb.content.text("Alright then."), next_topic = "TALK_EVAC_GUARD1" },
        {
            text = ccb.content.text("A good word might be helpful.  What do you need?"),
            next_topic = "TALK_MISSION_LIST",
        },
        { text = ccb.content.text("Old Guard huh, I'll go talk to him!"), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("Who are the Old Guard?"),
            next_topic = "TALK_EVAC_GUARD1_OLDGUARD",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD1_OLDGUARD",
    line = ccb.content.text("That's just our nickname for them.  They're what's left of the federal government.  Don't know how legitimate they are but they are named after some military unit that once protected the president.  Their liaison is usually hanging around here somewhere."),
    replies = {
        {
            text = ccb.content.text("Whatever, I had another question."),
            next_topic = "TALK_EVAC_GUARD1",
        },
        { text = ccb.content.text("Okay, I'll go look for him then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EVAC_GUARD1_BYE",
    line = ccb.content.text("Stay safe out there.  Hate to have to kill you after you've already died."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
