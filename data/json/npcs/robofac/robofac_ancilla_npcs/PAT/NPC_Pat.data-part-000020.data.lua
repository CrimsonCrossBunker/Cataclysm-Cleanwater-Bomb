local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_LENS_1",
    line = ccb.content.text("What in the evah-lovin' fahk is that supposed to be?  Jesus Christ.  Lemme see that thing.\"  Pat takes the helmet, puts it on, and starts the laugh.  \"There ain't even a goddamn visor on this thing.  Hah!\"\n\nPat takes off the helmet and wipes a hand over its smooth exterior, looking it over closely."),
    replies = {
        {
            text = ccb.content.text("Yeah, well, think you can make it work for our comm system?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_LENS_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_LENS_2",
    line = ccb.content.text("Alright, alright, alright let me take a look… yup… there.  Yeah, figures.  Lucky for us our employah's are cheap bastahds.  They slapped a fahkin' USB port on it.  Nothin' says \"sci-fi bullshit\" like a port ripped off a fahkin office printah\".\n\nPat sparks their car battery, hooks their laptop up to it, and boots it up.  \"Hang on a sec."),
    replies = {
        {
            text = ccb.content.text("[Wait quietly and patiently]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_LENS_3",
        },
        {
            text = ccb.content.text("[Laugh and relax]"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_LENS_3",
        },
        {
            text = ccb.content.text("Make it quick, Pat."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_LENS_3",
        },
    },
}
