local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE9_GOVERNMENT",
    line = ccb.content.gendered_line("That's what I'm saying!  Everything that's going on wouldn't be possible without massive fuck-ups by people in power.  China has fusion reactors?  Well, I've never seen it!  America sinks trillions and trillions of dollars into secret military budgets with no explanation.  If you gave me a trillion dollars and the brain of a bureaucrat, I bet I could completely fuck up reality, too.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("<lets_go>  I'm trying to stick it to 'The Man' while we've still got a chance."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE9_GOD",
    line = ccb.content.gendered_line("I've been trying not to think about it, but you could be right.  The more that I see, the less I can explain.  I grew up around a lot of people who always talked about the Rapture.  Hell itself opening up and everything.  It was like they KNEW it would happen.  Before the internet stopped working, I saw people saying that sinners were becoming zombies.  'As above, so below' someone said, or something like that…", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("We should keep moving…  No sense dwelling on fate.  If those people are right, then this is all we've got: survival."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE9_SKEPTIC",
    line = ccb.content.text("Maybe.  I guess multiple things could be possible.  You really don't think that there's someone or something behind this?  Someone who flew a little too close to the sun?  Poked the beast?"),
    replies = {
        {
            text = ccb.content.text("I think it's possible, but ultimately unknowable.  What matters now is survival and actually fighting the monsters that are trying to kill us.  We shouldn't dwell on crazy theories."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE10_SKEPTIC",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE9_FED",
    line = ccb.content.text("A Marshal, huh?  I could tell there was something a bit square about you.  Or… round, I suppose, ha!  In my experience, when people at that level start talking stuff like that, there's at least some truth to it."),
    replies = {
        {
            text = ccb.content.text("I might not have 'real' authority anymore, and we might not have a real 'society', but it's still not nice to make fat jokes…"),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE10_TAKE_BAIT",
        },
        {
            text = ccb.content.text("They were talking a LOT in that time, that's for sure."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE10_IGNORE_BAIT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE9_HUB01",
    line = ccb.content.text("High-tech armor?  And there's a whole group of them down in a bunker?  Probably best to keep people like that on our good side.  What they're saying seems to check out.  Reality does seem pretty fucked.  Kinda makes me wonder how involved THEY were if they know all that, though."),
    replies = {
        {
            text = ccb.content.text("I'm not sure yet.  It's suspicious, yes, but they seem to be nearly as confused as we are about some things.  Almost like they're scared by what's happened."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE10_HUB01",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE9_BONE_SEER",
    line = ccb.content.gendered_line("She said it was… energy in bones?  Listen, I've heard a lot of crazy bullshit in my time and that's up there, for sure.  And I don't see how something like that explains all the crazy shit I've seen either.  But collecting bones to… save the world?  Fuck it, give it a shot.  Maybe that's something just YOU do, though.  I'm happy believing a lie if that's the truth, I'll be honest.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I didn't say it was a SOLID theory, but maybe she's onto something.  This is evil on a cosmic scale; I don't know how else to explain it.  Maybe she's right.  Maybe the bones really are 'singing'."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE10_BONE_SEER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE9_ALIENS",
    line = ccb.content.gendered_line("I've been trying not to think about it, but you could be right.  The more that I see, the less I can explain.  I don't know why humans would want this, but if you're a brain-sucking alien, this is the place to be.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("So… are you down to kick some alien ass with me?"),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE10_ALIENS",
        },
        { text = ccb.content.text("Let's not dwell on it.  <lets_go>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE9_CHAOS",
    line = ccb.content.text("I can't accept that.  Everything was just fine for a while, but the bad started some years ago, with bad people doing bad things.  I think we all knew it was gonna end one way or another.  But there's got to be some sort of deeper explanation for… this!  Someone is responsible!"),
    replies = {
        {
            text = ccb.content.text("Possibly, but we can never know for sure.  Sometimes bad things gather into uncontrollable avalanches."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE10_CHAOS",
        },
        {
            text = ccb.content.text("Those bad people are probably all dead now.  If bad things continue to happen, it's just the nature of the universe.  Entropy and chaos are the natural order of things."),
            next_topic = "BGSS_PREPPER_1_FOUND_LMOE10_CHAOS",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE10_SKEPTIC",
    line = ccb.content.gendered_line("You're right, but I still think there's something bigger out there.  Something evil.  It doesn't matter whether science can explain it because we damn sure don't seem capable of defeating it.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Yeah, it does seem a little grim…  <lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE10_TAKE_BAIT",
    line = ccb.content.gendered_line("I'm sorry, 'officer'.  I didn't write the book of cop jokes, you know.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("<lets_go>  We don't have time for this nonsense…"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE10_IGNORE_BAIT",
    line = ccb.content.text("That's always how it goes: someone knows someone else, they get drunk at some Virginia wine party for rich elites, and suddenly state secrets are leaking out.  'Oh, my Russian contacts got this covert intelligence'…  'My secret Chinese spies think this crazy thing is happening'…  Sometimes they know and sometimes they don't.  It's up to us to put the truth together."),
    replies = {
        {
            text = ccb.content.text("I'm tired of talking.  Let's get moving and put that truth together for ourselves…"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE10_HUB01",
    line = ccb.content.gendered_line("Scared?  Yeah, that's fair.  I wouldn't say it's a friendly world out here.  Still, it's best to be friends.  Anyone that prepared for the apocalypse is probably armed to the teeth anyway.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("<lets_go>  I feel like it's useless worrying who they are when they're some of the only friends we've got…"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE10_BONE_SEER",
    line = ccb.content.text("Once again, I'm staying out of the bone bullshit.  I hope the best for you and the bone woman.  You definitely seem like you have things under control."),
    replies = {
        {
            text = ccb.content.text("Maybe I shouldn't have mentioned it…  Let's just get moving."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE10_ALIENS",
    line = ccb.content.text("Honestly, it doesn't matter who opened up what portal to wherever.  Extraterrestrial monster?  Engineered bio-weapon?  Three children standing on each others' shoulders in an alien Halloween costume?  I'll blast 'em either way."),
    replies = {
        {
            text = ccb.content.text("'War of the Worlds', baby!  That's what I like to hear!  <lets_go>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_FOUND_LMOE10_CHAOS",
    line = ccb.content.text("I refuse to believe things are just random.  Especially this!  The dead don't start rising all over the world for no reason!"),
    replies = {
        {
            text = ccb.content.text("Let's keep moving.  This is a topic for another day, when we've actually found some answers…"),
            next_topic = "TALK_DONE",
        },
    },
}
