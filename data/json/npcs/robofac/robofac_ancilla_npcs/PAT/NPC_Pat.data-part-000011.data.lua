local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_MISSION_FRIEND_3",
    line = ccb.content.text("Pat laughs, nods, and offers a handshake.  \"See ya around?\""),
    replies = {
        {
            text = ccb.content.text("[Return the handshake]  See you around."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("[Offer a fistbump]  See you around."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("[Go for the shake and pull away last minute]  Hah, psych!  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GEAR",
    line = ccb.content.text("Check this shit out, eh?  So ya' wear the glasses like normal, but I've made a leg-strap for the other bits.  The tablet heah is useless for ya', we just need it for extra processin' powah to run the long range radiowave emitter and receiver.  The pictures you send'll be shit, but it should work, long as you aren't stupid enough to drive off to Texas or some shit.  Ya' stick that earbud in ya' ear, and we should be able to chat.  Here's the trick - toggle the recording switch on, and I'll be able to collect pictures and audio now and again, and I'll keep an eye on the feed, even though it may be slow n' ugly.  You just keep that transmitter-receiver toggled on and I'll do what I can to give you some wicked fahkin' good advice and info."),
    replies = {
        {
            text = ccb.content.text("Sounds great.  Guess we'll talk soon."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_IMPROVE_GEAR_NO",
    line = ccb.content.text("We've only just made'em, come on.  Try it out for a couple weeks, then we can talk."),
    replies = { { text = ccb.content.text("Yeah, alright."), next_topic = "TALK_ROBOFAC_MERC_PAT" } },
}
