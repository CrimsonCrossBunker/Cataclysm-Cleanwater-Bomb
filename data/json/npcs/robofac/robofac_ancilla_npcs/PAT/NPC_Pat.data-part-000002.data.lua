local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GREETING_1",
    line = ccb.content.text("Hey, I'm Pat.  Hope ya weren't plannin' on usin' this office.  The bosses don't seem ta give a damn, so I'm callin' dibs."),
    replies = {
        {
            text = ccb.content.text("What do you do for our… employer?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_GREETING_2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GREETING_2",
    line = ccb.content.text("I kinda stumbled inta this place aftah everythin' went down, an' they started tossin' me odd jobs in exchange for some old weathah data I had lyin' around.  Used ta be a meteorologist - the computah kind, not the TV kind.  Now they got me takin' recordin's of those portal storms, but if I'm bein' straight with ya, I ain't really built for fieldwork.  Honestly, I'm shocked I'm still breathin'."),
    replies = {
        {
            text = ccb.content.text("They've contracted me to do the same."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_GREETING_3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_GREETING_3",
    line = ccb.content.text("No kiddin'? Well, hey - good ta meet ya. Swing by once in a while, yeah?  You're a helluva lot friendlier than most a the assholes I've run inta round heah… not that theah's been a ton, but still."),
    replies = {
        {
            text = ccb.content.text("Nice to meet you.  See you around."),
            next_topic = "TALK_ROBOFAC_MERC_PAT_GREETING_4",
        },
    },
}
