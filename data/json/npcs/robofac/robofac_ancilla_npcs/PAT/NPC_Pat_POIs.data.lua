local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_scarlet_storm_recon",
    line = ccb.content.text("Shit, I meant ta' call ya'.  That fuckah I got the photo from?  Dead as a fakhin' doornail.  Toast.  Kaput.  Maybe this isn't such a good idea.  Though, I guess that poor sap was in it for a day or two.  At least get yourself a mask, if you don't got one already.  Deal?  Ovah'n'out."),
    replies = {
        {
            text = ccb.content.text("Got it.  Thanks, Pat.  Over and out."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_POI_scarlet_storm_1",
    line = ccb.content.text("Pickin' up images now.  Shit.  That looks a lot like some photos some fuckah' hawkin' smokes just showed me.  Poor shit was hackin' up a lung.  Could hardly breath.  I think that's a bad sign, yeah?  I'd turn ya' ass around if ya don't got a respiratah - a gas mask - somethin'."),
    replies = {
        {
            text = ccb.content.text("Good to know.  Thanks, Pat.  Over and out."),
            next_topic = "TALK_DONE",
        },
    },
}
