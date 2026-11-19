local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_EXODII_AR",
    line = ccb.content.text("Well, I don't see any freakin' plugs on ya', and unless you gone and shoved a Wi-Fi router up ya' ass, I don't see how we're gettin' the software we need on there.  Come back if you get some kind of interface I can work with, and we'll see what's what."),
    replies = {
        {
            text = ccb.content.text("Yeah, alright.  I'll come back if my bionic interface becomes accessible to you."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
        },
    },
}
