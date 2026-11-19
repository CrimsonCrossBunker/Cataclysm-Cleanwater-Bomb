local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Where",
    line = ccb.content.text("This is the New England Community Church, the congregation of it.  Praise the Lord that we made it through!"),
    replies = {
        {
            text = ccb.content.text("What are you doing out here?"),
            next_topic = "TALK_GODCO_Greenwood_Compound",
        },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Compound",
    line = ccb.content.text("We all came out here when <the_cataclysm> rocked the world.  It's an old retreat Helena bought in the hopes of renovating it, good thing we did."),
    replies = {
        {
            text = ccb.content.text("Could I ask you a few more questions?"),
            next_topic = "TALK_GODCO_Greenwood_2",
        },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Past",
    line = ccb.content.text("I had a pretty comfortable life growing up.  My parents were florists, owned a shop along the main street of town.  They were always so cheery, as if nothing bad could phase them.  When I was about fifteen, I dreamt that the Lord spoke to me; as if urging me to go and spread his Gospel, so I did.  I took odd jobs at several churches for a while, before I went to seminary.  I went between three different churches, before I found this one.  I've been here since."),
    replies = {
        {
            text = ccb.content.text("Could I ask you a few more questions?"),
            next_topic = "TALK_GODCO_Greenwood_2",
        },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_NECC",
    line = ccb.content.text("The full name is the New England Community Church.  Helena's father started it about twenty years ago.  The flock may be small, but we've always helped each other when times were tough; we're like a family now."),
    replies = {
        {
            text = ccb.content.text("Could I ask you a few more questions?"),
            next_topic = "TALK_GODCO_Greenwood_2",
        },
        {
            text = ccb.content.text("What do you think about Helena?"),
            next_topic = "TALK_GODCO_Greenwood_Helena",
        },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Helena",
    line = ccb.content.text("&Greenwood looks over his their shoulder, briefly glancing around before speaking in a low whisper.  \"Don't tell anyone I said this, but I don't like Helena at all.  Her father was a real nut, he'd rave on and on about an apocalypse he'd prepared for.  He always thought that his church would be the ark to weather the storm, that God would destroy the world by unleashing the armies of Hell; and he wasn't talking about the Second Coming of Christ.  Helena's just as fanatical as he was, and it reflects in her inadequate leadership.  To be honest, I'm highly concerned for some of the people here; they're obsessively zealous with Helena, and harbor a xenophobic hatred of everything.  As in Matthew 15:14, 'They are blind guides.  And if one blind person guides another, they will both fall into a pit'.\""),
    replies = {
        {
            text = ccb.content.text("Could I ask you a few more questions?"),
            next_topic = "TALK_GODCO_Greenwood_2",
        },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_You_Mutant",
    line = ccb.content.text("Well, it's your appearance.  You're… how do I say, significantly different than what most people are used to.  With the sudden appearance of strange phenomenon following the Rapture, some have taken your changes as a mark of demonic corruption, and won't be very kind to you either.  Be wary of this."),
    replies = {
        {
            text = ccb.content.text("Alright.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_Greenwood_2",
        },
        {
            text = ccb.content.text("Thanks for the info, I'd best be going then."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_Greenwood_Angry",
    line = ccb.content.text("I've already given you a second chance, and yet you kept right on abusing me.  I can't stand it any longer, and I want nothing to do with you.  I hope that God will show you the light soon enough."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
