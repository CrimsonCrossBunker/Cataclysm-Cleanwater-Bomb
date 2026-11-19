local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GIVE_EARPIECE",
    line = ccb.content.text("Right, so check this shit out.  I rigged up'a small radio transponder to an earpiece.  Just put it in your ear, plug it in'ta the port there on the headset, switch it on, and as long as your AR headset is on, I can see, heah, and talk.  Wicked, eh?  You just keep that transmitter-receiver toggled on and I'll do what I can to give you some wicked fahkin' good advice and info.  On my end, I'll sell data to the Hub to keep me afloat, and you keep whatever comes out of the jobs."),
    replies = {
        {
            text = ccb.content.text("Wicked.  Guess we'll talk soon, Pat.  Thanks."),
            next_topic = "TALK_DONE",
        },
    },
}
